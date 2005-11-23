Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88184687EF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 07:21:20 +1100 (EST)
Date: Wed, 23 Nov 2005 21:21:15 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051123202115.GA17320@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de> <20051119172900.GA11829@suse.de>
	<20051119204742.GA17604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051119204742.GA17604@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Nov 19, Olaf Hering wrote:

>  On Sat, Nov 19, Olaf Hering wrote:
> 
> >  On Sat, Nov 19, Olaf Hering wrote:
> > 
> > > This patch on top of yours fixes it for me.
> > 
> > Another Makefile fix to actually include the kernel in the zImage.coff.

It just died while uncompressing vmlinux. Some unaligned load.
So we either need a very simple byte by byte memcpy, or my version below.

0 > boot file: 1.1.1.3,coffloading XCOFF
tsize=4D84 dsize=1542B8 bsize=BC80 entry=500000
SECTIONS:
.text    00500000 00500000 00004D84 000000FC
.data    00505000 00505000 001542B8 00004E80
.bss     0065A000 0065A000 0000BC80 00000000
.note.GN 00000000 00000000 00000000 00000000
loading .text, done..
loading .data, done..
clearing .bss, done..

zImage starting: loaded at 0x00500000 (sp: 0x003fff00)
Allocating 0x4b4660 bytes for kernel ...
OF version = 'Open Firmware, 1.0.5'
old OF detected
gunzipping (0x700000 <- 0x505c44:0x6592b8)...DEFAULT CATCH!, code=FFF00600
 ok
0 > .registers
Client's Fix Pt Regs:
 00 00000001 003FFDF0 00000000 00662183 00629FF6 000039FC 006621C0 9D6528E2
 08 7385808D 005023A0 00000002 005055C0 00000060 DEADBEEF DEADBEEF DEADBEEF
 10 DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF 00662183 000039FD 00000000
 18 003FFE80 0002F2FF 0065A45C 0062D9B6 00000000 00000000 0050DBC0 000039FD
Special Regs:
    %IV: 00000600   %SRR0: 005001C8   %SRR1: 00003070     %MQ: 00000000
    %CR: 50000055     %LR: 005023F4    %CTR: 00000737    %XER: E000BE6F
   %DAR: 00629FFE  %DSISR: 00004104   %SDR1: 004E0000
 ok
0 > reset-all


00000000005001a8 <memcpy>:
  5001a8:       54 a7 e8 ff     rlinm.  r7,r5,29,3,31
  5001ac:       38 c3 ff fc     cal     r6,-4(r3)
  5001b0:       38 84 ff fc     cal     r4,-4(r4)
  5001b4:       41 82 00 28     beq     5001dc <memcpy+0x34>
  5001b8:       70 c0 00 03     andil.  r0,r6,3
  5001bc:       7c e9 03 a6     mtctr   r7
  5001c0:       40 82 00 54     bne     500214 <memcpy+0x6c>
  5001c4:       80 e4 00 04     l       r7,4(r4)
  5001c8:       85 04 00 08     lu      r8,8(r4)
  5001cc:       90 e6 00 04     st      r7,4(r6)
  5001d0:       95 06 00 08     stu     r8,8(r6)
  5001d4:       42 00 ff f0     bdn     5001c4 <memcpy+0x1c>

 arch/powerpc/boot/string.S      |  121 +++++++++++++++++++++++++---------------

Index: linux-2.6.15-rc1-olh/arch/powerpc/boot/string.S
===================================================================
--- linux-2.6.15-rc1-olh.orig/arch/powerpc/boot/string.S
+++ linux-2.6.15-rc1-olh/arch/powerpc/boot/string.S
@@ -98,88 +98,124 @@ memset:
 
 	.globl	memmove
 memmove:
+	cmpwi	0,r5,0
+	beqlr
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	/* fall through */
 
 	.globl	memcpy
 memcpy:
