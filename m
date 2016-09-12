Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY0tw0Qt1zDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 07:14:47 +1000 (AEST)
Subject: [PATCH] KVM: PPC: e500: Rename jump labels in kvmppc_e500_tlb_init()
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <566ABCD9.1060404@users.sourceforge.net>
 <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
 <165cb42e-f9fe-83ad-7c4c-299a805dbe6e@users.sourceforge.net>
 <20160911232547.GA9873@fergus.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b3d10e3b-79f9-b52c-c013-fe33f87cbd08@users.sourceforge.net>
Date: Mon, 12 Sep 2016 23:00:08 +0200
MIME-Version: 1.0
In-Reply-To: <20160911232547.GA9873@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 22:33:53 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

Thanks that five update steps could be integrated into the branch "kvm-ppc-next"
of another source code repository.


> With this I get a compile error:
> 
>   CC      arch/powerpc/kvm/e500_mmu.o
> /home/paulus/kernel/kvm/arch/powerpc/kvm/e500_mmu.c: In function ‘kvmppc_e500_tlb_init’:
> /home/paulus/kernel/kvm/arch/powerpc/kvm/e500_mmu.c:910:3: error: label ‘err’ used but not defined
>    goto err;
>    ^
> /home/paulus/kernel/kvm/scripts/Makefile.build:289: recipe for target 'arch/powerpc/kvm/e500_mmu.o' failed
> make[2]: *** [arch/powerpc/kvm/e500_mmu.o] Error 1

I overlooked a single goto statement there somehow.

I hope that you like my second approach for this function implementation better.


 arch/powerpc/kvm/e500_mmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 0a2eeb1..ddbf8f0 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -907,7 +907,7 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	struct kvm_vcpu *vcpu = &vcpu_e500->vcpu;
 
 	if (e500_mmu_host_init(vcpu_e500))
-		goto err;
+		goto free_vcpu;
 
 	vcpu_e500->gtlb_params[0].entries = KVM_E500_TLB0_SIZE;
 	vcpu_e500->gtlb_params[1].entries = KVM_E500_TLB1_SIZE;
@@ -933,26 +933,25 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 					  sizeof(struct tlbe_ref),
 					  GFP_KERNEL);
 	if (!vcpu_e500->gtlb_priv[0])
-		goto err;
+		goto free_vcpu;
 
 	vcpu_e500->gtlb_priv[1] = kcalloc(vcpu_e500->gtlb_params[1].entries,
 					  sizeof(struct tlbe_ref),
 					  GFP_KERNEL);
 	if (!vcpu_e500->gtlb_priv[1])
-		goto err;
+		goto free_vcpu;
 
 	vcpu_e500->g2h_tlb1_map = kcalloc(vcpu_e500->gtlb_params[1].entries,
 					  sizeof(*vcpu_e500->g2h_tlb1_map),
 					  GFP_KERNEL);
 	if (!vcpu_e500->g2h_tlb1_map)
-		goto err;
+		goto free_vcpu;
 
 	vcpu_mmu_init(vcpu, vcpu_e500->gtlb_params);
 
 	kvmppc_recalc_tlb1map_range(vcpu_e500);
 	return 0;
-
-err:
+ free_vcpu:
 	free_gtlb(vcpu_e500);
 	return -1;
 }
-- 
2.10.0
