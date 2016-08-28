Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMhK52K7PzDrff
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:16:40 +1000 (AEST)
Subject: [PATCH 4/6] KVM: PPC: e500: Replace kzalloc() calls by kcalloc() in
 two functions
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
Message-ID: <f142a12c-c70f-7046-e20c-fbb83ba6bdae@users.sourceforge.net>
Date: Sun, 28 Aug 2016 19:16:17 +0200
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
Date: Sun, 28 Aug 2016 18:30:38 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kcalloc".

  Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

  This issue was detected also by using the Coccinelle software.

* Replace the specification of data structures by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/e500_mmu.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index e9c19e9..2be2afc4 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -799,22 +799,21 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 		goto put_pages;
 	}
 
-	privs[0] = kzalloc(sizeof(struct tlbe_priv) * params.tlb_sizes[0],
-			   GFP_KERNEL);
+	privs[0] = kcalloc(params.tlb_sizes[0], sizeof(*privs[0]), GFP_KERNEL);
 	if (!privs[0]) {
 		ret = -ENOMEM;
 		goto put_pages;
 	}
 
-	privs[1] = kzalloc(sizeof(struct tlbe_priv) * params.tlb_sizes[1],
-			   GFP_KERNEL);
+	privs[1] = kcalloc(params.tlb_sizes[1], sizeof(*privs[1]), GFP_KERNEL);
 	if (!privs[1]) {
 		ret = -ENOMEM;
 		goto free_privs_first;
 	}
 
-	g2h_bitmap = kzalloc(sizeof(u64) * params.tlb_sizes[1],
-	                     GFP_KERNEL);
+	g2h_bitmap = kcalloc(params.tlb_sizes[1],
+			     sizeof(*g2h_bitmap),
+			     GFP_KERNEL);
 	if (!g2h_bitmap) {
 		ret = -ENOMEM;
 		goto free_privs_second;
@@ -929,20 +928,20 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	vcpu_e500->gtlb_offset[0] = 0;
 	vcpu_e500->gtlb_offset[1] = KVM_E500_TLB0_SIZE;
 
-	vcpu_e500->gtlb_priv[0] = kzalloc(sizeof(struct tlbe_ref) *
-					  vcpu_e500->gtlb_params[0].entries,
+	vcpu_e500->gtlb_priv[0] = kcalloc(vcpu_e500->gtlb_params[0].entries,
+					  sizeof(struct tlbe_ref),
 					  GFP_KERNEL);
 	if (!vcpu_e500->gtlb_priv[0])
 		goto err;
 
-	vcpu_e500->gtlb_priv[1] = kzalloc(sizeof(struct tlbe_ref) *
-					  vcpu_e500->gtlb_params[1].entries,
+	vcpu_e500->gtlb_priv[1] = kcalloc(vcpu_e500->gtlb_params[1].entries,
+					  sizeof(struct tlbe_ref),
 					  GFP_KERNEL);
 	if (!vcpu_e500->gtlb_priv[1])
 		goto err;
 
-	vcpu_e500->g2h_tlb1_map = kzalloc(sizeof(u64) *
-					  vcpu_e500->gtlb_params[1].entries,
+	vcpu_e500->g2h_tlb1_map = kcalloc(vcpu_e500->gtlb_params[1].entries,
+					  sizeof(*vcpu_e500->g2h_tlb1_map),
 					  GFP_KERNEL);
 	if (!vcpu_e500->g2h_tlb1_map)
 		goto err;
-- 
2.9.3
