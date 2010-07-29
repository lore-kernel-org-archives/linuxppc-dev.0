Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id A93E91007DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 23:04:24 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 7/7] KVM: PPC: Move KVM trampolines before __end_interrupts
Date: Thu, 29 Jul 2010 15:04:22 +0200
Message-Id: <1280408662-10328-8-git-send-email-agraf@suse.de>
In-Reply-To: <1280408662-10328-1-git-send-email-agraf@suse.de>
References: <1280408662-10328-1-git-send-email-agraf@suse.de>
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

When using a relocatable kernel we need to make sure that the trampline code
and the interrupt handlers are both copied to low memory. The only way to do
this reliably is to put them in the copied section.

This patch should make relocated kernels work with KVM.

KVM-Stable-Tag
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/exceptions-64s.S |    6 ++++++
 arch/powerpc/kernel/head_64.S        |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3e423fb..a0f25fb 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -299,6 +299,12 @@ slb_miss_user_pseries:
 	b	.				/* prevent spec. execution */
 #endif /* __DISABLED__ */
 
+/* KVM's trampoline code needs to be close to the interrupt handlers */
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#include "../kvm/book3s_rmhandlers.S"
+#endif
+
 	.align	7
 	.globl	__end_interrupts
 __end_interrupts:
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 844a44b..d3010a3 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -166,12 +166,6 @@ exception_marker:
 #include "exceptions-64s.S"
 #endif
 
-/* KVM trampoline code needs to be close to the interrupt handlers */
-
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-#include "../kvm/book3s_rmhandlers.S"
-#endif
-
 _GLOBAL(generic_secondary_thread_init)
 	mr	r24,r3
 
-- 
1.6.0.2
