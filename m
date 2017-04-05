Return-Path: <srs0=xpzz=3n=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vydTG3pZHzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:56:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vydTG30JBz8t15
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:56:34 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vydTF3GXsz9s84
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2017 17:56:33 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 08/10] powerpc: Consolidate variants of real-mode MMIOs
Date: Wed,  5 Apr 2017 17:54:54 +1000
Message-Id: <20170405075456.13561-8-benh@kernel.crashing.org>
In-Reply-To: <20170405075456.13561-1-benh@kernel.crashing.org>
References: <20170405075456.13561-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have all sort of variants of MMIO accessors for the real mode
instructions. This creates a clean set of accessors based on
Linux normal naming conventions, replacing all occurrences of
the old ones in the tree.

I have purposefully removed the "out/in" variants in favor of
only including __raw variants. Any code using these is already
pretty much hand tuned to operate in a very specific environment.
I've fixed up the 2 users (only one of them actually needed
a barrier in the first place).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/io.h             | 98 ++++++++++++++++---------------
 arch/powerpc/include/asm/kvm_book3s_asm.h |  2 +-
 arch/powerpc/include/asm/kvm_ppc.h        |  2 +-
 arch/powerpc/kvm/book3s_hv_builtin.c      | 21 +++----
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |  4 +-
 arch/powerpc/platforms/powernv/rng.c      |  2 +-
 arch/powerpc/sysdev/xics/icp-native.c     |  8 +--
 7 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5ed2924..45c136a 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -192,24 +192,8 @@ DEF_MMIO_OUT_D(out_le32, 32, stw);
 
 #endif /* __BIG_ENDIAN */
 
-/*
- * Cache inhibitied accessors for use in real mode, you don't want to use these
- * unless you know what you're doing.
- *
- * NB. These use the cpu byte ordering.
- */
-DEF_MMIO_OUT_X(out_rm8,   8, stbcix);
-DEF_MMIO_OUT_X(out_rm16, 16, sthcix);
-DEF_MMIO_OUT_X(out_rm32, 32, stwcix);
-DEF_MMIO_IN_X(in_rm8,   8, lbzcix);
-DEF_MMIO_IN_X(in_rm16, 16, lhzcix);
-DEF_MMIO_IN_X(in_rm32, 32, lwzcix);
-
 #ifdef __powerpc64__
 
-DEF_MMIO_OUT_X(out_rm64, 64, stdcix);
-DEF_MMIO_IN_X(in_rm64, 64, ldcix);
-
 #ifdef __BIG_ENDIAN__
 DEF_MMIO_OUT_D(out_be64, 64, std);
 DEF_MMIO_IN_D(in_be64, 64, ld);
@@ -242,35 +226,6 @@ static inline void out_be64(volatile u64 __iomem *addr, u64 val)
 #endif
 #endif /* __powerpc64__ */
 
-
-/*
- * Simple Cache inhibited accessors
- * Unlike the DEF_MMIO_* macros, these don't include any h/w memory
- * barriers, callers need to manage memory barriers on their own.
- * These can only be used in hypervisor real mode.
- */
-
-static inline u32 _lwzcix(unsigned long addr)
-{
-	u32 ret;
-
-	__asm__ __volatile__("lwzcix %0,0, %1"
-			     : "=r" (ret) : "r" (addr) : "memory");
-	return ret;
-}
-
-static inline void _stbcix(u64 addr, u8 val)
-{
-	__asm__ __volatile__("stbcix %0,0,%1"
-		: : "r" (val), "r" (addr) : "memory");
-}
-
-static inline void _stwcix(u64 addr, u32 val)
-{
-	__asm__ __volatile__("stwcix %0,0,%1"
-		: : "r" (val), "r" (addr) : "memory");
-}
-
 /*
  * Low level IO stream instructions are defined out of line for now
  */
@@ -417,15 +372,64 @@ static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
 }
 
 /*
- * Real mode version of the above. stdcix is only supposed to be used
- * in hypervisor real mode as per the architecture spec.
+ * Real mode versions of the above. Those instructions are only supposed
+ * to be used in hypervisor real mode as per the architecture spec.
  */
