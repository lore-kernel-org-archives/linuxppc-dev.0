Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 02 May 2006 14:05:51 +1000
Subject: [PATCH] powerpc: Remove remaining iSeries debugger cruft
In-Reply-To: <1145386937.20493.33.camel@localhost.localdomain>
Message-Id: <20060502040557.DE09667C13@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This isn't needed anymore, as no one is using this debugger. Doesn't have
any effect on early debug output etc.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/head_64.S |    9 ---------
 1 file changed, 9 deletions(-)

Index: to-merge/arch/powerpc/kernel/head_64.S
===================================================================
--- to-merge.orig/arch/powerpc/kernel/head_64.S
+++ to-merge/arch/powerpc/kernel/head_64.S
@@ -93,15 +93,6 @@ END_FTR_SECTION(0, 1)
 	. = 0x20
 	.llong hvReleaseData-KERNELBASE
 
-	/*
-	 * At offset 0x28 and 0x30 are offsets to the mschunks_map
-	 * array (used by the iSeries LPAR debugger to do translation
-	 * between physical addresses and absolute addresses) and
-	 * to the pidhash table (also used by the debugger)
-	 */
-	.llong mschunks_map-KERNELBASE
-	.llong 0	/* pidhash-KERNELBASE SFRXXX */
-
 	/* Offset 0x38 - Pointer to start of embedded System.map */
 	.globl	embedded_sysmap_start
 embedded_sysmap_start:
