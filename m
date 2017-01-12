Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzn589gzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:49 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 18/18] KVM: PPC: Book3S HV: Use ASDR for HPT guests on POWER9
Date: Thu, 12 Jan 2017 20:07:26 +1100
Message-Id: <1484212046-29591-19-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 adds a register called ASDR (Access Segment Descriptor
Register), which is set by hypervisor data/instruction storage
interrupts to contain the segment descriptor for the address
being accessed, assuming the guest is using HPT translation.
(For radix guests, it contains the guest real address of the
access.)

Thus, for HPT guests on POWER9, we can use this register rather
than looking up the SLB with the slbfee. instruction.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f638f3e..625ba5e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1731,6 +1731,10 @@ kvmppc_hdsi:
 	/* HPTE not found fault or protection fault? */
 	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
 	beq	1f			/* if not, send it to the guest */
+BEGIN_FTR_SECTION
+	mfspr	r5, SPRN_ASDR		/* on POWER9, use ASDR to get VSID */
+	b	4f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
 	beq	3f
 	clrrdi	r0, r4, 28
@@ -1819,6 +1823,10 @@ kvmppc_hisi:
 	bne	.Lradix_hisi		/* for radix, just save ASDR */
 	andis.	r0, r11, SRR1_ISI_NOPT@h
 	beq	1f
+BEGIN_FTR_SECTION
+	mfspr	r5, SPRN_ASDR		/* on POWER9, use ASDR to get VSID */
+	b	4f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	andi.	r0, r11, MSR_IR		/* instruction relocation enabled? */
 	beq	3f
 	clrrdi	r0, r10, 28
-- 
2.7.4
