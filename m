Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 41FF91008ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:23 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 12/26] KVM: PPC: First magic page steps
Date: Sat, 26 Jun 2010 01:25:00 +0200
Message-Id: <1277508314-915-13-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will be introducing a method to project the shared page in guest context.
As soon as we're talking about this coupling, the shared page is colled magic
page.

This patch introduces simple defines, so the follow-up patches are easier to
read.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    2 ++
 include/linux/kvm_para.h            |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e35c1ac..5f8c214 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -285,6 +285,8 @@ struct kvm_vcpu_arch {
 	u64 dec_jiffies;
 	unsigned long pending_exceptions;
 	struct kvm_vcpu_arch_shared *shared;
+	unsigned long magic_page_pa; /* phys addr to map the magic page to */
+	unsigned long magic_page_ea; /* effect. addr to map the magic page to */
 
 #ifdef CONFIG_PPC_BOOK3S
 	struct kmem_cache *hpte_cache;
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 3b8080e..ac2015a 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -18,6 +18,7 @@
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
 #define KVM_HC_FEATURES			3
+#define KVM_HC_PPC_MAP_MAGIC_PAGE	4
 
 /*
  * hypercalls use architecture specific
-- 
1.6.0.2
