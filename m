Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbsx5376jzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 20:12:25 +1000 (AEST)
Date: Mon, 29 May 2017 20:11:48 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V3 1/2] KVM: PPC: Book3S HV: Cope with host using large
 decrementer mode
Message-ID: <20170529101148.GB13938@fergus.ozlabs.ibm.com>
References: <20170529101113.GA13938@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170529101113.GA13938@fergus.ozlabs.ibm.com>
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
wide rather than 32, and reads are sign-extended rather than
zero-extended.  For the decrementer, this new mode is optional and
controlled by a bit in the LPCR.  The hypervisor decrementer (HDEC)
is 56 bits wide on POWER9 and has no mode control.

Since KVM code reads and writes the decrementer and hypervisor
decrementer registers in a few places, it needs to be aware of the
need to treat the decrementer value as a 64-bit quantity, and only do
a 32-bit sign extension when large decrementer mode is not in effect.
Similarly, the HDEC should always be treated as a 64-bit quantity on
POWER9.  We define a new EXTEND_HDEC macro to encapsulate the feature
test for POWER9 and the sign extension.

To enable the sign extension to be removed in large decrementer mode,
we test the LPCR_LD bit in the host LPCR image stored in the struct
kvm for the guest.  If is set then large decrementer mode is enabled
and the sign extension should be skipped.

This is partly based on an earlier patch by Oliver O'Halloran.

Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_interrupts.S | 12 +++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 23 +++++++++++++++++------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 0fdc4a2..404deb5 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -121,10 +121,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	 * Put whatever is in the decrementer into the
 	 * hypervisor decrementer.
 	 */
+BEGIN_FTR_SECTION
+	ld	r5, HSTATE_KVM_VCORE(r13)
+	ld	r6, VCORE_KVM(r5)
+	ld	r9, KVM_HOST_LPCR(r6)
+	andis.	r9, r9, LPCR_LD@h
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mfspr	r8,SPRN_DEC
 	mftb	r7
-	mtspr	SPRN_HDEC,r8
+BEGIN_FTR_SECTION
+	/* On POWER9, don't sign-extend if host LPCR[LD] bit is set */
+	bne	32f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	extsw	r8,r8
+32:	mtspr	SPRN_HDEC,r8
 	add	r8,r8,r7
 	std	r8,HSTATE_DECEXP(r13)
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bdb3f76..e390b38 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -32,6 +32,12 @@
 #include <asm/opal.h>
 #include <asm/xive-regs.h>
 
+/* Sign-extend HDEC if not on POWER9 */
+#define EXTEND_HDEC(reg)			\
+BEGIN_FTR_SECTION;				\
+	extsw	reg, reg;			\
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+
 #define VCPU_GPRS_TM(reg) (((reg) * ULONG_SIZE) + VCPU_GPR_TM)
 
 /* Values in HSTATE_NAPPING(r13) */
@@ -214,6 +220,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 kvmppc_primary_no_guest:
 	/* We handle this much like a ceded vcpu */
 	/* put the HDEC into the DEC, since HDEC interrupts don't wake us */
+	/* HDEC may be larger than DEC for arch >= v3.00, but since the */
+	/* HDEC value came from DEC in the first place, it will fit */
 	mfspr	r3, SPRN_HDEC
 	mtspr	SPRN_DEC, r3
 	/*
@@ -295,8 +303,9 @@ kvm_novcpu_wakeup:
 
 	/* See if our timeslice has expired (HDEC is negative) */
 	mfspr	r0, SPRN_HDEC
+	EXTEND_HDEC(r0)
 	li	r12, BOOK3S_INTERRUPT_HV_DECREMENTER
-	cmpwi	r0, 0
+	cmpdi	r0, 0
 	blt	kvm_novcpu_exit
 
 	/* Got an IPI but other vcpus aren't yet exiting, must be a latecomer */
@@ -390,8 +399,8 @@ kvm_secondary_got_guest:
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
@@ -968,7 +977,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 
 	/* Check if HDEC expires soon */
 	mfspr	r3, SPRN_HDEC
-	cmpwi	r3, 512		/* 1 microsecond */
+	EXTEND_HDEC(r3)
+	cmpdi	r3, 512		/* 1 microsecond */
 	blt	hdec_soon
 
 #ifdef CONFIG_KVM_XICS
@@ -2366,12 +2376,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	mfspr	r3, SPRN_DEC
 	mfspr	r4, SPRN_HDEC
 	mftb	r5
-	cmpw	r3, r4
+	extsw	r3, r3
+	EXTEND_HDEC(r4)
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
