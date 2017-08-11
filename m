Return-Path: <clg@kaod.org>
Received: from 1.mo4.mail-out.ovh.net (1.mo4.mail-out.ovh.net [178.33.248.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTS9X3179zDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 00:31:12 +1000 (AEST)
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id A77BF8C9A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 16:24:10 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/8] powerpc/xive: introduce a common routine
 xive_queue_page_alloc()
Date: Fri, 11 Aug 2017 16:23:34 +0200
Message-Id: <20170811142341.22715-2-clg@kaod.org>
In-Reply-To: <20170811142341.22715-1-clg@kaod.org>
References: <20170811142341.22715-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This routine will be used in the spapr backend. Also introduce a short
xive_alloc_order() helper.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/common.c        | 16 ++++++++++++++++
 arch/powerpc/sysdev/xive/native.c        | 16 +++++-----------
 arch/powerpc/sysdev/xive/xive-internal.h |  6 ++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 6e0c9dee724f..26999ceae20e 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1424,6 +1424,22 @@ bool xive_core_init(const struct xive_ops *ops, void __iomem *area, u32 offset,
 	return true;
 }
 
+__be32 *xive_queue_page_alloc(unsigned int cpu, u32 queue_shift)
+{
+	unsigned int alloc_order;
+	struct page *pages;
+	__be32 *qpage;
+
+	alloc_order = xive_alloc_order(queue_shift);
+	pages = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, alloc_order);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+	qpage = (__be32 *)page_address(pages);
+	memset(qpage, 0, 1 << queue_shift);
+
+	return qpage;
+}
+
 static int __init xive_off(char *arg)
 {
 	xive_cmdline_disabled = true;
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 0f95476b01f6..ef92a83090e1 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -202,17 +202,12 @@ EXPORT_SYMBOL_GPL(xive_native_disable_queue);
 static int xive_native_setup_queue(unsigned int cpu, struct xive_cpu *xc, u8 prio)
 {
 	struct xive_q *q = &xc->queue[prio];
-	unsigned int alloc_order;
-	struct page *pages;
 	__be32 *qpage;
 
-	alloc_order = (xive_queue_shift > PAGE_SHIFT) ?
-		(xive_queue_shift - PAGE_SHIFT) : 0;
-	pages = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, alloc_order);
-	if (!pages)
-		return -ENOMEM;
-	qpage = (__be32 *)page_address(pages);
-	memset(qpage, 0, 1 << xive_queue_shift);
+	qpage = xive_queue_page_alloc(cpu, xive_queue_shift);
+	if (IS_ERR(qpage))
+		return PTR_ERR(qpage);
+
 	return xive_native_configure_queue(get_hard_smp_processor_id(cpu),
 					   q, prio, qpage, xive_queue_shift, false);
 }
@@ -227,8 +222,7 @@ static void xive_native_cleanup_queue(unsigned int cpu, struct xive_cpu *xc, u8
 	 * from an IPI and iounmap isn't safe
 	 */
 	__xive_native_disable_queue(get_hard_smp_processor_id(cpu), q, prio);
-	alloc_order = (xive_queue_shift > PAGE_SHIFT) ?
-		(xive_queue_shift - PAGE_SHIFT) : 0;
+	alloc_order = xive_alloc_order(xive_queue_shift);
 	free_pages((unsigned long)q->qpage, alloc_order);
 	q->qpage = NULL;
 }
diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysdev/xive/xive-internal.h
index d07ef2d29caf..dd1e2022cce4 100644
--- a/arch/powerpc/sysdev/xive/xive-internal.h
+++ b/arch/powerpc/sysdev/xive/xive-internal.h
@@ -56,6 +56,12 @@ struct xive_ops {
 
 bool xive_core_init(const struct xive_ops *ops, void __iomem *area, u32 offset,
 		    u8 max_prio);
+__be32 *xive_queue_page_alloc(unsigned int cpu, u32 queue_shift);
+
+static inline u32 xive_alloc_order(u32 queue_shift)
+{
+	return (queue_shift > PAGE_SHIFT) ? (queue_shift - PAGE_SHIFT) : 0;
+}
 
 extern bool xive_cmdline_disabled;
 
-- 
2.13.4
