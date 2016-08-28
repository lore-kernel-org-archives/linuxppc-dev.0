Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMhPB0LkFzDrgY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:20:13 +1000 (AEST)
Subject: [PATCH 6/6] KVM: PPC: e500: Rename jump labels in
 kvmppc_e500_tlb_init()
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <165cb42e-f9fe-83ad-7c4c-299a805dbe6e@users.sourceforge.net>
Date: Sun, 28 Aug 2016 19:19:22 +0200
MIME-Version: 1.0
In-Reply-To: <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 28 Aug 2016 18:45:26 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/e500_mmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 0a2eeb1..da8f22b 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
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
2.9.3
