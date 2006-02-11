Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 679AA67B2A
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Feb 2006 04:21:53 +1100 (EST)
Date: Sat, 11 Feb 2006 18:21:47 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove duplicate exports
Message-ID: <20060211172147.GA23956@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


A few symbols are exported twice, remove them from ppc_ksyms.c
Remove users of sys_ctrler in arch/ppc/

WARNING: vmlinux: duplicate symbol '__delay' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol '__up' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol '__down' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol '__down_interruptible' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'sys_ctrler' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strncat' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strncmp' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strchr' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strrchr' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strnlen' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strpbrk' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'memscan' previous definition was in vmlinux
WARNING: vmlinux: duplicate symbol 'strstr' previous definition was in vmlinux


Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/ppc_ksyms.c |   16 ----------------
 arch/ppc/kernel/ppc_ksyms.c     |    8 --------
 arch/ppc/xmon/start.c           |   15 +--------------
 include/asm-ppc/machdep.h       |   13 -------------
 4 files changed, 1 insertion(+), 51 deletions(-)

Index: linux-2.6.16-rc2-olh/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/powerpc/kernel/ppc_ksyms.c
+++ linux-2.6.16-rc2-olh/arch/powerpc/kernel/ppc_ksyms.c
@@ -78,15 +78,8 @@ EXPORT_SYMBOL(sys_sigreturn);
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strcasecmp);
 
 EXPORT_SYMBOL(csum_partial);
@@ -184,9 +177,6 @@ EXPORT_SYMBOL(adb_try_handler_change);
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 #endif /* CONFIG_ADB_CUDA */
-#ifdef CONFIG_PPC_PMAC
-EXPORT_SYMBOL(sys_ctrler);
-#endif
 #ifdef CONFIG_VT
 EXPORT_SYMBOL(kd_mksound);
 #endif
@@ -204,7 +194,6 @@ EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memchr);
 
@@ -213,7 +202,6 @@ EXPORT_SYMBOL(screen_info);
 #endif
 
 #ifdef CONFIG_PPC32
-EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
@@ -221,10 +209,6 @@ EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(cacheable_memcpy);
 #endif
 
-EXPORT_SYMBOL(__up);
-EXPORT_SYMBOL(__down);
-EXPORT_SYMBOL(__down_interruptible);
-
 #ifdef  CONFIG_8xx
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
Index: linux-2.6.16-rc2-olh/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/ppc/kernel/ppc_ksyms.c
+++ linux-2.6.16-rc2-olh/arch/ppc/kernel/ppc_ksyms.c
@@ -93,15 +93,8 @@ EXPORT_SYMBOL(test_and_change_bit);
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strcasecmp);
 EXPORT_SYMBOL(__div64_32);
 
@@ -253,7 +246,6 @@ EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memchr);
 
Index: linux-2.6.16-rc2-olh/include/asm-ppc/machdep.h
===================================================================
--- linux-2.6.16-rc2-olh.orig/include/asm-ppc/machdep.h
+++ linux-2.6.16-rc2-olh/include/asm-ppc/machdep.h
@@ -154,19 +154,6 @@ extern char cmd_line[COMMAND_LINE_SIZE];
 
 extern void setup_pci_ptrs(void);
 
-/*
- * Power macintoshes have either a CUDA or a PMU controlling
- * system reset, power, NVRAM, RTC.
- */
-typedef enum sys_ctrler_kind {
-	SYS_CTRLER_UNKNOWN = 0,
-	SYS_CTRLER_CUDA = 1,
-	SYS_CTRLER_PMU = 2,
-	SYS_CTRLER_SMU = 3,
-} sys_ctrler_t;
-
-extern sys_ctrler_t sys_ctrler;
-
 #ifdef CONFIG_SMP
 struct smp_ops_t {
 	void  (*message_pass)(int target, int msg);
Index: linux-2.6.16-rc2-olh/arch/ppc/xmon/start.c
===================================================================
--- linux-2.6.16-rc2-olh.orig/arch/ppc/xmon/start.c
+++ linux-2.6.16-rc2-olh/arch/ppc/xmon/start.c
@@ -146,19 +146,6 @@ xmon_map_scc(void)
 static int scc_initialized = 0;
 
 void xmon_init_scc(void);
-extern void cuda_poll(void);
-
-static inline void do_poll_adb(void)
-{
-#ifdef CONFIG_ADB_PMU
-	if (sys_ctrler == SYS_CTRLER_PMU)
-		pmu_poll_adb();
-#endif /* CONFIG_ADB_PMU */
-#ifdef CONFIG_ADB_CUDA
-	if (sys_ctrler == SYS_CTRLER_CUDA)
-		cuda_poll();
-#endif /* CONFIG_ADB_CUDA */
-}
 
 int
 xmon_write(void *handle, void *ptr, int nb)
@@ -189,7 +176,7 @@ xmon_write(void *handle, void *ptr, int 
 	ct = 0;
 	for (i = 0; i < nb; ++i) {
 		while ((*sccc & TXRDY) == 0)
-			do_poll_adb();
+			;
 		c = p[i];
 		if (c == '\n' && !ct) {
 			c = '\r';
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
