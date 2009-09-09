Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EBB26B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 10:17:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 237E3DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 10:17:07 +1000 (EST)
Subject: [PATCH] Don't set DABR on 64-bit BookE, use DAC1 instead
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 10:16:58 +1000
Message-Id: <1252455418.26522.21.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also remove a duplicate setting of it in the context switch path
on BookE.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 678ff13..0a32164 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -284,14 +284,13 @@ int set_dabr(unsigned long dabr)
 		return ppc_md.set_dabr(dabr);
 
 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
-#if defined(CONFIG_PPC64) || defined(CONFIG_6xx)
-	mtspr(SPRN_DABR, dabr);
-#endif
-
 #if defined(CONFIG_BOOKE)
 	mtspr(SPRN_DAC1, dabr);
+#elif defined(CONFIG_PPC_BOOK3S)
+	mtspr(SPRN_DABR, dabr);
 #endif
 
+
 	return 0;
 }
 
@@ -372,15 +371,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 #endif /* CONFIG_SMP */
 
-	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
-		set_dabr(new->thread.dabr);
-
 #if defined(CONFIG_BOOKE)
 	/* If new thread DAC (HW breakpoint) is the same then leave it */
 	if (new->thread.dabr)
 		set_dabr(new->thread.dabr);
+#else
+	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
+		set_dabr(new->thread.dabr);
 #endif
 
+
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 
