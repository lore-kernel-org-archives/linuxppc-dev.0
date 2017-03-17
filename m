Return-Path: <srs0=ey7g=22=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkrYq0bKKzDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:39 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkrYp6vnKz8swR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:38 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkrYp35Zbz9rxl
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 14:34:38 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H3TcG4077816
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:36 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297pv3psxe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:36 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 23:34:35 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 06/10] VAS: Define helpers to alloc/free windows
Date: Thu, 16 Mar 2017 20:33:58 -0700
In-Reply-To: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1489721642-5657-7-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define helpers to allocate/free VAS window objects. These will
be used in follow-on patches when opening/closing windows.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 drivers/misc/vas/vas-window.c | 74 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index edf5c9f..9233bf5 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -119,7 +119,7 @@ static void unmap_wc_mmio_bars(struct vas_window *window)
  * OS/User Window Context (UWC) MMIO Base Address Region for the given window.
  * Map these bus addresses and save the mapped kernel addresses in @window.
  */
-int map_wc_mmio_bars(struct vas_window *window)
+static int map_wc_mmio_bars(struct vas_window *window)
 {
 	int len;
 	uint64_t start;
@@ -472,8 +472,78 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
 	return 0;
 }
 
-/* stub for now */
+DEFINE_SPINLOCK(vas_ida_lock);
+
+void vas_release_window_id(struct ida *ida, int winid)
+{
+	spin_lock(&vas_ida_lock);
+	ida_remove(ida, winid);
+	spin_unlock(&vas_ida_lock);
+}
+
+int vas_assign_window_id(struct ida *ida)
+{
+	int rc, winid;
+
+	rc = ida_pre_get(ida, GFP_KERNEL);
+	if (!rc)
+		return -EAGAIN;
+
+	spin_lock(&vas_ida_lock);
+	rc = ida_get_new_above(ida, 0, &winid);
+	spin_unlock(&vas_ida_lock);
+
+	if (rc)
+		return rc;
+
+	if (winid > VAS_MAX_WINDOWS_PER_CHIP) {
+		pr_err("VAS: Too many (%d) open windows\n", winid);
+		vas_release_window_id(ida, winid);
+		return -EAGAIN;
+	}
+
+	return winid;
+}
+
+static void vas_window_free(struct vas_window *window)
+{
+	unmap_wc_mmio_bars(window);
+	kfree(window->paste_addr_name);
+	kfree(window);
+}
+
+static struct vas_window *vas_window_alloc(struct vas_instance *vinst, int id)
+{
+	struct vas_window *window;
+
+	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	if (!window)
+		return NULL;
+
+	window->vinst = vinst;
+	window->winid = id;
+
+	if (map_wc_mmio_bars(window))
+		goto out_free;
+
+	return window;
+
+out_free:
+	kfree(window);
+	return NULL;
+}
+
 int vas_window_reset(struct vas_instance *vinst, int winid)
 {
+	struct vas_window *window;
+
+	window = vas_window_alloc(vinst, winid);
+	if (!window)
+		return -ENOMEM;
+
+	reset_window_regs(window);
+
+	vas_window_free(window);
+
 	return 0;
 }
-- 
2.7.4
