Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B788B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 05:25:19 +1000 (EST)
Date: Mon, 16 May 2011 20:58:13 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: remove last piece of GEMINI
Message-ID: <20110516185813.GA23559@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-dev@lists.ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems that Adrian is getting old. He removed almost everything of
GEMINI in commit c53653130 ("[POWERPC] Remove the broken Gemini
support") except this piece.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/powerpc/kernel/head_32.S |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index c5c24be..0e49de0 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -805,19 +805,6 @@ _ENTRY(copy_and_flush)
 	blr
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_GEMINI
-	.globl	__secondary_start_gemini
-__secondary_start_gemini:
-        mfspr   r4,SPRN_HID0
-        ori     r4,r4,HID0_ICFI
-        li      r3,0
-        ori     r3,r3,HID0_ICE
-        andc    r4,r4,r3
-        mtspr   SPRN_HID0,r4
-        sync
-        b       __secondary_start
-#endif /* CONFIG_GEMINI */
-
 	.globl __secondary_start_mpc86xx
 __secondary_start_mpc86xx:
 	mfspr	r3, SPRN_PIR
-- 
1.7.4.4
