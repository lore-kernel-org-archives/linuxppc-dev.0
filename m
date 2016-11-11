Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTC59RlzDvjM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:27 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTB5zWcz9vDZ
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:26 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGwq9A120650
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:25 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26neaa0rjx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:25 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:24 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 05/11] VAS: Define helpers to alloc/free windows
Date: Fri, 11 Nov 2016 09:02:50 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-6-git-send-email-sukadev@linux.vnet.ibm.com>
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
 drivers/misc/vas/vas-window.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 797b4ebd..056cfe9 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -524,8 +524,80 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
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
+		return -1;
+
+	spin_lock(&vas_ida_lock);
+	rc = ida_get_new_above(ida, 1, &winid);
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
+	pr_devel("Initializing node %d chip %d window %d\n", vinst->node,
+			vinst->chip, id);
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
1.8.3.1
