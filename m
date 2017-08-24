Return-Path: <srs0=xwhe=72=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdF4C0fDRzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:35 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xdF4B4sdMz8w2H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xdF495vR1z9t3f
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 16:38:33 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O6bMbC052896
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:31 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chspjr2km-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:31 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 02:38:31 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 06/12] powerpc/vas: Define helpers to alloc/free windows
Date: Wed, 23 Aug 2017 23:38:02 -0700
In-Reply-To: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503556688-15412-7-git-send-email-sukadev@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/vas-window.c | 70 +++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 3a50d6a..9c12919 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -490,6 +490,76 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
 	return 0;
 }
 
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
+	if (winid > VAS_WINDOWS_PER_CHIP) {
+		pr_err("VAS: Too many (%d) open windows\n", winid);
+		vas_release_window_id(ida, winid);
+		return -EAGAIN;
+	}
+
+	return winid;
+}
+
+void vas_window_free(struct vas_window *window)
+{
+	int winid = window->winid;
+	struct vas_instance *vinst = window->vinst;
+
+	unmap_winctx_mmio_bars(window);
+	kfree(window);
+
+	vas_release_window_id(&vinst->ida, winid);
+}
+
+struct vas_window *vas_window_alloc(struct vas_instance *vinst)
+{
+	int winid;
+	struct vas_window *window;
+
+	winid = vas_assign_window_id(&vinst->ida);
+	if (winid < 0)
+		return ERR_PTR(winid);
+
+	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	if (!window)
+		return ERR_PTR(-ENOMEM);
+
+	window->vinst = vinst;
+	window->winid = winid;
+
+	if (map_winctx_mmio_bars(window))
+		goto out_free;
+
+	return window;
+
+out_free:
+	kfree(window);
+	return ERR_PTR(-ENOMEM);
+}
+
 /* stub for now */
 int vas_win_close(struct vas_window *window)
 {
-- 
2.7.4
