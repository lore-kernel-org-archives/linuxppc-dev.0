Return-Path: <kernelfans@gmail.com>
Received: from mail-qa0-x22c.google.com (mail-qa0-x22c.google.com
 [IPv6:2607:f8b0:400d:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 836052C03BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 17:22:35 +1100 (EST)
Received: by mail-qa0-f44.google.com with SMTP id f11so118814qae.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 22:22:32 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/kvm: remove redundant assignment
Date: Thu,  7 Nov 2013 14:22:55 +0800
Message-Id: <1383805375-14766-2-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ret is assigned twice with the same value, so remove the later one.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index dbc1478..9b97b42 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -733,7 +733,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	lock_rmap(rmap);
 
 	/* Check if we might have been invalidated; let the guest retry if so */
-	ret = RESUME_GUEST;
 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
 		unlock_rmap(rmap);
 		goto out_unlock;
-- 
1.8.1.4
