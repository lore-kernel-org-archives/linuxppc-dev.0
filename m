Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXnsD6JnNzDqdW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 19:58:24 +1000 (AEST)
Date: Wed, 24 May 2017 19:57:19 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: Cope with host using large
 decrementer mode
Message-ID: <20170524095719.GB18900@fergus.ozlabs.ibm.com>
References: <20170524095531.GA18900@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170524095531.GA18900@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 introduces a new mode for the decrementer register, called
large decrementer mode, in which the decrementer counter is 56 bits
wide rather than 32, and reads sign-extend rather than zero-extending.

Since KVM code reads and writes the host decrementer value in a few
places, it needs to be aware of the need to treat the decrementer
value as a 64-bit quantity, and only do a 32-bit sign extension when
large decrementer mode is not in effect.  To enable the sign extension
to be removed in large decrementer mode, we use a CPU feature bit to
indicate that large decrementer mode is in effect.  This CPU feature
bit is derived from the ibm,pa-features property in the firmware
device tree.  This bit is already set by firmware in the device tree
that the kernel uses when running as a host.  We change the kernel
timer code to use this bit and enable large decrementer mode whenever
it is set (even if firmware tells us that the large decrementer mode
only gives us 32 bits) so that we get the sign extension in hardware.

For now, the guest still uses the decrementer in small decrementer
(32-bit) mode.

This is partly based on an earlier patch by Oliver O'Halloran.

Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/cputable.h     |  4 +++-
 arch/powerpc/kernel/prom.c              |  1 +
 arch/powerpc/kernel/time.c              |  7 ++-----
 arch/powerpc/kvm/book3s_hv_interrupts.S |  2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 23 +++++++++++++++++------
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index c2d5095..99c3c56 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -216,6 +216,7 @@ enum {
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
 #define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
+#define CPU_FTR_LARGE_DEC		LONG_ASM_CONST(0x8000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -496,7 +497,8 @@ enum {
 	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
-	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1)
+	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | \
+	     CPU_FTRS_POWER9_DD1 | CPU_FTR_LARGE_DEC)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 40c4887..b315dff 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -165,6 +165,7 @@ static struct ibm_pa_feature {
 	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
 	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
 				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
+	{ .pabyte = 24, .pabit = 0, .cpu_features = CPU_FTR_LARGE_DEC },
 	/*
 	 * If the kernel doesn't support TM (ie CONFIG_PPC_TRANSACTIONAL_MEM=n),
 	 * we don't want to turn on TM here, so we use the *_COMP versions
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2b33cfa..5d13f06 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -946,10 +946,7 @@ static void register_decrementer_clockevent(int cpu)
 
 static void enable_large_decrementer(void)
 {
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
-		return;
-
-	if (decrementer_max <= DECREMENTER_DEFAULT_MAX)
+	if (!cpu_has_feature(CPU_FTR_LARGE_DEC))
 		return;
 
 	/*
@@ -966,7 +963,7 @@ static void __init set_decrementer_max(void)
 	u32 bits = 32;
 
 	/* Prior to ISAv3 the decrementer is always 32 bit */
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!cpu_has_feature(CPU_FTR_LARGE_DEC))
 		return;
 
 	cpu = of_find_node_by_type(NULL, "cpu");
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 0fdc4a2..6e1d75f 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -124,7 +124,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mfspr	r8,SPRN_DEC
 	mftb	r7
 	mtspr	SPRN_HDEC,r8
+BEGIN_FTR_SECTION
 	extsw	r8,r8
+END_FTR_SECTION_IFCLR(CPU_FTR_LARGE_DEC)
 	add	r8,r8,r7
 	std	r8,HSTATE_DECEXP(r13)
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bdb3f76..bcb5401 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -214,6 +214,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 kvmppc_primary_no_guest:
 	/* We handle this much like a ceded vcpu */
 	/* put the HDEC into the DEC, since HDEC interrupts don't wake us */
+	/* HDEC may be larger than DEC for arch >= v3.00, but since the */
+	/* HDEC value came from DEC in the first place, it will fit */
 	mfspr	r3, SPRN_HDEC
 	mtspr	SPRN_DEC, r3
 	/*
@@ -295,8 +297,11 @@ kvm_novcpu_wakeup:
 
 	/* See if our timeslice has expired (HDEC is negative) */
 	mfspr	r0, SPRN_HDEC
+BEGIN_FTR_SECTION
+	extsw	r0, r0
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	li	r12, BOOK3S_INTERRUPT_HV_DECREMENTER
-	cmpwi	r0, 0
+	cmpdi	r0, 0
 	blt	kvm_novcpu_exit
 
 	/* Got an IPI but other vcpus aren't yet exiting, must be a latecomer */
@@ -390,8 +395,8 @@ kvm_secondary_got_guest:
 	lbz	r4, HSTATE_PTID(r13)
 	cmpwi	r4, 0
 	bne	63f
-	lis	r6, 0x7fff
-	ori	r6, r6, 0xffff
+	LOAD_REG_ADDR(r6, decrementer_max)
+	ld	r6, 0(r6)
 	mtspr	SPRN_HDEC, r6
 	/* and set per-LPAR registers, if doing dynamic micro-threading */
 	ld	r6, HSTATE_SPLIT_MODE(r13)
@@ -968,7 +973,10 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 
 	/* Check if HDEC expires soon */
 	mfspr	r3, SPRN_HDEC
-	cmpwi	r3, 512		/* 1 microsecond */
+BEGIN_FTR_SECTION
+	extsw	r3, r3
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+	cmpdi	r3, 512		/* 1 microsecond */
 	blt	hdec_soon
 
 #ifdef CONFIG_KVM_XICS
@@ -2366,12 +2374,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	mfspr	r3, SPRN_DEC
 	mfspr	r4, SPRN_HDEC
 	mftb	r5
-	cmpw	r3, r4
+	extsw	r3, r3
+BEGIN_FTR_SECTION
+	extsw	r4, r4
+END_FTR_SECTION_IFSET(CPU_FTR_LARGE_DEC)
+	cmpd	r3, r4
 	ble	67f
 	mtspr	SPRN_DEC, r4
 67:
 	/* save expiry time of guest decrementer */
-	extsw	r3, r3
 	add	r3, r3, r5
 	ld	r4, HSTATE_KVM_VCPU(r13)
 	ld	r5, HSTATE_KVM_VCORE(r13)
-- 
2.7.4
