Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 727FEB6F0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 15:45:51 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nB94jkU5032576
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2009 22:45:47 -0600
Subject: powerpc: Fix usage of 64-bit instruction in 32-bit altivec code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 15:45:45 +1100
Message-ID: <1260333945.16132.9.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e821ea70f3b4873b50056a1e0f74befed1014c09 introduced a bug by copying
some 64-bit originated code as-is to be used by both 32 and 64-bit
but this code contains a 64-bit ony "cmpdi" instruction.

This changes it to cmpwi, which is fine since VRSAVE can only contains
a 32-bit value anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@kernel.org>
---

I'm adding that to -next now so it goes into stable shortly after
I push to Linus, hopefully tomorrow

Index: linux-work/arch/powerpc/kernel/vector.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vector.S	2009-12-09 15:39:55.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vector.S	2009-12-09 15:39:58.000000000 +1100
@@ -58,7 +58,7 @@ _GLOBAL(load_up_altivec)
 	 * all 1's
 	 */
 	mfspr	r4,SPRN_VRSAVE
-	cmpdi	0,r4,0
+	cmpwi	0,r4,0
 	bne+	1f
 	li	r4,-1
 	mtspr	SPRN_VRSAVE,r4
