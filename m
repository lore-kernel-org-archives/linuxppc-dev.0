Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 54C20B7175
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 34/35] KVM: PPC: Fix compile error in e500_tlb.c
Date: Tue, 31 Aug 2010 04:32:15 +0200
Message-Id: <1283221937-21006-35-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e500_tlb.c file didn't compile for me due to the following error:

arch/powerpc/kvm/e500_tlb.c: In function ‘kvmppc_e500_shadow_map’:
arch/powerpc/kvm/e500_tlb.c:300: error: format ‘%lx’ expects type ‘long unsigned int’, but argument 2 has type ‘gfn_t’

So let's explicitly cast the argument to make printk happy.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/e500_tlb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index a413883..d6d6d47 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -297,7 +297,8 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	/* Get reference to new page. */
 	new_page = gfn_to_page(vcpu_e500->vcpu.kvm, gfn);
 	if (is_error_page(new_page)) {
-		printk(KERN_ERR "Couldn't get guest page for gfn %lx!\n", gfn);
+		printk(KERN_ERR "Couldn't get guest page for gfn %lx!\n",
+				(long)gfn);
 		kvm_release_page_clean(new_page);
 		return;
 	}
-- 
1.6.0.2
