Return-Path: <B02008@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A40FF2C01C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 09:06:04 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 5/7 v2] KVM: PPC: e500: Remove E.PT and E.HV.LRAT categories
 from VCPUs
Date: Wed, 27 Mar 2013 00:05:10 +0200
Message-ID: <1364335512-28426-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
References: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Embedded.Page Table (E.PT) category in VMs requires indirect tlb entries
emulation which is not supported yet. Configure TLBnCFG to remove E.PT
and E.HV.LRAT categories from VCPUs.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - Remove E.HV.LRAT from vcpus

 arch/powerpc/kvm/e500_mmu.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index cf60db1..0d2a293 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -867,11 +867,17 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
 	vcpu->arch.tlbcfg[1] |= params[1].ways << TLBnCFG_ASSOC_SHIFT;
 
 	if (has_feature(vcpu, VCPU_FTR_MMU_V2)) {
+		vcpu->arch.mmucfg &= ~MMUCFG_LRAT;
+
 		if (has_feature(vcpu, VCPU_FTR_E_PT))
 			vcpu->arch.eptcfg = mfspr(SPRN_EPTCFG);
 		else
 			vcpu->arch.eptcfg = 0;
 
+		/* Guest mmu emulation currently doesn't handle E.PT */
+		vcpu->arch.tlbcfg[0] &= ~TLBnCFG_PT;
+		vcpu->arch.tlbcfg[1] &= ~TLBnCFG_IND;
+
 		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
 		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
 	}
-- 
1.7.4.1