+static inline void __raw_rm_writeb(u8 val, volatile void __iomem *paddr)
+{
+	__asm__ __volatile__("stbcix %0,0,%1"
+		: : "r" (val), "r" (paddr) : "memory");
+}
+
+static inline void __raw_rm_writew(u16 val, volatile void __iomem *paddr)
+{
+	__asm__ __volatile__("sthcix %0,0,%1"
+		: : "r" (val), "r" (paddr) : "memory");
+}
+
+static inline void __raw_rm_writel(u32 val, volatile void __iomem *paddr)
+{
+	__asm__ __volatile__("stwcix %0,0,%1"
+		: : "r" (val), "r" (paddr) : "memory");
+}
+
 static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
 {
 	__asm__ __volatile__("stdcix %0,0,%1"
 		: : "r" (val), "r" (paddr) : "memory");
 }
 
+static inline u8 __raw_rm_readb(volatile void __iomem *paddr)
+{
+	u8 ret;
+	__asm__ __volatile__("lbzcix %0,0, %1"
+			     : "=r" (ret) : "r" (paddr) : "memory");
+	return ret;
+}
+
+static inline u16 __raw_rm_readw(volatile void __iomem *paddr)
+{
+	u16 ret;
+	__asm__ __volatile__("lhzcix %0,0, %1"
+			     : "=r" (ret) : "r" (paddr) : "memory");
+	return ret;
+}
+
+static inline u32 __raw_rm_readl(volatile void __iomem *paddr)
+{
+	u32 ret;
+	__asm__ __volatile__("lwzcix %0,0, %1"
+			     : "=r" (ret) : "r" (paddr) : "memory");
+	return ret;
+}
+
+static inline u64 __raw_rm_readq(volatile void __iomem *paddr)
+{
+	u64 ret;
+	__asm__ __volatile__("ldcix %0,0, %1"
+			     : "=r" (ret) : "r" (paddr) : "memory");
+	return ret;
+}
 #endif /* __powerpc64__ */
 
 /*
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index d318d43..0593d94 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -110,7 +110,7 @@ struct kvmppc_host_state {
 	u8 ptid;
 	struct kvm_vcpu *kvm_vcpu;
 	struct kvmppc_vcore *kvm_vcore;
-	unsigned long xics_phys;
+	void __iomem *xics_phys;
 	u32 saved_xirr;
 	u64 dabr;
 	u64 host_mmcr[7];	/* MMCR 0,1,A, SIAR, SDAR, MMCR2, SIER */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0c41865..c387799 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -409,7 +409,7 @@ struct openpic;
 extern void kvm_cma_reserve(void) __init;
 static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {
-	paca[cpu].kvm_hstate.xics_phys = addr;
+	paca[cpu].kvm_hstate.xics_phys = (void __iomem *)addr;
 }
 
 static inline u32 kvmppc_get_xics_latch(void)
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index ae55603..a752e29 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -194,12 +194,6 @@ long kvmppc_h_random(struct kvm_vcpu *vcpu)
 	return H_HARDWARE;
 }
 
-static inline void rm_writeb(unsigned long paddr, u8 val)
-{
-	__asm__ __volatile__("stbcix %0,0,%1"
-		: : "r" (val), "r" (paddr) : "memory");
-}
-
 /*
  * Send an interrupt or message to another CPU.
  * The caller needs to include any barrier needed to order writes
@@ -207,7 +201,7 @@ static inline void rm_writeb(unsigned long paddr, u8 val)
  */
 void kvmhv_rm_send_ipi(int cpu)
 {
-	unsigned long xics_phys;
+	void __iomem *xics_phys;
 	unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
 
 	/* On POWER9 we can use msgsnd for any destination cpu. */
@@ -232,7 +226,7 @@ void kvmhv_rm_send_ipi(int cpu)
 	/* Else poke the target with an IPI */
 	xics_phys = paca[cpu].kvm_hstate.xics_phys;
 	if (xics_phys)
-		rm_writeb(xics_phys + XICS_MFRR, IPI_PRIORITY);
+		__raw_rm_writeb(IPI_PRIORITY, xics_phys + XICS_MFRR);
 	else
 		opal_int_set_mfrr(get_hard_smp_processor_id(cpu), IPI_PRIORITY);
 }
