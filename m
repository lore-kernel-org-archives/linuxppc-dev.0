Return-Path: <srs0=teic=7h=nefkom.net=whitebox@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPrzq1RtzzDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:55:19 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xPrzp73gxz8vlJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:55:18 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xPrzp0RNzz9t0j
 for <linuxppc-dev@ozlabs.org>; Sun,  6 Aug 2017 03:55:16 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 3xPrzj3xRXz1qrtF
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2017 19:55:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 3xPrzj2WmKz3jgYN
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2017 19:55:13 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024) with ESMTP id se1mB1DlxkYs for <linuxppc-dev@ozlabs.org>;
 Sat,  5 Aug 2017 19:55:11 +0200 (CEST)
Received: from igel.home (ppp-88-217-9-22.dynamic.mnet-online.de [88.217.9.22])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2017 19:55:11 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix invalid use of register expressions
Date: Sat, 05 Aug 2017 19:55:11 +0200
Message-ID: <878tixj3wg.fsf@linux-m68k.org>
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

binutils >= 2.26 now warns about misuse of register expressions in
assembler operands that are actually literals, for example:

arch/powerpc/kernel/entry_64.S:535: Warning: invalid register expression

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/include/asm/ppc_asm.h |  2 +-
 arch/powerpc/kernel/swsusp_asm64.S |  2 +-
 arch/powerpc/kvm/book3s_64_slb.S   |  2 +-
 arch/powerpc/lib/copypage_power7.S | 14 ++++----
 arch/powerpc/lib/copyuser_power7.S | 66 +++++++++++++++++++-------------------
 arch/powerpc/lib/memcpy_power7.S   | 66 +++++++++++++++++++-------------------
 arch/powerpc/lib/string_64.S       |  2 +-
 7 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 6baeeb9acd..daeda2bbe1 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -439,7 +439,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 .machine push ;					\
 .machine "power4" ;				\
        lis     scratch,0x60000000@h;		\
-       dcbt    r0,scratch,0b01010;		\
+       dcbt    0,scratch,0b01010;		\
 .machine pop
 
 /*
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index 988f38dced..82d8aae81c 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -179,7 +179,7 @@ nothing_to_copy:
 	sld	r3, r3, r0
 	li	r0, 0
 1:
-	dcbf	r0,r3
+	dcbf	0,r3
 	addi	r3,r3,0x20
 	bdnz	1b
 
diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/book3s_64_slb.S
index 3589c4e3d4..688722acd6 100644
--- a/arch/powerpc/kvm/book3s_64_slb.S
+++ b/arch/powerpc/kvm/book3s_64_slb.S
@@ -113,7 +113,7 @@ slb_do_enter:
 
 	/* Remove all SLB entries that are in use. */
 
-	li	r0, r0
+	li	r0, 0
 	slbmte	r0, r0
 	slbia
 
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index a84d333ecb..ca5fc8fa7e 100644
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
index 706b7cc198..d416a4a665 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -315,13 +315,13 @@ err1;	stb	r0,0(r3)
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
@@ -376,26 +376,26 @@ err3;	std	r0,0(r3)
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
@@ -421,7 +421,7 @@ err3;	stvx	v0,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 err4;	lvx	v6,r4,r9
 err4;	lvx	v5,r4,r10
 err4;	lvx	v4,r4,r11
@@ -430,7 +430,7 @@ err4;	lvx	v2,r4,r14
 err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	addi	r4,r4,128
-err4;	stvx	v7,r0,r3
+err4;	stvx	v7,0,r3
 err4;	stvx	v6,r3,r9
 err4;	stvx	v5,r3,r10
 err4;	stvx	v4,r3,r11
@@ -451,29 +451,29 @@ err4;	stvx	v0,r3,r16
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
@@ -553,25 +553,25 @@ err3;	lvx	v0,0,r4
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
@@ -580,7 +580,7 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
@@ -606,7 +606,7 @@ err3;	stvx	v11,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 err4;	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -623,7 +623,7 @@ err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-err4;	stvx	v8,r0,r3
+err4;	stvx	v8,0,r3
 err4;	stvx	v9,r3,r9
 err4;	stvx	v10,r3,r10
 err4;	stvx	v11,r3,r11
@@ -644,7 +644,7 @@ err4;	stvx	v15,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -653,27 +653,27 @@ err3;	lvx	v1,r4,r10
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
index 786234fd4e..193909abd1 100644
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
index d5b4d9498c..56aac4c220 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -184,7 +184,7 @@ err1;	std	r0,8(r3)
 	mtctr	r6
 	mr	r8,r3
 14:
-err1;	dcbz	r0,r3
+err1;	dcbz	0,r3
 	add	r3,r3,r9
 	bdnz	14b
 
-- 
2.14.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
