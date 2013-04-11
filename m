Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95AFB2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:22 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 6/8 v3] KVM: PPC: e500: Remove E.PT and E.HV.LRAT categories
 from VCPUs
Date: Thu, 11 Apr 2013 13:03:12 +0300
Message-ID: <1365674594-17410-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
References: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
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

Embedded.Page Table (E.PT) category is not supported yet in e6500 kernel.
Configure TLBnCFG to remove E.PT and E.HV.LRAT categories from VCPUs.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - No change

 arch/powerpc/kvm/e500_mmu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 1c1c5cb..c41a5a9 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -885,8 +885,12 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
 		vcpu->arch.tlbps[0] = mfspr(SPRN_TLB0PS);
 		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
 
+		vcpu->arch.mmucfg &= ~MMUCFG_LRAT;
+
 		/* Guest mmu emulation currently doesn't handle E.PT */
 		vcpu->arch.eptcfg = 0;
+		vcpu->arch.tlbcfg[0] &= ~TLBnCFG_PT;
+		vcpu->arch.tlbcfg[1] &= ~TLBnCFG_IND;
 	}
 
 	return 0;
-- 
1.7.4.1
