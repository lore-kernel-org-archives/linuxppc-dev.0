Return-Path: <kernelfans@gmail.com>
Received: from mail-oa0-x22e.google.com (mail-oa0-x22e.google.com
 [IPv6:2607:f8b0:4003:c02::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F22D2C034F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 18:42:30 +1100 (EST)
Received: by mail-oa0-f46.google.com with SMTP id g12so8269731oah.19
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2013 23:42:27 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 3/3] powerpc/kvm: remove redundant assignment
Date: Tue,  5 Nov 2013 15:42:44 +0800
Message-Id: <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 28160ac..7682837 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -731,7 +731,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	lock_rmap(rmap);
 
 	/* Check if we might have been invalidated; let the guest retry if so */
-	ret = RESUME_GUEST;
 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
 		unlock_rmap(rmap);
 		goto out_unlock;
-- 
1.8.1.4