+	cmpwi	0,r5,0
+	beqlr
+	andi.	r0,r4,3			/* get src word aligned */
+	beq	20f
+10:	subfic	r0,r0,4
+	cmpd	r0,r5
+	blt	11f
+	mr	r0,r5
+11:	mtctr	r0
+12:	lbz	r7,0(r4)
+	stb	r7,0(r3)
+	addi	r4,r4,1
+	addi	r3,r3,1
+	bdnz	12b
+	subf.	r5,r0,r5
+	beqlr
+20:	andi.	r0,r3,3			/* get dest word aligned */
+	beq	30f
+	subfic	r0,r0,4
+	cmpd	r0,r5
+	blt	21f
+	mr	r0,r5
+21:	mtctr	r0
+22:	lbz	r7,0(r4)
+	stb	r7,0(r3)
+	addi	r4,r4,1
+	addi	r3,r3,1
+	bdnz	22b
+	subf.	r5,r0,r5
+	beqlr
+	andi.	r0,r4,3			/* get src word aligned */
+	bne	10b
+30:
 	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
 	addi	r6,r3,-4
 	addi	r4,r4,-4
-	beq	2f			/* if less than 8 bytes to do */
-	andi.	r0,r6,3			/* get dest word aligned */
+	beq	32f			/* if less than 8 bytes to do */
 	mtctr	r7
-	bne	5f
-1:	lwz	r7,4(r4)
+31:	lwz	r7,4(r4)
 	lwzu	r8,8(r4)
 	stw	r7,4(r6)
 	stwu	r8,8(r6)
-	bdnz	1b
+	bdnz	31b
 	andi.	r5,r5,7
-2:	cmplwi	0,r5,4
-	blt	3f
+32:	cmplwi	0,r5,4
+	blt	33f
 	lwzu	r0,4(r4)
 	addi	r5,r5,-4
 	stwu	r0,4(r6)
-3:	cmpwi	0,r5,0
+33:	cmpwi	0,r5,0
 	beqlr
 	mtctr	r5
 	addi	r4,r4,3
 	addi	r6,r6,3
-4:	lbzu	r0,1(r4)
+34:	lbzu	r0,1(r4)
 	stbu	r0,1(r6)
-	bdnz	4b
+	bdnz	34b
 	blr
-5:	subfic	r0,r0,4
-	mtctr	r0
-6:	lbz	r7,4(r4)
-	addi	r4,r4,1
-	stb	r7,4(r6)
-	addi	r6,r6,1
-	bdnz	6b
-	subf	r5,r0,r5
-	rlwinm.	r7,r5,32-3,3,31
-	beq	2b
-	mtctr	r7
-	b	1b
 
 	.globl	backwards_memcpy
 backwards_memcpy:
-	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
 	add	r6,r3,r5
 	add	r4,r4,r5
-	beq	2f
-	andi.	r0,r6,3
+
+	andi.	r0,r4,3			/* get src word aligned */
+	beq	20f
+10:	cmpd	r0,r5
+	blt	11f
+	mr	r0,r5
+11:	mtctr	r0
+12:	lbzu	r7,-1(r4)
+	stbu	r7,-1(r6)
+	bdnz	12b
+	subf.	r5,r0,r5
+	beqlr
+20:	andi.	r0,r6,3			/* get dest word aligned */
+	beq	30f
+	cmpd	r0,r5
+	blt	21f
+	mr	r0,r5
+21:	mtctr	r0
+22:	lbzu	r7,-1(r4)
+	stbu	r7,-1(r6)
+	bdnz	22b
+	subf.	r5,r0,r5
+	beqlr
+	andi.	r0,r4,3			/* get src word aligned */
+	bne	10b
+30:
+	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
+	beq	32f
 	mtctr	r7
-	bne	5f
-1:	lwz	r7,-4(r4)
+31:	lwz	r7,-4(r4)
 	lwzu	r8,-8(r4)
 	stw	r7,-4(r6)
 	stwu	r8,-8(r6)
-	bdnz	1b
+	bdnz	31b
 	andi.	r5,r5,7
-2:	cmplwi	0,r5,4
-	blt	3f
+32:	cmplwi	0,r5,4
+	blt	33f
 	lwzu	r0,-4(r4)
 	subi	r5,r5,4
 	stwu	r0,-4(r6)
-3:	cmpwi	0,r5,0
+33:	cmpwi	0,r5,0
 	beqlr
 	mtctr	r5
-4:	lbzu	r0,-1(r4)
+34:	lbzu	r0,-1(r4)
 	stbu	r0,-1(r6)
-	bdnz	4b
+	bdnz	34b
 	blr
-5:	mtctr	r0
-6:	lbzu	r7,-1(r4)
-	stbu	r7,-1(r6)
-	bdnz	6b
-	subf	r5,r0,r5
-	rlwinm.	r7,r5,32-3,3,31
-	beq	2b
-	mtctr	r7
-	b	1b
 
 	.globl	memcmp
 memcmp:

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
