Return-Path: <srs0=0p3s=7q=nefkom.net=whitebox@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWPcl6w8qzDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 04:43:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWPck0THyz8t59
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 04:43:02 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xWPch00jkz9t36
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2017 04:42:48 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: fix invalid use of register expressions
References: <878tixj3wg.fsf@linux-m68k.org>
 <87poc6mh0j.fsf@concordia.ellerman.id.au>
Date: Mon, 14 Aug 2017 20:42:43 +0200
In-Reply-To: <87poc6mh0j.fsf@concordia.ellerman.id.au> (Michael Ellerman's
 message of "Tue, 08 Aug 2017 21:32:44 +1000")
Message-ID: <87h8xat2ho.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes another invalid use of register expressions.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/l2cr_6xx.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/l2cr_6xx.S b/arch/powerpc/kernel/l2cr_6xx.S
index 97ec8557f9..6408f09dbb 100644
--- a/arch/powerpc/kernel/l2cr_6xx.S
+++ b/arch/powerpc/kernel/l2cr_6xx.S
@@ -181,7 +181,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 	mtctr	r4
 	li	r4,0
 1:
-	lwzx	r0,r0,r4
+	lwzx	r0,0,r4
 	addi	r4,r4,32		/* Go to start of next cache line */
 	bdnz	1b
 	isync
@@ -328,7 +328,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_L3CR)
 	mtctr	r4
 	li	r4,0
 1:
-	lwzx	r0,r0,r4
+	lwzx	r0,0,r4
 	dcbf	0,r4
 	addi	r4,r4,32		/* Go to start of next cache line */
 	bdnz	1b
-- 
2.14.1

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
