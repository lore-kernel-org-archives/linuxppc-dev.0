Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvx1rT0zDw1t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:13 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 02/11] KVM: PPC: Book3S HV: Set partition table rather than
 SDR1 on POWER9
Date: Wed, 23 Nov 2016 11:31:56 +1100
Message-Id: <1479861125-21394-3-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9, the SDR1 register (hashed page table base address) is no
longer used, and instead the hardware reads the HPT base address
and size from the partition table.  The partition table entry also
contains the bits that specify the page size for the VRMA mapping,
which were previously in the LPCR.  The VPM0 bit of the LPCR is
now reserved; the processor now always uses the VRMA (virtual
real-mode area) mechanism for guest real-mode accesses in HPT mode,
and the RMO (real-mode offset) mechanism has been dropped.

When entering or exiting the guest, we now only have to set the
LPIDR (logical partition ID register), not the SDR1 register.
There is also no requirement now to transition via a reserved
LPID value.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c            | 36 +++++++++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++++++---
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 02f9aed..13b6e61 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -54,6 +54,7 @@
 #include <asm/dbell.h>
 #include <asm/hmi.h>
 #include <asm/pnv-pci.h>
+#include <asm/mmu.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
@@ -3029,6 +3030,22 @@ static void kvmppc_mmu_destroy_hv(struct kvm_vcpu *vcpu)
 	return;
 }
 
+static void kvmppc_setup_partition_table(struct kvm *kvm)
+{
+	unsigned long dw0, dw1;
+
+	/* PS field - page size for VRMA */
+	dw0 = ((kvm->arch.vrma_slb_v & SLB_VSID_L) >> 1) |
+		((kvm->arch.vrma_slb_v & SLB_VSID_LP) << 1);
+	/* HTABSIZE and HTABORG fields */
+	dw0 |= kvm->arch.sdr1;
+
+	/* Second dword has GR=0; other fields are unused since UPRT=0 */
+	dw1 = 0;
+
+	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
+}
+
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 {
 	int err = 0;
@@ -3080,17 +3097,20 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 	      psize == 0x1000000))
 		goto out_srcu;
 
-	/* Update VRMASD field in the LPCR */
 	senc = slb_pgsize_encoding(psize);
 	kvm->arch.vrma_slb_v = senc | SLB_VSID_B_1T |
 		(VRMA_VSID << SLB_VSID_SHIFT_1T);
-	/* the -4 is to account for senc values starting at 0x10 */
-	lpcr = senc << (LPCR_VRMASD_SH - 4);
-
 	/* Create HPTEs in the hash page table for the VRMA */
 	kvmppc_map_vrma(vcpu, memslot, porder);
 
-	kvmppc_update_lpcr(kvm, lpcr, LPCR_VRMASD);
+	/* Update VRMASD field in the LPCR */
+	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+		/* the -4 is to account for senc values starting at 0x10 */
+		lpcr = senc << (LPCR_VRMASD_SH - 4);
+		kvmppc_update_lpcr(kvm, lpcr, LPCR_VRMASD);
+	} else {
+		kvmppc_setup_partition_table(kvm);
+	}
 
 	/* Order updates to kvm->arch.lpcr etc. vs. hpte_setup_done */
 	smp_wmb();
@@ -3240,7 +3260,8 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	memcpy(kvm->arch.enabled_hcalls, default_enabled_hcalls,
 	       sizeof(kvm->arch.enabled_hcalls));
 
-	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
 
 	/* Init LPCR for virtual RMA mode */
 	kvm->arch.host_lpid = mfspr(SPRN_LPID);
@@ -3253,6 +3274,9 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	/* On POWER8 turn on online bit to enable PURR/SPURR */
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		lpcr |= LPCR_ONL;
+	/* On POWER9, VPM0 bit is reserved (VPM0=1 behaviour is assumed) */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		lpcr &= ~LPCR_VPM0;
 	kvm->arch.lpcr = lpcr;
 
 	/*
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6f81adb..b2d107d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -581,12 +581,14 @@ kvmppc_hv_entry:
 	ld	r9,VCORE_KVM(r5)	/* pointer to struct kvm */
 	cmpwi	r6,0
 	bne	10f
-	ld	r6,KVM_SDR1(r9)
 	lwz	r7,KVM_LPID(r9)
+BEGIN_FTR_SECTION
+	ld	r6,KVM_SDR1(r9)
 	li	r0,LPID_RSVD		/* switch to reserved LPID */
 	mtspr	SPRN_LPID,r0
 	ptesync
 	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPID,r7
 	isync
 
@@ -1552,12 +1554,14 @@ kvmhv_switch_to_host:
 	beq	19f
 
 	/* Primary thread switches back to host partition */
-	ld	r6,KVM_HOST_SDR1(r4)
 	lwz	r7,KVM_HOST_LPID(r4)
+BEGIN_FTR_SECTION
+	ld	r6,KVM_HOST_SDR1(r4)
 	li	r8,LPID_RSVD		/* switch to reserved LPID */
 	mtspr	SPRN_LPID,r8
 	ptesync
-	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
+	mtspr	SPRN_SDR1,r6		/* switch to host page table */
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPID,r7
 	isync
 
-- 
2.7.4
