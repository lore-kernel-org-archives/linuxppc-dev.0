Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 Feb 2007 11:48:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [powerpc] Compile fixes for arch/powerpc dcr code
Message-ID: <20070206004828.GC20123@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, please apply.

The new dcr code does not currently compile when configured for native
DCR access on ARCH=powerpc.  This patch fixes the problems.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/ppc_ksyms.c	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/ppc_ksyms.c	2007-02-06 11:34:54.000000000 +1100
@@ -44,6 +44,7 @@
 #include <asm/btext.h>
 #include <asm/div64.h>
 #include <asm/signal.h>
+#include <asm/dcr.h>
 
 #ifdef  CONFIG_8xx
 #include <asm/commproc.h>
Index: working-2.6/include/asm-powerpc/dcr.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/dcr.h	2007-01-24 12:01:20.000000000 +1100
+++ working-2.6/include/asm-powerpc/dcr.h	2007-02-06 11:34:54.000000000 +1100
@@ -33,6 +33,7 @@
  * base from the device-tree
  */
 #ifdef CONFIG_PPC_MERGE
+struct device_node;
 extern unsigned int dcr_resource_start(struct device_node *np,
 				       unsigned int index);
 extern unsigned int dcr_resource_len(struct device_node *np,
Index: working-2.6/include/asm-ppc/reg_booke.h
===================================================================
--- working-2.6.orig/include/asm-ppc/reg_booke.h	2007-01-24 12:01:20.000000000 +1100
+++ working-2.6/include/asm-ppc/reg_booke.h	2007-02-06 11:34:54.000000000 +1100
@@ -9,8 +9,6 @@
 #ifndef __ASM_PPC_REG_BOOKE_H__
 #define __ASM_PPC_REG_BOOKE_H__
 
-#include <asm/dcr.h>
-
 #ifndef __ASSEMBLY__
 /* Performance Monitor Registers */
 #define mfpmr(rn)	({unsigned int rval; \
Index: working-2.6/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- working-2.6.orig/arch/ppc/kernel/ppc_ksyms.c	2007-02-06 11:38:28.000000000 +1100
+++ working-2.6/arch/ppc/kernel/ppc_ksyms.c	2007-02-06 11:38:39.000000000 +1100
@@ -43,6 +43,7 @@
 #include <asm/div64.h>
 #include <asm/xmon.h>
 #include <asm/signal.h>
+#include <asm/dcr.h>
 
 #ifdef  CONFIG_8xx
 #include <asm/commproc.h>
Index: working-2.6/include/asm-ppc/ibm4xx.h
===================================================================
--- working-2.6.orig/include/asm-ppc/ibm4xx.h	2007-02-06 11:39:13.000000000 +1100
+++ working-2.6/include/asm-ppc/ibm4xx.h	2007-02-06 11:39:27.000000000 +1100
@@ -15,6 +15,7 @@
 #define __ASM_IBM4XX_H__
 
 #include <asm/types.h>
+#include <asm/dcr.h>
 
 #ifdef CONFIG_40x
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
