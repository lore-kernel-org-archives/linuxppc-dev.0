Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C4DBEB7C0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:53 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:42 +1000
Subject: [PATCH 7/20] powerpc: Modify some ppc_asm.h macros to accomodate
	64-bits Book3E
Message-Id: <20090723055953.B6F57DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The way I intend to use tophys/tovirt on 64-bit BookE is different
from the "trick" that we currently play for 32-bit BookE so change
the condition of definition of these macros to make it so.

Also, make sure we only use rfid and mtmsrd instead of rfi and mtmsr
for 64-bit server processors, not all 64-bit processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/ppc_asm.h |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/ppc_asm.h	2009-07-22 15:53:06.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/ppc_asm.h	2009-07-22 15:58:24.000000000 +1000
@@ -375,8 +375,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define PPC440EP_ERR42
 #endif
 
-
-#if defined(CONFIG_BOOKE)
+/*
+ * toreal/fromreal/tophys/tovirt macros. 32-bit BookE makes them
+ * keep the address intact to be compatible with code shared with
+ * 32-bit classic.
+ *
+ * On the other hand, I find it useful to have them behave as expected
+ * by their name (ie always do the addition) on 64-bit BookE
+ */
+#if defined(CONFIG_BOOKE) && !defined(CONFIG_PPC64)
 #define toreal(rd)
 #define fromreal(rd)
 
@@ -426,10 +433,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.previous
 #endif
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 #define RFI		rfid
 #define MTMSRD(r)	mtmsrd	r
-
 #else
 #define FIX_SRR1(ra, rb)
 #ifndef CONFIG_40x
