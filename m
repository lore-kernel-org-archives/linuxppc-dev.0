Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D4092C039D
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:04:44 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 17:54:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 558443578052
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:04:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7G84VCl131482
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:04:31 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7G84fl5030801
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:04:42 +1000
Subject: [RFC PATCH v2 05/10] powerpc/book3s: Add flush_tlb operation in
 cpu_spec.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 13:34:39 +0530
Message-ID: <20130816080439.680.48489.stgit@mars.in.ibm.com>
In-Reply-To: <20130816080213.680.50794.stgit@mars.in.ibm.com>
References: <20130816080213.680.50794.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch introduces flush_tlb operation in cpu_spec structure. This will
help us to invoke appropriate CPU-side flush tlb routine. This patch
adds the foundation to invoke CPU specific flush routine for respective
architectures. Currently this patch introduce flush_tlb for p7 and p8.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputable.h   |    5 ++++
 arch/powerpc/kernel/cpu_setup_power.S |   38 +++++++++++++++++++++++----------
 arch/powerpc/kernel/cputable.c        |    8 +++++++
 arch/powerpc/kvm/book3s_hv_ras.c      |   18 +++-------------
 4 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index d8c098e..d76e47b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -97,6 +97,11 @@ struct cpu_spec {
 	 */
 	long		(*machine_check_early)(struct pt_regs *regs);
 
+	/*
+	 * Processor specific routine to flush tlbs.
+	 */
+	void		(*flush_tlb)(unsigned long inval_selector);
+
 };
 
 extern struct cpu_spec		*cur_cpu_spec;
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 18b5b9c..37d1bb0 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -29,7 +29,7 @@ _GLOBAL(__setup_cpu_power7)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
-	bl	__init_TLB
+	bl	__init_tlb_power7
 	mtlr	r11
 	blr
 
@@ -42,7 +42,7 @@ _GLOBAL(__restore_cpu_power7)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
-	bl	__init_TLB
+	bl	__init_tlb_power7
 	mtlr	r11
 	blr
 
@@ -59,7 +59,7 @@ _GLOBAL(__setup_cpu_power8)
 	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
 	bl	__init_HFSCR
-	bl	__init_TLB
+	bl	__init_tlb_power8
 	bl	__init_PMU_HV
 	mtlr	r11
 	blr
@@ -78,7 +78,7 @@ _GLOBAL(__restore_cpu_power8)
 	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
 	bl	__init_HFSCR
-	bl	__init_TLB
+	bl	__init_tlb_power8
 	bl	__init_PMU_HV
 	mtlr	r11
 	blr
@@ -134,15 +134,31 @@ __init_HFSCR:
 	mtspr	SPRN_HFSCR,r3
 	blr
 
-__init_TLB:
-	/*
-	 * Clear the TLB using the "IS 3" form of tlbiel instruction
-	 * (invalidate by congruence class). P7 has 128 CCs, P8 has 512
-	 * so we just always do 512
-	 */
+/*
+ * Clear the TLB using the specified IS form of tlbiel instruction
+ * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
+ *
+ * r3 = IS field
+ */
+__init_tlb_power7:
+	li	r3,0xc00	/* IS field = 0b11 */
+_GLOBAL(__flush_tlb_power7)
+	li	r6,128
+	mtctr	r6
+	mr	r7,r3		/* IS field */
+	ptesync
+2:	tlbiel	r7
+	addi	r7,r7,0x1000
+	bdnz	2b
+	ptesync
+1:	blr
+
+__init_tlb_power8:
+	li	r3,0xc00	/* IS field = 0b11 */
+_GLOBAL(__flush_tlb_power8)
 	li	r6,512
 	mtctr	r6
-	li	r7,0xc00	/* IS field = 0b11 */
+	mr	r7,r3		/* IS field */
 	ptesync
 2:	tlbiel	r7
 	addi	r7,r7,0x1000
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 22973a7..cdbe115 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -71,6 +71,8 @@ extern void __restore_cpu_power7(void);
 extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
 extern void __restore_cpu_a2(void);
+extern void __flush_tlb_power7(unsigned long inval_selector);
+extern void __flush_tlb_power8(unsigned long inval_selector);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
@@ -440,6 +442,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
+		.flush_tlb		= __flush_tlb_power7,
 		.platform		= "power7",
 	},
 	{	/* 2.07-compliant processor, i.e. Power8 "architected" mode */
@@ -456,6 +459,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
+		.flush_tlb		= __flush_tlb_power8,
 		.platform		= "power8",
 	},
 	{	/* Power7 */
@@ -474,6 +478,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
+		.flush_tlb		= __flush_tlb_power7,
 		.platform		= "power7",
 	},
 	{	/* Power7+ */
@@ -492,6 +497,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
+		.flush_tlb		= __flush_tlb_power7,
 		.platform		= "power7+",
 	},
 	{	/* Power8E */
@@ -510,6 +516,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
+		.flush_tlb		= __flush_tlb_power8,
 		.platform		= "power8",
 	},
 	{	/* Power8 */
@@ -528,6 +535,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
+		.flush_tlb		= __flush_tlb_power8,
 		.platform		= "power8",
 	},
 	{	/* Cell Broadband Engine */
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index a353c48..5c427b4 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -58,18 +58,6 @@ static void reload_slb(struct kvm_vcpu *vcpu)
 	}
 }
 
-/* POWER7 TLB flush */
-static void flush_tlb_power7(struct kvm_vcpu *vcpu)
-{
-	unsigned long i, rb;
-
-	rb = TLBIEL_INVAL_SET_LPID;
-	for (i = 0; i < POWER7_TLB_SETS; ++i) {
-		asm volatile("tlbiel %0" : : "r" (rb));
-		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
-	}
-}
-
 /*
  * On POWER7, see if we can handle a machine check that occurred inside
  * the guest in real mode, without switching to the host partition.
@@ -96,7 +84,8 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
 		}
 		if (dsisr & DSISR_MC_TLB_MULTI) {
-			flush_tlb_power7(vcpu);
+			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
+				cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET_LPID);
 			dsisr &= ~DSISR_MC_TLB_MULTI;
 		}
 		/* Any other errors we don't understand? */
@@ -113,7 +102,8 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		reload_slb(vcpu);
 		break;
 	case SRR1_MC_IFETCH_TLBMULTI:
-		flush_tlb_power7(vcpu);
+		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
+			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET_LPID);
 		break;
 	default:
 		handled = 0;
