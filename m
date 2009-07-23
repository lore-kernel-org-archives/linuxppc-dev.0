Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 87BFAB7B90
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:51 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:40 +1000
Subject: [PATCH 4/20] powerpc/mm: Add opcode definitions for tlbivax and
	tlbsrx.
Message-Id: <20090723055951.7867DDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the opcode definitions to ppc-opcode.h for the two instructions
tlbivax and tlbsrx. as defined by Book3E 2.06

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-work.orig/arch/powerpc/include/asm/ppc-opcode.h	2009-07-22 15:25:45.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/ppc-opcode.h	2009-07-22 15:26:05.000000000 +1000
@@ -48,6 +48,8 @@
 #define PPC_INST_TLBIE			0x7c000264
 #define PPC_INST_TLBILX			0x7c000024
 #define PPC_INST_WAIT			0x7c00007c
+#define PPC_INST_TLBIVAX		0x7c000624
+#define PPC_INST_TLBSRX_DOT		0x7c0006a5
 
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
@@ -76,6 +78,10 @@
 					__PPC_WC(w))
 #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
 					       __PPC_RB(a) | __PPC_RS(lp))
+#define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
+					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
+					__PPC_RA(a) | __PPC_RB(b))
 
 /*
  * Define what the VSX XX1 form instructions will look like, then add
