Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 71B57B7098
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 12/27] KVM: PPC: First magic page steps
Date: Thu,  1 Jul 2010 12:42:47 +0200
Message-Id: <1277980982-12433-13-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
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
index fdfb7f0..14be0f3 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -286,6 +286,8 @@ struct kvm_vcpu_arch {
 	u64 dec_jiffies;
 	unsigned long pending_exceptions;
 	struct kvm_vcpu_arch_shared *shared;
+	unsigned long magic_page_pa; /* phys addr to map the magic page to */
+	unsigned long magic_page_ea; /* effect. addr to map the magic page to */
 
 #ifdef CONFIG_PPC_BOOK3S
 	struct hlist_head hpte_hash_pte[HPTEG_HASH_NUM_PTE];
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
