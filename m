Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc283ffTzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 03/42] powerpc/64: Change the way relocation copy is
 calculated
Date: Wed,  5 Oct 2016 11:22:25 +1100
Message-Id: <1475626984-18770-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

With a subsequent patch to put text into different sections,
(_end - _stext) can no longer be computed at link time to determine
the end of the copy. Instead, calculate it at runtime with
(copy_to_here - _stext) + (_end - copy_to_here).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/head_64.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index f765b0434731..6e21812ee672 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -628,11 +628,16 @@ __after_prom_start:
 	bctr
 
 .balign 8
-p_end:	.llong	_end - _stext
+p_end: .llong _end - copy_to_here
 
-4:	/* Now copy the rest of the kernel up to _end */
-	addis	r5,r26,(p_end - _stext)@ha
-	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
+4:
+	/*
+	 * Now copy the rest of the kernel up to _end, add
+	 * _end - copy_to_here to the copy limit and run again.
+	 */
+	addis   r8,r26,(p_end - _stext)@ha
+	ld      r8,(p_end - _stext)@l(r8)
+	add	r5,r5,r8
 5:	bl	copy_and_flush		/* copy the rest */
 
 9:	b	start_here_multiplatform
-- 
2.7.4
