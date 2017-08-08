Return-Path: <clg@kaod.org>
Received: from 7.mo3.mail-out.ovh.net (7.mo3.mail-out.ovh.net [46.105.57.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRSvW3zjQzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 18:57:11 +1000 (AEST)
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id BDA4312AF0C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 10:57:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 06/10] powerpc/xive: introduce H_INT_ESB hcall
Date: Tue,  8 Aug 2017 10:56:16 +0200
Message-Id: <1502182579-990-7-git-send-email-clg@kaod.org>
In-Reply-To: <1502182579-990-1-git-send-email-clg@kaod.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
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

The H_INT_ESB hcall() is used to issue a load or store to the ESB page
instead of using the MMIO pages. This can be used as a workaround on
some HW issues. The OS knows that this hcall should be used on an
interrupt source when the ESB hcall flag is set to 1 in the hcall
H_INT_GET_SOURCE_INFO.

To maintain the frontier between the xive frontend and backend, we
introduce a new xive operation 'esb_rw' to be used in the routines
doing memory accesses on the ESBs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/xive.h          |  1 +
 arch/powerpc/sysdev/xive/common.c        | 10 ++++++--
 arch/powerpc/sysdev/xive/spapr.c         | 44 +++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/xive/xive-internal.h |  1 +
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 6d097a18d3ae..c6a4eede7733 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -56,6 +56,7 @@ struct xive_irq_data {
 #define XIVE_IRQ_FLAG_SHIFT_BUG	0x04
 #define XIVE_IRQ_FLAG_MASK_FW	0x08
 #define XIVE_IRQ_FLAG_EOI_FW	0x10
+#define XIVE_IRQ_FLAG_H_INT_ESB	0x20
 
 #define XIVE_INVALID_CHIP_ID	-1
 
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 22b6f8954083..891d24c82e03 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -198,7 +198,10 @@ static u8 xive_peek_esb(struct xive_irq_data *xd, u32 offset)
 	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
 		offset |= offset << 4;
 
-	val = in_be64(xd->eoi_mmio + offset);
+	if ((xd->flags & XIVE_IRQ_FLAG_H_INT_ESB) && xive_ops->esb_rw)
+		val = xive_ops->esb_rw(xd->hw_irq, offset, 0, 0);
+	else
+		val = in_be64(xd->eoi_mmio + offset);
 
 	return (u8)val;
 }
@@ -209,7 +212,10 @@ static void xive_esb_write(struct xive_irq_data *xd, u32 offset, u64 data)
 	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
 		offset |= offset << 4;
 
-	out_be64(xd->eoi_mmio + offset, data);
+	if ((xd->flags & XIVE_IRQ_FLAG_H_INT_ESB) && xive_ops->esb_rw)
+		xive_ops->esb_rw(xd->hw_irq, offset, data, 1);
+	else
+		out_be64(xd->eoi_mmio + offset, data);
 }
 
 #ifdef CONFIG_XMON
diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 9a0fd9f7e38a..7fc40047c23d 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -224,7 +224,46 @@ static long plpar_int_sync(unsigned long flags)
 	return 0;
 }
 
-#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60)) /* TODO */
+#define XIVE_ESB_FLAG_STORE (1ull << (63 - 63))
+
+static long plpar_int_esb(unsigned long flags,
+			  unsigned long lisn,
+			  unsigned long offset,
+			  unsigned long in_data,
+			  unsigned long *out_data)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	long rc;
+
+	pr_devel("H_INT_ESB flags=%lx lisn=%lx offset=%lx in=%lx\n",
+		flags,  lisn, offset, in_data);
+
+	rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset, in_data);
+	if (rc) {
+		pr_err("H_INT_ESB lisn=%ld offset=%ld returned %ld\n",
+		       lisn, offset, rc);
+		return  rc;
+	}
+
+	*out_data = retbuf[0];
+
+	return 0;
+}
+
+static u64 xive_spapr_esb_rw(u32 lisn, u32 offset, u64 data, bool write)
+{
+	unsigned long read_data;
+	long rc;
+
+	rc = plpar_int_esb(write ? XIVE_ESB_FLAG_STORE : 0,
+			   lisn, offset, data, &read_data);
+	if (rc)
+		return -1;
+
+	return write ? 0 : read_data;
+}
+
+#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
 #define XIVE_SRC_LSI           (1ull << (63 - 61))
 #define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
 #define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
@@ -244,6 +283,8 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 	if (rc)
 		return  -EINVAL;
 
+	if (flags & XIVE_SRC_H_INT_ESB)
+		data->flags  |= XIVE_IRQ_FLAG_H_INT_ESB;
 	if (flags & XIVE_SRC_STORE_EOI)
 		data->flags  |= XIVE_IRQ_FLAG_STORE_EOI;
 	if (flags & XIVE_SRC_LSI)
@@ -483,6 +524,7 @@ static const struct xive_ops xive_spapr_ops = {
 	.setup_cpu		= xive_spapr_setup_cpu,
 	.teardown_cpu		= xive_spapr_teardown_cpu,
 	.sync_source		= xive_spapr_sync_source,
+	.esb_rw			= xive_spapr_esb_rw,
 #ifdef CONFIG_SMP
 	.get_ipi		= xive_spapr_get_ipi,
 	.put_ipi		= xive_spapr_put_ipi,
diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysdev/xive/xive-internal.h
index d07ef2d29caf..c99a100abf02 100644
--- a/arch/powerpc/sysdev/xive/xive-internal.h
+++ b/arch/powerpc/sysdev/xive/xive-internal.h
@@ -47,6 +47,7 @@ struct xive_ops {
 	void	(*update_pending)(struct xive_cpu *xc);
 	void	(*eoi)(u32 hw_irq);
 	void	(*sync_source)(u32 hw_irq);
+	u64	(*esb_rw)(u32 hw_irq, u32 offset, u64 data, bool write);
 #ifdef CONFIG_SMP
 	int	(*get_ipi)(unsigned int cpu, struct xive_cpu *xc);
 	void	(*put_ipi)(unsigned int cpu, struct xive_cpu *xc);
-- 
2.7.5
