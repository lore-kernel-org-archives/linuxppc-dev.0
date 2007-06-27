Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/3] Abolish unused ucBoardRev variables
In-Reply-To: <20070627065335.GD11191@localhost.localdomain>
Message-Id: <20070627065458.5AE10DDF2A@ozlabs.org>
Date: Wed, 27 Jun 2007 16:54:58 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

asm-powerpc/processor.h declares, and arch/ppc/platforms/prep_setup.c
defines variables ucBoardRev, ucBoardRevMaj and ucBoardRevMin which
are used nowhere in the current kernel (neither in arch/ppc nor
arch/powerpc).  This patch removes them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/ppc/platforms/prep_setup.c |    3 ---
 include/asm-powerpc/processor.h |    8 --------
 2 files changed, 11 deletions(-)

Index: working-2.6/arch/ppc/platforms/prep_setup.c
===================================================================
--- working-2.6.orig/arch/ppc/platforms/prep_setup.c	2007-06-19 16:38:20.000000000 +1000
+++ working-2.6/arch/ppc/platforms/prep_setup.c	2007-06-19 16:38:23.000000000 +1000
@@ -69,9 +69,6 @@
 
 TODC_ALLOC();
 
-unsigned char ucBoardRev;
-unsigned char ucBoardRevMaj, ucBoardRevMin;
-
 extern unsigned char prep_nvram_read_val(int addr);
 extern void prep_nvram_write_val(int addr,
 				 unsigned char val);
Index: working-2.6/include/asm-powerpc/processor.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/processor.h	2007-06-19 16:38:03.000000000 +1000
+++ working-2.6/include/asm-powerpc/processor.h	2007-06-19 16:38:09.000000000 +1000
@@ -43,14 +43,6 @@ extern int _chrp_type;
 /* what kind of prep workstation we are */
 extern int _prep_type;
 
-/*
- * This is used to identify the board type from a given PReP board
- * vendor. Board revision is also made available. This will be moved
- * elsewhere soon
- */
-extern unsigned char ucBoardRev;
-extern unsigned char ucBoardRevMaj, ucBoardRevMin;
-
 #endif /* CONFIG_PPC_PREP */
 
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
