Return-Path: <kelly@au1.ibm.com>
From: Kelly Daly <kelly@au1.ibm.com>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: disable OProfile for iSeries (take 2!)
Date: Wed, 21 Jun 2006 11:51:01 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606211151.01386.kelly@au.ibm.com>
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the changes from an earlier patch that disables oProfile for iSeries within the oProfile KConfig (submitted Feb 23, 2006).  Checks within the arch init for iSeries, still allowing profiling for timer interrupts.

Signed-off-by: Kelly Daly <kelly@au.ibm.com>
---


diff -urdp linux-2.6.16.20/arch/powerpc/oprofile/Kconfig linux-2.6.16.20_kel/arch/powerpc/oprofile/Kconfig
--- linux-2.6.16.20/arch/powerpc/oprofile/Kconfig	2006-06-06 03:18:23.000000000 +1000
+++ linux-2.6.16.20_kel/arch/powerpc/oprofile/Kconfig	2006-06-20 15:53:02.000000000 +1000
@@ -1,5 +1,4 @@
 config PROFILING
-	depends on !PPC_ISERIES
 	bool "Profiling support (EXPERIMENTAL)"
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
diff -urdp linux-2.6.16.20/arch/powerpc/oprofile/common.c linux-2.6.16.20_kel/arch/powerpc/oprofile/common.c
--- linux-2.6.16.20/arch/powerpc/oprofile/common.c	2006-06-06 03:18:23.000000000 +1000
+++ linux-2.6.16.20_kel/arch/powerpc/oprofile/common.c	2006-06-20 15:33:56.000000000 +1000
@@ -137,7 +137,10 @@ int __init oprofile_arch_init(struct opr
 {
 	if (!cur_cpu_spec->oprofile_cpu_type)
 		return -ENODEV;
-
+#ifdef CONFIG_PPC_ISERIES
+	return -ENODEV;
+#endif
+	
 	switch (cur_cpu_spec->oprofile_type) {
 #ifdef CONFIG_PPC64
 		case PPC_OPROFILE_RS64:
