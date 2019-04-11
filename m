Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA0BC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:52:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FACD2133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FACD2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fzsF3qSGzDqGM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:52:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzkx412hzDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzkx3Gn1z9s70; Thu, 11 Apr 2019 21:46:33 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzkx2Hrgz9sB3; Thu, 11 Apr 2019 21:46:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 01/35] powerpc: Fix invalid use of register
 expressions
Date: Thu, 11 Apr 2019 21:45:56 +1000
Message-Id: <20190411114630.4042-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411114630.4042-1-mpe@ellerman.id.au>
References: <20190411114630.4042-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Andreas Schwab <schwab@linux-m68k.org>

commit 8a583c0a8d316d8ea52ea78491174ab1a3e9ef9d upstream.

binutils >= 2.26 now warns about misuse of register expressions in
assembler operands that are actually literals, for example:

  arch/powerpc/kernel/entry_64.S:535: Warning: invalid register expression

In practice these are almost all uses of r0 that should just be a
literal 0.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
[mpe: Mention r0 is almost always the culprit, fold in purgatory change]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc_asm.h |  2 +-
 arch/powerpc/kernel/swsusp_asm64.S |  2 +-
 arch/powerpc/lib/copypage_power7.S | 14 +++----
 arch/powerpc/lib/copyuser_power7.S | 66 +++++++++++++++---------------
 arch/powerpc/lib/memcpy_power7.S   | 66 +++++++++++++++---------------
 arch/powerpc/lib/string_64.S       |  2 +-
 6 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index c73750b0d9fa..24e95be3bfaf 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -437,7 +437,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 .machine push ;					\
 .machine "power4" ;				\
        lis     scratch,0x60000000@h;		\
-       dcbt    r0,scratch,0b01010;		\
+       dcbt    0,scratch,0b01010;		\
 .machine pop
 
 /*
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index 988f38dced0f..82d8aae81c6a 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -179,7 +179,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	sld	r3, r3, r0
 	li	r0, 0
 1:
-	dcbf	r0,r3
+	dcbf	0,r3
 	addi	r3,r3,0x20
 	bdnz	1b
 
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index a84d333ecb09..ca5fc8fa7efc 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -45,13 +45,13 @@ _GLOBAL(copypage_power7)
 .machine push
 .machine "power4"
 	/* setup read stream 0  */
-	dcbt	r0,r4,0b01000  	/* addr from */
-	dcbt	r0,r7,0b01010   /* length and depth from */
+	dcbt	0,r4,0b01000  	/* addr from */
+	dcbt	0,r7,0b01010   /* length and depth from */
 	/* setup write stream 1 */
-	dcbtst	r0,r9,0b01000   /* addr to */
-	dcbtst	r0,r10,0b01010  /* length and depth to */
+	dcbtst	0,r9,0b01000   /* addr to */
+	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
-	dcbt	r0,r8,0b01010	/* all streams GO */
+	dcbt	0,r8,0b01010	/* all streams GO */
 .machine pop
 
 #ifdef CONFIG_ALTIVEC
@@ -83,7 +83,7 @@ _GLOBAL(copypage_power7)
 	li	r12,112
 
 	.align	5
-1:	lvx	v7,r0,r4
+1:	lvx	v7,0,r4
 	lvx	v6,r4,r6
 	lvx	v5,r4,r7
 	lvx	v4,r4,r8
@@ -92,7 +92,7 @@ _GLOBAL(copypage_power7)
 	lvx	v1,r4,r11
 	lvx	v0,r4,r12
 	addi	r4,r4,128
-	stvx	v7,r0,r3
+	stvx	v7,0,r3
 	stvx	v6,r3,r6
 	stvx	v5,r3,r7
 	stvx	v4,r3,r8
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index da0c568d18c4..391694814691 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -327,13 +327,13 @@ err1;	stb	r0,0(r3)
 .machine push
 .machine "power4"
 	/* setup read stream 0 */
-	dcbt	r0,r6,0b01000   /* addr from */
-	dcbt	r0,r7,0b01010   /* length and depth from */
+	dcbt	0,r6,0b01000   /* addr from */
+	dcbt	0,r7,0b01010   /* length and depth from */
 	/* setup write stream 1 */
-	dcbtst	r0,r9,0b01000   /* addr to */
-	dcbtst	r0,r10,0b01010  /* length and depth to */
+	dcbtst	0,r9,0b01000   /* addr to */
+	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
-	dcbt	r0,r8,0b01010	/* all streams GO */
+	dcbt	0,r8,0b01010	/* all streams GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
@@ -388,26 +388,26 @@ err3;	std	r0,0(r3)
 	li	r11,48
 
 	bf	cr7*4+3,5f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	addi	r4,r4,16
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 err3;	lvx	v2,r4,r9
 err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
-err3;	stvx	v3,r0,r3
+err3;	stvx	v3,0,r3
 err3;	stvx	v2,r3,r9
 err3;	stvx	v1,r3,r10
 err3;	stvx	v0,r3,r11
@@ -433,7 +433,7 @@ err3;	stvx	v0,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 err4;	lvx	v6,r4,r9
 err4;	lvx	v5,r4,r10
 err4;	lvx	v4,r4,r11
@@ -442,7 +442,7 @@ err4;	lvx	v2,r4,r14
 err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	addi	r4,r4,128
-err4;	stvx	v7,r0,r3
+err4;	stvx	v7,0,r3
 err4;	stvx	v6,r3,r9
 err4;	stvx	v5,r3,r10
 err4;	stvx	v4,r3,r11
@@ -463,29 +463,29 @@ err4;	stvx	v0,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 err3;	lvx	v2,r4,r9
 err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
-err3;	stvx	v3,r0,r3
+err3;	stvx	v3,0,r3
 err3;	stvx	v2,r3,r9
 err3;	stvx	v1,r3,r10
 err3;	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	addi	r4,r4,16
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -565,25 +565,25 @@ err3;	lvx	v0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 	addi	r3,r3,16
 	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 err3;	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -592,7 +592,7 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
@@ -618,7 +618,7 @@ err3;	stvx	v11,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 err4;	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -635,7 +635,7 @@ err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-err4;	stvx	v8,r0,r3
+err4;	stvx	v8,0,r3
 err4;	stvx	v9,r3,r9
 err4;	stvx	v10,r3,r10
 err4;	stvx	v11,r3,r11
@@ -656,7 +656,7 @@ err4;	stvx	v15,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -665,27 +665,27 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 err3;	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 786234fd4e91..193909abd18b 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -261,12 +261,12 @@ _GLOBAL(memcpy_power7)
 
 .machine push
 .machine "power4"
-	dcbt	r0,r6,0b01000
-	dcbt	r0,r7,0b01010
-	dcbtst	r0,r9,0b01000
-	dcbtst	r0,r10,0b01010
+	dcbt	0,r6,0b01000
+	dcbt	0,r7,0b01010
+	dcbtst	0,r9,0b01000
+	dcbtst	0,r10,0b01010
 	eieio
-	dcbt	r0,r8,0b01010	/* GO */
+	dcbt	0,r8,0b01010	/* GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
@@ -321,26 +321,26 @@ _GLOBAL(memcpy_power7)
 	li	r11,48
 
 	bf	cr7*4+3,5f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	addi	r4,r4,16
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	lvx	v0,r4,r9
 	addi	r4,r4,32
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	lvx	v2,r4,r9
 	lvx	v1,r4,r10
 	lvx	v0,r4,r11
 	addi	r4,r4,64
-	stvx	v3,r0,r3
+	stvx	v3,0,r3
 	stvx	v2,r3,r9
 	stvx	v1,r3,r10
 	stvx	v0,r3,r11
@@ -366,7 +366,7 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
-	lvx	v7,r0,r4
+	lvx	v7,0,r4
 	lvx	v6,r4,r9
 	lvx	v5,r4,r10
 	lvx	v4,r4,r11
@@ -375,7 +375,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v1,r4,r15
 	lvx	v0,r4,r16
 	addi	r4,r4,128
-	stvx	v7,r0,r3
+	stvx	v7,0,r3
 	stvx	v6,r3,r9
 	stvx	v5,r3,r10
 	stvx	v4,r3,r11
@@ -396,29 +396,29 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	lvx	v2,r4,r9
 	lvx	v1,r4,r10
 	lvx	v0,r4,r11
 	addi	r4,r4,64
-	stvx	v3,r0,r3
+	stvx	v3,0,r3
 	stvx	v2,r3,r9
 	stvx	v1,r3,r10
 	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	lvx	v0,r4,r9
 	addi	r4,r4,32
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	addi	r4,r4,16
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -499,25 +499,25 @@ _GLOBAL(memcpy_power7)
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	addi	r3,r3,16
 	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -526,7 +526,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
@@ -552,7 +552,7 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
-	lvx	v7,r0,r4
+	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -569,7 +569,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
@@ -590,7 +590,7 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -599,27 +599,27 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index 57ace356c949..11e6372537fd 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -192,7 +192,7 @@ err1;	std	r0,8(r3)
 	mtctr	r6
 	mr	r8,r3
 14:
-err1;	dcbz	r0,r3
+err1;	dcbz	0,r3
 	add	r3,r3,r9
 	bdnz	14b
 
-- 
2.20.1

