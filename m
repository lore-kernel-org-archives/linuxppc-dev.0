Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC62467AA0
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:44:58 +1000 (EST)
Date: Thu, 29 Jun 2006 08:25:20 -0500 (CDT)
Message-Id: <200606291325.k5TDPK0f098172@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [1/5][POWERPC] boot: prepare for zImage.kexec
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the initializations of prom variables to boot/prom.c
to allow it to be replaced for kexec.   Kexec does not care about
the stdout handle, but will care about the location of the device
tree and will search for RTAS.

It also checks if we stop trying to claim so that we print an error
instead of storing to address -1.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2006-06-29 02:14:51.347560058 -0500
+++ kernel/arch/powerpc/boot/main.c	2006-06-29 02:14:57.344543429 -0500
@@ -17,14 +17,12 @@
 #include "prom.h"
 #include "zlib.h"
 
-extern void flush_cache(void *, unsigned long);
-
-
 /* Value picked to match that used by yaboot */
 #define PROG_START	0x01400000	/* only used on 64-bit systems */
-#define RAM_END		(512<<20)	/* Fixme: use OF */
 #define	ONE_MB		0x100000
 
+unsigned long ram_end;		/* end of usable memory, set by init_prom */
+
 extern char _start[];
 extern char __bss_start[];
 extern char _end[];
@@ -119,7 +117,7 @@ static unsigned long try_claim(unsigned 
 {
 	unsigned long addr = 0;
 
-	for(; claim_base < RAM_END; claim_base += ONE_MB) {
+	for(; claim_base < ram_end; claim_base += ONE_MB) {
 #ifdef DEBUG
 		printf("    trying: 0x%08lx\n\r", claim_base);
 #endif
@@ -127,7 +125,7 @@ static unsigned long try_claim(unsigned 
 		if ((void *)addr != (void *)-1)
 			break;
 	}
-	if (addr == 0)
+	if ((addr == 0) || (void *)addr == (void *)-1)
 		return 0;
 	claim_base = PAGE_ALIGN(claim_base + size);
 	return addr;
@@ -211,12 +209,7 @@ void start(unsigned long a1, unsigned lo
 
 	memset(__bss_start, 0, _end - __bss_start);
 
-	prom = (int (*)(void *)) promptr;
-	chosen_handle = finddevice("/chosen");
-	if (chosen_handle == (void *) -1)
-		exit();
-	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
-		exit();
+	init_prom(a1, a2, promptr);
 
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
 
@@ -297,6 +290,7 @@ void start(unsigned long a1, unsigned lo
 	vmlinux.addr += elfoffset;
 
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
+	prom_smp_hook(vmlinux.addr);
 
 	kernel_entry = (kernel_entry_t)vmlinux.addr;
 #ifdef DEBUG
Index: kernel/arch/powerpc/boot/prom.c
===================================================================
--- kernel.orig/arch/powerpc/boot/prom.c	2006-06-29 02:14:51.379554992 -0500
+++ kernel/arch/powerpc/boot/prom.c	2006-06-29 02:48:30.069204787 -0500
@@ -16,6 +16,22 @@ int (*prom)(void *);
 phandle chosen_handle;
 ihandle stdout;
 
+void init_prom(unsigned long a1, unsigned long a2, void *p)
+{
+	prom = (int (*)(void *)) p;
+	chosen_handle = finddevice("/chosen");
+	if (chosen_handle == (void *) -1)
+		exit();
+	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
+		exit();
+	ram_end = (512<<20);	/* Fixme: use OF */
+}
+
+void prom_smp_hook(unsigned long kernel_start)
+{
+	return;
+}
+
 int call_prom(const char *service, int nargs, int nret, ...)
 {
 	int i;
Index: kernel/arch/powerpc/boot/prom.h
===================================================================
--- kernel.orig/arch/powerpc/boot/prom.h	2006-06-29 02:14:51.429547077 -0500
+++ kernel/arch/powerpc/boot/prom.h	2006-06-29 02:14:57.348542796 -0500
@@ -12,8 +12,10 @@ int	call_prom(const char *service, int n
 int	call_prom_ret(const char *service, int nargs, int nret,
 		      unsigned int *rets, ...);
 
-extern int write(void *handle, void *ptr, int nb);
-extern void *claim(unsigned long virt, unsigned long size, unsigned long aln);
+void init_prom(unsigned long a1, unsigned long a2, void *p);
+void prom_smp_hook(unsigned long kernel_start);
+int write(void *handle, void *ptr, int nb);
+void *claim(unsigned long virt, unsigned long size, unsigned long aln);
 
 static inline void exit(void)
 {
@@ -31,4 +33,9 @@ static inline int getprop(void *phandle,
 	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
 }
 
+
+extern unsigned long ram_end;		/* end of usable memory */
+
+extern void flush_cache(void *, unsigned long);
+
 #endif				/* _PPC_BOOT_PROM_H_ */
