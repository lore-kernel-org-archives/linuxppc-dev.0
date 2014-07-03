Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B67361A0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 00:45:54 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 4/4] KVM: PPC: e500mc: Advertise E.PT to support HTW guests
Date: Thu, 3 Jul 2014 17:45:27 +0300
Message-ID: <1404398727-12844-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
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

Enable E.PT for vcpus with MMU MAV 2.0 to support Hardware Page Tablewalk (HTW)
in guests.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500_mmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index b775e6a..1de0cd6 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -945,11 +945,7 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
 		vcpu->arch.tlbps[1] = mfspr(SPRN_TLB1PS);
 
 		vcpu->arch.mmucfg &= ~MMUCFG_LRAT;
-
-		/* Guest mmu emulation currently doesn't handle E.PT */
-		vcpu->arch.eptcfg = 0;
-		vcpu->arch.tlbcfg[0] &= ~TLBnCFG_PT;
-		vcpu->arch.tlbcfg[1] &= ~TLBnCFG_IND;
+		vcpu->arch.eptcfg = mfspr(SPRN_EPTCFG);
 	}
 
 	return 0;
-- 
1.7.11.7
