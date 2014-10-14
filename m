Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07DBF1A0228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 12:24:38 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Remove ppc64_boot_msg
Date: Tue, 14 Oct 2014 12:24:35 +1100
Message-Id: <1413249875-25551-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc64_boot_msg is meant to be a boot debug aid, but
is only used in one spot. Get rid of it, and save
ourseleves a couple of lines in the kernel log
buffer.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/machdep.h | 10 ----------
 arch/powerpc/kernel/setup_64.c     | 29 -----------------------------
 2 files changed, 39 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 327e8dd..6ac6dfd 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -341,16 +341,6 @@ extern sys_ctrler_t sys_ctrler;
 
 #endif /* CONFIG_PPC_PMAC */
 
-
-/* Functions to produce codes on the leds.
- * The SRC code should be unique for the message category and should
- * be limited to the lower 24 bits (the upper 8 are set by these funcs),
- * and (for boot & dump) should be sorted numerically in the order
- * the events occur.
- */
-/* Print a boot progress message. */
-void ppc64_boot_msg(unsigned int src, const char *msg);
-
 static inline void log_error(char *buf, unsigned int err_type, int fatal)
 {
 	if (ppc_md.log_error)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 317e96a..1b56320 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -665,8 +665,6 @@ static void __init emergency_stack_init(void)
  */
 void __init setup_arch(char **cmdline_p)
 {
-	ppc64_boot_msg(0x12, "Setup Arch");
-
 	*cmdline_p = boot_command_line;
 
 	/*
@@ -711,33 +709,6 @@ void __init setup_arch(char **cmdline_p)
 	if ((unsigned long)_stext & 0xffff)
 		panic("Kernelbase not 64K-aligned (0x%lx)!\n",
 		      (unsigned long)_stext);
-
-	ppc64_boot_msg(0x15, "Setup Done");
-}
-
-
-/* ToDo: do something useful if ppc_md is not yet setup. */
-#define PPC64_LINUX_FUNCTION 0x0f000000
-#define PPC64_IPL_MESSAGE 0xc0000000
-#define PPC64_TERM_MESSAGE 0xb0000000
-
-static void ppc64_do_msg(unsigned int src, const char *msg)
-{
-	if (ppc_md.progress) {
-		char buf[128];
-
-		sprintf(buf, "%08X\n", src);
-		ppc_md.progress(buf, 0);
-		snprintf(buf, 128, "%s", msg);
-		ppc_md.progress(buf, 0);
-	}
-}
-
-/* Print a boot progress message. */
-void ppc64_boot_msg(unsigned int src, const char *msg)
-{
-	ppc64_do_msg(PPC64_LINUX_FUNCTION|PPC64_IPL_MESSAGE|src, msg);
-	printk("[boot]%04x %s\n", src, msg);
 }
 
 #ifdef CONFIG_SMP
-- 
1.9.1
