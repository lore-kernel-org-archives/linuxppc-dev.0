Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4F8C67E05
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:58:12 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAFIwUf2027982
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 13:58:30 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAFIvj04246938
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 13:57:50 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAFIviGO002373
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 13:57:45 -0500
Date: Wed, 15 Nov 2006 12:57:44 -0600
To: paulus@samba.org
Subject: [PATCH]: wrap cpu_die() with CONFIG_HOTPLUG_CPU
Message-ID: <20061115185743.GH8395@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Srinivasa Ds <srinivasa@in.ibm.com>,
	Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Paul,

Please apply the janitorial patch below. Its not urgent.
It replaces/obsoletes the previous Subject: [PATCH]: 
PowerPC: make sure the rtas stop-self token is defined.
patch.

--linas

Per email discussion, it appears that rtas_stop_self()
and pSeries_mach_cpu_die() should not be compiled if 
CONFIG_HOTPLUG_CPU is not defined. This patch adds
#ifdefs around these bits of code.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/kernel/rtas.c             |    5 +++--
 arch/powerpc/platforms/pseries/setup.c |    4 ++++
 include/asm-powerpc/rtas.h             |    4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc4-git3/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/arch/powerpc/kernel/rtas.c	2006-11-15 11:40:14.000000000 -0600
+++ linux-2.6.19-rc4-git3/arch/powerpc/kernel/rtas.c	2006-11-15 12:46:51.000000000 -0600
@@ -810,9 +810,9 @@ asmlinkage int ppc_rtas(struct rtas_args
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /* This version can't take the spinlock, because it never returns */
-
-struct rtas_args rtas_stop_self_args = {
+static struct rtas_args rtas_stop_self_args = {
 	/* The token is initialized for real in setup_system() */
 	.token = RTAS_UNKNOWN_SERVICE,
 	.nargs = 0,
@@ -834,6 +834,7 @@ void rtas_stop_self(void)
 
 	panic("Alas, I survived.\n");
 }
+#endif
 
 /*
  * Call early during boot, before mem init or bootmem, to retrieve the RTAS
Index: linux-2.6.19-rc4-git3/include/asm-powerpc/rtas.h
===================================================================
--- linux-2.6.19-rc4-git3.orig/include/asm-powerpc/rtas.h	2006-11-01 16:15:46.000000000 -0600
+++ linux-2.6.19-rc4-git3/include/asm-powerpc/rtas.h	2006-11-15 11:44:24.000000000 -0600
@@ -54,8 +54,6 @@ struct rtas_args {
 	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 };  
 
-extern struct rtas_args rtas_stop_self_args;
-
 struct rtas_t {
 	unsigned long entry;		/* physical address pointer */
 	unsigned long base;		/* physical address pointer */
@@ -223,7 +221,9 @@ extern int rtas_get_error_log_max(void);
 extern spinlock_t rtas_data_buf_lock;
 extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
 
+#ifdef CONFIG_HOTPLUG_CPU
 extern void rtas_stop_self(void);
+#endif
 
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
Index: linux-2.6.19-rc4-git3/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/arch/powerpc/platforms/pseries/setup.c	2006-11-01 16:15:09.000000000 -0600
+++ linux-2.6.19-rc4-git3/arch/powerpc/platforms/pseries/setup.c	2006-11-15 11:46:10.000000000 -0600
@@ -347,6 +347,7 @@ static int __init pSeries_init_panel(voi
 }
 arch_initcall(pSeries_init_panel);
 
+#ifdef CONFIG_HOTPLUG_CPU
 static void pSeries_mach_cpu_die(void)
 {
 	local_irq_disable();
@@ -357,6 +358,7 @@ static void pSeries_mach_cpu_die(void)
 	BUG();
 	for(;;);
 }
+#endif
 
 static int pseries_set_dabr(unsigned long dabr)
 {
@@ -558,7 +560,9 @@ define_machine(pseries) {
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
+#ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= pSeries_mach_cpu_die,
+#endif
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