@@ -405,7 +399,7 @@ long kvmppc_read_intr(void)
 
 static long kvmppc_read_one_intr(bool *again)
 {
-	unsigned long xics_phys;
+	void __iomem *xics_phys;
 	u32 h_xirr;
 	__be32 xirr;
 	u32 xisr;
@@ -423,7 +417,7 @@ static long kvmppc_read_one_intr(bool *again)
 	if (!xics_phys)
 		rc = opal_int_get_xirr(&xirr, false);
 	else
-		xirr = _lwzcix(xics_phys + XICS_XIRR);
+		xirr = __raw_rm_readl(xics_phys + XICS_XIRR);
 	if (rc < 0)
 		return 1;
 
@@ -453,8 +447,8 @@ static long kvmppc_read_one_intr(bool *again)
 	if (xisr == XICS_IPI) {
 		rc = 0;
 		if (xics_phys) {
-			_stbcix(xics_phys + XICS_MFRR, 0xff);
-			_stwcix(xics_phys + XICS_XIRR, xirr);
+			__raw_rm_writeb(0xff, xics_phys + XICS_MFRR);
+			__raw_rm_writel(xirr, xics_phys + XICS_XIRR);
 		} else {
 			opal_int_set_mfrr(hard_smp_processor_id(), 0xff);
 			rc = opal_int_eoi(h_xirr);
@@ -479,7 +473,8 @@ static long kvmppc_read_one_intr(bool *again)
 			 * we need to resend that IPI, bummer
 			 */
 			if (xics_phys)
-				_stbcix(xics_phys + XICS_MFRR, IPI_PRIORITY);
+				__raw_rm_writeb(IPI_PRIORITY,
+						xics_phys + XICS_MFRR);
 			else
 				opal_int_set_mfrr(hard_smp_processor_id(),
 						  IPI_PRIORITY);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index e78542d..3a1a463 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -766,7 +766,7 @@ unsigned long eoi_rc;
 
 static void icp_eoi(struct irq_chip *c, u32 hwirq, __be32 xirr, bool *again)
 {
-	unsigned long xics_phys;
+	void __iomem *xics_phys;
 	int64_t rc;
 
 	rc = pnv_opal_pci_msi_eoi(c, hwirq);
@@ -779,7 +779,7 @@ static void icp_eoi(struct irq_chip *c, u32 hwirq, __be32 xirr, bool *again)
 	/* EOI it */
 	xics_phys = local_paca->kvm_hstate.xics_phys;
 	if (xics_phys) {
-		_stwcix(xics_phys + XICS_XIRR, xirr);
+		__raw_rm_writel(xirr, xics_phys + XICS_XIRR);
 	} else {
 		rc = opal_int_eoi(be32_to_cpu(xirr));
 		*again = rc > 0;
diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 5dcbdea..1a9d843 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -62,7 +62,7 @@ int powernv_get_random_real_mode(unsigned long *v)
 
 	rng = raw_cpu_read(powernv_rng);
 
-	*v = rng_whiten(rng, in_rm64(rng->regs_real));
+	*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));
 
 	return 1;
 }
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 8a6a043..f0f3f47 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -168,15 +168,15 @@ void icp_native_cause_ipi_rm(int cpu)
 	 * Need the physical address of the XICS to be
 	 * previously saved in kvm_hstate in the paca.
 	 */
-	unsigned long xics_phys;
+	void __iomem *xics_phys;
 
 	/*
 	 * Just like the cause_ipi functions, it is required to
-	 * include a full barrier (out8 includes a sync) before
-	 * causing the IPI.
+	 * include a full barrier before causing the IPI.
 	 */
 	xics_phys = paca[cpu].kvm_hstate.xics_phys;
-	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
+	mb();
+	__raw_rm_writeb(IPI_PRIORITY, xics_phys + XICS_MFRR);
 }
 #endif
 
-- 
2.9.3
