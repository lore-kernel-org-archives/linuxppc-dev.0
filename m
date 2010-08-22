Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5B271B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 08:10:01 +1000 (EST)
Date: Sun, 22 Aug 2010 18:09:58 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100822180958.6305f5b1@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Let's try a patch to get the ball rolling. 

ldstfp.S does not compile if mtmsrd not defined. But is it only defined
for BOOK3S_64. This defines mtmsrd to be mtmsr on all but BOOK3S_64.
This solves the compile problem... but I am not sure how to test it.

I am also not sure if this is the best place to define it. If the
mapping of mtmsrd to mtmsr is correct, maybe it should be in asm/reg.h?

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index f644863..df8a03b 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -17,6 +17,10 @@
 #include <asm/asm-offsets.h>
 #include <linux/errno.h>
 
+#ifndef CONFIG_PPC_BOOK3S_64
+#define mtmsrd mtmsr
+#endif
+
 #define STKFRM	(PPC_MIN_STKFRM + 16)
 
 	.macro	extab	instr,handler

Cheers,
   Sean
