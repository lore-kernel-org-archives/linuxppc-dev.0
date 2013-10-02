Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E44212C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 00:38:56 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Oct 2013 20:08:50 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3A587E0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 20:09:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r92EfH0232768058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 20:11:17 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r92EckKL002637
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 20:08:47 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] kvm: powerpc: book3s: Fix build break for BOOK3S_32
Date: Wed,  2 Oct 2013 20:08:44 +0530
Message-Id: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This was introduced by 85a0d845d8bb5df5d2669416212f56cbe1474c6b

arch/powerpc/kvm/book3s_pr.c: In function 'kvmppc_core_vcpu_create':
arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 8941885..6075dbd 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1179,7 +1179,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 
 #ifdef CONFIG_KVM_BOOK3S_32
 	vcpu->arch.shadow_vcpu =
-		kzalloc(sizeof(*vcpu_book3s->shadow_vcpu), GFP_KERNEL);
+		kzalloc(sizeof(*vcpu->arch.shadow_vcpu), GFP_KERNEL);
 	if (!vcpu->arch.shadow_vcpu)
 		goto free_vcpu3s;
 #endif
-- 
1.8.1.2
