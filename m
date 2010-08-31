Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 06091B715D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 27/35] KVM: PPC: Enable napping only for Book3s_64
Date: Tue, 31 Aug 2010 04:32:08 +0200
Message-Id: <1283221937-21006-28-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before I incorrectly enabled napping also for BookE, which would result in
needless dcache flushes. Since we only need to force enable napping on
Book3s_64 because it doesn't go into MSR_POW otherwise, we can just #ifdef
that code to this particular platform.

Reported-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 95aed6b..293765a 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -583,8 +583,10 @@ static int __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
 		kvm_use_magic_page();
 
+#ifdef CONFIG_PPC_BOOK3S_64
 	/* Enable napping */
 	powersave_nap = 1;
+#endif
 
 free_tmp:
 	kvm_free_tmp();
-- 
1.6.0.2
