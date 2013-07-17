Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93DBB2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 01:11:01 +1000 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 12:10:47 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 42AF43520027
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 11:10:38 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6HF9KAk27787514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 12:09:20 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6HFAbk2001071
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 12:10:37 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] KVM: PPC: Book3S PR: return appropriate error when allocation
 fails
Date: Wed, 17 Jul 2013 12:10:29 -0300
Message-Id: <1374073829-28246-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

err was overwritten by a previous function call, and checked to be 0. If
the following page allocation fails, 0 is going to be returned instead
of -ENOMEM.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_pr.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 19498a5..c6e13d9 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1047,11 +1047,12 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto free_shadow_vcpu;
 
+	err = -ENOMEM;
 	p = __get_free_page(GFP_KERNEL|__GFP_ZERO);
-	/* the real shared page fills the last 4k of our page */
-	vcpu->arch.shared = (void*)(p + PAGE_SIZE - 4096);
 	if (!p)
 		goto uninit_vcpu;
+	/* the real shared page fills the last 4k of our page */
+	vcpu->arch.shared = (void *)(p + PAGE_SIZE - 4096);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* default to book3s_64 (970fx) */
-- 
1.7.1
