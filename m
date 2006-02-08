Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D601568A1B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:18:30 +1100 (EST)
To: torvalds@osdl.org
Subject: [PATCH 07/29] ppc: last_task_.... is defined only on non-SMP
Message-Id: <E1F6fqd-0006Bx-0m@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:27 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1137641660 -0500

... so it should be exported only on non-SMP.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/ppc/kernel/ppc_ksyms.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

3ba9d91208a71947b69d52e3ca2142306457d816
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 3a6e4bc..15bd9b4 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -186,11 +186,15 @@ EXPORT_SYMBOL(flush_tlb_kernel_range);
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(_tlbie);
 #ifdef CONFIG_ALTIVEC
+#ifndef CONFIG_SMP
 EXPORT_SYMBOL(last_task_used_altivec);
+#endif
 EXPORT_SYMBOL(giveup_altivec);
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
+#ifndef CONFIG_SMP
 EXPORT_SYMBOL(last_task_used_spe);
+#endif
 EXPORT_SYMBOL(giveup_spe);
 #endif /* CONFIG_SPE */
 #ifdef CONFIG_SMP
-- 
0.99.9.GIT
