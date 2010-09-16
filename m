Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id AC9D51007DA
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 08:49:21 +1000 (EST)
Received: from mail19-va3 (localhost.localdomain [127.0.0.1])	by
	mail19-va3-R.bigfish.com (Postfix) with ESMTP id 8CED017B00D9	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:17 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.235])	by
	mail19-va3.bigfish.com (Postfix) with ESMTP id 1C347F4004F	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:17 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GMnFaj002208	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 15:49:16 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc/kexec: make masking/disabling interrupts generic
Date: Thu, 16 Sep 2010 17:58:23 -0500
Message-ID: <1284677906-23787-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right now just the kexec crash pathway turns turns off the
interrupts. Pull that out and make a generic version for
use elsewhere

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/include/asm/kexec.h       |    1 +
 arch/powerpc/kernel/crash.c            |   13 +------------
 arch/powerpc/kernel/machine_kexec.c    |   24 ++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_32.c |    4 ++++
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 076327f..f54408d 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -91,6 +91,7 @@ extern void machine_kexec_simple(struct kimage *image);
 extern void crash_kexec_secondary(struct pt_regs *regs);
 extern int overlaps_crashkernel(unsigned long start, unsigned long size);
 extern void reserve_crashkernel(void);
+extern void machine_kexec_mask_interrupts(void);
 
 #else /* !CONFIG_KEXEC */
 static inline int kexec_sr_activated(int cpu) { return 0; }
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 4457382..832c8c4 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -414,18 +414,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	crash_kexec_wait_realmode(crashing_cpu);
 #endif
 
-	for_each_irq(i) {
-		struct irq_desc *desc = irq_to_desc(i);
-
-		if (!desc || !desc->chip || !desc->chip->eoi)
-			continue;
-
-		if (desc->status & IRQ_INPROGRESS)
-			desc->chip->eoi(i);
-
-		if (!(desc->status & IRQ_DISABLED))
-			desc->chip->shutdown(i);
-	}
+	machine_kexec_mask_interrupts();
 
 	/*
 	 * Call registered shutdown routines savely.  Swap out
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index dd6c141..df7e20c 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -14,10 +14,34 @@
 #include <linux/threads.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
+#include <linux/irq.h>
+
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/sections.h>
 
+void machine_kexec_mask_interrupts(void) {
+	unsigned int i;
+
+	for_each_irq(i) {
+		struct irq_desc *desc = irq_to_desc(i);
+
+		if (!desc || !desc->chip)
+			continue;
+
+		if (desc->chip->eoi &&
+		    desc->status & IRQ_INPROGRESS)
+			desc->chip->eoi(i);
+
+		if (desc->chip->mask)
+			desc->chip->mask(i);
+
+		if (desc->chip->disable &&
+		    !(desc->status & IRQ_DISABLED))
+			desc->chip->disable(i);
+	}
+}
+
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (ppc_md.machine_crash_shutdown)
diff --git a/arch/powerpc/kernel/machine_kexec_32.c b/arch/powerpc/kernel/machine_kexec_32.c
index ae63a96..e63f2e7 100644
--- a/arch/powerpc/kernel/machine_kexec_32.c
+++ b/arch/powerpc/kernel/machine_kexec_32.c
@@ -39,6 +39,10 @@ void default_machine_kexec(struct kimage *image)
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
+	/* mask each interrupt so we are in a more sane state for the
+	 * kexec kernel */
+	machine_kexec_mask_interrupts();
+
 	page_list = image->head;
 
 	/* we need both effective and real address here */
-- 
1.6.6.1
