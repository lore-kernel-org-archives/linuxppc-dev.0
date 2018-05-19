Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nsgK497vzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 14:36:13 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id bi12-v6so5690161plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 21:36:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] powerpc/64: hard disable irqs on the panic()ing CPU
Date: Sat, 19 May 2018 14:35:54 +1000
Message-Id: <20180519043554.26640-4-npiggin@gmail.com>
In-Reply-To: <20180519043554.26640-1-npiggin@gmail.com>
References: <20180519043554.26640-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to previous patches, hard disable interrupts when a CPU is
in panic. This reduces the chance the watchdog has to interfere with
the panic, and avoids any other type of masked interrupt being
executed when crashing which minimises the length of the crash path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 0af5c11b9e78..d45fb522fe8a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -706,12 +706,19 @@ EXPORT_SYMBOL(check_legacy_ioport);
 static int ppc_panic_event(struct notifier_block *this,
                              unsigned long event, void *ptr)
 {
+	/*
+	 * panic does a local_irq_disable, but we really
+	 * want interrupts to be hard disabled.
+	 */
+	hard_irq_disable();
+
 	/*
 	 * If firmware-assisted dump has been registered then trigger
 	 * firmware-assisted dump and let firmware handle everything else.
 	 */
 	crash_fadump(NULL, ptr);
-	ppc_md.panic(ptr);  /* May not return */
+	if (ppc_md.panic)
+		ppc_md.panic(ptr);  /* May not return */
 	return NOTIFY_DONE;
 }
 
@@ -722,7 +729,8 @@ static struct notifier_block ppc_panic_block = {
 
 void __init setup_panic(void)
 {
-	if (!ppc_md.panic)
+	/* PPC64 always does a hard irq disable in its panic handler */
+	if (!IS_ENABLED(CONFIG_PPC64) && !ppc_md.panic)
 		return;
 	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
 }
-- 
2.17.0
