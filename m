Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EBCCDDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 17:04:27 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5Q74Gtc023650
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 02:04:17 -0500
Date: Thu, 26 Jun 2008 02:04:16 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/kprobes: Some minor fixes
Message-ID: <Pine.LNX.4.64.0806260204030.13731@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Mark __flush_icache_range as a function that can't be probed since its
  used by the kprobe code.

* Fix an issue with single stepping and async exceptions.  We need to
  ensure that we dont get an async exception (external, decrementer, etc)
  while we are attempting to single step the probe point.

  Added a check to ensure we only handle a single step if its really
  intended for the instruction in question.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/kprobes.c |    9 +++++++++
 arch/powerpc/kernel/misc_32.S |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 23545a2..74693d9 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -95,6 +95,11 @@ void __kprobes arch_remove_kprobe(struct kprobe *p)

 static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
+	/* We turn off async exceptions to ensure that the single step will
+	 * be for the instruction we have the kprobe on, if we dont its
+	 * possible we'd get the single step reported for an exception handler
+	 * like Decrementer or External Interrupt */
+	regs->msr &= ~MSR_EE;
 	regs->msr |= MSR_SE;

 	/*
@@ -376,6 +381,10 @@ static int __kprobes post_kprobe_handler(struct pt_regs *regs)
 	if (!cur)
 		return 0;

+	/* make sure we got here for instruction we have a kprobe on */
+	if (((unsigned long)cur->ainsn.insn + 4) != regs->nip)
+		return 0;
+
 	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;
 		cur->post_handler(cur, regs, 0);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 89aaaa6..6321ae3 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -489,7 +489,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  *
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
-_GLOBAL(__flush_icache_range)
+_KPROBE(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
-- 
1.5.5.1
