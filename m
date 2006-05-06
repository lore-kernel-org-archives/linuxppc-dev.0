Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <445BE72D.3050205@am.sony.com>
Date: Fri, 05 May 2006 17:00:45 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] powerpc: remove do-nothing cpu setup routines
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removes the processor specific do-nothing routines __setup_cpu_power3 and
__setup_cpu_power4 with the generic routine __setup_cpu_null.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/cpu_setup_power4.S	2006-05-05 15:59:58.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S	2006-05-05 16:40:44.000000000 -0700
@@ -73,9 +73,6 @@
 	isync
 	blr

-_GLOBAL(__setup_cpu_power4)
-	blr
-
 _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
Index: cell--alp--3/arch/powerpc/kernel/cputable.c
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/cputable.c	2006-05-05 16:29:06.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cputable.c	2006-05-05 16:40:41.000000000 -0700
@@ -32,8 +32,6 @@
  */
 #ifdef CONFIG_PPC64
 extern void __setup_cpu_null(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
 #else
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
@@ -80,7 +78,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "power3",
@@ -94,7 +92,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "power3",
@@ -108,7 +106,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -122,7 +120,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -136,7 +134,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -150,7 +148,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -164,7 +162,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power4,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power4",
@@ -178,7 +176,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power4,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power4",
@@ -244,7 +242,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_power4,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/power5",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5",
@@ -258,7 +256,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_power4,
+		.cpu_setup		= __setup_cpu_null,
 		.oprofile_cpu_type	= "ppc64/power5+",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5+",
@@ -285,7 +283,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_power4,
+		.cpu_setup		= __setup_cpu_null,
 		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC64 */
Index: cell--alp--3/arch/powerpc/kernel/misc_64.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/misc_64.S	2006-05-05 16:04:59.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/misc_64.S	2006-05-05 16:40:47.000000000 -0700
@@ -771,9 +771,6 @@
 _GLOBAL(__setup_cpu_null)
 	blr

-_GLOBAL(__setup_cpu_power3)
-	blr
-
 _GLOBAL(execve)
 	li	r0,__NR_execve
 	sc
