Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtkQl1g7tzDrZZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 15:26:23 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, paulus@samba.org, benh@kernel.crashing.org,
 mikey@neuling.org
Subject: [PATCH] KVM: PPC: Book3S HV: Check for updated HDSISR on P9 HDSI
 exception
Date: Fri, 15 Sep 2017 15:26:14 +1000
Message-Id: <20170915052614.8231-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 DD2.1 and below, sometimes on a Hypervisor Data Storage
Interrupt (HDSI) the HDSISR is not be updated at all.

To work around this we put a canary value into the HDSISR before
returning to a guest and then check for this canary when we take a
HDSI. If we find the canary on a HDSI, we know the hardware didn't
update the HDSISR. In this case we return to the guest to retake the
HDSI which should correctly update the HDSISR the second time HDSI
entry.

After talking to Paulus we've applied this workaround to all POWER9
CPUs. The workaround of returning to the guest shouldn't ever be
triggered on well behaving CPU. The extra instructions should have
negligible performance impact.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 663a4a861e..70dca60569 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1118,6 +1118,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 BEGIN_FTR_SECTION
 	mtspr	SPRN_PPR, r0
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
+
+/* Move canary into DSISR to check for later */
+BEGIN_FTR_SECTION
+	li	r0, 0x7fff
+	mtspr	SPRN_HDSISR, r0
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	ld	r0, VCPU_GPR(R0)(r4)
 	ld	r4, VCPU_GPR(R4)(r4)
 
@@ -1947,9 +1954,14 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 kvmppc_hdsi:
 	ld	r3, VCPU_KVM(r9)
 	lbz	r0, KVM_RADIX(r3)
-	cmpwi	r0, 0
 	mfspr	r4, SPRN_HDAR
 	mfspr	r6, SPRN_HDSISR
+BEGIN_FTR_SECTION
+	/* Look for DSISR canary. If we find it, retry instruction */
+	cmpdi	r6, 0x7fff
+	beq	6f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+	cmpwi	r0, 0
 	bne	.Lradix_hdsi		/* on radix, just save DAR/DSISR/ASDR */
 	/* HPTE not found fault or protection fault? */
 	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
-- 
2.11.0
