Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCEE11A0327
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 01:45:29 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH] KVM: PPC: Book3E: Unlock mmu_lock when setting caching
 atttribute
Date: Wed, 18 Jun 2014 18:45:05 +0300
Message-ID: <1403106305-11565-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch 08c9a188d0d0fc0f0c5e17d89a06bb59c493110f
  	kvm: powerpc: use caching attributes as per linux pte
do not handle properly the error case, letting mmu_lock locked. The lock
will further generate a RCU stall from kvmppc_e500_emul_tlbwe() caller.

In case of an error go to out label.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 0528fe5..54144c7 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -473,7 +473,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (printk_ratelimit())
 			pr_err("%s: pte not present: gfn %lx, pfn %lx\n",
 				__func__, (long)gfn, pfn);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 
-- 
1.7.11.7
