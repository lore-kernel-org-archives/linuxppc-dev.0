Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMhH82b3TzDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:15:00 +1000 (AEST)
Subject: [PATCH 2/6] KVM: PPC: e500: Less function calls in
 kvm_vcpu_ioctl_config_tlb() after error detection
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
Message-ID: <bb5571c3-d3a4-e93f-ac9a-543dbd2f2387@users.sourceforge.net>
Date: Sun, 28 Aug 2016 19:14:07 +0200
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
Date: Sun, 28 Aug 2016 17:34:46 +0200

The kfree() function was called in two cases by the
kvm_vcpu_ioctl_config_tlb() function during error handling
even if the passed data structure element contained a null pointer.

* Split a condition check for memory allocation failures.

* Adjust jump targets according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/e500_mmu.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 26f3737..b65a894 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -785,35 +785,39 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 
 	ret = get_user_pages_fast(cfg->array, num_pages, 1, pages);
 	if (ret < 0)
-		goto err_pages;
+		goto free_pages;
 
 	if (ret != num_pages) {
 		num_pages = ret;
 		ret = -EFAULT;
-		goto err_put_page;
+		goto put_pages;
 	}
 
 	virt = vmap(pages, num_pages, VM_MAP, PAGE_KERNEL);
 	if (!virt) {
 		ret = -ENOMEM;
-		goto err_put_page;
+		goto put_pages;
 	}
 
 	privs[0] = kzalloc(sizeof(struct tlbe_priv) * params.tlb_sizes[0],
 			   GFP_KERNEL);
+	if (!privs[0]) {
+		ret = -ENOMEM;
+		goto put_pages;
+	}
+
 	privs[1] = kzalloc(sizeof(struct tlbe_priv) * params.tlb_sizes[1],
 			   GFP_KERNEL);
-
-	if (!privs[0] || !privs[1]) {
+	if (!privs[1]) {
 		ret = -ENOMEM;
-		goto err_privs;
+		goto free_privs_first;
 	}
 
 	g2h_bitmap = kzalloc(sizeof(u64) * params.tlb_sizes[1],
 	                     GFP_KERNEL);
 	if (!g2h_bitmap) {
 		ret = -ENOMEM;
-		goto err_privs;
+		goto free_privs_second;
 	}
 
 	free_gtlb(vcpu_e500);
@@ -845,16 +849,14 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 
 	kvmppc_recalc_tlb1map_range(vcpu_e500);
 	return 0;
-
-err_privs:
-	kfree(privs[0]);
+ free_privs_second:
 	kfree(privs[1]);
-
-err_put_page:
+ free_privs_first:
+	kfree(privs[0]);
+ put_pages:
 	for (i = 0; i < num_pages; i++)
 		put_page(pages[i]);
-
-err_pages:
+ free_pages:
 	kfree(pages);
 	return ret;
 }
-- 
2.9.3
