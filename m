Return-Path: <joel.stan@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42824B5991zF3FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:57:30 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id r1-v6so10111284pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 01:57:30 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 1/2] powerpc/boot: Fix crt0.S syntax for clang
Date: Mon, 10 Sep 2018 18:57:13 +1000
Message-Id: <20180910085714.4834-2-joel@jms.id.au>
In-Reply-To: <20180910085714.4834-1-joel@jms.id.au>
References: <20180910085714.4834-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clang's assembler does not like the syntax of the cmpdi:

 arch/powerpc/boot/crt0.S:168:22: error: unexpected modifier on variable reference
         cmpdi   12,RELACOUNT@l
                              ^
 arch/powerpc/boot/crt0.S:168:11: error: unknown operand
         cmpdi   12,RELACOUNT@l
                   ^
Enclosing RELACOUNT in () makes it is happy. Tested with GCC 8 and Clang
8 (trunk).

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/crt0.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index dcf2f15e6797..ace3f3c64620 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -165,7 +165,7 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
 	ld	r13,8(r11)       /* get RELA pointer in r13 */
 	b	11f
 10:	addis	r12,r12,(-RELACOUNT)@ha
-	cmpdi	r12,RELACOUNT@l
+	cmpdi	r12,(RELACOUNT)@l
 	bne	11f
 	ld	r8,8(r11)       /* get RELACOUNT value in r8 */
 11:	addi	r11,r11,16
-- 
2.17.1
