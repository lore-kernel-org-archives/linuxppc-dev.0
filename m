Return-Path: <baiyaowei@cmss.chinamobile.com>
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by lists.ozlabs.org (Postfix) with ESMTP id A91CD1A064D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 14:19:39 +1100 (AEDT)
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: agraf@suse.sz, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, gleb@kernel.org, pbonzini@redhat.com
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: powerpc: kvmppc_visible_gpa can be boolean
Date: Mon, 16 Nov 2015 11:10:24 +0800
Message-Id: <1447643424-4058-1-git-send-email-baiyaowei@cmss.chinamobile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In another patch kvm_is_visible_gfn is maken return bool due to this
function only returns zero or one as its return value, let's also make
kvmppc_visible_gpa return bool to keep consistent.

No functional change.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 arch/powerpc/kvm/book3s_pr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 64891b0..70fb08d 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -512,7 +512,7 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 	put_page(hpage);
 }
 
-static int kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+static bool kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	ulong mp_pa = vcpu->arch.magic_page_pa;
 
@@ -521,7 +521,7 @@ static int kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 
 	gpa &= ~0xFFFULL;
 	if (unlikely(mp_pa) && unlikely((mp_pa & KVM_PAM) == (gpa & KVM_PAM))) {
-		return 1;
+		return true;
 	}
 
 	return kvm_is_visible_gfn(vcpu->kvm, gpa >> PAGE_SHIFT);
-- 
1.9.1
