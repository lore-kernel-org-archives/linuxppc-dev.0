Return-Path: <nhorman@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB3A0B70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 23:57:02 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id C7E61DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 23:56:59 +1000 (EST)
Date: Tue, 23 Jun 2009 09:56:04 -0400
From: Neil Horman <nhorman@redhat.com>
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090623135604.GC1157@hmsreliant.think-freely.org>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090623125534.GA8664@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 23, 2009 at 06:25:34PM +0530, M. Mohan Kumar wrote:
> On Wed, Jun 17, 2009 at 10:40:07AM -0400, Neil Horman wrote:
>  
> > > send objdump of fs2dt.o with and without this assignment.
> > > 
> > That would be a fine thing to do, and I'd be happy to compare them.  My though
> > regarding the comparison of the device tree on a good and bad run was meant to
> > expidite what change in the assembly we'd be looking for.  If its the kdump
> > kernel boot thats hanging, Its likely hanging on something in the device tree,
> > as thats whats being manipulated by this code.  So I figure that understanding
> > whats changed there will point us toward what change in the assembly might be
> > responsible for the hang.  The assmebly's going to be signficantly different
> > (lots of optimization might be lost from no longer inlining a function), so
> > anything that helps us narrow down whats changed will be good
> 
> I am attaching the objdumps of fs2dt with and without dt_len.
> 
Well it definately looks like removing that variable had some code changes.
It'll take some time to match it up to source, but Most interesting I think is
the variance in putprops around address f34.  Looks like its doing some string
maniuplation in a reversed order, using a huge offset.  Might be worthwhile to
check to see if theres any string overruns in this code.
Neil

> Regards,
> M. Mohan Kumar.

> 
> kexec/arch/ppc64/fs2dt.o:     file format elf64-powerpc
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <.reserve>:
>        0:	7c 08 02 a6 	mflr    r0
>        4:	fb 61 ff d8 	std     r27,-40(r1)
>        8:	fb 81 ff e0 	std     r28,-32(r1)
>        c:	fb a1 ff e8 	std     r29,-24(r1)
>       10:	fb c1 ff f0 	std     r30,-16(r1)
>       14:	fb e1 ff f8 	std     r31,-8(r1)
>       18:	eb a2 00 00 	ld      r29,0(r2)
>       1c:	f8 01 00 10 	std     r0,16(r1)
>       20:	f8 21 ff 61 	stdu    r1,-160(r1)
>       24:	7c 7c 1b 78 	mr      r28,r3
>       28:	7c 9b 23 78 	mr      r27,r4
>       2c:	e8 1d 00 08 	ld      r0,8(r29)
>       30:	2f a0 00 00 	cmpdi   cr7,r0,0
>       34:	41 de 00 84 	beq-    cr7,b8 <.reserve+0xb8>
>       38:	39 3d 00 18 	addi    r9,r29,24
>       3c:	3b e0 00 00 	li      r31,0
>       40:	e8 09 00 00 	ld      r0,0(r9)
>       44:	3b ff 00 02 	addi    r31,r31,2
>       48:	39 29 00 10 	addi    r9,r9,16
>       4c:	3b df 00 01 	addi    r30,r31,1
>       50:	2f a0 00 00 	cmpdi   cr7,r0,0
>       54:	40 fe ff ec 	bne-    cr7,40 <.reserve+0x40>
>       58:	38 1f 00 04 	addi    r0,r31,4
>       5c:	39 7f 00 03 	addi    r11,r31,3
>       60:	2b a0 01 ff 	cmpldi  cr7,r0,511
>       64:	40 9d 00 14 	ble-    cr7,78 <.reserve+0x78>
>       68:	e8 62 00 08 	ld      r3,8(r2)
>       6c:	48 00 00 01 	bl      6c <.reserve+0x6c>
>       70:	60 00 00 00 	nop
>       74:	39 7f 00 03 	addi    r11,r31,3
>       78:	7b e0 1f 24 	rldicr  r0,r31,3,60
>       7c:	7b c9 1f 24 	rldicr  r9,r30,3,60
>       80:	79 6b 1f 24 	rldicr  r11,r11,3,60
>       84:	38 21 00 a0 	addi    r1,r1,160
>       88:	7f 9d 01 2a 	stdx    r28,r29,r0
>       8c:	38 00 00 00 	li      r0,0
>       90:	7f 7d 49 2a 	stdx    r27,r29,r9
>       94:	7c 1d 59 2a 	stdx    r0,r29,r11
>       98:	e8 01 00 10 	ld      r0,16(r1)
>       9c:	eb 61 ff d8 	ld      r27,-40(r1)
>       a0:	eb 81 ff e0 	ld      r28,-32(r1)
>       a4:	eb a1 ff e8 	ld      r29,-24(r1)
>       a8:	eb c1 ff f0 	ld      r30,-16(r1)
>       ac:	eb e1 ff f8 	ld      r31,-8(r1)
>       b0:	7c 08 03 a6 	mtlr    r0
>       b4:	4e 80 00 20 	blr
>       b8:	3b e0 00 00 	li      r31,0
>       bc:	3b c0 00 01 	li      r30,1
>       c0:	39 60 00 03 	li      r11,3
>       c4:	4b ff ff b4 	b       78 <.reserve+0x78>
>       c8:	00 00 00 00 	.long 0x0
>       cc:	00 00 00 01 	.long 0x1
>       d0:	80 05 00 00 	lwz     r0,0(r5)
>       d4:	60 00 00 00 	nop
>       d8:	60 00 00 00 	nop
>       dc:	60 00 00 00 	nop
> 
> 00000000000000e0 <.checkprop>:
>       e0:	7c 08 02 a6 	mflr    r0
>       e4:	fb c1 ff f0 	std     r30,-16(r1)
>       e8:	7c 9e 23 79 	mr.     r30,r4
>       ec:	fb 81 ff e0 	std     r28,-32(r1)
>       f0:	fb a1 ff e8 	std     r29,-24(r1)
>       f4:	fb e1 ff f8 	std     r31,-8(r1)
>       f8:	f8 01 00 10 	std     r0,16(r1)
>       fc:	7c 7d 1b 78 	mr      r29,r3
>      100:	f8 21 ff 71 	stdu    r1,-144(r1)
>      104:	7c bc 2b 78 	mr      r28,r5
>      108:	41 82 00 88 	beq-    190 <.checkprop+0xb0>
>      10c:	eb e2 00 00 	ld      r31,0(r2)
>      110:	e8 82 00 18 	ld      r4,24(r2)
>      114:	7f a3 eb 78 	mr      r3,r29
>      118:	48 00 00 01 	bl      118 <.checkprop+0x38>
>      11c:	60 00 00 00 	nop
>      120:	2f a3 00 00 	cmpdi   cr7,r3,0
>      124:	40 9e 00 ac 	bne-    cr7,1d0 <.checkprop+0xf0>
>      128:	80 1e 00 00 	lwz     r0,0(r30)
>      12c:	f8 1f 10 00 	std     r0,4096(r31)
>      130:	e8 1f 10 08 	ld      r0,4104(r31)
>      134:	2f a0 00 00 	cmpdi   cr7,r0,0
>      138:	41 9e 00 10 	beq-    cr7,148 <.checkprop+0x68>
>      13c:	e8 1f 10 10 	ld      r0,4112(r31)
>      140:	2f a0 00 00 	cmpdi   cr7,r0,0
>      144:	40 9e 00 bc 	bne-    cr7,200 <.checkprop+0x120>
>      148:	e8 7f 10 00 	ld      r3,4096(r31)
>      14c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      150:	41 9e 00 1c 	beq-    cr7,16c <.checkprop+0x8c>
>      154:	eb df 10 08 	ld      r30,4104(r31)
>      158:	2f be 00 00 	cmpdi   cr7,r30,0
>      15c:	40 9e 00 b4 	bne-    cr7,210 <.checkprop+0x130>
>      160:	e8 9f 10 10 	ld      r4,4112(r31)
>      164:	2f a4 00 00 	cmpdi   cr7,r4,0
>      168:	40 9e 00 e8 	bne-    cr7,250 <.checkprop+0x170>
>      16c:	38 21 00 90 	addi    r1,r1,144
>      170:	e8 01 00 10 	ld      r0,16(r1)
>      174:	eb 81 ff e0 	ld      r28,-32(r1)
>      178:	eb a1 ff e8 	ld      r29,-24(r1)
>      17c:	eb c1 ff f0 	ld      r30,-16(r1)
>      180:	eb e1 ff f8 	ld      r31,-8(r1)
>      184:	7c 08 03 a6 	mtlr    r0
>      188:	4e 80 00 20 	blr
>      18c:	60 00 00 00 	nop
>      190:	eb e2 00 00 	ld      r31,0(r2)
>      194:	e8 1f 10 00 	ld      r0,4096(r31)
>      198:	2f a0 00 00 	cmpdi   cr7,r0,0
>      19c:	40 9e 00 1c 	bne-    cr7,1b8 <.checkprop+0xd8>
>      1a0:	e8 1f 10 08 	ld      r0,4104(r31)
>      1a4:	2f a0 00 00 	cmpdi   cr7,r0,0
>      1a8:	40 9e 00 10 	bne-    cr7,1b8 <.checkprop+0xd8>
>      1ac:	e8 1f 10 10 	ld      r0,4112(r31)
>      1b0:	2f a0 00 00 	cmpdi   cr7,r0,0
>      1b4:	41 9e ff 5c 	beq+    cr7,110 <.checkprop+0x30>
>      1b8:	e8 62 00 10 	ld      r3,16(r2)
>      1bc:	48 00 00 01 	bl      1bc <.checkprop+0xdc>
>      1c0:	60 00 00 00 	nop
>      1c4:	4b ff ff 6c 	b       130 <.checkprop+0x50>
>      1c8:	60 00 00 00 	nop
>      1cc:	60 00 00 00 	nop
>      1d0:	e8 82 00 20 	ld      r4,32(r2)
>      1d4:	7f a3 eb 78 	mr      r3,r29
>      1d8:	48 00 00 01 	bl      1d8 <.checkprop+0xf8>
>      1dc:	60 00 00 00 	nop
>      1e0:	2f a3 00 00 	cmpdi   cr7,r3,0
>      1e4:	40 9e 00 9c 	bne-    cr7,280 <.checkprop+0x1a0>
>      1e8:	e8 1e 00 00 	ld      r0,0(r30)
>      1ec:	f8 1f 10 00 	std     r0,4096(r31)
>      1f0:	4b ff ff 40 	b       130 <.checkprop+0x50>
>      1f4:	60 00 00 00 	nop
>      1f8:	60 00 00 00 	nop
>      1fc:	60 00 00 00 	nop
>      200:	e8 62 00 50 	ld      r3,80(r2)
>      204:	48 00 00 01 	bl      204 <.checkprop+0x124>
>      208:	60 00 00 00 	nop
>      20c:	4b ff ff 3c 	b       148 <.checkprop+0x68>
>      210:	7f c4 f3 78 	mr      r4,r30
>      214:	48 00 00 01 	bl      214 <.checkprop+0x134>
>      218:	38 00 00 00 	li      r0,0
>      21c:	38 21 00 90 	addi    r1,r1,144
>      220:	f8 1f 10 00 	std     r0,4096(r31)
>      224:	f8 1f 10 08 	std     r0,4104(r31)
>      228:	e8 01 00 10 	ld      r0,16(r1)
>      22c:	eb 81 ff e0 	ld      r28,-32(r1)
>      230:	eb a1 ff e8 	ld      r29,-24(r1)
>      234:	eb c1 ff f0 	ld      r30,-16(r1)
>      238:	eb e1 ff f8 	ld      r31,-8(r1)
>      23c:	7c 08 03 a6 	mtlr    r0
>      240:	4e 80 00 20 	blr
>      244:	60 00 00 00 	nop
>      248:	60 00 00 00 	nop
>      24c:	60 00 00 00 	nop
>      250:	7c 83 20 50 	subf    r4,r3,r4
>      254:	48 00 00 01 	bl      254 <.checkprop+0x174>
>      258:	fb df 10 00 	std     r30,4096(r31)
>      25c:	fb df 10 10 	std     r30,4112(r31)
>      260:	38 21 00 90 	addi    r1,r1,144
>      264:	e8 01 00 10 	ld      r0,16(r1)
>      268:	eb 81 ff e0 	ld      r28,-32(r1)
>      26c:	eb a1 ff e8 	ld      r29,-24(r1)
>      270:	eb c1 ff f0 	ld      r30,-16(r1)
>      274:	eb e1 ff f8 	ld      r31,-8(r1)
>      278:	7c 08 03 a6 	mtlr    r0
>      27c:	4e 80 00 20 	blr
>      280:	e8 82 00 28 	ld      r4,40(r2)
>      284:	7f a3 eb 78 	mr      r3,r29
>      288:	48 00 00 01 	bl      288 <.checkprop+0x1a8>
>      28c:	60 00 00 00 	nop
>      290:	2f a3 00 00 	cmpdi   cr7,r3,0
>      294:	40 9e 00 1c 	bne-    cr7,2b0 <.checkprop+0x1d0>
>      298:	80 1e 00 00 	lwz     r0,0(r30)
>      29c:	f8 1f 10 08 	std     r0,4104(r31)
>      2a0:	4b ff fe 90 	b       130 <.checkprop+0x50>
>      2a4:	60 00 00 00 	nop
>      2a8:	60 00 00 00 	nop
>      2ac:	60 00 00 00 	nop
>      2b0:	e8 82 00 30 	ld      r4,48(r2)
>      2b4:	7f a3 eb 78 	mr      r3,r29
>      2b8:	48 00 00 01 	bl      2b8 <.checkprop+0x1d8>
>      2bc:	60 00 00 00 	nop
>      2c0:	2f a3 00 00 	cmpdi   cr7,r3,0
>      2c4:	41 9e ff d4 	beq+    cr7,298 <.checkprop+0x1b8>
>      2c8:	e9 22 00 38 	ld      r9,56(r2)
>      2cc:	88 09 00 00 	lbz     r0,0(r9)
>      2d0:	2f 80 00 00 	cmpwi   cr7,r0,0
>      2d4:	41 9e fe 5c 	beq+    cr7,130 <.checkprop+0x50>
>      2d8:	e8 82 00 40 	ld      r4,64(r2)
>      2dc:	7f a3 eb 78 	mr      r3,r29
>      2e0:	48 00 00 01 	bl      2e0 <.checkprop+0x200>
>      2e4:	60 00 00 00 	nop
>      2e8:	2f a3 00 00 	cmpdi   cr7,r3,0
>      2ec:	40 9e 00 10 	bne-    cr7,2fc <.checkprop+0x21c>
>      2f0:	2f 9c 00 08 	cmpwi   cr7,r28,8
>      2f4:	40 9e fe 34 	bne+    cr7,128 <.checkprop+0x48>
>      2f8:	4b ff fe f0 	b       1e8 <.checkprop+0x108>
>      2fc:	e8 82 00 48 	ld      r4,72(r2)
>      300:	7f a3 eb 78 	mr      r3,r29
>      304:	48 00 00 01 	bl      304 <.checkprop+0x224>
>      308:	60 00 00 00 	nop
>      30c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      310:	40 9e fe 20 	bne+    cr7,130 <.checkprop+0x50>
>      314:	e8 1e 00 00 	ld      r0,0(r30)
>      318:	f8 1f 10 10 	std     r0,4112(r31)
>      31c:	4b ff fe 14 	b       130 <.checkprop+0x50>
>      320:	00 00 00 00 	.long 0x0
>      324:	00 00 00 01 	.long 0x1
>      328:	80 04 00 00 	lwz     r0,0(r4)
>      32c:	60 00 00 00 	nop
> 
> 0000000000000330 <.propnum>:
>      330:	7c 08 02 a6 	mflr    r0
>      334:	fb 81 ff e0 	std     r28,-32(r1)
>      338:	fb a1 ff e8 	std     r29,-24(r1)
>      33c:	fb 61 ff d8 	std     r27,-40(r1)
>      340:	fb c1 ff f0 	std     r30,-16(r1)
>      344:	fb e1 ff f8 	std     r31,-8(r1)
>      348:	eb a2 00 00 	ld      r29,0(r2)
>      34c:	f8 01 00 10 	std     r0,16(r1)
>      350:	f8 21 ff 61 	stdu    r1,-160(r1)
>      354:	7c 7c 1b 78 	mr      r28,r3
>      358:	88 1d 10 18 	lbz     r0,4120(r29)
>      35c:	2f 80 00 00 	cmpwi   cr7,r0,0
>      360:	41 9e 01 00 	beq-    cr7,460 <.propnum+0x130>
>      364:	7f bb eb 78 	mr      r27,r29
>      368:	3b e0 00 00 	li      r31,0
>      36c:	3b dd 10 18 	addi    r30,r29,4120
>      370:	48 00 00 38 	b       3a8 <.propnum+0x78>
>      374:	60 00 00 00 	nop
>      378:	60 00 00 00 	nop
>      37c:	60 00 00 00 	nop
>      380:	48 00 00 01 	bl      380 <.propnum+0x50>
>      384:	60 00 00 00 	nop
>      388:	38 63 00 01 	addi    r3,r3,1
>      38c:	7c 63 fa 14 	add     r3,r3,r31
>      390:	78 7d 00 20 	clrldi  r29,r3,32
>      394:	7d 3b ea 14 	add     r9,r27,r29
>      398:	7f bf eb 78 	mr      r31,r29
>      39c:	88 09 10 18 	lbz     r0,4120(r9)
>      3a0:	2f 80 00 00 	cmpwi   cr7,r0,0
>      3a4:	41 9e 00 4c 	beq-    cr7,3f0 <.propnum+0xc0>
>      3a8:	7f be fa 14 	add     r29,r30,r31
>      3ac:	7f 83 e3 78 	mr      r3,r28
>      3b0:	7f a4 eb 78 	mr      r4,r29
>      3b4:	48 00 00 01 	bl      3b4 <.propnum+0x84>
>      3b8:	60 00 00 00 	nop
>      3bc:	2f a3 00 00 	cmpdi   cr7,r3,0
>      3c0:	7f a3 eb 78 	mr      r3,r29
>      3c4:	40 9e ff bc 	bne+    cr7,380 <.propnum+0x50>
>      3c8:	38 21 00 a0 	addi    r1,r1,160
>      3cc:	7f e3 fb 78 	mr      r3,r31
>      3d0:	e8 01 00 10 	ld      r0,16(r1)
>      3d4:	eb 61 ff d8 	ld      r27,-40(r1)
>      3d8:	eb 81 ff e0 	ld      r28,-32(r1)
>      3dc:	eb a1 ff e8 	ld      r29,-24(r1)
>      3e0:	eb c1 ff f0 	ld      r30,-16(r1)
>      3e4:	eb e1 ff f8 	ld      r31,-8(r1)
>      3e8:	7c 08 03 a6 	mtlr    r0
>      3ec:	4e 80 00 20 	blr
>      3f0:	7f bf eb 78 	mr      r31,r29
>      3f4:	7f 83 e3 78 	mr      r3,r28
>      3f8:	48 00 00 01 	bl      3f8 <.propnum+0xc8>
>      3fc:	60 00 00 00 	nop
>      400:	20 1d 40 00 	subfic  r0,r29,16384
>      404:	38 63 00 01 	addi    r3,r3,1
>      408:	78 00 00 20 	clrldi  r0,r0,32
>      40c:	7f a0 18 40 	cmpld   cr7,r0,r3
>      410:	41 9c 00 40 	blt-    cr7,450 <.propnum+0x120>
>      414:	7c 7e ea 14 	add     r3,r30,r29
>      418:	7f 84 e3 78 	mr      r4,r28
>      41c:	48 00 00 01 	bl      41c <.propnum+0xec>
>      420:	60 00 00 00 	nop
>      424:	38 21 00 a0 	addi    r1,r1,160
>      428:	7f e3 fb 78 	mr      r3,r31
>      42c:	e8 01 00 10 	ld      r0,16(r1)
>      430:	eb 61 ff d8 	ld      r27,-40(r1)
>      434:	eb 81 ff e0 	ld      r28,-32(r1)
>      438:	eb a1 ff e8 	ld      r29,-24(r1)
>      43c:	eb c1 ff f0 	ld      r30,-16(r1)
>      440:	eb e1 ff f8 	ld      r31,-8(r1)
>      444:	7c 08 03 a6 	mtlr    r0
>      448:	4e 80 00 20 	blr
>      44c:	60 00 00 00 	nop
>      450:	e8 62 00 58 	ld      r3,88(r2)
>      454:	48 00 00 01 	bl      454 <.propnum+0x124>
>      458:	60 00 00 00 	nop
>      45c:	4b ff ff b8 	b       414 <.propnum+0xe4>
>      460:	3b dd 10 18 	addi    r30,r29,4120
>      464:	3b a0 00 00 	li      r29,0
>      468:	3b e0 00 00 	li      r31,0
>      46c:	4b ff ff 88 	b       3f4 <.propnum+0xc4>
>      470:	00 00 00 00 	.long 0x0
>      474:	00 00 00 01 	.long 0x1
>      478:	80 05 00 00 	lwz     r0,0(r5)
>      47c:	60 00 00 00 	nop
> 
> 0000000000000480 <.add_usable_mem_property>:
>      480:	7c 08 02 a6 	mflr    r0
>      484:	fb 61 ff d8 	std     r27,-40(r1)
>      488:	fb 81 ff e0 	std     r28,-32(r1)
>      48c:	fb a1 ff e8 	std     r29,-24(r1)
>      490:	fb c1 ff f0 	std     r30,-16(r1)
>      494:	fb e1 ff f8 	std     r31,-8(r1)
>      498:	eb c2 00 00 	ld      r30,0(r2)
>      49c:	f8 01 00 10 	std     r0,16(r1)
>      4a0:	f8 21 bb 51 	stdu    r1,-17584(r1)
>      4a4:	7c 7b 1b 78 	mr      r27,r3
>      4a8:	7c 9f 23 78 	mr      r31,r4
>      4ac:	3b 9e 50 18 	addi    r28,r30,20504
>      4b0:	7f 84 e3 78 	mr      r4,r28
>      4b4:	3b a1 00 80 	addi    r29,r1,128
>      4b8:	7f a3 eb 78 	mr      r3,r29
>      4bc:	48 00 00 01 	bl      4bc <.add_usable_mem_property+0x3c>
>      4c0:	60 00 00 00 	nop
>      4c4:	38 80 00 2f 	li      r4,47
>      4c8:	7f a3 eb 78 	mr      r3,r29
>      4cc:	48 00 00 01 	bl      4cc <.add_usable_mem_property+0x4c>
>      4d0:	60 00 00 00 	nop
>      4d4:	38 00 00 00 	li      r0,0
>      4d8:	38 80 00 2f 	li      r4,47
>      4dc:	7c 69 1b 78 	mr      r9,r3
>      4e0:	7f a3 eb 78 	mr      r3,r29
>      4e4:	98 09 00 00 	stb     r0,0(r9)
>      4e8:	48 00 00 01 	bl      4e8 <.add_usable_mem_property+0x68>
>      4ec:	60 00 00 00 	nop
>      4f0:	e8 82 00 60 	ld      r4,96(r2)
>      4f4:	38 a0 00 08 	li      r5,8
>      4f8:	48 00 00 01 	bl      4f8 <.add_usable_mem_property+0x78>
>      4fc:	60 00 00 00 	nop
>      500:	2f a3 00 00 	cmpdi   cr7,r3,0
>      504:	40 9e 01 f8 	bne-    cr7,6fc <.add_usable_mem_property+0x27c>
>      508:	2b 9f 00 0f 	cmplwi  cr7,r31,15
>      50c:	40 9d 02 c4 	ble-    cr7,7d0 <.add_usable_mem_property+0x350>
>      510:	7f 63 db 78 	mr      r3,r27
>      514:	38 80 00 00 	li      r4,0
>      518:	38 a0 00 00 	li      r5,0
>      51c:	48 00 00 01 	bl      51c <.add_usable_mem_property+0x9c>
>      520:	60 00 00 00 	nop
>      524:	2f a3 00 00 	cmpdi   cr7,r3,0
>      528:	41 9c 02 d0 	blt-    cr7,7f8 <.add_usable_mem_property+0x378>
>      52c:	3b e1 00 70 	addi    r31,r1,112
>      530:	7f 63 db 78 	mr      r3,r27
>      534:	38 a0 00 10 	li      r5,16
>      538:	7f e4 fb 78 	mr      r4,r31
>      53c:	48 00 00 01 	bl      53c <.add_usable_mem_property+0xbc>
>      540:	60 00 00 00 	nop
>      544:	2f a3 00 10 	cmpdi   cr7,r3,16
>      548:	41 9e 00 2c 	beq-    cr7,574 <.add_usable_mem_property+0xf4>
>      54c:	48 00 00 01 	bl      54c <.add_usable_mem_property+0xcc>
>      550:	60 00 00 00 	nop
>      554:	e8 63 00 02 	lwa     r3,0(r3)
>      558:	48 00 00 01 	bl      558 <.add_usable_mem_property+0xd8>
>      55c:	60 00 00 00 	nop
>      560:	7f 84 e3 78 	mr      r4,r28
>      564:	7c 65 1b 78 	mr      r5,r3
>      568:	e8 62 00 78 	ld      r3,120(r2)
>      56c:	48 00 00 01 	bl      56c <.add_usable_mem_property+0xec>
>      570:	60 00 00 00 	nop
>      574:	e8 a1 00 70 	ld      r5,112(r1)
>      578:	e9 21 00 78 	ld      r9,120(r1)
>      57c:	7c a0 28 f8 	not     r0,r5
>      580:	7f a0 48 40 	cmpld   cr7,r0,r9
>      584:	41 9c 02 1c 	blt-    cr7,7a0 <.add_usable_mem_property+0x320>
>      588:	e9 62 00 88 	ld      r11,136(r2)
>      58c:	7c 85 4a 14 	add     r4,r5,r9
>      590:	81 2b 00 00 	lwz     r9,0(r11)
>      594:	2f a9 00 00 	cmpdi   cr7,r9,0
>      598:	41 9e 01 88 	beq-    cr7,720 <.add_usable_mem_property+0x2a0>
>      59c:	39 29 ff ff 	addi    r9,r9,-1
>      5a0:	eb ab 00 08 	ld      r29,8(r11)
>      5a4:	39 40 00 00 	li      r10,0
>      5a8:	38 c0 00 00 	li      r6,0
>      5ac:	79 29 00 20 	clrldi  r9,r9,32
>      5b0:	39 29 00 01 	addi    r9,r9,1
>      5b4:	1c 69 00 18 	mulli   r3,r9,24
>      5b8:	48 00 00 48 	b       600 <.add_usable_mem_property+0x180>
>      5bc:	60 00 00 00 	nop
>      5c0:	7f a4 38 40 	cmpld   cr7,r4,r7
>      5c4:	41 9c 00 50 	blt-    cr7,614 <.add_usable_mem_property+0x194>
>      5c8:	39 6a 00 01 	addi    r11,r10,1
>      5cc:	79 4a 1f 24 	rldicr  r10,r10,3,60
>      5d0:	7c 08 38 50 	subf    r0,r8,r7
>      5d4:	7d 6b 07 b4 	extsw   r11,r11
>      5d8:	7d 5f 52 14 	add     r10,r31,r10
>      5dc:	79 69 1f 24 	rldicr  r9,r11,3,60
>      5e0:	f9 0a 04 10 	std     r8,1040(r10)
>      5e4:	39 6b 00 01 	addi    r11,r11,1
>      5e8:	7d 3f 4a 14 	add     r9,r31,r9
>      5ec:	7d 6a 07 b4 	extsw   r10,r11
>      5f0:	f8 09 04 10 	std     r0,1040(r9)
>      5f4:	38 c6 00 18 	addi    r6,r6,24
>      5f8:	7f a6 18 00 	cmpd    cr7,r6,r3
>      5fc:	41 9e 00 84 	beq-    cr7,680 <.add_usable_mem_property+0x200>
>      600:	7f a9 eb 78 	mr      r9,r29
>      604:	7d 09 30 6a 	ldux    r8,r9,r6
>      608:	7f a5 40 40 	cmpld   cr7,r5,r8
>      60c:	e8 e9 00 08 	ld      r7,8(r9)
>      610:	40 9d ff b0 	ble+    cr7,5c0 <.add_usable_mem_property+0x140>
>      614:	7f a5 38 40 	cmpld   cr7,r5,r7
>      618:	40 9c ff dc 	bge+    cr7,5f4 <.add_usable_mem_property+0x174>
>      61c:	7f a4 40 40 	cmpld   cr7,r4,r8
>      620:	40 9d ff d4 	ble+    cr7,5f4 <.add_usable_mem_property+0x174>
>      624:	7f a5 40 40 	cmpld   cr7,r5,r8
>      628:	7c ab 2b 78 	mr      r11,r5
>      62c:	40 9c 00 08 	bge-    cr7,634 <.add_usable_mem_property+0x1b4>
>      630:	7d 0b 43 78 	mr      r11,r8
>      634:	38 0a 00 01 	addi    r0,r10,1
>      638:	7f a4 38 40 	cmpld   cr7,r4,r7
>      63c:	79 49 1f 24 	rldicr  r9,r10,3,60
>      640:	7c 08 07 b4 	extsw   r8,r0
>      644:	7d 3f 4a 14 	add     r9,r31,r9
>      648:	79 00 1f 24 	rldicr  r0,r8,3,60
>      64c:	f9 69 04 10 	std     r11,1040(r9)
>      650:	7d 5f 02 14 	add     r10,r31,r0
>      654:	7c 80 23 78 	mr      r0,r4
>      658:	40 9d 00 08 	ble-    cr7,660 <.add_usable_mem_property+0x1e0>
>      65c:	7c e0 3b 78 	mr      r0,r7
>      660:	38 c6 00 18 	addi    r6,r6,24
>      664:	7c 0b 00 50 	subf    r0,r11,r0
>      668:	39 28 00 01 	addi    r9,r8,1
>      66c:	7f a6 18 00 	cmpd    cr7,r6,r3
>      670:	f8 0a 04 10 	std     r0,1040(r10)
>      674:	7d 2a 07 b4 	extsw   r10,r9
>      678:	40 9e ff 88 	bne+    cr7,600 <.add_usable_mem_property+0x180>
>      67c:	60 00 00 00 	nop
>      680:	2f aa 00 00 	cmpdi   cr7,r10,0
>      684:	41 9e 00 9c 	beq-    cr7,720 <.add_usable_mem_property+0x2a0>
>      688:	eb be 54 18 	ld      r29,21528(r30)
>      68c:	79 40 1f 24 	rldicr  r0,r10,3,60
>      690:	e8 62 00 90 	ld      r3,144(r2)
>      694:	7c 1f 07 b4 	extsw   r31,r0
>      698:	38 00 00 03 	li      r0,3
>      69c:	93 fd 00 04 	stw     r31,4(r29)
>      6a0:	90 1d 00 00 	stw     r0,0(r29)
>      6a4:	3b bd 00 04 	addi    r29,r29,4
>      6a8:	39 3f 00 03 	addi    r9,r31,3
>      6ac:	3b 9d 00 04 	addi    r28,r29,4
>      6b0:	7d 29 16 70 	srawi   r9,r9,2
>      6b4:	7d 29 01 94 	addze   r9,r9
>      6b8:	fb 9e 54 18 	std     r28,21528(r30)
>      6bc:	7d 29 07 b4 	extsw   r9,r9
>      6c0:	3b 9c 00 04 	addi    r28,r28,4
>      6c4:	79 3b 17 64 	rldicr  r27,r9,2,61
>      6c8:	48 00 00 31 	bl      6f8 <.add_usable_mem_property+0x278>
>      6cc:	2f 9f 00 07 	cmpwi   cr7,r31,7
>      6d0:	90 7d 00 04 	stw     r3,4(r29)
>      6d4:	fb 9e 54 18 	std     r28,21528(r30)
>      6d8:	41 dd 00 90 	bgt-    cr7,768 <.add_usable_mem_property+0x2e8>
>      6dc:	e8 7e 54 18 	ld      r3,21528(r30)
>      6e0:	7f e5 fb 78 	mr      r5,r31
>      6e4:	38 81 04 80 	addi    r4,r1,1152
>      6e8:	48 00 00 01 	bl      6e8 <.add_usable_mem_property+0x268>
>      6ec:	60 00 00 00 	nop
>      6f0:	e8 1e 54 18 	ld      r0,21528(r30)
>      6f4:	7c 00 da 14 	add     r0,r0,r27
>      6f8:	f8 1e 54 18 	std     r0,21528(r30)
>      6fc:	38 21 44 b0 	addi    r1,r1,17584
>      700:	e8 01 00 10 	ld      r0,16(r1)
>      704:	eb 61 ff d8 	ld      r27,-40(r1)
>      708:	eb 81 ff e0 	ld      r28,-32(r1)
>      70c:	eb a1 ff e8 	ld      r29,-24(r1)
>      710:	eb c1 ff f0 	ld      r30,-16(r1)
>      714:	eb e1 ff f8 	ld      r31,-8(r1)
>      718:	7c 08 03 a6 	mtlr    r0
>      71c:	4e 80 00 20 	blr
>      720:	eb be 54 18 	ld      r29,21528(r30)
>      724:	39 20 00 00 	li      r9,0
>      728:	38 00 00 10 	li      r0,16
>      72c:	e8 62 00 90 	ld      r3,144(r2)
>      730:	3b e0 00 10 	li      r31,16
>      734:	3b 60 00 10 	li      r27,16
>      738:	f9 21 04 88 	std     r9,1160(r1)
>      73c:	f9 21 04 80 	std     r9,1152(r1)
>      740:	39 20 00 03 	li      r9,3
>      744:	90 1d 00 04 	stw     r0,4(r29)
>      748:	91 3d 00 00 	stw     r9,0(r29)
>      74c:	3b bd 00 04 	addi    r29,r29,4
>      750:	3b 9d 00 04 	addi    r28,r29,4
>      754:	fb 9e 54 18 	std     r28,21528(r30)
>      758:	3b 9c 00 04 	addi    r28,r28,4
>      75c:	48 00 00 31 	bl      78c <.add_usable_mem_property+0x30c>
>      760:	90 7d 00 04 	stw     r3,4(r29)
>      764:	fb 9e 54 18 	std     r28,21528(r30)
>      768:	7b 80 f7 e3 	rldicl. r0,r28,62,63
>      76c:	41 82 ff 70 	beq+    6dc <.add_usable_mem_property+0x25c>
>      770:	38 1c 00 04 	addi    r0,r28,4
>      774:	7f e5 fb 78 	mr      r5,r31
>      778:	38 81 04 80 	addi    r4,r1,1152
>      77c:	f8 1e 54 18 	std     r0,21528(r30)
>      780:	e8 7e 54 18 	ld      r3,21528(r30)
>      784:	48 00 00 01 	bl      784 <.add_usable_mem_property+0x304>
>      788:	60 00 00 00 	nop
>      78c:	e8 1e 54 18 	ld      r0,21528(r30)
>      790:	7c 00 da 14 	add     r0,r0,r27
>      794:	f8 1e 54 18 	std     r0,21528(r30)
>      798:	4b ff ff 64 	b       6fc <.add_usable_mem_property+0x27c>
>      79c:	60 00 00 00 	nop
>      7a0:	e8 62 00 80 	ld      r3,128(r2)
>      7a4:	48 00 00 01 	bl      7a4 <.add_usable_mem_property+0x324>
>      7a8:	60 00 00 00 	nop
>      7ac:	e9 21 00 78 	ld      r9,120(r1)
>      7b0:	e8 a1 00 70 	ld      r5,112(r1)
>      7b4:	e9 62 00 88 	ld      r11,136(r2)
>      7b8:	7c 85 4a 14 	add     r4,r5,r9
>      7bc:	81 2b 00 00 	lwz     r9,0(r11)
>      7c0:	2f a9 00 00 	cmpdi   cr7,r9,0
>      7c4:	40 9e fd d8 	bne+    cr7,59c <.add_usable_mem_property+0x11c>
>      7c8:	4b ff ff 58 	b       720 <.add_usable_mem_property+0x2a0>
>      7cc:	60 00 00 00 	nop
>      7d0:	e8 62 00 68 	ld      r3,104(r2)
>      7d4:	48 00 00 01 	bl      7d4 <.add_usable_mem_property+0x354>
>      7d8:	60 00 00 00 	nop
>      7dc:	7f 63 db 78 	mr      r3,r27
>      7e0:	38 80 00 00 	li      r4,0
>      7e4:	38 a0 00 00 	li      r5,0
>      7e8:	48 00 00 01 	bl      7e8 <.add_usable_mem_property+0x368>
>      7ec:	60 00 00 00 	nop
>      7f0:	2f a3 00 00 	cmpdi   cr7,r3,0
>      7f4:	40 9c fd 38 	bge+    cr7,52c <.add_usable_mem_property+0xac>
>      7f8:	48 00 00 01 	bl      7f8 <.add_usable_mem_property+0x378>
>      7fc:	60 00 00 00 	nop
>      800:	e8 63 00 02 	lwa     r3,0(r3)
>      804:	48 00 00 01 	bl      804 <.add_usable_mem_property+0x384>
>      808:	60 00 00 00 	nop
>      80c:	7f 84 e3 78 	mr      r4,r28
>      810:	7c 65 1b 78 	mr      r5,r3
>      814:	e8 62 00 70 	ld      r3,112(r2)
>      818:	48 00 00 01 	bl      818 <.add_usable_mem_property+0x398>
>      81c:	60 00 00 00 	nop
>      820:	4b ff fd 0c 	b       52c <.add_usable_mem_property+0xac>
>      824:	00 00 00 00 	.long 0x0
>      828:	00 00 00 01 	.long 0x1
>      82c:	80 05 00 00 	lwz     r0,0(r5)
> 
> 0000000000000830 <.add_dyn_reconf_usable_mem_property>:
>      830:	7c 08 02 a6 	mflr    r0
>      834:	fb 01 ff c0 	std     r24,-64(r1)
>      838:	fb 21 ff c8 	std     r25,-56(r1)
>      83c:	fb 41 ff d0 	std     r26,-48(r1)
>      840:	fb a1 ff e8 	std     r29,-24(r1)
>      844:	fa 81 ff a0 	std     r20,-96(r1)
>      848:	fa a1 ff a8 	std     r21,-88(r1)
>      84c:	f8 01 00 10 	std     r0,16(r1)
>      850:	fa c1 ff b0 	std     r22,-80(r1)
>      854:	fa e1 ff b8 	std     r23,-72(r1)
>      858:	fb 61 ff d8 	std     r27,-40(r1)
>      85c:	fb 81 ff e0 	std     r28,-32(r1)
>      860:	fb c1 ff f0 	std     r30,-16(r1)
>      864:	fb e1 ff f8 	std     r31,-8(r1)
>      868:	f8 21 ba 31 	stdu    r1,-17872(r1)
>      86c:	eb 42 00 00 	ld      r26,0(r2)
>      870:	7c 79 1b 78 	mr      r25,r3
>      874:	3b 1a 50 18 	addi    r24,r26,20504
>      878:	7f 04 c3 78 	mr      r4,r24
>      87c:	3b a1 01 70 	addi    r29,r1,368
>      880:	7f a3 eb 78 	mr      r3,r29
>      884:	48 00 00 01 	bl      884 <.add_dyn_reconf_usable_mem_property+0x54>
>      888:	60 00 00 00 	nop
>      88c:	38 80 00 2f 	li      r4,47
>      890:	7f a3 eb 78 	mr      r3,r29
>      894:	48 00 00 01 	bl      894 <.add_dyn_reconf_usable_mem_property+0x64>
>      898:	60 00 00 00 	nop
>      89c:	38 00 00 00 	li      r0,0
>      8a0:	38 80 00 2f 	li      r4,47
>      8a4:	7c 69 1b 78 	mr      r9,r3
>      8a8:	7f a3 eb 78 	mr      r3,r29
>      8ac:	98 09 00 00 	stb     r0,0(r9)
>      8b0:	48 00 00 01 	bl      8b0 <.add_dyn_reconf_usable_mem_property+0x80>
>      8b4:	60 00 00 00 	nop
>      8b8:	e8 82 00 98 	ld      r4,152(r2)
>      8bc:	48 00 00 01 	bl      8bc <.add_dyn_reconf_usable_mem_property+0x8c>
>      8c0:	60 00 00 00 	nop
>      8c4:	2f a3 00 00 	cmpdi   cr7,r3,0
>      8c8:	41 9e 00 44 	beq-    cr7,90c <.add_dyn_reconf_usable_mem_property+0xdc>
>      8cc:	38 21 45 d0 	addi    r1,r1,17872
>      8d0:	e8 01 00 10 	ld      r0,16(r1)
>      8d4:	ea 81 ff a0 	ld      r20,-96(r1)
>      8d8:	ea a1 ff a8 	ld      r21,-88(r1)
>      8dc:	ea c1 ff b0 	ld      r22,-80(r1)
>      8e0:	ea e1 ff b8 	ld      r23,-72(r1)
>      8e4:	eb 01 ff c0 	ld      r24,-64(r1)
>      8e8:	eb 21 ff c8 	ld      r25,-56(r1)
>      8ec:	eb 41 ff d0 	ld      r26,-48(r1)
>      8f0:	7c 08 03 a6 	mtlr    r0
>      8f4:	eb 61 ff d8 	ld      r27,-40(r1)
>      8f8:	eb 81 ff e0 	ld      r28,-32(r1)
>      8fc:	eb a1 ff e8 	ld      r29,-24(r1)
>      900:	eb c1 ff f0 	ld      r30,-16(r1)
>      904:	eb e1 ff f8 	ld      r31,-8(r1)
>      908:	4e 80 00 20 	blr
>      90c:	7f 23 cb 78 	mr      r3,r25
>      910:	38 80 00 04 	li      r4,4
>      914:	38 a0 00 00 	li      r5,0
>      918:	48 00 00 01 	bl      918 <.add_dyn_reconf_usable_mem_property+0xe8>
>      91c:	60 00 00 00 	nop
>      920:	2f a3 00 00 	cmpdi   cr7,r3,0
>      924:	41 9c 02 d0 	blt-    cr7,bf4 <.add_dyn_reconf_usable_mem_property+0x3c4>
>      928:	ea a2 00 a0 	ld      r21,160(r2)
>      92c:	80 15 00 00 	lwz     r0,0(r21)
>      930:	2f 80 00 00 	cmpwi   cr7,r0,0
>      934:	41 9e 02 ec 	beq-    cr7,c20 <.add_dyn_reconf_usable_mem_property+0x3f0>
>      938:	3b e1 00 70 	addi    r31,r1,112
>      93c:	7f 23 cb 78 	mr      r3,r25
>      940:	ea c2 00 88 	ld      r22,136(r2)
>      944:	ea e2 00 a8 	ld      r23,168(r2)
>      948:	38 a0 00 18 	li      r5,24
>      94c:	3b c0 00 00 	li      r30,0
>      950:	7f e4 fb 78 	mr      r4,r31
>      954:	3b 60 00 00 	li      r27,0
>      958:	48 00 00 01 	bl      958 <.add_dyn_reconf_usable_mem_property+0x128>
>      95c:	60 00 00 00 	nop
>      960:	7e d4 b3 78 	mr      r20,r22
>      964:	2f a3 00 00 	cmpdi   cr7,r3,0
>      968:	41 9c 01 6c 	blt-    cr7,ad4 <.add_dyn_reconf_usable_mem_property+0x2a4>
>      96c:	60 00 00 00 	nop
>      970:	eb a1 00 70 	ld      r29,112(r1)
>      974:	e9 37 00 00 	ld      r9,0(r23)
>      978:	7f a0 e8 f8 	not     r0,r29
>      97c:	7f 9d 4a 14 	add     r28,r29,r9
>      980:	7f bc 00 40 	cmpld   cr7,r28,r0
>      984:	41 9d 01 9c 	bgt-    cr7,b20 <.add_dyn_reconf_usable_mem_property+0x2f0>
>      988:	81 36 00 00 	lwz     r9,0(r22)
>      98c:	38 1e 00 01 	addi    r0,r30,1
>      990:	39 00 00 00 	li      r8,0
>      994:	7c 0a 07 b4 	extsw   r10,r0
>      998:	2f a9 00 00 	cmpdi   cr7,r9,0
>      99c:	41 9e 00 f8 	beq-    cr7,a94 <.add_dyn_reconf_usable_mem_property+0x264>
>      9a0:	39 29 ff ff 	addi    r9,r9,-1
>      9a4:	e8 74 00 08 	ld      r3,8(r20)
>      9a8:	38 a0 00 00 	li      r5,0
>      9ac:	38 c0 00 00 	li      r6,0
>      9b0:	79 29 00 20 	clrldi  r9,r9,32
>      9b4:	39 29 00 01 	addi    r9,r9,1
>      9b8:	1c 89 00 18 	mulli   r4,r9,24
>      9bc:	48 00 00 4c 	b       a08 <.add_dyn_reconf_usable_mem_property+0x1d8>
>      9c0:	7f bc 40 40 	cmpld   cr7,r28,r8
>      9c4:	41 9c 00 58 	blt-    cr7,a1c <.add_dyn_reconf_usable_mem_property+0x1ec>
>      9c8:	39 6a 00 01 	addi    r11,r10,1
>      9cc:	79 4a 1f 24 	rldicr  r10,r10,3,60
>      9d0:	7d 07 40 50 	subf    r8,r7,r8
>      9d4:	38 05 00 01 	addi    r0,r5,1
>      9d8:	7d 6b 07 b4 	extsw   r11,r11
>      9dc:	7d 5f 52 14 	add     r10,r31,r10
>      9e0:	7c 05 07 b4 	extsw   r5,r0
>      9e4:	79 69 1f 24 	rldicr  r9,r11,3,60
>      9e8:	f8 ea 05 00 	std     r7,1280(r10)
>      9ec:	39 6b 00 01 	addi    r11,r11,1
>      9f0:	7d 3f 4a 14 	add     r9,r31,r9
>      9f4:	7d 6a 07 b4 	extsw   r10,r11
>      9f8:	f9 09 05 00 	std     r8,1280(r9)
>      9fc:	38 c6 00 18 	addi    r6,r6,24
>      a00:	7f a6 20 00 	cmpd    cr7,r6,r4
>      a04:	41 9e 00 8c 	beq-    cr7,a90 <.add_dyn_reconf_usable_mem_property+0x260>
>      a08:	7c 69 1b 78 	mr      r9,r3
>      a0c:	7c e9 30 6a 	ldux    r7,r9,r6
>      a10:	7f bd 38 40 	cmpld   cr7,r29,r7
>      a14:	e9 09 00 08 	ld      r8,8(r9)
>      a18:	40 9d ff a8 	ble+    cr7,9c0 <.add_dyn_reconf_usable_mem_property+0x190>
>      a1c:	7f bd 40 40 	cmpld   cr7,r29,r8
>      a20:	40 9c ff dc 	bge+    cr7,9fc <.add_dyn_reconf_usable_mem_property+0x1cc>
>      a24:	7f bc 38 40 	cmpld   cr7,r28,r7
>      a28:	40 9d ff d4 	ble+    cr7,9fc <.add_dyn_reconf_usable_mem_property+0x1cc>
>      a2c:	7f a7 e8 40 	cmpld   cr7,r7,r29
>      a30:	40 9c 00 08 	bge-    cr7,a38 <.add_dyn_reconf_usable_mem_property+0x208>
>      a34:	7f a7 eb 78 	mr      r7,r29
>      a38:	38 0a 00 01 	addi    r0,r10,1
>      a3c:	7f bc 40 40 	cmpld   cr7,r28,r8
>      a40:	79 49 1f 24 	rldicr  r9,r10,3,60
>      a44:	7c 0b 07 b4 	extsw   r11,r0
>      a48:	7d 3f 4a 14 	add     r9,r31,r9
>      a4c:	79 60 1f 24 	rldicr  r0,r11,3,60
>      a50:	f8 e9 05 00 	std     r7,1280(r9)
>      a54:	7d 5f 02 14 	add     r10,r31,r0
>      a58:	7f 80 e3 78 	mr      r0,r28
>      a5c:	40 9d 00 08 	ble-    cr7,a64 <.add_dyn_reconf_usable_mem_property+0x234>
>      a60:	7d 00 43 78 	mr      r0,r8
>      a64:	38 c6 00 18 	addi    r6,r6,24
>      a68:	7c 07 00 50 	subf    r0,r7,r0
>      a6c:	39 6b 00 01 	addi    r11,r11,1
>      a70:	39 25 00 01 	addi    r9,r5,1
>      a74:	7f a6 20 00 	cmpd    cr7,r6,r4
>      a78:	f8 0a 05 00 	std     r0,1280(r10)
>      a7c:	7d 25 07 b4 	extsw   r5,r9
>      a80:	7d 6a 07 b4 	extsw   r10,r11
>      a84:	40 9e ff 84 	bne+    cr7,a08 <.add_dyn_reconf_usable_mem_property+0x1d8>
>      a88:	60 00 00 00 	nop
>      a8c:	60 00 00 00 	nop
>      a90:	7c a8 2b 78 	mr      r8,r5
>      a94:	38 1b 00 01 	addi    r0,r27,1
>      a98:	81 75 00 00 	lwz     r11,0(r21)
>      a9c:	7b c9 1f 24 	rldicr  r9,r30,3,60
>      aa0:	7c 1b 07 b4 	extsw   r27,r0
>      aa4:	7d 3f 4a 14 	add     r9,r31,r9
>      aa8:	7f 8b d8 40 	cmplw   cr7,r11,r27
>      aac:	f9 09 05 00 	std     r8,1280(r9)
>      ab0:	40 9d 00 80 	ble-    cr7,b30 <.add_dyn_reconf_usable_mem_property+0x300>
>      ab4:	7f 23 cb 78 	mr      r3,r25
>      ab8:	7f e4 fb 78 	mr      r4,r31
>      abc:	38 a0 00 18 	li      r5,24
>      ac0:	7d 5e 53 78 	mr      r30,r10
>      ac4:	48 00 00 01 	bl      ac4 <.add_dyn_reconf_usable_mem_property+0x294>
>      ac8:	60 00 00 00 	nop
>      acc:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ad0:	40 9c fe a0 	bge+    cr7,970 <.add_dyn_reconf_usable_mem_property+0x140>
>      ad4:	48 00 00 01 	bl      ad4 <.add_dyn_reconf_usable_mem_property+0x2a4>
>      ad8:	60 00 00 00 	nop
>      adc:	e8 63 00 02 	lwa     r3,0(r3)
>      ae0:	48 00 00 01 	bl      ae0 <.add_dyn_reconf_usable_mem_property+0x2b0>
>      ae4:	60 00 00 00 	nop
>      ae8:	7f 04 c3 78 	mr      r4,r24
>      aec:	7c 65 1b 78 	mr      r5,r3
>      af0:	e8 62 00 78 	ld      r3,120(r2)
>      af4:	48 00 00 01 	bl      af4 <.add_dyn_reconf_usable_mem_property+0x2c4>
>      af8:	60 00 00 00 	nop
>      afc:	eb a1 00 70 	ld      r29,112(r1)
>      b00:	e9 37 00 00 	ld      r9,0(r23)
>      b04:	7f a0 e8 f8 	not     r0,r29
>      b08:	7f 9d 4a 14 	add     r28,r29,r9
>      b0c:	7f bc 00 40 	cmpld   cr7,r28,r0
>      b10:	40 9d fe 78 	ble+    cr7,988 <.add_dyn_reconf_usable_mem_property+0x158>
>      b14:	60 00 00 00 	nop
>      b18:	60 00 00 00 	nop
>      b1c:	60 00 00 00 	nop
>      b20:	e8 62 00 80 	ld      r3,128(r2)
>      b24:	48 00 00 01 	bl      b24 <.add_dyn_reconf_usable_mem_property+0x2f4>
>      b28:	60 00 00 00 	nop
>      b2c:	4b ff fe 5c 	b       988 <.add_dyn_reconf_usable_mem_property+0x158>
>      b30:	eb ba 54 18 	ld      r29,21528(r26)
>      b34:	79 40 1f 24 	rldicr  r0,r10,3,60
>      b38:	e8 62 00 b0 	ld      r3,176(r2)
>      b3c:	7c 1f 07 b4 	extsw   r31,r0
>      b40:	38 00 00 03 	li      r0,3
>      b44:	93 fd 00 04 	stw     r31,4(r29)
>      b48:	90 1d 00 00 	stw     r0,0(r29)
>      b4c:	3b bd 00 04 	addi    r29,r29,4
>      b50:	39 3f 00 03 	addi    r9,r31,3
>      b54:	3b 9d 00 04 	addi    r28,r29,4
>      b58:	7d 29 16 70 	srawi   r9,r9,2
>      b5c:	7d 29 01 94 	addze   r9,r9
>      b60:	fb 9a 54 18 	std     r28,21528(r26)
>      b64:	7d 29 07 b4 	extsw   r9,r9
>      b68:	3b 9c 00 04 	addi    r28,r28,4
>      b6c:	79 3e 17 64 	rldicr  r30,r9,2,61
>      b70:	48 00 00 31 	bl      ba0 <.add_dyn_reconf_usable_mem_property+0x370>
>      b74:	2f 9f 00 07 	cmpwi   cr7,r31,7
>      b78:	90 7d 00 04 	stw     r3,4(r29)
>      b7c:	fb 9a 54 18 	std     r28,21528(r26)
>      b80:	40 9d 00 14 	ble-    cr7,b94 <.add_dyn_reconf_usable_mem_property+0x364>
>      b84:	7b 80 f7 e3 	rldicl. r0,r28,62,63
>      b88:	41 82 00 0c 	beq-    b94 <.add_dyn_reconf_usable_mem_property+0x364>
>      b8c:	38 1c 00 04 	addi    r0,r28,4
>      b90:	f8 1a 54 18 	std     r0,21528(r26)
>      b94:	e8 7a 54 18 	ld      r3,21528(r26)
>      b98:	7f e5 fb 78 	mr      r5,r31
>      b9c:	38 81 05 70 	addi    r4,r1,1392
>      ba0:	48 00 00 01 	bl      ba0 <.add_dyn_reconf_usable_mem_property+0x370>
>      ba4:	60 00 00 00 	nop
>      ba8:	e8 1a 54 18 	ld      r0,21528(r26)
>      bac:	38 21 45 d0 	addi    r1,r1,17872
>      bb0:	7c 00 f2 14 	add     r0,r0,r30
>      bb4:	f8 1a 54 18 	std     r0,21528(r26)
>      bb8:	e8 01 00 10 	ld      r0,16(r1)
>      bbc:	ea 81 ff a0 	ld      r20,-96(r1)
>      bc0:	ea a1 ff a8 	ld      r21,-88(r1)
>      bc4:	ea c1 ff b0 	ld      r22,-80(r1)
>      bc8:	ea e1 ff b8 	ld      r23,-72(r1)
>      bcc:	eb 01 ff c0 	ld      r24,-64(r1)
>      bd0:	eb 21 ff c8 	ld      r25,-56(r1)
>      bd4:	eb 41 ff d0 	ld      r26,-48(r1)
>      bd8:	7c 08 03 a6 	mtlr    r0
>      bdc:	eb 61 ff d8 	ld      r27,-40(r1)
>      be0:	eb 81 ff e0 	ld      r28,-32(r1)
>      be4:	eb a1 ff e8 	ld      r29,-24(r1)
>      be8:	eb c1 ff f0 	ld      r30,-16(r1)
>      bec:	eb e1 ff f8 	ld      r31,-8(r1)
>      bf0:	4e 80 00 20 	blr
>      bf4:	48 00 00 01 	bl      bf4 <.add_dyn_reconf_usable_mem_property+0x3c4>
>      bf8:	60 00 00 00 	nop
>      bfc:	e8 63 00 02 	lwa     r3,0(r3)
>      c00:	48 00 00 01 	bl      c00 <.add_dyn_reconf_usable_mem_property+0x3d0>
>      c04:	60 00 00 00 	nop
>      c08:	7f 04 c3 78 	mr      r4,r24
>      c0c:	7c 65 1b 78 	mr      r5,r3
>      c10:	e8 62 00 70 	ld      r3,112(r2)
>      c14:	48 00 00 01 	bl      c14 <.add_dyn_reconf_usable_mem_property+0x3e4>
>      c18:	60 00 00 00 	nop
>      c1c:	4b ff fd 0c 	b       928 <.add_dyn_reconf_usable_mem_property+0xf8>
>      c20:	eb ba 54 18 	ld      r29,21528(r26)
>      c24:	e8 62 00 b0 	ld      r3,176(r2)
>      c28:	3b e0 00 00 	li      r31,0
>      c2c:	3b c0 00 00 	li      r30,0
>      c30:	90 1d 00 04 	stw     r0,4(r29)
>      c34:	38 00 00 03 	li      r0,3
>      c38:	90 1d 00 00 	stw     r0,0(r29)
>      c3c:	3b bd 00 04 	addi    r29,r29,4
>      c40:	3b 9d 00 04 	addi    r28,r29,4
>      c44:	fb 9a 54 18 	std     r28,21528(r26)
>      c48:	3b 9c 00 04 	addi    r28,r28,4
>      c4c:	48 00 00 31 	bl      c7c <.putprops+0xc>
>      c50:	90 7d 00 04 	stw     r3,4(r29)
>      c54:	fb 9a 54 18 	std     r28,21528(r26)
>      c58:	4b ff ff 3c 	b       b94 <.add_dyn_reconf_usable_mem_property+0x364>
>      c5c:	00 00 00 00 	.long 0x0
>      c60:	00 00 00 01 	.long 0x1
>      c64:	80 0c 00 00 	lwz     r0,0(r12)
>      c68:	60 00 00 00 	nop
>      c6c:	60 00 00 00 	nop
> 
> 0000000000000c70 <.putprops>:
>      c70:	7c 08 02 a6 	mflr    r0
>      c74:	2f 85 00 00 	cmpwi   cr7,r5,0
>      c78:	fa e1 ff b8 	std     r23,-72(r1)
>      c7c:	fb 21 ff c8 	std     r25,-56(r1)
>      c80:	fa 01 ff 80 	std     r16,-128(r1)
>      c84:	fa 21 ff 88 	std     r17,-120(r1)
>      c88:	fa 41 ff 90 	std     r18,-112(r1)
>      c8c:	fa 61 ff 98 	std     r19,-104(r1)
>      c90:	f8 01 00 10 	std     r0,16(r1)
>      c94:	fa 81 ff a0 	std     r20,-96(r1)
>      c98:	fa a1 ff a8 	std     r21,-88(r1)
>      c9c:	fa c1 ff b0 	std     r22,-80(r1)
>      ca0:	fb 01 ff c0 	std     r24,-64(r1)
>      ca4:	fb 41 ff d0 	std     r26,-48(r1)
>      ca8:	fb 61 ff d8 	std     r27,-40(r1)
>      cac:	fb 81 ff e0 	std     r28,-32(r1)
>      cb0:	fb a1 ff e8 	std     r29,-24(r1)
>      cb4:	fb c1 ff f0 	std     r30,-16(r1)
>      cb8:	fb e1 ff f8 	std     r31,-8(r1)
>      cbc:	f8 21 fe 81 	stdu    r1,-384(r1)
>      cc0:	7c b7 2b 78 	mr      r23,r5
>      cc4:	7c 79 1b 78 	mr      r25,r3
>      cc8:	40 9d 04 08 	ble-    cr7,10d0 <.putprops+0x460>
>      ccc:	eb 02 00 00 	ld      r24,0(r2)
>      cd0:	38 00 00 00 	li      r0,0
>      cd4:	7c 9a 23 78 	mr      r26,r4
>      cd8:	3b 60 00 00 	li      r27,0
>      cdc:	3a 81 00 70 	addi    r20,r1,112
>      ce0:	60 12 80 00 	ori     r18,r0,32768
>      ce4:	3a 00 00 03 	li      r16,3
>      ce8:	3a d8 50 18 	addi    r22,r24,20504
>      cec:	7f 11 c3 78 	mr      r17,r24
>      cf0:	7e d5 b3 78 	mr      r21,r22
>      cf4:	48 00 00 60 	b       d54 <.putprops+0xe4>
>      cf8:	60 00 00 00 	nop
>      cfc:	60 00 00 00 	nop
>      d00:	38 60 00 01 	li      r3,1
>      d04:	7e a4 ab 78 	mr      r4,r21
>      d08:	7e 85 a3 78 	mr      r5,r20
>      d0c:	48 00 00 01 	bl      d0c <.putprops+0x9c>
>      d10:	60 00 00 00 	nop
>      d14:	2f a3 00 00 	cmpdi   cr7,r3,0
>      d18:	40 9e 01 08 	bne-    cr7,e20 <.putprops+0x1b0>
>      d1c:	80 18 54 20 	lwz     r0,21536(r24)
>      d20:	2f 80 00 00 	cmpwi   cr7,r0,0
>      d24:	41 9e 01 30 	beq-    cr7,e54 <.putprops+0x1e4>
>      d28:	e8 82 00 d0 	ld      r4,208(r2)
>      d2c:	7f c3 f3 78 	mr      r3,r30
>      d30:	48 00 00 01 	bl      d30 <.putprops+0xc0>
>      d34:	60 00 00 00 	nop
>      d38:	2f a3 00 00 	cmpdi   cr7,r3,0
>      d3c:	40 9e 01 60 	bne-    cr7,e9c <.putprops+0x22c>
>      d40:	38 1b 00 01 	addi    r0,r27,1
>      d44:	3b 5a 00 08 	addi    r26,r26,8
>      d48:	7c 1b 07 b4 	extsw   r27,r0
>      d4c:	7f 97 d8 00 	cmpw    cr7,r23,r27
>      d50:	40 9d 00 60 	ble-    cr7,db0 <.putprops+0x140>
>      d54:	eb fa 00 00 	ld      r31,0(r26)
>      d58:	7f 23 cb 78 	mr      r3,r25
>      d5c:	3b df 00 13 	addi    r30,r31,19
>      d60:	7f c4 f3 78 	mr      r4,r30
>      d64:	48 00 00 01 	bl      d64 <.putprops+0xf4>
>      d68:	60 00 00 00 	nop
>      d6c:	88 1f 00 13 	lbz     r0,19(r31)
>      d70:	2f 80 00 2e 	cmpwi   cr7,r0,46
>      d74:	40 9e ff 8c 	bne+    cr7,d00 <.putprops+0x90>
>      d78:	88 1f 00 14 	lbz     r0,20(r31)
>      d7c:	2f a0 00 00 	cmpdi   cr7,r0,0
>      d80:	41 fe ff c0 	beq-    cr7,d40 <.putprops+0xd0>
>      d84:	2f 80 00 2e 	cmpwi   cr7,r0,46
>      d88:	40 9e ff 78 	bne+    cr7,d00 <.putprops+0x90>
>      d8c:	88 1f 00 15 	lbz     r0,21(r31)
>      d90:	2f 80 00 00 	cmpwi   cr7,r0,0
>      d94:	40 de ff 6c 	bne+    cr7,d00 <.putprops+0x90>
>      d98:	38 1b 00 01 	addi    r0,r27,1
>      d9c:	3b 5a 00 08 	addi    r26,r26,8
>      da0:	7c 1b 07 b4 	extsw   r27,r0
>      da4:	7f 97 d8 00 	cmpw    cr7,r23,r27
>      da8:	41 9d ff ac 	bgt+    cr7,d54 <.putprops+0xe4>
>      dac:	60 00 00 00 	nop
>      db0:	38 00 00 00 	li      r0,0
>      db4:	7e c3 b3 78 	mr      r3,r22
>      db8:	38 80 00 00 	li      r4,0
>      dbc:	38 a0 00 00 	li      r5,0
>      dc0:	98 19 00 00 	stb     r0,0(r25)
>      dc4:	48 00 00 19 	bl      ddc <.putprops+0x16c>
>      dc8:	38 21 01 80 	addi    r1,r1,384
>      dcc:	e8 01 00 10 	ld      r0,16(r1)
>      dd0:	ea 01 ff 80 	ld      r16,-128(r1)
>      dd4:	ea 21 ff 88 	ld      r17,-120(r1)
>      dd8:	ea 41 ff 90 	ld      r18,-112(r1)
>      ddc:	ea 61 ff 98 	ld      r19,-104(r1)
>      de0:	ea 81 ff a0 	ld      r20,-96(r1)
>      de4:	ea a1 ff a8 	ld      r21,-88(r1)
>      de8:	ea c1 ff b0 	ld      r22,-80(r1)
>      dec:	7c 08 03 a6 	mtlr    r0
>      df0:	ea e1 ff b8 	ld      r23,-72(r1)
>      df4:	eb 01 ff c0 	ld      r24,-64(r1)
>      df8:	eb 21 ff c8 	ld      r25,-56(r1)
>      dfc:	eb 41 ff d0 	ld      r26,-48(r1)
>      e00:	eb 61 ff d8 	ld      r27,-40(r1)
>      e04:	eb 81 ff e0 	ld      r28,-32(r1)
>      e08:	eb a1 ff e8 	ld      r29,-24(r1)
>      e0c:	eb c1 ff f0 	ld      r30,-16(r1)
>      e10:	eb e1 ff f8 	ld      r31,-8(r1)
>      e14:	4e 80 00 20 	blr
>      e18:	60 00 00 00 	nop
>      e1c:	60 00 00 00 	nop
>      e20:	48 00 00 01 	bl      e20 <.putprops+0x1b0>
>      e24:	60 00 00 00 	nop
>      e28:	e8 63 00 02 	lwa     r3,0(r3)
>      e2c:	48 00 00 01 	bl      e2c <.putprops+0x1bc>
>      e30:	60 00 00 00 	nop
>      e34:	7e a4 ab 78 	mr      r4,r21
>      e38:	7c 65 1b 78 	mr      r5,r3
>      e3c:	e8 62 00 b8 	ld      r3,184(r2)
>      e40:	48 00 00 01 	bl      e40 <.putprops+0x1d0>
>      e44:	60 00 00 00 	nop
>      e48:	80 18 54 20 	lwz     r0,21536(r24)
>      e4c:	2f 80 00 00 	cmpwi   cr7,r0,0
>      e50:	40 9e fe d8 	bne+    cr7,d28 <.putprops+0xb8>
>      e54:	e8 82 00 c0 	ld      r4,192(r2)
>      e58:	7f 23 cb 78 	mr      r3,r25
>      e5c:	48 00 00 01 	bl      e5c <.putprops+0x1ec>
>      e60:	60 00 00 00 	nop
>      e64:	2f a3 00 00 	cmpdi   cr7,r3,0
>      e68:	41 9e fe d8 	beq+    cr7,d40 <.putprops+0xd0>
>      e6c:	e8 82 00 c8 	ld      r4,200(r2)
>      e70:	7f 23 cb 78 	mr      r3,r25
>      e74:	48 00 00 01 	bl      e74 <.putprops+0x204>
>      e78:	60 00 00 00 	nop
>      e7c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      e80:	41 9e fe c0 	beq+    cr7,d40 <.putprops+0xd0>
>      e84:	e8 82 00 d0 	ld      r4,208(r2)
>      e88:	7f c3 f3 78 	mr      r3,r30
>      e8c:	48 00 00 01 	bl      e8c <.putprops+0x21c>
>      e90:	60 00 00 00 	nop
>      e94:	2f a3 00 00 	cmpdi   cr7,r3,0
>      e98:	41 9e fe a8 	beq+    cr7,d40 <.putprops+0xd0>
>      e9c:	e8 82 00 d8 	ld      r4,216(r2)
>      ea0:	7f c3 f3 78 	mr      r3,r30
>      ea4:	48 00 00 01 	bl      ea4 <.putprops+0x234>
>      ea8:	60 00 00 00 	nop
>      eac:	2f a3 00 00 	cmpdi   cr7,r3,0
>      eb0:	41 9e fe 90 	beq+    cr7,d40 <.putprops+0xd0>
>      eb4:	e8 82 00 e0 	ld      r4,224(r2)
>      eb8:	7f c3 f3 78 	mr      r3,r30
>      ebc:	48 00 00 01 	bl      ebc <.putprops+0x24c>
>      ec0:	60 00 00 00 	nop
>      ec4:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ec8:	41 9e fe 78 	beq+    cr7,d40 <.putprops+0xd0>
>      ecc:	e8 82 00 e8 	ld      r4,232(r2)
>      ed0:	7f c3 f3 78 	mr      r3,r30
>      ed4:	48 00 00 01 	bl      ed4 <.putprops+0x264>
>      ed8:	60 00 00 00 	nop
>      edc:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ee0:	41 9e fe 60 	beq+    cr7,d40 <.putprops+0xd0>
>      ee4:	e8 82 00 40 	ld      r4,64(r2)
>      ee8:	7f c3 f3 78 	mr      r3,r30
>      eec:	48 00 00 01 	bl      eec <.putprops+0x27c>
>      ef0:	60 00 00 00 	nop
>      ef4:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ef8:	40 9e 01 e0 	bne-    cr7,10d8 <.putprops+0x468>
>      efc:	e9 22 00 38 	ld      r9,56(r2)
>      f00:	88 09 00 00 	lbz     r0,0(r9)
>      f04:	2f 80 00 00 	cmpwi   cr7,r0,0
>      f08:	41 9e fe 38 	beq+    cr7,d40 <.putprops+0xd0>
>      f0c:	e8 82 00 f0 	ld      r4,240(r2)
>      f10:	7f c3 f3 78 	mr      r3,r30
>      f14:	48 00 00 01 	bl      f14 <.putprops+0x2a4>
>      f18:	60 00 00 00 	nop
>      f1c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      f20:	41 9e fe 20 	beq+    cr7,d40 <.putprops+0xd0>
>      f24:	80 01 00 88 	lwz     r0,136(r1)
>      f28:	54 00 04 26 	rlwinm  r0,r0,0,16,19
>      f2c:	7f 80 90 00 	cmpw    cr7,r0,r18
>      f30:	40 9e fe 10 	bne+    cr7,d40 <.putprops+0xd0>
>      f34:	e9 38 54 18 	ld      r9,21528(r24)
>      f38:	ea 61 00 a6 	lwa     r19,164(r1)
>      f3c:	7f 23 cb 78 	mr      r3,r25
>      f40:	3b a9 00 04 	addi    r29,r9,4
>      f44:	92 09 00 00 	stw     r16,0(r9)
>      f48:	3b 9d 00 04 	addi    r28,r29,4
>      f4c:	fb b8 54 28 	std     r29,21544(r24)
>      f50:	92 69 00 04 	stw     r19,4(r9)
>      f54:	fb 98 54 18 	std     r28,21528(r24)
>      f58:	3b 9c 00 04 	addi    r28,r28,4
>      f5c:	48 00 00 31 	bl      f8c <.putprops+0x31c>
>      f60:	2f 93 00 07 	cmpwi   cr7,r19,7
>      f64:	90 7d 00 04 	stw     r3,4(r29)
>      f68:	fb 98 54 18 	std     r28,21528(r24)
>      f6c:	40 9d 00 14 	ble-    cr7,f80 <.putprops+0x310>
>      f70:	7b 80 f7 e3 	rldicl. r0,r28,62,63
>      f74:	41 82 00 0c 	beq-    f80 <.putprops+0x310>
>      f78:	38 1c 00 04 	addi    r0,r28,4
>      f7c:	f8 11 54 18 	std     r0,21528(r17)
>      f80:	7e a3 ab 78 	mr      r3,r21
>      f84:	38 80 00 00 	li      r4,0
>      f88:	48 00 00 01 	bl      f88 <.putprops+0x318>
>      f8c:	60 00 00 00 	nop
>      f90:	2f 83 ff ff 	cmpwi   cr7,r3,-1
>      f94:	7c 7d 1b 78 	mr      r29,r3
>      f98:	40 9e 00 2c 	bne-    cr7,fc4 <.putprops+0x354>
>      f9c:	48 00 00 01 	bl      f9c <.putprops+0x32c>
>      fa0:	60 00 00 00 	nop
>      fa4:	e8 63 00 02 	lwa     r3,0(r3)
>      fa8:	48 00 00 01 	bl      fa8 <.putprops+0x338>
>      fac:	60 00 00 00 	nop
>      fb0:	7e a4 ab 78 	mr      r4,r21
>      fb4:	7c 65 1b 78 	mr      r5,r3
>      fb8:	e8 62 00 f8 	ld      r3,248(r2)
>      fbc:	48 00 00 01 	bl      fbc <.putprops+0x34c>
>      fc0:	60 00 00 00 	nop
>      fc4:	e8 98 54 18 	ld      r4,21528(r24)
>      fc8:	7f a3 eb 78 	mr      r3,r29
>      fcc:	7e 65 9b 78 	mr      r5,r19
>      fd0:	48 00 00 01 	bl      fd0 <.putprops+0x360>
>      fd4:	60 00 00 00 	nop
>      fd8:	7f a3 98 00 	cmpd    cr7,r3,r19
>      fdc:	41 9e 00 2c 	beq-    cr7,1008 <.putprops+0x398>
>      fe0:	48 00 00 01 	bl      fe0 <.putprops+0x370>
>      fe4:	60 00 00 00 	nop
>      fe8:	e8 63 00 02 	lwa     r3,0(r3)
>      fec:	48 00 00 01 	bl      fec <.putprops+0x37c>
>      ff0:	60 00 00 00 	nop
>      ff4:	7e a4 ab 78 	mr      r4,r21
>      ff8:	7c 65 1b 78 	mr      r5,r3
>      ffc:	e8 62 01 00 	ld      r3,256(r2)
>     1000:	48 00 00 01 	bl      1000 <.putprops+0x390>
>     1004:	60 00 00 00 	nop
>     1008:	e8 98 54 18 	ld      r4,21528(r24)
>     100c:	7f 23 cb 78 	mr      r3,r25
>     1010:	7e 65 9b 78 	mr      r5,r19
>     1014:	48 00 00 19 	bl      102c <.putprops+0x3bc>
>     1018:	38 13 00 03 	addi    r0,r19,3
>     101c:	e9 38 54 18 	ld      r9,21528(r24)
>     1020:	7c 00 16 70 	srawi   r0,r0,2
>     1024:	7c 00 01 94 	addze   r0,r0
>     1028:	7c 00 07 b4 	extsw   r0,r0
>     102c:	78 00 17 64 	rldicr  r0,r0,2,61
>     1030:	7d 29 02 14 	add     r9,r9,r0
>     1034:	f9 38 54 18 	std     r9,21528(r24)
>     1038:	88 1f 00 13 	lbz     r0,19(r31)
>     103c:	2f 80 00 72 	cmpwi   cr7,r0,114
>     1040:	40 9e 00 44 	bne-    cr7,1084 <.putprops+0x414>
>     1044:	88 1f 00 14 	lbz     r0,20(r31)
>     1048:	2f 80 00 65 	cmpwi   cr7,r0,101
>     104c:	40 9e 00 38 	bne-    cr7,1084 <.putprops+0x414>
>     1050:	88 1f 00 15 	lbz     r0,21(r31)
>     1054:	2f 80 00 67 	cmpwi   cr7,r0,103
>     1058:	40 9e 00 2c 	bne-    cr7,1084 <.putprops+0x414>
>     105c:	88 1f 00 16 	lbz     r0,22(r31)
>     1060:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1064:	40 9e 00 20 	bne-    cr7,1084 <.putprops+0x414>
>     1068:	e9 22 00 88 	ld      r9,136(r2)
>     106c:	80 09 00 00 	lwz     r0,0(r9)
>     1070:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1074:	41 9e 00 10 	beq-    cr7,1084 <.putprops+0x414>
>     1078:	7e 64 9b 78 	mr      r4,r19
>     107c:	7f a3 eb 78 	mr      r3,r29
>     1080:	48 00 00 49 	bl      10c8 <.putprops+0x458>
>     1084:	e8 82 01 08 	ld      r4,264(r2)
>     1088:	7f c3 f3 78 	mr      r3,r30
>     108c:	48 00 00 01 	bl      108c <.putprops+0x41c>
>     1090:	60 00 00 00 	nop
>     1094:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1098:	40 9e 00 1c 	bne-    cr7,10b4 <.putprops+0x444>
>     109c:	e9 22 00 88 	ld      r9,136(r2)
>     10a0:	80 09 00 00 	lwz     r0,0(r9)
>     10a4:	2f 80 00 00 	cmpwi   cr7,r0,0
>     10a8:	41 9e 00 0c 	beq-    cr7,10b4 <.putprops+0x444>
>     10ac:	7f a3 eb 78 	mr      r3,r29
>     10b0:	48 00 00 61 	bl      1110 <.putnode+0x10>
>     10b4:	7f a3 eb 78 	mr      r3,r29
>     10b8:	48 00 00 01 	bl      10b8 <.putprops+0x448>
>     10bc:	60 00 00 00 	nop
>     10c0:	4b ff fc 80 	b       d40 <.putprops+0xd0>
>     10c4:	60 00 00 00 	nop
>     10c8:	60 00 00 00 	nop
>     10cc:	60 00 00 00 	nop
>     10d0:	ea c2 01 10 	ld      r22,272(r2)
>     10d4:	4b ff fc dc 	b       db0 <.putprops+0x140>
>     10d8:	e8 82 00 48 	ld      r4,72(r2)
>     10dc:	7f c3 f3 78 	mr      r3,r30
>     10e0:	48 00 00 01 	bl      10e0 <.putprops+0x470>
>     10e4:	60 00 00 00 	nop
>     10e8:	2f a3 00 00 	cmpdi   cr7,r3,0
>     10ec:	40 9e fe 20 	bne+    cr7,f0c <.putprops+0x29c>
>     10f0:	4b ff fe 0c 	b       efc <.putprops+0x28c>
>     10f4:	00 00 00 00 	.long 0x0
>     10f8:	00 00 00 01 	.long 0x1
>     10fc:	80 10 00 00 	lwz     r0,0(r16)
> 
> 0000000000001100 <.putnode>:
>     1100:	7c 08 02 a6 	mflr    r0
>     1104:	fb 41 ff d0 	std     r26,-48(r1)
>     1108:	fa c1 ff b0 	std     r22,-80(r1)
>     110c:	7d 80 00 26 	mfcr    r12
>     1110:	f8 01 00 10 	std     r0,16(r1)
>     1114:	fa e1 ff b8 	std     r23,-72(r1)
>     1118:	38 00 00 01 	li      r0,1
>     111c:	fb 01 ff c0 	std     r24,-64(r1)
>     1120:	fb 21 ff c8 	std     r25,-56(r1)
>     1124:	fb 61 ff d8 	std     r27,-40(r1)
>     1128:	fb 81 ff e0 	std     r28,-32(r1)
>     112c:	fb a1 ff e8 	std     r29,-24(r1)
>     1130:	fb c1 ff f0 	std     r30,-16(r1)
>     1134:	91 81 00 08 	stw     r12,8(r1)
>     1138:	fb e1 ff f8 	std     r31,-8(r1)
>     113c:	f8 21 fa 91 	stdu    r1,-1392(r1)
>     1140:	eb 42 00 00 	ld      r26,0(r2)
>     1144:	e9 3a 54 18 	ld      r9,21528(r26)
>     1148:	90 09 00 00 	stw     r0,0(r9)
>     114c:	38 69 00 04 	addi    r3,r9,4
>     1150:	f8 7a 54 18 	std     r3,21528(r26)
>     1154:	e8 9a 54 30 	ld      r4,21552(r26)
>     1158:	88 04 00 00 	lbz     r0,0(r4)
>     115c:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1160:	40 9e 00 08 	bne-    cr7,1168 <.putnode+0x68>
>     1164:	e8 82 01 18 	ld      r4,280(r2)
>     1168:	48 00 00 01 	bl      1168 <.putnode+0x68>
>     116c:	60 00 00 00 	nop
>     1170:	e9 3a 54 18 	ld      r9,21528(r26)
>     1174:	80 09 00 00 	lwz     r0,0(r9)
>     1178:	2f 80 00 00 	cmpwi   cr7,r0,0
>     117c:	41 9e 00 18 	beq-    cr7,1194 <.putnode+0x94>
>     1180:	39 29 00 04 	addi    r9,r9,4
>     1184:	f9 3a 54 18 	std     r9,21528(r26)
>     1188:	80 09 00 00 	lwz     r0,0(r9)
>     118c:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1190:	40 9e ff f0 	bne+    cr7,1180 <.putnode+0x80>
>     1194:	88 09 ff ff 	lbz     r0,-1(r9)
>     1198:	2f 80 00 00 	cmpwi   cr7,r0,0
>     119c:	41 9e 00 0c 	beq-    cr7,11a8 <.putnode+0xa8>
>     11a0:	38 09 00 04 	addi    r0,r9,4
>     11a4:	f8 1a 54 18 	std     r0,21528(r26)
>     11a8:	e8 c2 01 20 	ld      r6,288(r2)
>     11ac:	3b 1a 50 18 	addi    r24,r26,20504
>     11b0:	38 81 00 70 	addi    r4,r1,112
>     11b4:	38 a0 00 00 	li      r5,0
>     11b8:	7f 03 c3 78 	mr      r3,r24
>     11bc:	48 00 00 01 	bl      11bc <.putnode+0xbc>
>     11c0:	60 00 00 00 	nop
>     11c4:	2e 03 00 00 	cmpwi   cr4,r3,0
>     11c8:	7c 79 1b 78 	mr      r25,r3
>     11cc:	41 90 04 24 	blt-    cr4,15f0 <.putnode+0x4f0>
>     11d0:	2f b9 00 00 	cmpdi   cr7,r25,0
>     11d4:	41 9e 03 fc 	beq-    cr7,15d0 <.putnode+0x4d0>
>     11d8:	38 80 00 2f 	li      r4,47
>     11dc:	7f 03 c3 78 	mr      r3,r24
>     11e0:	48 00 00 01 	bl      11e0 <.putnode+0xe0>
>     11e4:	60 00 00 00 	nop
>     11e8:	7c 76 1b 78 	mr      r22,r3
>     11ec:	7f 03 c3 78 	mr      r3,r24
>     11f0:	48 00 00 01 	bl      11f0 <.putnode+0xf0>
>     11f4:	60 00 00 00 	nop
>     11f8:	38 00 2f 00 	li      r0,12032
>     11fc:	7c 18 1b 2e 	sthx    r0,r24,r3
>     1200:	7f 03 c3 78 	mr      r3,r24
>     1204:	48 00 00 01 	bl      1204 <.putnode+0x104>
>     1208:	60 00 00 00 	nop
>     120c:	e8 81 00 70 	ld      r4,112(r1)
>     1210:	7f 25 cb 78 	mr      r5,r25
>     1214:	7f f8 1a 14 	add     r31,r24,r3
>     1218:	7f e3 fb 78 	mr      r3,r31
>     121c:	48 00 00 79 	bl      1294 <.putnode+0x194>
>     1220:	ea e2 01 38 	ld      r23,312(r2)
>     1224:	e8 17 00 00 	ld      r0,0(r23)
>     1228:	2f a0 00 00 	cmpdi   cr7,r0,0
>     122c:	40 9e 02 b4 	bne-    cr7,14e0 <.putnode+0x3e0>
>     1230:	eb 62 01 40 	ld      r27,320(r2)
>     1234:	7e c3 b3 78 	mr      r3,r22
>     1238:	7f 64 db 78 	mr      r4,r27
>     123c:	48 00 00 01 	bl      123c <.putnode+0x13c>
>     1240:	60 00 00 00 	nop
>     1244:	2c 23 00 00 	cmpdi   r3,0
>     1248:	41 82 01 48 	beq-    1390 <.putnode+0x290>
>     124c:	40 91 00 d4 	ble-    cr4,1320 <.putnode+0x220>
>     1250:	7f 1b c3 78 	mr      r27,r24
>     1254:	3b 80 00 00 	li      r28,0
>     1258:	3b a0 00 00 	li      r29,0
>     125c:	3b c1 00 88 	addi    r30,r1,136
>     1260:	48 00 00 40 	b       12a0 <.putnode+0x1a0>
>     1264:	60 00 00 00 	nop
>     1268:	60 00 00 00 	nop
>     126c:	60 00 00 00 	nop
>     1270:	48 00 00 01 	bl      1270 <.putnode+0x170>
>     1274:	60 00 00 00 	nop
>     1278:	2f a3 00 00 	cmpdi   cr7,r3,0
>     127c:	40 9e 02 24 	bne-    cr7,14a0 <.putnode+0x3a0>
>     1280:	80 01 00 a0 	lwz     r0,160(r1)
>     1284:	54 00 04 26 	rlwinm  r0,r0,0,16,19
>     1288:	2f 80 40 00 	cmpwi   cr7,r0,16384
>     128c:	41 9e 02 4c 	beq-    cr7,14d8 <.putnode+0x3d8>
>     1290:	38 1c 00 01 	addi    r0,r28,1
>     1294:	7c 1c 07 b4 	extsw   r28,r0
>     1298:	7f 99 e0 00 	cmpw    cr7,r25,r28
>     129c:	40 9d 00 84 	ble-    cr7,1320 <.putnode+0x220>
>     12a0:	e9 21 00 70 	ld      r9,112(r1)
>     12a4:	7f e3 fb 78 	mr      r3,r31
>     12a8:	7c 89 e8 2a 	ldx     r4,r9,r29
>     12ac:	38 84 00 13 	addi    r4,r4,19
>     12b0:	48 00 00 01 	bl      12b0 <.putnode+0x1b0>
>     12b4:	60 00 00 00 	nop
>     12b8:	e9 21 00 70 	ld      r9,112(r1)
>     12bc:	7c 69 e8 2a 	ldx     r3,r9,r29
>     12c0:	3b bd 00 08 	addi    r29,r29,8
>     12c4:	48 00 00 01 	bl      12c4 <.putnode+0x1c4>
>     12c8:	60 00 00 00 	nop
>     12cc:	88 1f 00 00 	lbz     r0,0(r31)
>     12d0:	7f 64 db 78 	mr      r4,r27
>     12d4:	7f c5 f3 78 	mr      r5,r30
>     12d8:	38 60 00 01 	li      r3,1
>     12dc:	2f 80 00 2e 	cmpwi   cr7,r0,46
>     12e0:	40 9e ff 90 	bne+    cr7,1270 <.putnode+0x170>
>     12e4:	88 1f 00 01 	lbz     r0,1(r31)
>     12e8:	2f a0 00 00 	cmpdi   cr7,r0,0
>     12ec:	41 fe ff a4 	beq-    cr7,1290 <.putnode+0x190>
>     12f0:	2f 80 00 2e 	cmpwi   cr7,r0,46
>     12f4:	40 9e ff 7c 	bne+    cr7,1270 <.putnode+0x170>
>     12f8:	88 1f 00 02 	lbz     r0,2(r31)
>     12fc:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1300:	40 de ff 70 	bne+    cr7,1270 <.putnode+0x170>
>     1304:	38 1c 00 01 	addi    r0,r28,1
>     1308:	7c 1c 07 b4 	extsw   r28,r0
>     130c:	7f 99 e0 00 	cmpw    cr7,r25,r28
>     1310:	41 9d ff 90 	bgt+    cr7,12a0 <.putnode+0x1a0>
>     1314:	60 00 00 00 	nop
>     1318:	60 00 00 00 	nop
>     131c:	60 00 00 00 	nop
>     1320:	e9 7a 54 18 	ld      r11,21528(r26)
>     1324:	38 00 00 02 	li      r0,2
>     1328:	90 0b 00 00 	stw     r0,0(r11)
>     132c:	39 2b 00 04 	addi    r9,r11,4
>     1330:	38 00 00 00 	li      r0,0
>     1334:	f9 3a 54 18 	std     r9,21528(r26)
>     1338:	98 1f ff ff 	stb     r0,-1(r31)
>     133c:	e8 61 00 70 	ld      r3,112(r1)
>     1340:	48 00 00 01 	bl      1340 <.putnode+0x240>
>     1344:	60 00 00 00 	nop
>     1348:	38 21 05 70 	addi    r1,r1,1392
>     134c:	e8 01 00 10 	ld      r0,16(r1)
>     1350:	81 81 00 08 	lwz     r12,8(r1)
>     1354:	ea c1 ff b0 	ld      r22,-80(r1)
>     1358:	ea e1 ff b8 	ld      r23,-72(r1)
>     135c:	eb 01 ff c0 	ld      r24,-64(r1)
>     1360:	eb 21 ff c8 	ld      r25,-56(r1)
>     1364:	eb 41 ff d0 	ld      r26,-48(r1)
>     1368:	eb 61 ff d8 	ld      r27,-40(r1)
>     136c:	7c 08 03 a6 	mtlr    r0
>     1370:	eb 81 ff e0 	ld      r28,-32(r1)
>     1374:	eb a1 ff e8 	ld      r29,-24(r1)
>     1378:	7d 90 81 20 	mtocrf  8,r12
>     137c:	eb c1 ff f0 	ld      r30,-16(r1)
>     1380:	eb e1 ff f8 	ld      r31,-8(r1)
>     1384:	4e 80 00 20 	blr
>     1388:	60 00 00 00 	nop
>     138c:	60 00 00 00 	nop
>     1390:	f8 61 00 78 	std     r3,120(r1)
>     1394:	eb c2 01 50 	ld      r30,336(r2)
>     1398:	7f c3 f3 78 	mr      r3,r30
>     139c:	48 00 00 01 	bl      139c <.putnode+0x29c>
>     13a0:	60 00 00 00 	nop
>     13a4:	2f a3 00 00 	cmpdi   cr7,r3,0
>     13a8:	f8 61 00 78 	std     r3,120(r1)
>     13ac:	40 9e 02 70 	bne-    cr7,161c <.putnode+0x51c>
>     13b0:	3b 81 01 18 	addi    r28,r1,280
>     13b4:	38 00 00 00 	li      r0,0
>     13b8:	7f 04 c3 78 	mr      r4,r24
>     13bc:	7f 83 e3 78 	mr      r3,r28
>     13c0:	f8 01 00 80 	std     r0,128(r1)
>     13c4:	48 00 00 01 	bl      13c4 <.putnode+0x2c4>
>     13c8:	60 00 00 00 	nop
>     13cc:	7f 83 e3 78 	mr      r3,r28
>     13d0:	48 00 00 01 	bl      13d0 <.putnode+0x2d0>
>     13d4:	60 00 00 00 	nop
>     13d8:	eb a2 00 f0 	ld      r29,240(r2)
>     13dc:	e8 82 01 68 	ld      r4,360(r2)
>     13e0:	7d 5c 1a 14 	add     r10,r28,r3
>     13e4:	7c 68 1b 78 	mr      r8,r3
>     13e8:	7f 83 e3 78 	mr      r3,r28
>     13ec:	80 1d 00 00 	lwz     r0,0(r29)
>     13f0:	81 3d 00 04 	lwz     r9,4(r29)
>     13f4:	89 7d 00 08 	lbz     r11,8(r29)
>     13f8:	7c 1c 41 2e 	stwx    r0,r28,r8
>     13fc:	91 2a 00 04 	stw     r9,4(r10)
>     1400:	99 6a 00 08 	stb     r11,8(r10)
>     1404:	48 00 00 01 	bl      1404 <.putnode+0x304>
>     1408:	60 00 00 00 	nop
>     140c:	2c 23 00 00 	cmpdi   r3,0
>     1410:	41 82 00 6c 	beq-    147c <.putnode+0x37c>
>     1414:	7c 66 1b 78 	mr      r6,r3
>     1418:	38 81 00 78 	addi    r4,r1,120
>     141c:	38 61 00 80 	addi    r3,r1,128
>     1420:	38 a0 00 0a 	li      r5,10
>     1424:	48 00 00 01 	bl      1424 <.putnode+0x324>
>     1428:	60 00 00 00 	nop
>     142c:	2f a3 ff ff 	cmpdi   cr7,r3,-1
>     1430:	41 9e 02 fc 	beq-    cr7,172c <.putnode+0x62c>
>     1434:	eb 81 00 80 	ld      r28,128(r1)
>     1438:	e8 82 01 60 	ld      r4,352(r2)
>     143c:	7f 83 e3 78 	mr      r3,r28
>     1440:	48 00 00 01 	bl      1440 <.putnode+0x340>
>     1444:	60 00 00 00 	nop
>     1448:	2f a3 00 00 	cmpdi   cr7,r3,0
>     144c:	41 9e 00 34 	beq-    cr7,1480 <.putnode+0x380>
>     1450:	e8 82 01 78 	ld      r4,376(r2)
>     1454:	48 00 00 01 	bl      1454 <.putnode+0x354>
>     1458:	60 00 00 00 	nop
>     145c:	e8 01 00 78 	ld      r0,120(r1)
>     1460:	7c 7c 1b 78 	mr      r28,r3
>     1464:	2f a0 00 00 	cmpdi   cr7,r0,0
>     1468:	40 9e 02 ac 	bne-    cr7,1714 <.putnode+0x614>
>     146c:	7f 84 e3 78 	mr      r4,r28
>     1470:	7f c3 f3 78 	mr      r3,r30
>     1474:	48 00 00 01 	bl      1474 <.putnode+0x374>
>     1478:	60 00 00 00 	nop
>     147c:	eb 81 00 80 	ld      r28,128(r1)
>     1480:	2f bc 00 00 	cmpdi   cr7,r28,0
>     1484:	41 9e 01 d4 	beq-    cr7,1658 <.putnode+0x558>
>     1488:	7f 83 e3 78 	mr      r3,r28
>     148c:	48 00 00 01 	bl      148c <.putnode+0x38c>
>     1490:	60 00 00 00 	nop
>     1494:	48 00 01 c4 	b       1658 <.putnode+0x558>
>     1498:	60 00 00 00 	nop
>     149c:	60 00 00 00 	nop
>     14a0:	48 00 00 01 	bl      14a0 <.putnode+0x3a0>
>     14a4:	60 00 00 00 	nop
>     14a8:	e8 63 00 02 	lwa     r3,0(r3)
>     14ac:	48 00 00 01 	bl      14ac <.putnode+0x3ac>
>     14b0:	60 00 00 00 	nop
>     14b4:	7f 64 db 78 	mr      r4,r27
>     14b8:	7c 65 1b 78 	mr      r5,r3
>     14bc:	e8 62 00 b8 	ld      r3,184(r2)
>     14c0:	48 00 00 01 	bl      14c0 <.putnode+0x3c0>
>     14c4:	60 00 00 00 	nop
>     14c8:	80 01 00 a0 	lwz     r0,160(r1)
>     14cc:	54 00 04 26 	rlwinm  r0,r0,0,16,19
>     14d0:	2f 80 40 00 	cmpwi   cr7,r0,16384
>     14d4:	40 9e fd bc 	bne+    cr7,1290 <.putnode+0x190>
>     14d8:	48 00 00 91 	bl      1568 <.putnode+0x468>
>     14dc:	4b ff fd b4 	b       1290 <.putnode+0x190>
>     14e0:	eb 62 01 40 	ld      r27,320(r2)
>     14e4:	7e c3 b3 78 	mr      r3,r22
>     14e8:	7f 64 db 78 	mr      r4,r27
>     14ec:	48 00 00 01 	bl      14ec <.putnode+0x3ec>
>     14f0:	60 00 00 00 	nop
>     14f4:	2f a3 00 00 	cmpdi   cr7,r3,0
>     14f8:	40 9e fd 54 	bne+    cr7,124c <.putnode+0x14c>
>     14fc:	eb 9a 54 18 	ld      r28,21528(r26)
>     1500:	38 00 00 08 	li      r0,8
>     1504:	39 20 00 03 	li      r9,3
>     1508:	e8 62 00 40 	ld      r3,64(r2)
>     150c:	90 1c 00 04 	stw     r0,4(r28)
>     1510:	91 3c 00 00 	stw     r9,0(r28)
>     1514:	3b 9c 00 04 	addi    r28,r28,4
>     1518:	3b bc 00 04 	addi    r29,r28,4
>     151c:	fb ba 54 18 	std     r29,21528(r26)
>     1520:	3b bd 00 04 	addi    r29,r29,4
>     1524:	48 00 00 31 	bl      1554 <.putnode+0x454>
>     1528:	7b a0 f7 e3 	rldicl. r0,r29,62,63
>     152c:	90 7c 00 04 	stw     r3,4(r28)
>     1530:	fb ba 54 18 	std     r29,21528(r26)
>     1534:	41 82 00 0c 	beq-    1540 <.putnode+0x440>
>     1538:	38 1d 00 04 	addi    r0,r29,4
>     153c:	f8 1a 54 18 	std     r0,21528(r26)
>     1540:	e9 3a 54 18 	ld      r9,21528(r26)
>     1544:	e8 17 00 00 	ld      r0,0(r23)
>     1548:	e8 62 00 48 	ld      r3,72(r2)
>     154c:	f8 09 00 00 	std     r0,0(r9)
>     1550:	38 00 00 03 	li      r0,3
>     1554:	39 20 00 08 	li      r9,8
>     1558:	eb da 54 18 	ld      r30,21528(r26)
>     155c:	90 1e 00 08 	stw     r0,8(r30)
>     1560:	38 1e 00 10 	addi    r0,r30,16
>     1564:	91 3e 00 0c 	stw     r9,12(r30)
>     1568:	f8 1a 54 18 	std     r0,21528(r26)
>     156c:	48 00 00 31 	bl      159c <.putnode+0x49c>
>     1570:	e8 82 01 48 	ld      r4,328(r2)
>     1574:	39 3e 00 14 	addi    r9,r30,20
>     1578:	90 7e 00 10 	stw     r3,16(r30)
>     157c:	79 20 f7 e3 	rldicl. r0,r9,62,63
>     1580:	f9 3a 54 18 	std     r9,21528(r26)
>     1584:	e8 04 00 00 	ld      r0,0(r4)
>     1588:	e9 37 00 00 	ld      r9,0(r23)
>     158c:	7c 00 4a 14 	add     r0,r0,r9
>     1590:	f8 01 00 78 	std     r0,120(r1)
>     1594:	41 82 00 0c 	beq-    15a0 <.putnode+0x4a0>
>     1598:	38 1e 00 18 	addi    r0,r30,24
>     159c:	f8 1a 54 18 	std     r0,21528(r26)
>     15a0:	e9 3a 54 18 	ld      r9,21528(r26)
>     15a4:	e8 01 00 78 	ld      r0,120(r1)
>     15a8:	f8 09 00 00 	std     r0,0(r9)
>     15ac:	e9 7a 54 18 	ld      r11,21528(r26)
>     15b0:	e8 77 00 00 	ld      r3,0(r23)
>     15b4:	e8 84 00 00 	ld      r4,0(r4)
>     15b8:	39 6b 00 08 	addi    r11,r11,8
>     15bc:	f9 7a 54 18 	std     r11,21528(r26)
>     15c0:	48 00 00 01 	bl      15c0 <.putnode+0x4c0>
>     15c4:	4b ff fc 70 	b       1234 <.putnode+0x134>
>     15c8:	60 00 00 00 	nop
>     15cc:	60 00 00 00 	nop
>     15d0:	e8 62 01 30 	ld      r3,304(r2)
>     15d4:	7f 04 c3 78 	mr      r4,r24
>     15d8:	48 00 00 01 	bl      15d8 <.putnode+0x4d8>
>     15dc:	60 00 00 00 	nop
>     15e0:	4b ff fb f8 	b       11d8 <.putnode+0xd8>
>     15e4:	60 00 00 00 	nop
>     15e8:	60 00 00 00 	nop
>     15ec:	60 00 00 00 	nop
>     15f0:	48 00 00 01 	bl      15f0 <.putnode+0x4f0>
>     15f4:	60 00 00 00 	nop
>     15f8:	e8 63 00 02 	lwa     r3,0(r3)
>     15fc:	48 00 00 01 	bl      15fc <.putnode+0x4fc>
>     1600:	60 00 00 00 	nop
>     1604:	7f 04 c3 78 	mr      r4,r24
>     1608:	7c 65 1b 78 	mr      r5,r3
>     160c:	e8 62 01 28 	ld      r3,296(r2)
>     1610:	48 00 00 01 	bl      1610 <.putnode+0x510>
>     1614:	60 00 00 00 	nop
>     1618:	4b ff fb b8 	b       11d0 <.putnode+0xd0>
>     161c:	e8 82 01 58 	ld      r4,344(r2)
>     1620:	7f c3 f3 78 	mr      r3,r30
>     1624:	48 00 00 01 	bl      1624 <.putnode+0x524>
>     1628:	60 00 00 00 	nop
>     162c:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1630:	41 9e 00 0c 	beq-    cr7,163c <.putnode+0x53c>
>     1634:	38 00 00 01 	li      r0,1
>     1638:	90 1a 54 20 	stw     r0,21536(r26)
>     163c:	e8 82 01 60 	ld      r4,352(r2)
>     1640:	7f c3 f3 78 	mr      r3,r30
>     1644:	48 00 00 01 	bl      1644 <.putnode+0x544>
>     1648:	60 00 00 00 	nop
>     164c:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1650:	41 de fd 60 	beq+    cr7,13b0 <.putnode+0x2b0>
>     1654:	eb a2 00 f0 	ld      r29,240(r2)
>     1658:	7f c3 f3 78 	mr      r3,r30
>     165c:	48 00 00 01 	bl      165c <.putnode+0x55c>
>     1660:	60 00 00 00 	nop
>     1664:	38 00 20 00 	li      r0,8192
>     1668:	7c 1e 1b 2e 	sthx    r0,r30,r3
>     166c:	7f c3 f3 78 	mr      r3,r30
>     1670:	48 00 00 01 	bl      1670 <.putnode+0x570>
>     1674:	60 00 00 00 	nop
>     1678:	e9 3a 54 18 	ld      r9,21528(r26)
>     167c:	38 00 00 03 	li      r0,3
>     1680:	38 63 00 01 	addi    r3,r3,1
>     1684:	f8 61 00 78 	std     r3,120(r1)
>     1688:	7f a3 eb 78 	mr      r3,r29
>     168c:	90 09 00 00 	stw     r0,0(r9)
>     1690:	3b 89 00 04 	addi    r28,r9,4
>     1694:	3b bc 00 04 	addi    r29,r28,4
>     1698:	e8 01 00 78 	ld      r0,120(r1)
>     169c:	90 09 00 04 	stw     r0,4(r9)
>     16a0:	fb ba 54 18 	std     r29,21528(r26)
>     16a4:	3b bd 00 04 	addi    r29,r29,4
>     16a8:	48 00 00 31 	bl      16d8 <.putnode+0x5d8>
>     16ac:	90 7c 00 04 	stw     r3,4(r28)
>     16b0:	fb ba 54 18 	std     r29,21528(r26)
>     16b4:	e8 a1 00 78 	ld      r5,120(r1)
>     16b8:	2b a5 00 07 	cmpldi  cr7,r5,7
>     16bc:	40 9d 00 14 	ble-    cr7,16d0 <.putnode+0x5d0>
>     16c0:	7b a0 f7 e3 	rldicl. r0,r29,62,63
>     16c4:	41 82 00 0c 	beq-    16d0 <.putnode+0x5d0>
>     16c8:	38 1d 00 04 	addi    r0,r29,4
>     16cc:	f8 1a 54 18 	std     r0,21528(r26)
>     16d0:	e8 7a 54 18 	ld      r3,21528(r26)
>     16d4:	7f c4 f3 78 	mr      r4,r30
>     16d8:	48 00 00 01 	bl      16d8 <.putnode+0x5d8>
>     16dc:	60 00 00 00 	nop
>     16e0:	e9 21 00 78 	ld      r9,120(r1)
>     16e4:	e8 1a 54 18 	ld      r0,21528(r26)
>     16e8:	7f c5 f3 78 	mr      r5,r30
>     16ec:	e9 62 01 80 	ld      r11,384(r2)
>     16f0:	e8 82 01 88 	ld      r4,392(r2)
>     16f4:	39 29 00 03 	addi    r9,r9,3
>     16f8:	e8 6b 00 00 	ld      r3,0(r11)
>     16fc:	79 29 07 64 	rldicr  r9,r9,0,61
>     1700:	7c 00 4a 14 	add     r0,r0,r9
>     1704:	f8 1a 54 18 	std     r0,21528(r26)
>     1708:	48 00 00 01 	bl      1708 <.putnode+0x608>
>     170c:	60 00 00 00 	nop
>     1710:	4b ff fb 3c 	b       124c <.putnode+0x14c>
>     1714:	7f c3 f3 78 	mr      r3,r30
>     1718:	48 00 00 01 	bl      1718 <.putnode+0x618>
>     171c:	60 00 00 00 	nop
>     1720:	38 00 20 00 	li      r0,8192
>     1724:	7c 1e 1b 2e 	sthx    r0,r30,r3
>     1728:	4b ff fd 44 	b       146c <.putnode+0x36c>
>     172c:	e8 62 01 70 	ld      r3,368(r2)
>     1730:	7f 84 e3 78 	mr      r4,r28
>     1734:	48 00 00 01 	bl      1734 <.putnode+0x634>
>     1738:	60 00 00 00 	nop
>     173c:	4b ff fc f8 	b       1434 <.putnode+0x334>
>     1740:	00 00 00 00 	.long 0x0
>     1744:	00 00 00 03 	.long 0x3
>     1748:	80 0a 00 00 	lwz     r0,0(r10)
>     174c:	60 00 00 00 	nop
> 
> 0000000000001750 <.create_flatten_tree>:
>     1750:	7c 08 02 a6 	mflr    r0
>     1754:	fb 21 ff c8 	std     r25,-56(r1)
>     1758:	fb 41 ff d0 	std     r26,-48(r1)
>     175c:	fb 81 ff e0 	std     r28,-32(r1)
>     1760:	fb a1 ff e8 	std     r29,-24(r1)
>     1764:	fb c1 ff f0 	std     r30,-16(r1)
>     1768:	fb e1 ff f8 	std     r31,-8(r1)
>     176c:	f8 01 00 10 	std     r0,16(r1)
>     1770:	fb 61 ff d8 	std     r27,-40(r1)
>     1774:	f8 21 ff 51 	stdu    r1,-176(r1)
>     1778:	e9 22 01 90 	ld      r9,400(r2)
>     177c:	eb e2 00 00 	ld      r31,0(r2)
>     1780:	7c be 2b 78 	mr      r30,r5
>     1784:	7c 7c 1b 78 	mr      r28,r3
>     1788:	7c 99 23 78 	mr      r25,r4
>     178c:	3b bf 50 18 	addi    r29,r31,20504
>     1790:	3b 5f 54 38 	addi    r26,r31,21560
>     1794:	7f a3 eb 78 	mr      r3,r29
>     1798:	89 09 00 12 	lbz     r8,18(r9)
>     179c:	e8 09 00 00 	ld      r0,0(r9)
>     17a0:	e9 69 00 08 	ld      r11,8(r9)
>     17a4:	a1 49 00 10 	lhz     r10,16(r9)
>     17a8:	99 1d 00 12 	stb     r8,18(r29)
>     17ac:	f8 1f 50 18 	std     r0,20504(r31)
>     17b0:	f9 7d 00 08 	std     r11,8(r29)
>     17b4:	b1 5d 00 10 	sth     r10,16(r29)
>     17b8:	48 00 00 01 	bl      17b8 <.create_flatten_tree+0x68>
>     17bc:	60 00 00 00 	nop
>     17c0:	2f be 00 00 	cmpdi   cr7,r30,0
>     17c4:	fb 5f 54 18 	std     r26,21528(r31)
>     17c8:	7f bd 1a 14 	add     r29,r29,r3
>     17cc:	fb bf 54 30 	std     r29,21552(r31)
>     17d0:	41 9e 00 14 	beq-    cr7,17e4 <.create_flatten_tree+0x94>
>     17d4:	e8 62 01 50 	ld      r3,336(r2)
>     17d8:	7f c4 f3 78 	mr      r4,r30
>     17dc:	48 00 00 01 	bl      17dc <.create_flatten_tree+0x8c>
>     17e0:	60 00 00 00 	nop
>     17e4:	48 00 00 91 	bl      1874 <.create_flatten_tree+0x124>
>     17e8:	e9 3f 54 18 	ld      r9,21528(r31)
>     17ec:	38 00 00 09 	li      r0,9
>     17f0:	3f df 00 04 	addis   r30,r31,4
>     17f4:	39 60 00 01 	li      r11,1
>     17f8:	90 09 00 00 	stw     r0,0(r9)
>     17fc:	38 00 00 20 	li      r0,32
>     1800:	39 49 00 04 	addi    r10,r9,4
>     1804:	39 20 00 40 	li      r9,64
>     1808:	90 1e 54 48 	stw     r0,21576(r30)
>     180c:	f9 5f 54 18 	std     r10,21528(r31)
>     1810:	e8 1f 00 08 	ld      r0,8(r31)
>     1814:	2f a0 00 00 	cmpdi   cr7,r0,0
>     1818:	41 de 00 28 	beq-    cr7,1840 <.create_flatten_tree+0xf0>
>     181c:	60 00 00 00 	nop
>     1820:	39 6b 00 02 	addi    r11,r11,2
>     1824:	79 60 1f 24 	rldicr  r0,r11,3,60
>     1828:	7d 3f 00 2a 	ldx     r9,r31,r0
>     182c:	2f a9 00 00 	cmpdi   cr7,r9,0
>     1830:	40 fe ff f0 	bne-    cr7,1820 <.create_flatten_tree+0xd0>
>     1834:	55 69 18 38 	rlwinm  r9,r11,3,0,28
>     1838:	39 29 00 38 	addi    r9,r9,56
>     183c:	79 29 00 20 	clrldi  r9,r9,32
>     1840:	7c 1a 50 50 	subf    r0,r26,r10
>     1844:	91 3e 54 40 	stw     r9,21568(r30)
>     1848:	e8 62 01 98 	ld      r3,408(r2)
>     184c:	78 00 07 64 	rldicr  r0,r0,0,61
>     1850:	7c 09 02 14 	add     r0,r9,r0
>     1854:	90 1e 54 44 	stw     r0,21572(r30)
>     1858:	48 00 00 31 	bl      1888 <.create_flatten_tree+0x138>
>     185c:	81 3e 54 44 	lwz     r9,21572(r30)
>     1860:	3c 00 d0 0d 	lis     r0,-12275
>     1864:	39 60 00 02 	li      r11,2
>     1868:	38 63 00 03 	addi    r3,r3,3
>     186c:	60 00 fe ed 	ori     r0,r0,65261
>     1870:	91 7e 54 50 	stw     r11,21584(r30)
>     1874:	91 7e 54 4c 	stw     r11,21580(r30)
>     1878:	78 63 07 64 	rldicr  r3,r3,0,61
>     187c:	90 1e 54 38 	stw     r0,21560(r30)
>     1880:	7d 29 1a 14 	add     r9,r9,r3
>     1884:	38 60 00 00 	li      r3,0
>     1888:	79 29 00 20 	clrldi  r9,r9,32
>     188c:	91 3e 54 3c 	stw     r9,21564(r30)
>     1890:	7d 24 4b 78 	mr      r4,r9
>     1894:	48 00 00 01 	bl      1894 <.create_flatten_tree+0x144>
>     1898:	80 7e 54 3c 	lwz     r3,21564(r30)
>     189c:	48 00 00 01 	bl      189c <.create_flatten_tree+0x14c>
>     18a0:	60 00 00 00 	nop
>     18a4:	38 9e 54 38 	addi    r4,r30,21560
>     18a8:	f8 7c 00 00 	std     r3,0(r28)
>     18ac:	7c 7b 1b 78 	mr      r27,r3
>     18b0:	80 be 54 48 	lwz     r5,21576(r30)
>     18b4:	48 00 00 01 	bl      18b4 <.create_flatten_tree+0x164>
>     18b8:	60 00 00 00 	nop
>     18bc:	83 9e 54 48 	lwz     r28,21576(r30)
>     18c0:	80 be 54 40 	lwz     r5,21568(r30)
>     18c4:	7f e4 fb 78 	mr      r4,r31
>     18c8:	7c bc 28 50 	subf    r5,r28,r5
>     18cc:	7c 7b e2 14 	add     r3,r27,r28
>     18d0:	78 a5 00 20 	clrldi  r5,r5,32
>     18d4:	48 00 00 01 	bl      18d4 <.create_flatten_tree+0x184>
>     18d8:	60 00 00 00 	nop
>     18dc:	80 1e 54 40 	lwz     r0,21568(r30)
>     18e0:	83 be 54 48 	lwz     r29,21576(r30)
>     18e4:	7f 44 d3 78 	mr      r4,r26
>     18e8:	80 be 54 44 	lwz     r5,21572(r30)
>     18ec:	7f bd 00 50 	subf    r29,r29,r0
>     18f0:	7c a0 28 50 	subf    r5,r0,r5
>     18f4:	7b bd 00 20 	clrldi  r29,r29,32
>     18f8:	78 a5 00 20 	clrldi  r5,r5,32
>     18fc:	7f bd e2 14 	add     r29,r29,r28
>     1900:	7c 7b ea 14 	add     r3,r27,r29
>     1904:	48 00 00 01 	bl      1904 <.create_flatten_tree+0x1b4>
>     1908:	60 00 00 00 	nop
>     190c:	81 3e 54 44 	lwz     r9,21572(r30)
>     1910:	80 1e 54 40 	lwz     r0,21568(r30)
>     1914:	38 9f 10 18 	addi    r4,r31,4120
>     1918:	80 be 54 3c 	lwz     r5,21564(r30)
>     191c:	7c 00 48 50 	subf    r0,r0,r9
>     1920:	7c a9 28 50 	subf    r5,r9,r5
>     1924:	78 00 00 20 	clrldi  r0,r0,32
>     1928:	78 a5 00 20 	clrldi  r5,r5,32
>     192c:	7f bd 02 14 	add     r29,r29,r0
>     1930:	7c 7b ea 14 	add     r3,r27,r29
>     1934:	48 00 00 01 	bl      1934 <.create_flatten_tree+0x1e4>
>     1938:	60 00 00 00 	nop
>     193c:	81 3e 54 44 	lwz     r9,21572(r30)
>     1940:	80 1e 54 3c 	lwz     r0,21564(r30)
>     1944:	38 21 00 b0 	addi    r1,r1,176
>     1948:	38 60 00 00 	li      r3,0
>     194c:	7c 09 00 50 	subf    r0,r9,r0
>     1950:	7c 00 ea 14 	add     r0,r0,r29
>     1954:	f8 19 00 00 	std     r0,0(r25)
>     1958:	e8 01 00 10 	ld      r0,16(r1)
>     195c:	eb 21 ff c8 	ld      r25,-56(r1)
>     1960:	eb 41 ff d0 	ld      r26,-48(r1)
>     1964:	eb 61 ff d8 	ld      r27,-40(r1)
>     1968:	eb 81 ff e0 	ld      r28,-32(r1)
>     196c:	eb a1 ff e8 	ld      r29,-24(r1)
>     1970:	eb c1 ff f0 	ld      r30,-16(r1)
>     1974:	eb e1 ff f8 	ld      r31,-8(r1)
>     1978:	7c 08 03 a6 	mtlr    r0
>     197c:	4e 80 00 20 	blr
>     1980:	00 00 00 00 	.long 0x0
>     1984:	00 00 00 01 	.long 0x1
>     1988:	80 07 00 00 	lwz     r0,0(r7)
>     198c:	60 00 00 00 	nop
> 
> 0000000000001990 <.comparefunc>:
>     1990:	7c 08 02 a6 	mflr    r0
>     1994:	fb c1 ff f0 	std     r30,-16(r1)
>     1998:	fb e1 ff f8 	std     r31,-8(r1)
>     199c:	fb a1 ff e8 	std     r29,-24(r1)
>     19a0:	f8 01 00 10 	std     r0,16(r1)
>     19a4:	f8 21 ff 71 	stdu    r1,-144(r1)
>     19a8:	e9 23 00 00 	ld      r9,0(r3)
>     19ac:	e9 64 00 00 	ld      r11,0(r4)
>     19b0:	38 80 00 40 	li      r4,64
>     19b4:	3b e9 00 13 	addi    r31,r9,19
>     19b8:	3b cb 00 13 	addi    r30,r11,19
>     19bc:	7f e3 fb 78 	mr      r3,r31
>     19c0:	48 00 00 01 	bl      19c0 <.comparefunc+0x30>
>     19c4:	60 00 00 00 	nop
>     19c8:	2f a3 00 00 	cmpdi   cr7,r3,0
>     19cc:	41 9e 00 44 	beq-    cr7,1a10 <.comparefunc+0x80>
>     19d0:	7f c3 f3 78 	mr      r3,r30
>     19d4:	38 80 00 40 	li      r4,64
>     19d8:	48 00 00 01 	bl      19d8 <.comparefunc+0x48>
>     19dc:	60 00 00 00 	nop
>     19e0:	2f a3 00 00 	cmpdi   cr7,r3,0
>     19e4:	41 9e 00 2c 	beq-    cr7,1a10 <.comparefunc+0x80>
>     19e8:	7f e3 fb 78 	mr      r3,r31
>     19ec:	48 00 00 01 	bl      19ec <.comparefunc+0x5c>
>     19f0:	60 00 00 00 	nop
>     19f4:	7c 7d 1b 78 	mr      r29,r3
>     19f8:	7f c3 f3 78 	mr      r3,r30
>     19fc:	48 00 00 01 	bl      19fc <.comparefunc+0x6c>
>     1a00:	60 00 00 00 	nop
>     1a04:	38 00 00 01 	li      r0,1
>     1a08:	7f bd 18 40 	cmpld   cr7,r29,r3
>     1a0c:	41 9d 00 18 	bgt-    cr7,1a24 <.comparefunc+0x94>
>     1a10:	7f e3 fb 78 	mr      r3,r31
>     1a14:	7f c4 f3 78 	mr      r4,r30
>     1a18:	48 00 00 01 	bl      1a18 <.comparefunc+0x88>
>     1a1c:	60 00 00 00 	nop
>     1a20:	7c 60 1b 78 	mr      r0,r3
>     1a24:	38 21 00 90 	addi    r1,r1,144
>     1a28:	7c 03 03 78 	mr      r3,r0
>     1a2c:	e8 01 00 10 	ld      r0,16(r1)
>     1a30:	eb a1 ff e8 	ld      r29,-24(r1)
>     1a34:	eb c1 ff f0 	ld      r30,-16(r1)
>     1a38:	eb e1 ff f8 	ld      r31,-8(r1)
>     1a3c:	7c 08 03 a6 	mtlr    r0
>     1a40:	4e 80 00 20 	blr
>     1a44:	00 00 00 00 	.long 0x0
>     1a48:	00 00 00 01 	.long 0x1
>     1a4c:	80 03 00 00 	lwz     r0,0(r3)
> 
> Disassembly of section .data:
> 
> 0000000000000000 <local_cmdline>:
> 	...
> 
> Disassembly of section .bss:
> 
> 0000000000000000 <mem_rsrv>:
> 	...
> 
> 0000000000001000 <base.4422>:
> 	...
> 
> 0000000000001008 <size.4423>:
> 	...
> 
> 0000000000001010 <end.4424>:
> 	...
> 
> 0000000000001018 <propnames>:
> 	...
> 
> 0000000000005018 <pathname>:
> 	...
> 
> 0000000000005418 <dt>:
> 	...
> 
> 0000000000005420 <crash_param>:
> 	...
> 
> 0000000000005428 <dt_len>:
> 	...
> 
> 0000000000005430 <pathstart>:
> 	...
> 
> 0000000000005438 <dtstruct>:
> 	...
> 
> 0000000000045438 <bb>:
> 	...
> 
> Disassembly of section .toc:
> 
> 0000000000000000 <.toc>:
> 	...
>   14:	00 00 00 38 	.long 0x38
>   18:	00 00 00 00 	.long 0x0
>   1c:	00 00 00 60 	.long 0x60
>   20:	00 00 00 00 	.long 0x0
>   24:	00 00 00 70 	.long 0x70
>   28:	00 00 00 00 	.long 0x0
>   2c:	00 00 00 80 	.long 0x80
>   30:	00 00 00 00 	.long 0x0
>   34:	00 00 00 90 	.long 0x90
> 	...
>   44:	00 00 00 a0 	.long 0xa0
>   48:	00 00 00 00 	.long 0x0
>   4c:	00 00 00 b8 	.long 0xb8
>   50:	00 00 00 00 	.long 0x0
>   54:	00 00 00 d0 	.long 0xd0
>   58:	00 00 00 00 	.long 0x0
>   5c:	00 00 01 08 	.long 0x108
>   60:	00 00 00 00 	.long 0x0
>   64:	00 00 01 30 	.long 0x130
>   68:	00 00 00 00 	.long 0x0
>   6c:	00 00 01 40 	.long 0x140
>   70:	00 00 00 00 	.long 0x0
>   74:	00 00 01 78 	.long 0x178
>   78:	00 00 00 00 	.long 0x0
>   7c:	00 00 01 a8 	.long 0x1a8
>   80:	00 00 00 00 	.long 0x0
>   84:	00 00 01 d8 	.long 0x1d8
> 	...
>   94:	00 00 02 08 	.long 0x208
>   98:	00 00 00 00 	.long 0x0
>   9c:	00 00 02 20 	.long 0x220
> 	...
>   b4:	00 00 02 48 	.long 0x248
>   b8:	00 00 00 00 	.long 0x0
>   bc:	00 00 02 68 	.long 0x268
>   c0:	00 00 00 00 	.long 0x0
>   c4:	00 00 02 98 	.long 0x298
>   c8:	00 00 00 00 	.long 0x0
>   cc:	00 00 02 b0 	.long 0x2b0
>   d0:	00 00 00 00 	.long 0x0
>   d4:	00 00 02 c8 	.long 0x2c8
>   d8:	00 00 00 00 	.long 0x0
>   dc:	00 00 02 e0 	.long 0x2e0
>   e0:	00 00 00 00 	.long 0x0
>   e4:	00 00 02 f0 	.long 0x2f0
>   e8:	00 00 00 00 	.long 0x0
>   ec:	00 00 03 00 	.long 0x300
>   f0:	00 00 00 00 	.long 0x0
>   f4:	00 00 03 18 	.long 0x318
>   f8:	00 00 00 00 	.long 0x0
>   fc:	00 00 03 28 	.long 0x328
>  100:	00 00 00 00 	.long 0x0
>  104:	00 00 03 58 	.long 0x358
>  108:	00 00 00 00 	.long 0x0
>  10c:	00 00 03 88 	.long 0x388
>  110:	00 00 00 00 	.long 0x0
>  114:	00 00 50 18 	.long 0x5018
>  118:	00 00 00 00 	.long 0x0
>  11c:	00 00 03 a0 	.long 0x3a0
>  120:	00 00 00 00 	.long 0x0
>  124:	00 00 00 c0 	.long 0xc0
>  128:	00 00 00 00 	.long 0x0
>  12c:	00 00 03 a8 	.long 0x3a8
>  130:	00 00 00 00 	.long 0x0
>  134:	00 00 03 d8 	.long 0x3d8
> 	...
>  144:	00 00 04 10 	.long 0x410
> 	...
>  15c:	00 00 04 20 	.long 0x420
>  160:	00 00 00 00 	.long 0x0
>  164:	00 00 04 30 	.long 0x430
>  168:	00 00 00 00 	.long 0x0
>  16c:	00 00 04 38 	.long 0x438
>  170:	00 00 00 00 	.long 0x0
>  174:	00 00 04 40 	.long 0x440
>  178:	00 00 00 00 	.long 0x0
>  17c:	00 00 04 58 	.long 0x458
> 	...
>  18c:	00 00 04 60 	.long 0x460
>  190:	00 00 00 00 	.long 0x0
>  194:	00 00 04 78 	.long 0x478
>  198:	00 00 00 00 	.long 0x0
>  19c:	00 00 04 90 	.long 0x490
> 
> Disassembly of section .debug_abbrev:
> 
> 0000000000000000 <.debug_abbrev>:
>    0:	01 11 01 25 	.long 0x1110125
>    4:	0e 13 0b 03 	twlti   r19,2819
>    8:	0e 1b 0e 11 	twlti   r27,3601
>    c:	01 12 01 10 	.long 0x1120110
>   10:	06 00 00 02 	.long 0x6000002
>   14:	24 00 0b 0b 	dozi    r0,r0,2827
>   18:	3e 0b 03 0e 	addis   r16,r11,782
>   1c:	00 00 03 24 	.long 0x324
>   20:	00 0b 0b 3e 	.long 0xb0b3e
>   24:	0b 03 08 00 	tdnei   r3,2048
>   28:	00 04 16 00 	.long 0x41600
>   2c:	03 0e 3a 0b 	.long 0x30e3a0b
>   30:	3b 0b 49 13 	addi    r24,r11,18707
>   34:	00 00 05 24 	.long 0x524
>   38:	00 0b 0b 3e 	.long 0xb0b3e
>   3c:	0b 00 00 06 	tdnei   r0,6
>   40:	0f 00 0b 0b 	twnei   r0,2827
>   44:	00 00 07 0f 	.long 0x70f
>   48:	00 0b 0b 49 	.long 0xb0b49
>   4c:	13 00 00 08 	vmuloub v24,v0,v0
>   50:	13 01 03 0e 	vpkpx   v24,v1,v0
>   54:	0b 0b 3a 0b 	tdnei   r11,14859
>   58:	3b 0b 01 13 	addi    r24,r11,275
>   5c:	00 00 09 0d 	.long 0x90d
>   60:	00 03 0e 3a 	.long 0x30e3a
>   64:	0b 3b 0b 49 	tdi     25,r27,2889
>   68:	13 38 0a 00 	vaddubs v25,v24,v1
>   6c:	00 0a 13 01 	.long 0xa1301
>   70:	03 0e 0b 05 	.long 0x30e0b05
>   74:	3a 0b 3b 0b 	addi    r16,r11,15115
>   78:	01 13 00 00 	.long 0x1130000
>   7c:	0b 01 01 49 	tdnei   r1,329
>   80:	13 01 13 00 	vaddsbs v24,v1,v2
>   84:	00 0c 21 00 	.long 0xc2100
>   88:	49 13 2f 0b 	bla     1132f08 <bb+0x10edad0>
>   8c:	00 00 0d 26 	.long 0xd26
>   90:	00 49 13 00 	.long 0x491300
>   94:	00 0e 26 00 	.long 0xe2600
>   98:	00 00 0f 0d 	.long 0xf0d
>   9c:	00 03 0e 3a 	.long 0x30e3a
>   a0:	0b 3b 05 49 	tdi     25,r27,1353
>   a4:	13 38 0a 00 	vaddubs v25,v24,v1
>   a8:	00 10 16 00 	.long 0x101600
>   ac:	03 0e 3a 0b 	.long 0x30e3a0b
>   b0:	3b 0b 00 00 	addi    r24,r11,0
>   b4:	11 0d 00 03 	.long 0x110d0003
>   b8:	08 3a 0b 3b 	tdlgti  r26,2875
>   bc:	0b 49 13 38 	tdi     26,r9,4920
>   c0:	0a 00 00 12 	tdlti   r0,18
>   c4:	2e 01 3f 0c 	cmpwi   cr4,r1,16140
>   c8:	03 0e 3a 0b 	.long 0x30e3a0b
>   cc:	3b 05 27 0c 	addi    r24,r5,9996
>   d0:	49 13 20 0b 	bla     1132008 <bb+0x10ecbd0>
>   d4:	01 13 00 00 	.long 0x1130000
>   d8:	13 05 00 03 	.long 0x13050003
>   dc:	0e 3a 0b 3b 	twi     17,r26,2875
>   e0:	05 49 13 00 	.long 0x5491300
>   e4:	00 14 2e 01 	.long 0x142e01
>   e8:	3f 0c 03 0e 	addis   r24,r12,782
>   ec:	3a 0b 3b 0b 	addi    r16,r11,15115
>   f0:	27 0c 49 13 	dozi    r24,r12,18707
>   f4:	20 0b 01 13 	subfic  r0,r11,275
>   f8:	00 00 15 05 	.long 0x1505
>   fc:	00 03 0e 3a 	.long 0x30e3a
>  100:	0b 3b 0b 49 	tdi     25,r27,2889
>  104:	13 00 00 16 	.long 0x13000016
>  108:	05 00 03 08 	.long 0x5000308
>  10c:	3a 0b 3b 0b 	addi    r16,r11,15115
>  110:	49 13 00 00 	b       1130110 <bb+0x10eacd8>
>  114:	17 2e 01 3f 	.long 0x172e013f
>  118:	0c 03 0e 3a 	twi     0,r3,3642
>  11c:	0b 3b 0b 27 	tdi     25,r27,2855
>  120:	0c 11 01 12 	twi     0,r17,274
>  124:	01 40 06 01 	.long 0x1400601
>  128:	13 00 00 18 	.long 0x13000018
>  12c:	05 00 03 0e 	.long 0x500030e
>  130:	3a 0b 3b 0b 	addi    r16,r11,15115
>  134:	49 13 02 06 	ba      1130204 <bb+0x10eadcc>
>  138:	00 00 19 34 	.long 0x1934
>  13c:	00 03 0e 3a 	.long 0x30e3a
>  140:	0b 3b 0b 49 	tdi     25,r27,2889
>  144:	13 02 06 00 	vsububs v24,v2,v0
>  148:	00 1a 2e 01 	.long 0x1a2e01
>  14c:	03 0e 3a 0b 	.long 0x30e3a0b
>  150:	3b 0b 27 0c 	addi    r24,r11,9996
>  154:	11 01 12 01 	.long 0x11011201
>  158:	40 06 01 13 	bdnzfla- 4*cr1+eq,110 <.debug_abbrev+0x110>
>  15c:	00 00 1b 05 	.long 0x1b05
>  160:	00 03 08 3a 	.long 0x3083a
>  164:	0b 3b 0b 49 	tdi     25,r27,2889
>  168:	13 02 06 00 	vsububs v24,v2,v0
>  16c:	00 1c 0b 01 	.long 0x1c0b01
>  170:	11 01 12 01 	.long 0x11011201
>  174:	01 13 00 00 	.long 0x1130000
>  178:	1d 34 00 03 	mulli   r9,r20,3
>  17c:	0e 3a 0b 3b 	twi     17,r26,2875
>  180:	0b 49 13 00 	tdi     26,r9,4864
>  184:	00 1e 34 00 	.long 0x1e3400
>  188:	03 0e 3a 0b 	.long 0x30e3a0b
>  18c:	3b 0b 49 13 	addi    r24,r11,18707
>  190:	02 0a 00 00 	.long 0x20a0000
>  194:	1f 34 00 03 	mulli   r25,r20,3
>  198:	08 3a 0b 3b 	tdlgti  r26,2875
>  19c:	0b 49 13 02 	tdi     26,r9,4866
>  1a0:	0a 00 00 20 	tdlti   r0,32
>  1a4:	2e 01 03 0e 	cmpwi   cr4,r1,782
>  1a8:	3a 0b 3b 0b 	addi    r16,r11,15115
>  1ac:	27 0c 49 13 	dozi    r24,r12,18707
>  1b0:	11 01 12 01 	.long 0x11011201
>  1b4:	40 06 01 13 	bdnzfla- 4*cr1+eq,110 <.debug_abbrev+0x110>
>  1b8:	00 00 21 0b 	.long 0x210b
>  1bc:	01 55 06 00 	.long 0x1550600
>  1c0:	00 22 34 00 	.long 0x223400
>  1c4:	03 08 3a 0b 	.long 0x3083a0b
>  1c8:	3b 0b 49 13 	addi    r24,r11,18707
>  1cc:	02 06 00 00 	.long 0x2060000
>  1d0:	23 21 00 49 	subfic  r25,r1,73
>  1d4:	13 2f 05 00 	.long 0x132f0500
>  1d8:	00 24 0b 01 	.long 0x240b01
>  1dc:	11 01 12 01 	.long 0x11011201
>  1e0:	00 00 25 2e 	.long 0x252e
>  1e4:	01 03 0e 3a 	.long 0x1030e3a
>  1e8:	0b 3b 05 27 	tdi     25,r27,1319
>  1ec:	0c 11 01 12 	twi     0,r17,274
>  1f0:	01 40 06 01 	.long 0x1400601
>  1f4:	13 00 00 26 	vmsumuhm v24,v0,v0,v0
>  1f8:	05 00 03 08 	.long 0x5000308
>  1fc:	3a 0b 3b 05 	addi    r16,r11,15109
>  200:	49 13 02 06 	ba      1130204 <bb+0x10eadcc>
>  204:	00 00 27 05 	.long 0x2705
>  208:	00 03 0e 3a 	.long 0x30e3a
>  20c:	0b 3b 05 49 	tdi     25,r27,1353
>  210:	13 02 06 00 	vsububs v24,v2,v0
>  214:	00 28 34 00 	.long 0x283400
>  218:	03 08 3a 0b 	.long 0x3083a0b
>  21c:	3b 05 49 13 	addi    r24,r5,18707
>  220:	02 06 00 00 	.long 0x2060000
>  224:	29 34 00 03 	cmpldi  cr2,r20,3
>  228:	0e 3a 0b 3b 	twi     17,r26,2875
>  22c:	05 49 13 02 	.long 0x5491302
>  230:	0a 00 00 2a 	tdlti   r0,42
>  234:	1d 01 31 13 	mulli   r8,r1,12563
>  238:	55 06 58 0b 	rlwinm. r6,r8,11,0,5
>  23c:	59 05 01 13 	rlmi.   r5,r8,r0,4,9
>  240:	00 00 2b 05 	.long 0x2b05
>  244:	00 31 13 00 	.long 0x311300
>  248:	00 2c 0b 01 	.long 0x2c0b01
>  24c:	55 06 01 13 	rlwinm. r6,r8,0,4,9
>  250:	00 00 2d 34 	.long 0x2d34
>  254:	00 03 0e 3a 	.long 0x30e3a
>  258:	0b 3b 05 49 	tdi     25,r27,1353
>  25c:	13 00 00 2e 	vmaddfp v24,v0,v0,v0
>  260:	34 00 03 08 	addic.  r0,r0,776
>  264:	3a 0b 3b 05 	addi    r16,r11,15109
>  268:	49 13 00 00 	b       1130268 <bb+0x10eae30>
>  26c:	2f 34 00 03 	cmpdi   cr6,r20,3
>  270:	0e 3a 0b 3b 	twi     17,r26,2875
>  274:	05 49 13 02 	.long 0x5491302
>  278:	06 00 00 30 	.long 0x6000030
>  27c:	1d 01 31 13 	mulli   r8,r1,12563
>  280:	11 01 12 01 	.long 0x11011201
>  284:	58 0b 59 05 	rlmi.   r11,r0,r11,4,2
>  288:	00 00 31 2e 	.long 0x312e
>  28c:	01 3f 0c 03 	.long 0x13f0c03
>  290:	0e 3a 0b 3b 	twi     17,r26,2875
>  294:	05 27 0c 49 	.long 0x5270c49
>  298:	13 11 01 12 	.long 0x13110112
>  29c:	01 40 06 01 	.long 0x1400601
>  2a0:	13 00 00 32 	.long 0x13000032
>  2a4:	2e 01 03 0e 	cmpwi   cr4,r1,782
>  2a8:	3a 0b 3b 05 	addi    r16,r11,15109
>  2ac:	27 0c 49 13 	dozi    r24,r12,18707
>  2b0:	11 01 12 01 	.long 0x11011201
>  2b4:	40 06 01 13 	bdnzfla- 4*cr1+eq,110 <.debug_abbrev+0x110>
>  2b8:	00 00 33 34 	.long 0x3334
>  2bc:	00 03 0e 3a 	.long 0x30e3a
>  2c0:	0b 3b 0b 49 	tdi     25,r27,2889
>  2c4:	13 3f 0c 3c 	.long 0x133f0c3c
>  2c8:	0c 00 00 34 	twi     0,r0,52
>  2cc:	34 00 03 0e 	addic.  r0,r0,782
>  2d0:	3a 0b 3b 0b 	addi    r16,r11,15115
>  2d4:	49 13 3f 0c 	b       11341e0 <bb+0x10eeda8>
>  2d8:	02 0a 00 00 	.long 0x20a0000
> 	...
> 
> Disassembly of section .debug_info:
> 
> 0000000000000000 <.debug_info>:
>        0:	00 00 13 19 	.long 0x1319
>        4:	00 02 00 00 	.long 0x20000
>        8:	00 00 08 01 	.long 0x801
>        c:	00 00 05 17 	.long 0x517
>       10:	01 00 00 04 	.long 0x1000004
>       14:	57 00 00 06 	rlwinm  r0,r24,0,0,3
>       18:	6c 00 00 00 	xoris   r0,r0,0
> 	...
>       24:	00 00 00 1a 	.long 0x1a
>       28:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>       2c:	00 02 01 08 	.long 0x20108
>       30:	00 00 04 70 	.long 0x470
>       34:	02 02 07 00 	.long 0x2020700
>       38:	00 05 86 02 	.long 0x58602
>       3c:	04 07 00 00 	.long 0x4070000
>       40:	02 1e 02 08 	.long 0x21e0208
>       44:	07 00 00 02 	.long 0x7000002
>       48:	58 02 01 06 	rlmi    r2,r0,r0,4,3
>       4c:	00 00 00 fc 	.long 0xfc
>       50:	02 02 05 00 	.long 0x2020500
>       54:	00 04 94 03 	.long 0x49403
>       58:	04 05 69 6e 	.long 0x405696e
>       5c:	74 00 02 08 	andis.  r0,r0,520
>       60:	05 00 00 01 	.long 0x5000001
>       64:	68 04 00 00 	xori    r4,r0,0
>       68:	03 92 04 86 	.long 0x3920486
>       6c:	00 00 00 42 	.long 0x42
>       70:	04 00 00 05 	.long 0x4000005
>       74:	4c 04 87 00 	.long 0x4c048700
>       78:	00 00 3b 04 	.long 0x3b04
>       7c:	00 00 00 08 	.long 0x8
>       80:	04 88 00 00 	.long 0x4880000
>       84:	00 3b 04 00 	.long 0x3b0400
>       88:	00 04 d6 04 	.long 0x4d604
>       8c:	89 00 00 00 	lbz     r8,0(0)
>       90:	42 04 00 00 	bc-     16,4*cr1+lt,90 <.debug_info+0x90>
>       94:	01 0f 04 8b 	.long 0x10f048b
>       98:	00 00 00 3b 	.long 0x3b
>       9c:	04 00 00 02 	.long 0x4000002
>       a0:	ee 04 8c 00 	.long 0xee048c00
>       a4:	00 00 42 04 	.long 0x4204
>       a8:	00 00 00 00 	.long 0x0
>       ac:	04 8d 00 00 	.long 0x48d0000
>       b0:	00 5e 04 00 	.long 0x5e0400
>       b4:	00 05 5a 04 	.long 0x55a04
>       b8:	8e 00 00 00 	lbzu    r16,0(0)
>       bc:	5e 05 08 07 	rlwnm.  r5,r16,r1,0,3
>       c0:	04 00 00 05 	.long 0x4000005
>       c4:	0e 04 95 00 	twlti   r4,-27392
>       c8:	00 00 5e 06 	.long 0x5e06
>       cc:	08 04 00 00 	tdi     0,r4,0
>       d0:	03 f3 04 a4 	.long 0x3f304a4
>       d4:	00 00 00 5e 	.long 0x5e
>       d8:	04 00 00 01 	.long 0x4000001
>       dc:	5d 04 a9 00 	rlwnm   r4,r8,r21,4,0
>       e0:	00 00 5e 04 	.long 0x5e04
>       e4:	00 00 01 86 	.long 0x186
>       e8:	04 b4 00 00 	.long 0x4b40000
>       ec:	00 5e 07 08 	.long 0x5e0708
>       f0:	00 00 00 f4 	.long 0xf4
>       f4:	02 01 08 00 	.long 0x2010800
>       f8:	00 05 00 04 	.long 0x50004
>       fc:	00 00 01 e9 	.long 0x1e9
>      100:	05 58 00 00 	.long 0x5580000
>      104:	00 a7 04 00 	.long 0xa70400
>      108:	00 00 38 06 	.long 0x3806
>      10c:	d6 00 00 00 	stfsu   f16,0(0)
>      110:	42 08 00 00 	bc-     16,4*cr2+lt,110 <.debug_info+0x110>
>      114:	02 4f 10 07 	.long 0x24f1007
>      118:	7a 00 00 01 	rotldi. r0,r16,0
>      11c:	3a 09 00 00 	addi    r16,r9,0
>      120:	04 29 07 7b 	.long 0x429077b
>      124:	00 00 00 c0 	.long 0xc0
>      128:	02 23 00 09 	.long 0x2230009
>      12c:	00 00 03 82 	.long 0x382
>      130:	07 7c 00 00 	.long 0x77c0000
>      134:	00 5e 02 23 	.long 0x5e0223
>      138:	08 00 02 08 	tdi     0,r0,520
>      13c:	07 00 00 00 	.long 0x7000000
>      140:	9c 02 08 05 	stbu    r0,2053(r2)
>      144:	00 00 00 ee 	.long 0xee
>      148:	08 00 00 00 	tdi     0,r0,0
>      14c:	e9 90 08 8d 	ldu     r12,2188(r16)
>      150:	00 00 02 45 	.long 0x245
>      154:	09 00 00 06 	tdgti   r0,6
>      158:	2c 08 8e 00 	cmpwi   r8,-29184
>      15c:	00 00 65 02 	.long 0x6502
>      160:	23 00 09 00 	subfic  r24,r0,2304
>      164:	00 01 08 08 	.long 0x10808
>      168:	90 00 00 00 	stw     r0,0(0)
>      16c:	86 02 23 08 	lwzu    r16,8968(r2)
>      170:	09 00 00 04 	tdgti   r0,4
>      174:	de 08 94 00 	stfdu   f16,-27648(r8)
>      178:	00 00 9c 02 	.long 0x9c02
>      17c:	23 10 09 00 	subfic  r24,r16,2304
>      180:	00 03 41 08 	.long 0x34108
>      184:	95 00 00 00 	stwu    r8,0(0)
>      188:	91 02 23 18 	stw     r8,8984(r2)
>      18c:	09 00 00 02 	tdgti   r0,2
>      190:	06 08 96 00 	.long 0x6089600
>      194:	00 00 70 02 	.long 0x7002
>      198:	23 1c 09 00 	subfic  r24,r28,2304
>      19c:	00 05 a8 08 	.long 0x5a808
>      1a0:	97 00 00 00 	stwu    r24,0(0)
>      1a4:	7b 02 23 20 	rldicl  r2,r24,4,44
>      1a8:	09 00 00 05 	tdgti   r0,5
>      1ac:	b6 08 98 00 	sthu    r16,-26624(r8)
>      1b0:	00 00 57 02 	.long 0x5702
>      1b4:	23 24 09 00 	subfic  r25,r4,2304
>      1b8:	00 04 f1 08 	.long 0x4f108
>      1bc:	99 00 00 00 	stb     r8,0(0)
>      1c0:	65 02 23 28 	oris    r2,r8,9000
>      1c4:	09 00 00 03 	tdgti   r0,3
>      1c8:	31 08 9b 00 	addic   r8,r8,-25856
>      1cc:	00 00 a7 02 	.long 0xa702
>      1d0:	23 30 09 00 	subfic  r25,r16,2304
>      1d4:	00 04 a4 08 	.long 0x4a408
>      1d8:	9f 00 00 00 	stbu    r24,0(0)
>      1dc:	cd 02 23 38 	lfdu    f8,9016(r2)
>      1e0:	09 00 00 01 	tdgti   r0,1
>      1e4:	fc 08 a2 00 	.long 0xfc08a200
>      1e8:	00 00 d8 02 	.long 0xd802
>      1ec:	23 40 09 00 	subfic  r26,r0,2304
>      1f0:	00 01 bd 08 	.long 0x1bd08
>      1f4:	ad 00 00 01 	lhau    r8,1(0)
>      1f8:	11 02 23 48 	vmulesh v8,v2,v4
>      1fc:	09 00 00 06 	tdgti   r0,6
>      200:	58 08 ae 00 	rlmi    r8,r0,r21,24,0
>      204:	00 01 11 02 	.long 0x11102
>      208:	23 58 09 00 	subfic  r26,r24,2304
>      20c:	00 00 24 08 	.long 0x2408
>      210:	af 00 00 01 	lhau    r24,1(0)
>      214:	11 02 23 68 	vmsumshm v8,v2,v4,v13
>      218:	09 00 00 01 	tdgti   r0,1
>      21c:	3f 08 bb 00 	addis   r24,r8,-17664
>      220:	00 00 42 02 	.long 0x4202
>      224:	23 78 09 00 	subfic  r27,r24,2304
>      228:	00 01 49 08 	.long 0x14908
>      22c:	bc 00 00 00 	stmw    r0,0(0)
>      230:	42 03 23 80 	bc-     16,so,25b0 <.comparefunc+0xc20>
>      234:	01 09 00 00 	.long 0x1090000
>      238:	01 53 08 bd 	.long 0x15308bd
>      23c:	00 00 00 42 	.long 0x42
>      240:	03 23 88 01 	.long 0x3238801
>      244:	00 0a 00 00 	.long 0xa0000
>      248:	03 d2 01 18 	.long 0x3d20118
>      24c:	09 18 00 00 	tdgti   r24,0
>      250:	02 99 09 00 	.long 0x2990900
>      254:	00 03 d9 09 	.long 0x3d909
>      258:	1a 00 00 00 	.long 0x1a000000
>      25c:	86 02 23 00 	lwzu    r16,8960(r2)
>      260:	09 00 00 02 	tdgti   r0,2
>      264:	da 09 1b 00 	stfd    f16,6912(r9)
>      268:	00 00 a7 02 	.long 0xa702
>      26c:	23 08 09 00 	subfic  r24,r8,2304
>      270:	00 01 71 09 	.long 0x17109
>      274:	20 00 00 00 	subfic  r0,r0,0
>      278:	34 02 23 10 	addic.  r0,r2,8976
>      27c:	09 00 00 04 	tdgti   r0,4
>      280:	7e 09 21 00 	.long 0x7e092100
>      284:	00 00 2d 02 	.long 0x2d02
>      288:	23 12 09 00 	subfic  r24,r18,2304
>      28c:	00 01 d2 09 	.long 0x1d209
>      290:	22 00 00 02 	subfic  r16,r0,2
>      294:	99 02 23 13 	stb     r8,8979(r2)
>      298:	00 0b 00 00 	.long 0xb0000
>      29c:	00 f4 00 00 	.long 0xf40000
>      2a0:	02 a9 0c 00 	.long 0x2a90c00
>      2a4:	00 00 bd ff 	.long 0xbdff
>      2a8:	00 07 08 00 	.long 0x70800
>      2ac:	00 02 af 0d 	.long 0x2af0d
>      2b0:	00 00 00 f4 	.long 0xf4
>      2b4:	07 08 00 00 	.long 0x7080000
>      2b8:	02 ba 0e 04 	.long 0x2ba0e04
>      2bc:	00 00 04 b5 	.long 0x4b5
>      2c0:	0a 31 00 00 	tdi     17,r17,0
>      2c4:	02 c6 08 00 	.long 0x2c60800
>      2c8:	00 03 ea d8 	.long 0x3ead8
>      2cc:	0a 2d 00 00 	tdi     17,r13,0
>      2d0:	04 92 0f 00 	.long 0x4920f00
>      2d4:	00 01 7a 0b 	.long 0x17a0b
>      2d8:	01 10 00 00 	.long 0x1100000
>      2dc:	00 57 02 23 	.long 0x570223
>      2e0:	00 0f 00 00 	.long 0xf0000
>      2e4:	00 10 0b 01 	.long 0x100b01
>      2e8:	15 00 00 00 	.long 0x15000000
>      2ec:	ee 02 23 08 	.long 0xee022308
>      2f0:	0f 00 00 03 	twnei   r0,3
>      2f4:	5d 0b 01 16 	rlwnm   r11,r8,r0,4,11
>      2f8:	00 00 00 ee 	.long 0xee
>      2fc:	02 23 10 0f 	.long 0x223100f
>      300:	00 00 05 6b 	.long 0x56b
>      304:	0b 01 17 00 	tdnei   r1,5888
>      308:	00 00 ee 02 	.long 0xee02
>      30c:	23 18 0f 00 	subfic  r24,r24,3840
>      310:	00 06 8a 0b 	.long 0x68a0b
>      314:	01 18 00 00 	.long 0x1180000
>      318:	00 ee 02 23 	.long 0xee0223
>      31c:	20 0f 00 00 	subfic  r0,r15,0
>      320:	02 8d 0b 01 	.long 0x28d0b01
>      324:	19 00 00 00 	.long 0x19000000
>      328:	ee 02 23 28 	.long 0xee022328
>      32c:	0f 00 00 05 	twnei   r0,5
>      330:	d2 0b 01 1a 	stfs    f16,282(r11)
>      334:	00 00 00 ee 	.long 0xee
>      338:	02 23 30 0f 	.long 0x223300f
>      33c:	00 00 00 88 	.long 0x88
>      340:	0b 01 1b 00 	tdnei   r1,6912
>      344:	00 00 ee 02 	.long 0xee02
>      348:	23 38 0f 00 	subfic  r25,r24,3840
>      34c:	00 01 90 0b 	.long 0x1900b
>      350:	01 1c 00 00 	.long 0x11c0000
>      354:	00 ee 02 23 	.long 0xee0223
>      358:	40 0f 00 00 	bdnzf-  4*cr3+so,358 <.debug_info+0x358>
>      35c:	02 e0 0b 01 	.long 0x2e00b01
>      360:	1e 00 00 00 	mulli   r16,r0,0
>      364:	ee 02 23 48 	.long 0xee022348
>      368:	0f 00 00 06 	twnei   r0,6
>      36c:	48 0b 01 1f 	bla     b011c <bb+0x6ace4>
>      370:	00 00 00 ee 	.long 0xee
>      374:	02 23 50 0f 	.long 0x223500f
>      378:	00 00 05 79 	.long 0x579
>      37c:	0b 01 20 00 	tdnei   r1,8192
>      380:	00 00 ee 02 	.long 0xee02
>      384:	23 58 0f 00 	subfic  r26,r24,3840
>      388:	00 04 30 0b 	.long 0x4300b
>      38c:	01 22 00 00 	.long 0x1220000
>      390:	04 d0 02 23 	.long 0x4d00223
>      394:	60 0f 00 00 	ori     r15,r0,0
>      398:	00 1d 0b 01 	.long 0x1d0b01
>      39c:	24 00 00 04 	dozi    r0,r0,4
>      3a0:	d6 02 23 68 	stfsu   f16,9064(r2)
>      3a4:	0f 00 00 01 	twnei   r0,1
>      3a8:	32 0b 01 26 	addic   r16,r11,294
>      3ac:	00 00 00 57 	.long 0x57
>      3b0:	02 23 70 0f 	.long 0x223700f
>      3b4:	00 00 06 40 	.long 0x640
>      3b8:	0b 01 2a 00 	tdnei   r1,10752
>      3bc:	00 00 57 02 	.long 0x5702
>      3c0:	23 74 0f 00 	subfic  r27,r20,3840
>      3c4:	00 04 1d 0b 	.long 0x41d0b
>      3c8:	01 2c 00 00 	.long 0x12c0000
>      3cc:	00 a7 02 23 	.long 0xa70223
>      3d0:	78 0f 00 00 	rotldi  r15,r0,0
>      3d4:	01 9c 0b 01 	.long 0x19c0b01
>      3d8:	30 00 00 00 	addic   r0,r0,0
>      3dc:	34 03 23 80 	addic.  r0,r3,9088
>      3e0:	01 0f 00 00 	.long 0x10f0000
>      3e4:	01 23 0b 01 	.long 0x1230b01
>      3e8:	31 00 00 00 	addic   r8,r0,0
>      3ec:	49 03 23 82 	ba      1032380 <bb+0xfecf48>
>      3f0:	01 0f 00 00 	.long 0x10f0000
>      3f4:	00 45 0b 01 	.long 0x450b01
>      3f8:	32 00 00 04 	addic   r16,r0,4
>      3fc:	dc 03 23 83 	stfdu   f0,9091(r3)
>      400:	01 0f 00 00 	.long 0x10f0000
>      404:	03 12 0b 01 	.long 0x3120b01
>      408:	36 00 00 04 	addic.  r16,r0,4
>      40c:	ec 03 23 88 	.long 0xec032388
>      410:	01 0f 00 00 	.long 0x10f0000
>      414:	01 c5 0b 01 	.long 0x1c50b01
>      418:	3f 00 00 00 	lis     r24,0
>      41c:	b2 03 23 90 	sth     r16,9104(r3)
>      420:	01 0f 00 00 	.long 0x10f0000
>      424:	05 af 0b 01 	.long 0x5af0b01
>      428:	48 00 00 00 	b       428 <.debug_info+0x428>
>      42c:	cb 03 23 98 	lfd     f24,9112(r3)
>      430:	01 0f 00 00 	.long 0x10f0000
>      434:	05 b6 0b 01 	.long 0x5b60b01
>      438:	49 00 00 00 	b       1000438 <bb+0xfbb000>
>      43c:	cb 03 23 a0 	lfd     f24,9120(r3)
>      440:	01 0f 00 00 	.long 0x10f0000
>      444:	05 bd 0b 01 	.long 0x5bd0b01
>      448:	4a 00 00 00 	b       fffffffffe000448 <bb+0xfffffffffdfbb010>
>      44c:	cb 03 23 a8 	lfd     f24,9128(r3)
>      450:	01 0f 00 00 	.long 0x10f0000
>      454:	05 c4 0b 01 	.long 0x5c40b01
>      458:	4b 00 00 00 	b       ffffffffff000458 <bb+0xfffffffffefbb020>
>      45c:	cb 03 23 b0 	lfd     f24,9136(r3)
>      460:	01 0f 00 00 	.long 0x10f0000
>      464:	05 cb 0b 01 	.long 0x5cb0b01
>      468:	4c 00 00 01 	.long 0x4c000001
>      46c:	06 03 23 b8 	.long 0x60323b8
>      470:	01 0f 00 00 	.long 0x10f0000
>      474:	03 18 0b 01 	.long 0x3180b01
>      478:	4e 00 00 00 	mcrf    cr4,cr0
>      47c:	57 03 23 c0 	rlwinm  r3,r24,4,15,0
>      480:	01 0f 00 00 	.long 0x10f0000
>      484:	05 e6 0b 01 	.long 0x5e60b01
>      488:	50 00 00 04 	rlwimi  r0,r0,0,0,2
>      48c:	f2 03 23 c4 	.long 0xf20323c4
>      490:	01 00 10 00 	.long 0x1001000
>      494:	00 03 df 0b 	.long 0x3df0b
>      498:	b4 08 00 00 	sthu    r0,0(r8)
>      49c:	02 0d 18 0b 	.long 0x20d180b
>      4a0:	ba 00 00 04 	lmw     r16,4(0)
>      4a4:	d0 09 00 00 	stfs    f0,0(r9)
>      4a8:	05 54 0b bb 	.long 0x5540bbb
>      4ac:	00 00 04 d0 	.long 0x4d0
>      4b0:	02 23 00 09 	.long 0x2230009
>      4b4:	00 00 02 aa 	.long 0x2aa
>      4b8:	0b bc 00 00 	tdi     29,r28,0
>      4bc:	04 d6 02 23 	.long 0x4d60223
>      4c0:	08 09 00 00 	tdi     0,r9,0
>      4c4:	04 18 0b c0 	.long 0x4180bc0
>      4c8:	00 00 00 57 	.long 0x57
>      4cc:	02 23 10 00 	.long 0x2231000
>      4d0:	07 08 00 00 	.long 0x7080000
>      4d4:	04 99 07 08 	.long 0x4990708
>      4d8:	00 00 02 c6 	.long 0x2c6
>      4dc:	0b 00 00 00 	tdnei   r0,0
>      4e0:	f4 00 00 04 	.long 0xf4000004
>      4e4:	ec 0c 00 00 	.long 0xec0c0000
>      4e8:	00 bd 00 00 	.long 0xbd0000
>      4ec:	07 08 00 00 	.long 0x7080000
>      4f0:	04 92 0b 00 	.long 0x4920b00
>      4f4:	00 00 f4 00 	.long 0xf400
>      4f8:	00 05 02 0c 	.long 0x5020c
>      4fc:	00 00 00 bd 	.long 0xbd
>      500:	13 00 04 00 	vsububm v24,v0,v0
>      504:	00 03 c9 0c 	.long 0x3c90c
>      508:	38 00 00 00 	li      r0,0
>      50c:	42 07 08 00 	bc-     16,4*cr1+so,d0c <.debug_info+0xd0c>
>      510:	00 05 13 0d 	.long 0x5130d
>      514:	00 00 00 2d 	.long 0x2d
>      518:	08 00 00 01 	tdi     0,r0,1
>      51c:	ef 18 0d 69 	.long 0xef180d69
>      520:	00 00 05 4f 	.long 0x54f
>      524:	09 00 00 06 	tdgti   r0,6
>      528:	84 0d 6a 00 	lwzu    r0,27136(r13)
>      52c:	00 01 3a 02 	.long 0x13a02
>      530:	23 00 11 65 	subfic  r24,r0,4453
>      534:	6e 64 00 0d 	xoris   r4,r19,13
>      538:	6a 00 00 01 	xori    r0,r16,1
>      53c:	3a 02 23 08 	addi    r16,r2,8968
>      540:	09 00 00 00 	tdgti   r0,0
>      544:	56 0d 6b 00 	rlwinm  r13,r16,13,12,0
>      548:	00 00 3b 02 	.long 0x3b02
>      54c:	23 10 00 07 	subfic  r24,r16,7
>      550:	08 00 00 05 	tdi     0,r0,5
>      554:	18 07 08 00 	.long 0x18070800
>      558:	00 00 ee 08 	.long 0xee08
>      55c:	00 00 02 2b 	.long 0x22b
>      560:	20 0e 19 00 	subfic  r0,r14,6400
>      564:	00 05 d8 09 	.long 0x5d809
>      568:	00 00 04 9e 	.long 0x49e
>      56c:	0e 1a 00 00 	twlti   r26,0
>      570:	00 3b 02 23 	.long 0x3b0223
>      574:	00 09 00 00 	.long 0x90000
>      578:	00 7e 0e 1b 	.long 0x7e0e1b
>      57c:	00 00 00 3b 	.long 0x3b
>      580:	02 23 04 09 	.long 0x2230409
>      584:	00 00 03 b5 	.long 0x3b5
>      588:	0e 1c 00 00 	twlti   r28,0
>      58c:	00 3b 02 23 	.long 0x3b0223
>      590:	08 09 00 00 	tdi     0,r9,0
>      594:	02 7e 0e 1d 	.long 0x27e0e1d
>      598:	00 00 00 3b 	.long 0x3b
>      59c:	02 23 0c 09 	.long 0x2230c09
>      5a0:	00 00 04 85 	.long 0x485
>      5a4:	0e 1e 00 00 	twlti   r30,0
>      5a8:	00 3b 02 23 	.long 0x3b0223
>      5ac:	10 09 00 00 	vaddubm v0,v9,v0
>      5b0:	03 49 0e 1f 	.long 0x3490e1f
>      5b4:	00 00 00 3b 	.long 0x3b
>      5b8:	02 23 14 09 	.long 0x2231409
>      5bc:	00 00 00 c5 	.long 0xc5
>      5c0:	0e 20 00 00 	twi     17,r0,0
>      5c4:	00 3b 02 23 	.long 0x3b0223
>      5c8:	18 09 00 00 	.long 0x18090000
>      5cc:	06 20 0e 21 	.long 0x6200e21
>      5d0:	00 00 00 3b 	.long 0x3b
>      5d4:	02 23 1c 00 	.long 0x2231c00
>      5d8:	08 00 00 04 	tdi     0,r0,4
>      5dc:	40 10 0e 28 	bdnzf-  4*cr4+lt,1404 <.putnode+0x304>
>      5e0:	00 00 06 01 	.long 0x601
>      5e4:	09 00 00 02 	tdgti   r0,2
>      5e8:	cc 0e 29 00 	lfdu    f0,10496(r14)
>      5ec:	00 00 3b 02 	.long 0x3b02
>      5f0:	23 00 09 00 	subfic  r24,r0,2304
>      5f4:	00 04 39 0e 	.long 0x4390e
>      5f8:	2a 00 00 05 	cmplwi  cr4,r0,5
>      5fc:	4f 02 23 08 	.long 0x4f022308
>      600:	00 04 00 00 	.long 0x40000
>      604:	01 d9 0e 2b 	.long 0x1d90e2b
>      608:	00 00 05 d8 	.long 0x5d8
>      60c:	12 01 00 00 	vaddubm v16,v1,v0
>      610:	04 af 02 01 	.long 0x4af0201
>      614:	cb 01 00 00 	lfd     f24,0(r1)
>      618:	00 57 03 00 	.long 0x570300
>      61c:	00 06 38 13 	.long 0x63813
>      620:	00 00 00 4f 	.long 0x4f
>      624:	02 01 ca 00 	.long 0x201ca00
>      628:	00 02 a9 13 	.long 0x2a913
>      62c:	00 00 02 a0 	.long 0x2a0
>      630:	02 01 ca 00 	.long 0x201ca00
>      634:	00 06 38 00 	.long 0x63800
>      638:	07 08 00 00 	.long 0x7080000
>      63c:	01 48 14 01 	.long 0x1481401
>      640:	00 00 02 3e 	.long 0x23e
>      644:	03 75 01 00 	.long 0x3750100
>      648:	00 00 e3 03 	.long 0xe303
>      64c:	00 00 06 72 	.long 0x672
>      650:	15 00 00 04 	.long 0x15000004
>      654:	ba 03 74 00 	lmw     r16,29696(r3)
>      658:	00 05 55 16 	.long 0x55516
>      65c:	5f 5f 6e 00 	rlwnm   r31,r26,r13,24,0
>      660:	03 74 00 00 	.long 0x3740000
>      664:	06 72 15 00 	.long 0x6721500
>      668:	00 02 46 03 	.long 0x24603
>      66c:	74 00 00 06 	andis.  r0,r0,6
>      670:	78 00 07 08 	rldic   r0,r0,0,28
>      674:	00 00 01 06 	.long 0x106
>      678:	07 08 00 00 	.long 0x7080000
>      67c:	02 bb 17 01 	.long 0x2bb1701
>      680:	00 00 06 06 	.long 0x606
>      684:	01 37 01 00 	.long 0x1370100
> 	...
>      694:	00 00 d4 00 	.long 0xd400
>      698:	00 00 00 00 	.long 0x0
>      69c:	00 06 cd 18 	.long 0x6cd18
>      6a0:	00 00 00 3f 	.long 0x3f
>      6a4:	01 36 00 00 	.long 0x1360000
>      6a8:	01 3a 00 00 	.long 0x13a0000
>      6ac:	00 38 18 00 	.long 0x381800
>      6b0:	00 04 f9 01 	.long 0x4f901
>      6b4:	36 00 00 01 	addic.  r16,r0,1
>      6b8:	3a 00 00 00 	li      r16,0
>      6bc:	94 19 00 00 	stwu    r0,0(r25)
>      6c0:	05 64 01 38 	.long 0x5640138
>      6c4:	00 00 01 06 	.long 0x106
>      6c8:	00 00 00 f0 	.long 0xf0
>      6cc:	00 1a 00 00 	.long 0x1a0000
>      6d0:	03 ab 01 47 	.long 0x3ab0147
>      6d4:	01 00 00 00 	.long 0x1000000
>      6d8:	00 00 00 00 	.long 0x0
>      6dc:	e0 00 00 00 	.long 0xe0000000
>      6e0:	00 00 00 03 	.long 0x3
>      6e4:	2c 00 00 01 	cmpwi   r0,1
>      6e8:	26 00 00 08 	dozi    r16,r0,8
>      6ec:	62 18 00 00 	ori     r24,r16,0
>      6f0:	02 9b 01 46 	.long 0x29b0146
>      6f4:	00 00 00 ee 	.long 0xee
>      6f8:	00 00 01 5e 	.long 0x15e
>      6fc:	18 00 00 02 	.long 0x18000002
>      700:	b9 01 46 00 	lmw     r8,17920(r1)
>      704:	00 08 62 00 	.long 0x86200
>      708:	00 01 cd 1b 	.long 0x1cd1b
>      70c:	6c 65 6e 00 	xoris   r5,r3,28160
>      710:	01 46 00 00 	.long 0x1460000
>      714:	00 57 00 00 	.long 0x570000
>      718:	02 3c 1c 00 	.long 0x23c1c00
>      71c:	00 00 00 00 	.long 0x0
>      720:	00 01 10 00 	.long 0x11000
>      724:	00 00 00 00 	.long 0x0
>      728:	00 01 20 00 	.long 0x12000
>      72c:	00 07 46 1d 	.long 0x7461d
>      730:	00 00 03 ff 	.long 0x3ff
>      734:	01 4c 00 00 	.long 0x14c0000
>      738:	01 06 1d 00 	.long 0x1061d00
>      73c:	00 00 b3 01 	.long 0xb301
>      740:	4c 00 00 01 	.long 0x4c000001
>      744:	06 00 1c 00 	.long 0x6001c00
>      748:	00 00 00 00 	.long 0x0
>      74c:	00 01 d0 00 	.long 0x1d000
>      750:	00 00 00 00 	.long 0x0
>      754:	00 01 e0 00 	.long 0x1e000
>      758:	00 07 72 1d 	.long 0x7721d
>      75c:	00 00 03 ff 	.long 0x3ff
>      760:	01 4e 00 00 	.long 0x14e0000
>      764:	01 06 1d 00 	.long 0x1061d00
>      768:	00 00 b3 01 	.long 0xb301
>      76c:	4e 00 00 01 	.long 0x4e000001
>      770:	06 00 1c 00 	.long 0x6001c00
>      774:	00 00 00 00 	.long 0x0
>      778:	00 02 80 00 	.long 0x28000
>      77c:	00 00 00 00 	.long 0x0
>      780:	00 02 90 00 	.long 0x29000
>      784:	00 07 9e 1d 	.long 0x79e1d
>      788:	00 00 03 ff 	.long 0x3ff
>      78c:	01 50 00 00 	.long 0x1500000
>      790:	01 06 1d 00 	.long 0x1061d00
>      794:	00 00 b3 01 	.long 0xb301
>      798:	50 00 00 01 	rlwimi. r0,r0,0,0,0
>      79c:	06 00 1c 00 	.long 0x6001c00
>      7a0:	00 00 00 00 	.long 0x0
>      7a4:	00 02 b0 00 	.long 0x2b000
>      7a8:	00 00 00 00 	.long 0x0
>      7ac:	00 02 c0 00 	.long 0x2c000
>      7b0:	00 07 ca 1d 	.long 0x7ca1d
>      7b4:	00 00 03 ff 	.long 0x3ff
>      7b8:	01 51 00 00 	.long 0x1510000
>      7bc:	01 06 1d 00 	.long 0x1061d00
>      7c0:	00 00 b3 01 	.long 0xb301
>      7c4:	51 00 00 01 	rlwimi. r0,r8,0,0,0
>      7c8:	06 00 1c 00 	.long 0x6001c00
>      7cc:	00 00 00 00 	.long 0x0
>      7d0:	00 02 d8 00 	.long 0x2d800
>      7d4:	00 00 00 00 	.long 0x0
>      7d8:	00 02 e8 00 	.long 0x2e800
>      7dc:	00 07 f6 1d 	.long 0x7f61d
>      7e0:	00 00 03 ff 	.long 0x3ff
>      7e4:	01 53 00 00 	.long 0x1530000
>      7e8:	01 06 1d 00 	.long 0x1061d00
>      7ec:	00 00 b3 01 	.long 0xb301
>      7f0:	53 00 00 01 	rlwimi. r0,r24,0,0,0
>      7f4:	06 00 1c 00 	.long 0x6001c00
>      7f8:	00 00 00 00 	.long 0x0
>      7fc:	00 02 fc 00 	.long 0x2fc00
>      800:	00 00 00 00 	.long 0x0
>      804:	00 03 0c 00 	.long 0x30c00
>      808:	00 08 22 1d 	.long 0x8221d
>      80c:	00 00 03 ff 	.long 0x3ff
>      810:	01 58 00 00 	.long 0x1580000
>      814:	01 06 1d 00 	.long 0x1061d00
>      818:	00 00 b3 01 	.long 0xb301
>      81c:	58 00 00 01 	rlmi.   r0,r0,r0,0,0
>      820:	06 00 1e 00 	.long 0x6001e00
>      824:	00 04 49 01 	.long 0x44901
>      828:	48 00 00 01 	bl      828 <.debug_info+0x828>
>      82c:	3a 09 03 00 	addi    r16,r9,768
>      830:	00 00 00 00 	.long 0x0
>      834:	00 10 00 1e 	.long 0x10001e
>      838:	00 00 02 cc 	.long 0x2cc
>      83c:	01 48 00 00 	.long 0x1480000
>      840:	01 3a 09 03 	.long 0x13a0903
>      844:	00 00 00 00 	.long 0x0
>      848:	00 00 10 08 	.long 0x1008
>      84c:	1f 65 6e 64 	mulli   r27,r5,28260
>      850:	00 01 48 00 	.long 0x14800
>      854:	00 01 3a 09 	.long 0x13a09
>      858:	03 00 00 00 	.long 0x3000000
>      85c:	00 00 00 10 	.long 0x10
>      860:	10 00 07 08 	vsum4sbs v0,v0,v0
>      864:	00 00 00 3b 	.long 0x3b
>      868:	20 00 00 03 	subfic  r0,r0,3
>      86c:	a3 01 6c 01 	lhz     r24,27649(r1)
>      870:	00 00 00 3b 	.long 0x3b
>      874:	00 00 00 00 	.long 0x0
>      878:	00 00 03 30 	.long 0x330
>      87c:	00 00 00 00 	.long 0x0
>      880:	00 00 04 7c 	.long 0x47c
>      884:	00 00 02 ab 	.long 0x2ab
>      888:	00 00 08 c7 	.long 0x8c7
>      88c:	18 00 00 02 	.long 0x18000002
>      890:	9b 01 6b 00 	stb     r24,27392(r1)
>      894:	00 02 a9 00 	.long 0x2a900
>      898:	00 02 e3 19 	.long 0x2e319
>      89c:	00 00 05 64 	.long 0x564
>      8a0:	01 6d 00 00 	.long 0x16d0000
>      8a4:	00 3b 00 00 	.long 0x3b0000
>      8a8:	03 3f 21 00 	.long 0x33f2100
>      8ac:	00 00 00 1d 	.long 0x1d
>      8b0:	00 00 03 ff 	.long 0x3ff
>      8b4:	01 70 00 00 	.long 0x1700000
>      8b8:	01 06 1d 00 	.long 0x1061d00
>      8bc:	00 00 b3 01 	.long 0xb301
>      8c0:	70 00 00 01 	andi.   r0,r0,1
>      8c4:	06 00 00 1a 	.long 0x600001a
>      8c8:	00 00 03 6a 	.long 0x36a
>      8cc:	01 c2 01 00 	.long 0x1c20100
>      8d0:	00 00 00 00 	.long 0x0
>      8d4:	00 04 80 00 	.long 0x48000
>      8d8:	00 00 00 00 	.long 0x0
>      8dc:	00 08 30 00 	.long 0x83000
>      8e0:	00 03 fa 00 	.long 0x3fa00
>      8e4:	00 09 92 1b 	.long 0x9921b
>      8e8:	66 64 00 01 	oris    r4,r19,1
>      8ec:	c1 00 00 00 	lfs     f8,0(0)
>      8f0:	57 00 00 04 	rlwinm  r0,r24,0,0,2
>      8f4:	33 1b 6c 65 	addic   r24,r27,27749
>      8f8:	6e 00 01 c1 	xoris   r0,r16,449
>      8fc:	00 00 00 57 	.long 0x57
>      900:	00 00 04 a2 	.long 0x4a2
>      904:	1e 00 00 05 	mulli   r16,r0,5
>      908:	e0 01 c3 00 	.long 0xe001c300
>      90c:	00 09 92 04 	.long 0x99204
>      910:	91 d0 f7 7e 	stw     r14,-2178(r16)
>      914:	1d 00 00 06 	mulli   r8,r0,6
>      918:	66 01 c3 00 	oris    r1,r16,49920
>      91c:	00 00 ee 1f 	.long 0xee1f
>      920:	62 75 66 00 	ori     r21,r19,26112
>      924:	01 c4 00 00 	.long 0x1c40000
>      928:	09 a3 04 91 	tdi     13,r3,1169
>      92c:	c0 f7 7e 1e 	lfs     f7,32286(r23)
>      930:	00 00 04 39 	.long 0x439
>      934:	01 c5 00 00 	.long 0x1c50000
>      938:	09 b3 04 91 	tdi     13,r19,1169
>      93c:	d0 ff 7e 1d 	stfs    f7,32285(r31)
>      940:	00 00 04 49 	.long 0x449
>      944:	01 c6 00 00 	.long 0x1c60000
>      948:	05 02 22 65 	.long 0x5022265
>      94c:	6e 64 00 01 	xoris   r4,r19,1
>      950:	c6 00 00 05 	lfsu    f16,5(0)
>      954:	02 00 00 04 	.long 0x2000004
>      958:	fe 19 00 00 	fcmpu   cr4,f25,f0
>      95c:	03 09 01 c6 	.long 0x30901c6
>      960:	00 00 05 02 	.long 0x502
>      964:	00 00 05 6d 	.long 0x56d
>      968:	19 00 00 03 	.long 0x19000003
>      96c:	8a 01 c6 00 	lbz     r16,-14848(r1)
>      970:	00 05 02 00 	.long 0x50200
>      974:	00 05 c9 1d 	.long 0x5c91d
>      978:	00 00 04 12 	.long 0x412
>      97c:	01 c7 00 00 	.long 0x1c70000
>      980:	00 57 19 00 	.long 0x571900
>      984:	00 01 81 01 	.long 0x18101
>      988:	c7 00 00 00 	lfsu    f24,0(0)
>      98c:	57 00 00 05 	rlwinm. r0,r24,0,0,2
>      990:	ff 00 0b 00 	.long 0xff000b00
>      994:	00 00 f4 00 	.long 0xf400
>      998:	00 09 a3 23 	.long 0x9a323
>      99c:	00 00 00 bd 	.long 0xbd
>      9a0:	03 ff 00 0b 	.long 0x3ff000b
>      9a4:	00 00 05 02 	.long 0x502
>      9a8:	00 00 09 b3 	.long 0x9b3
>      9ac:	0c 00 00 00 	twi     0,r0,0
>      9b0:	bd 01 00 0b 	stmw    r8,11(r1)
>      9b4:	00 00 05 02 	.long 0x502
>      9b8:	00 00 09 c4 	.long 0x9c4
>      9bc:	23 00 00 00 	subfic  r24,r0,0
>      9c0:	bd 07 ff 00 	stmw    r8,-256(r7)
>      9c4:	1a 00 00 00 	.long 0x1a000000
>      9c8:	5b 01 7e 01 	rlmi.   r1,r24,r15,24,0
>      9cc:	00 00 00 00 	.long 0x0
>      9d0:	00 00 08 30 	.long 0x830
>      9d4:	00 00 00 00 	.long 0x0
>      9d8:	00 00 0c 68 	.long 0xc68
>      9dc:	00 00 06 81 	.long 0x681
>      9e0:	00 00 0a d3 	.long 0xad3
>      9e4:	1b 66 64 00 	.long 0x1b666400
>      9e8:	01 7d 00 00 	.long 0x17d0000
>      9ec:	00 57 00 00 	.long 0x570000
>      9f0:	06 ba 1e 00 	.long 0x6ba1e00
>      9f4:	00 05 e0 01 	.long 0x5e001
>      9f8:	7f 00 00 09 	.long 0x7f000009
>      9fc:	92 04 91 a0 	stw     r16,-28256(r4)
>      a00:	f7 7e 1d 00 	.long 0xf77e1d00
>      a04:	00 06 66 01 	.long 0x66601
>      a08:	7f 00 00 00 	cmpw    cr6,r0,r0
>      a0c:	ee 1f 62 75 	.long 0xee1f6275
>      a10:	66 00 01 80 	oris    r0,r16,384
>      a14:	00 00 0a d3 	.long 0xad3
>      a18:	04 91 a0 f5 	.long 0x491a0f5
>      a1c:	7e 1e 00 00 	cmpw    cr4,r30,r0
>      a20:	04 39 01 81 	.long 0x4390181
>      a24:	00 00 09 b3 	.long 0x9b3
>      a28:	04 91 a0 ff 	.long 0x491a0ff
>      a2c:	7e 19 00 00 	cmpw    cr4,r25,r0
>      a30:	04 49 01 82 	.long 0x4490182
>      a34:	00 00 05 02 	.long 0x502
>      a38:	00 00 07 16 	.long 0x716
>      a3c:	22 65 6e 64 	subfic  r19,r5,28260
>      a40:	00 01 82 00 	.long 0x18200
>      a44:	00 05 02 00 	.long 0x50200
>      a48:	00 07 39 19 	.long 0x73919
>      a4c:	00 00 03 09 	.long 0x309
>      a50:	01 82 00 00 	.long 0x1820000
>      a54:	05 02 00 00 	.long 0x5020000
>      a58:	07 82 19 00 	.long 0x7821900
>      a5c:	00 03 8a 01 	.long 0x38a01
>      a60:	82 00 00 05 	lwz     r16,5(0)
>      a64:	02 00 00 07 	.long 0x2000007
>      a68:	b8 1d 00 00 	lmw     r0,0(r29)
>      a6c:	04 12 01 83 	.long 0x4120183
>      a70:	00 00 00 57 	.long 0x57
>      a74:	19 00 00 01 	.long 0x19000001
>      a78:	81 01 83 00 	lwz     r8,-32000(r1)
>      a7c:	00 00 57 00 	.long 0x5700
>      a80:	00 07 ee 22 	.long 0x7ee22
>      a84:	69 00 01 83 	xori    r0,r8,387
>      a88:	00 00 00 57 	.long 0x57
>      a8c:	00 00 08 96 	.long 0x896
>      a90:	19 00 00 00 	.long 0x19000000
>      a94:	bc 01 84 00 	stmw    r0,-31744(r1)
>      a98:	00 00 57 00 	.long 0x5700
>      a9c:	00 08 b9 1d 	.long 0x8b91d
>      aa0:	00 00 02 35 	.long 0x235
>      aa4:	01 84 00 00 	.long 0x1840000
>      aa8:	00 57 24 00 	.long 0x572400
>      aac:	00 00 00 00 	.long 0x0
>      ab0:	00 08 b8 00 	.long 0x8b800
>      ab4:	00 00 00 00 	.long 0x0
>      ab8:	00 08 c4 1d 	.long 0x8c41d
>      abc:	00 00 03 ff 	.long 0x3ff
>      ac0:	01 8a 00 00 	.long 0x18a0000
>      ac4:	01 06 1d 00 	.long 0x1061d00
>      ac8:	00 00 b3 01 	.long 0xb301
>      acc:	8a 00 00 01 	lbz     r16,1(0)
>      ad0:	06 00 00 0b 	.long 0x600000b
>      ad4:	00 00 05 02 	.long 0x502
>      ad8:	00 00 0a e3 	.long 0xae3
>      adc:	0c 00 00 00 	twi     0,r0,0
>      ae0:	bd 1f 00 25 	stmw    r8,37(r31)
>      ae4:	00 00 06 17 	.long 0x617
>      ae8:	01 01 09 01 	.long 0x1010901
>      aec:	00 00 00 00 	.long 0x0
>      af0:	00 00 0c 70 	.long 0xc70
>      af4:	00 00 00 00 	.long 0x0
>      af8:	00 00 11 00 	.long 0x1100
>      afc:	00 00 08 ef 	.long 0x8ef
>      b00:	00 00 0e 17 	.long 0xe17
>      b04:	26 66 6e 00 	dozi    r19,r6,28160
>      b08:	01 01 08 00 	.long 0x1010800
>      b0c:	00 00 ee 00 	.long 0xee00
>      b10:	00 09 27 27 	.long 0x92727
>      b14:	00 00 04 c4 	.long 0x4c4
>      b18:	01 01 08 00 	.long 0x1010800
>      b1c:	00 0e 17 00 	.long 0xe1700
>      b20:	00 09 70 27 	.long 0x97027
>      b24:	00 00 06 a7 	.long 0x6a7
>      b28:	01 01 08 00 	.long 0x1010800
>      b2c:	00 00 57 00 	.long 0x5700
>      b30:	00 09 cc 28 	.long 0x9cc28
>      b34:	64 70 00 01 	oris    r16,r3,1
>      b38:	01 0a 00 00 	.long 0x10a0000
>      b3c:	0e 1d 00 00 	twlti   r29,0
>      b40:	0a 15 28 69 	tdlti   r21,10345
>      b44:	00 01 01 0b 	.long 0x1010b
>      b48:	00 00 00 57 	.long 0x57
>      b4c:	00 00 0a 5e 	.long 0xa5e
>      b50:	28 66 64 00 	cmpldi  r6,25600
>      b54:	01 01 0b 00 	.long 0x1010b00
>      b58:	00 00 57 00 	.long 0x5700
>      b5c:	00 0a a7 28 	.long 0xaa728
>      b60:	6c 65 6e 00 	xoris   r5,r3,28160
>      b64:	01 01 0b 00 	.long 0x1010b00
>      b68:	00 00 57 00 	.long 0x5700
>      b6c:	00 0b 03 29 	.long 0xb0329
>      b70:	00 00 01 a8 	.long 0x1a8
>      b74:	01 01 0c 00 	.long 0x1010c00
>      b78:	00 01 48 03 	.long 0x14803
>      b7c:	91 f0 7d 2a 	stw     r15,32042(r16)
>      b80:	00 00 06 0c 	.long 0x60c
>      b84:	00 00 00 30 	.long 0x30
>      b88:	01 01 15 00 	.long 0x1011500
>      b8c:	00 0b 9a 2b 	.long 0xb9a2b
>      b90:	00 00 06 2b 	.long 0x62b
>      b94:	2b 00 00 06 	cmplwi  cr6,r0,6
>      b98:	1f 00 2c 00 	mulli   r24,r0,11264
>      b9c:	00 00 60 00 	.long 0x6000
>      ba0:	00 0b bc 2d 	.long 0xbbc2d
>      ba4:	00 00 03 ff 	.long 0x3ff
>      ba8:	01 01 23 00 	.long 0x1012300
>      bac:	00 01 06 2d 	.long 0x1062d
>      bb0:	00 00 00 b3 	.long 0xb3
>      bb4:	01 01 23 00 	.long 0x1012300
>      bb8:	00 01 06 00 	.long 0x10600
>      bbc:	1c 00 00 00 	mulli   r0,r0,0
>      bc0:	00 00 00 0d 	.long 0xd
>      bc4:	6c 00 00 00 	xoris   r0,r0,0
>      bc8:	00 00 00 0d 	.long 0xd
>      bcc:	7c 00 00 0b 	.long 0x7c00000b
>      bd0:	fc 24 00 00 	.long 0xfc240000
>      bd4:	00 00 00 00 	.long 0x0
>      bd8:	0d 6c 00 00 	twi     11,r12,0
>      bdc:	00 00 00 00 	.long 0x0
>      be0:	0d 7c 2d 00 	twi     11,r28,11520
>      be4:	00 03 04 01 	.long 0x30401
>      be8:	01 12 00 00 	.long 0x1120000
>      bec:	05 0d 2d 00 	.long 0x50d2d00
>      bf0:	00 02 b0 01 	.long 0x2b001
>      bf4:	01 12 00 00 	.long 0x1120000
>      bf8:	00 57 00 00 	.long 0x570000
>      bfc:	1c 00 00 00 	mulli   r0,r0,0
>      c00:	00 00 00 0d 	.long 0xd
>      c04:	84 00 00 00 	lwzu    r0,0(0)
>      c08:	00 00 00 0d 	.long 0xd
>      c0c:	8c 00 00 0c 	lbzu    r0,12(0)
>      c10:	3c 24 00 00 	addis   r1,r4,0
>      c14:	00 00 00 00 	.long 0x0
>      c18:	0d 84 00 00 	twgei   r4,0
>      c1c:	00 00 00 00 	.long 0x0
>      c20:	0d 8c 2d 00 	twgei   r12,11520
>      c24:	00 03 04 01 	.long 0x30401
>      c28:	01 12 00 00 	.long 0x1120000
>      c2c:	05 0d 2d 00 	.long 0x50d2d00
>      c30:	00 02 b0 01 	.long 0x2b001
>      c34:	01 12 00 00 	.long 0x1120000
>      c38:	00 57 00 00 	.long 0x570000
>      c3c:	1c 00 00 00 	mulli   r0,r0,0
>      c40:	00 00 00 0e 	.long 0xe
>      c44:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      c48:	00 00 00 0e 	.long 0xe
>      c4c:	64 00 00 0c 	oris    r0,r0,12
>      c50:	6a 2d 00 00 	xori    r13,r17,0
>      c54:	03 ff 01 01 	.long 0x3ff0101
>      c58:	19 00 00 01 	.long 0x19000001
>      c5c:	06 2d 00 00 	.long 0x62d0000
>      c60:	00 b3 01 01 	.long 0xb30101
>      c64:	19 00 00 01 	.long 0x19000001
>      c68:	06 00 1c 00 	.long 0x6001c00
>      c6c:	00 00 00 00 	.long 0x0
>      c70:	00 0e 6c 00 	.long 0xe6c00
>      c74:	00 00 00 00 	.long 0x0
>      c78:	00 0e 7c 00 	.long 0xe7c00
>      c7c:	00 0c 98 2d 	.long 0xc982d
>      c80:	00 00 03 ff 	.long 0x3ff
>      c84:	01 01 1c 00 	.long 0x1011c00
>      c88:	00 01 06 2d 	.long 0x1062d
>      c8c:	00 00 00 b3 	.long 0xb3
>      c90:	01 01 1c 00 	.long 0x1011c00
>      c94:	00 01 06 00 	.long 0x10600
>      c98:	1c 00 00 00 	mulli   r0,r0,0
>      c9c:	00 00 00 0e 	.long 0xe
>      ca0:	9c 00 00 00 	stbu    r0,0(0)
>      ca4:	00 00 00 0e 	.long 0xe
>      ca8:	ac 00 00 0c 	lhau    r0,12(0)
>      cac:	c6 2d 00 00 	lfsu    f17,0(r13)
>      cb0:	03 ff 01 01 	.long 0x3ff0101
>      cb4:	24 00 00 01 	dozi    r0,r0,1
>      cb8:	06 2d 00 00 	.long 0x62d0000
>      cbc:	00 b3 01 01 	.long 0xb30101
>      cc0:	24 00 00 01 	dozi    r0,r0,1
>      cc4:	06 00 1c 00 	.long 0x6001c00
>      cc8:	00 00 00 00 	.long 0x0
>      ccc:	00 0e b4 00 	.long 0xeb400
>      cd0:	00 00 00 00 	.long 0x0
>      cd4:	00 0e c4 00 	.long 0xec400
>      cd8:	00 0c f4 2d 	.long 0xcf42d
>      cdc:	00 00 03 ff 	.long 0x3ff
>      ce0:	01 01 25 00 	.long 0x1012500
>      ce4:	00 01 06 2d 	.long 0x1062d
>      ce8:	00 00 00 b3 	.long 0xb3
>      cec:	01 01 25 00 	.long 0x1012500
>      cf0:	00 01 06 00 	.long 0x10600
>      cf4:	1c 00 00 00 	mulli   r0,r0,0
>      cf8:	00 00 00 0e 	.long 0xe
>      cfc:	cc 00 00 00 	lfdu    f0,0(0)
>      d00:	00 00 00 0e 	.long 0xe
>      d04:	dc 00 00 0d 	stfdu   f0,13(0)
>      d08:	22 2d 00 00 	subfic  r17,r13,0
>      d0c:	03 ff 01 01 	.long 0x3ff0101
>      d10:	26 00 00 01 	dozi    r16,r0,1
>      d14:	06 2d 00 00 	.long 0x62d0000
>      d18:	00 b3 01 01 	.long 0xb30101
>      d1c:	26 00 00 01 	dozi    r16,r0,1
>      d20:	06 00 1c 00 	.long 0x6001c00
>      d24:	00 00 00 00 	.long 0x0
>      d28:	00 0e e4 00 	.long 0xee400
>      d2c:	00 00 00 00 	.long 0x0
>      d30:	00 0e f4 00 	.long 0xef400
>      d34:	00 0d 50 2d 	.long 0xd502d
>      d38:	00 00 03 ff 	.long 0x3ff
>      d3c:	01 01 2c 00 	.long 0x1012c00
>      d40:	00 01 06 2d 	.long 0x1062d
>      d44:	00 00 00 b3 	.long 0xb3
>      d48:	01 01 2c 00 	.long 0x1012c00
>      d4c:	00 01 06 00 	.long 0x10600
>      d50:	1c 00 00 00 	mulli   r0,r0,0
>      d54:	00 00 00 0f 	.long 0xf
>      d58:	0c 00 00 00 	twi     0,r0,0
>      d5c:	00 00 00 0f 	.long 0xf
>      d60:	1c 00 00 0d 	mulli   r0,r0,13
>      d64:	7e 2d 00 00 	cmpd    cr4,r13,r0
>      d68:	03 ff 01 01 	.long 0x3ff0101
>      d6c:	34 00 00 01 	addic.  r0,r0,1
>      d70:	06 2d 00 00 	.long 0x62d0000
>      d74:	00 b3 01 01 	.long 0xb30101
>      d78:	34 00 00 01 	addic.  r0,r0,1
>      d7c:	06 00 1c 00 	.long 0x6001c00
>      d80:	00 00 00 00 	.long 0x0
>      d84:	00 10 38 00 	.long 0x103800
>      d88:	00 00 00 00 	.long 0x0
>      d8c:	00 10 5c 00 	.long 0x105c00
>      d90:	00 0d be 24 	.long 0xdbe24
>      d94:	00 00 00 00 	.long 0x0
>      d98:	00 00 10 38 	.long 0x1038
>      d9c:	00 00 00 00 	.long 0x0
>      da0:	00 00 10 5c 	.long 0x105c
>      da4:	2d 00 00 03 	cmpwi   cr2,r0,3
>      da8:	04 01 01 50 	.long 0x4010150
>      dac:	00 00 05 0d 	.long 0x50d
>      db0:	2d 00 00 02 	cmpwi   cr2,r0,2
>      db4:	b0 01 01 50 	sth     r0,336(r1)
>      db8:	00 00 00 57 	.long 0x57
>      dbc:	00 00 1c 00 	.long 0x1c00
>      dc0:	00 00 00 00 	.long 0x0
>      dc4:	00 10 84 00 	.long 0x108400
>      dc8:	00 00 00 00 	.long 0x0
>      dcc:	00 10 94 00 	.long 0x109400
>      dd0:	00 0d ec 2d 	.long 0xdec2d
>      dd4:	00 00 03 ff 	.long 0x3ff
>      dd8:	01 01 52 00 	.long 0x1015200
>      ddc:	00 01 06 2d 	.long 0x1062d
>      de0:	00 00 00 b3 	.long 0xb3
>      de4:	01 01 52 00 	.long 0x1015200
>      de8:	00 01 06 00 	.long 0x10600
>      dec:	24 00 00 00 	dozi    r0,r0,0
>      df0:	00 00 00 10 	.long 0x10
>      df4:	d8 00 00 00 	stfd    f0,0(0)
>      df8:	00 00 00 10 	.long 0x10
>      dfc:	e8 2d 00 00 	ld      r1,0(r13)
>      e00:	03 ff 01 01 	.long 0x3ff0101
>      e04:	2d 00 00 01 	cmpwi   cr2,r0,1
>      e08:	06 2d 00 00 	.long 0x62d0000
>      e0c:	00 b3 01 01 	.long 0xb30101
>      e10:	2d 00 00 01 	cmpwi   cr2,r0,1
>      e14:	06 00 00 07 	.long 0x6000007
>      e18:	08 00 00 0e 	tdi     0,r0,14
>      e1c:	1d 07 08 00 	mulli   r8,r7,2048
>      e20:	00 02 45 25 	.long 0x24525
>      e24:	00 00 00 e1 	.long 0xe1
>      e28:	01 01 78 01 	.long 0x1017801
>      e2c:	00 00 00 00 	.long 0x0
>      e30:	00 00 11 00 	.long 0x1100
>      e34:	00 00 00 00 	.long 0x0
>      e38:	00 00 17 4c 	.long 0x174c
>      e3c:	00 00 0b 4c 	.long 0xb4c
>      e40:	00 00 10 4d 	.long 0x104d
>      e44:	28 64 6e 00 	cmpldi  r4,28160
>      e48:	01 01 79 00 	.long 0x1017900
>      e4c:	00 00 ee 00 	.long 0xee00
>      e50:	00 0b 84 2e 	.long 0xb842e
>      e54:	64 70 00 01 	oris    r16,r3,1
>      e58:	01 7a 00 00 	.long 0x17a0000
>      e5c:	0e 1d 2f 00 	twlti   r29,12032
>      e60:	00 05 05 01 	.long 0x50501
>      e64:	01 7b 00 00 	.long 0x17b0000
>      e68:	00 ee 00 00 	.long 0xee0000
>      e6c:	0b cd 2f 00 	tdi     30,r13,12032
>      e70:	00 06 af 01 	.long 0x6af01
>      e74:	01 7c 00 00 	.long 0x17c0000
>      e78:	0e 17 00 00 	twlti   r23,0
>      e7c:	0c 16 2f 00 	twi     0,r22,12032
>      e80:	00 06 a7 01 	.long 0x6a701
>      e84:	01 7d 00 00 	.long 0x17d0000
>      e88:	00 57 00 00 	.long 0x570000
>      e8c:	0c 50 28 69 	twllti  r16,10345
>      e90:	00 01 01 7d 	.long 0x1017d
>      e94:	00 00 00 57 	.long 0x57
>      e98:	00 00 0c 86 	.long 0xc86
>      e9c:	29 00 00 01 	cmplwi  cr2,r0,1
>      ea0:	a8 01 01 7e 	lha     r0,382(r1)
>      ea4:	00 00 01 48 	.long 0x148
>      ea8:	03 91 98 76 	.long 0x3919876
>      eac:	1c 00 00 00 	mulli   r0,r0,0
>      eb0:	00 00 00 12 	.long 0x12
>      eb4:	34 00 00 00 	addic.  r0,r0,0
>      eb8:	00 00 00 12 	.long 0x12
>      ebc:	44 00 00 0e 	sc      
>      ec0:	da 2d 00 00 	stfd    f17,0(r13)
>      ec4:	03 ff 01 01 	.long 0x3ff0101
>      ec8:	b5 00 00 01 	sthu    r8,1(0)
>      ecc:	06 2d 00 00 	.long 0x62d0000
>      ed0:	00 b3 01 01 	.long 0xb30101
>      ed4:	b5 00 00 01 	sthu    r8,1(0)
>      ed8:	06 00 2a 00 	.long 0x6002a00
>      edc:	00 06 0c 00 	.long 0x60c00
>      ee0:	00 00 90 01 	.long 0x9001
>      ee4:	01 f3 00 00 	.long 0x1f30000
>      ee8:	0e f5 2b 00 	twi     23,r21,11008
>      eec:	00 06 2b 2b 	.long 0x62b2b
>      ef0:	00 00 06 1f 	.long 0x61f
>      ef4:	00 2c 00 00 	.long 0x2c0000
>      ef8:	00 d0 00 00 	.long 0xd00000
>      efc:	0f 1d 21 00 	twnei   r29,8448
>      f00:	00 01 00 2d 	.long 0x1002d
>      f04:	00 00 03 04 	.long 0x304
>      f08:	01 01 f0 00 	.long 0x101f000
>      f0c:	00 05 0d 2d 	.long 0x50d2d
>      f10:	00 00 02 b0 	.long 0x2b0
>      f14:	01 01 f0 00 	.long 0x101f000
>      f18:	00 00 57 00 	.long 0x5700
>      f1c:	00 1c 00 00 	.long 0x1c0000
>      f20:	00 00 00 00 	.long 0x0
>      f24:	12 f0 00 00 	vaddubm v23,v16,v0
>      f28:	00 00 00 00 	.long 0x0
>      f2c:	12 f8 00 00 	vaddubm v23,v24,v0
>      f30:	0f 5d 24 00 	twi     26,r29,9216
>      f34:	00 00 00 00 	.long 0x0
>      f38:	00 12 f0 00 	.long 0x12f000
>      f3c:	00 00 00 00 	.long 0x0
>      f40:	00 12 f8 2d 	.long 0x12f82d
>      f44:	00 00 03 04 	.long 0x304
>      f48:	01 01 f0 00 	.long 0x101f000
>      f4c:	00 05 0d 2d 	.long 0x50d2d
>      f50:	00 00 02 b0 	.long 0x2b0
>      f54:	01 01 f0 00 	.long 0x101f000
>      f58:	00 00 57 00 	.long 0x5700
>      f5c:	00 2c 00 00 	.long 0x2c0000
>      f60:	01 30 00 00 	.long 0x1300000
>      f64:	0f f0 2f 00 	twi     31,r16,12032
>      f68:	00 03 39 01 	.long 0x33901
>      f6c:	01 b6 00 00 	.long 0x1b60000
>      f70:	01 06 00 00 	.long 0x1060000
>      f74:	0c bc 2d 00 	twlgei  r28,11520
>      f78:	00 03 c3 01 	.long 0x3c301
>      f7c:	01 b7 00 00 	.long 0x1b70000
>      f80:	00 ee 21 00 	.long 0xee2100
>      f84:	00 01 60 29 	.long 0x16029
>      f88:	00 00 03 9a 	.long 0x39a
>      f8c:	01 01 c4 00 	.long 0x101c400
>      f90:	00 09 92 03 	.long 0x99203
>      f94:	91 a8 77 28 	stw     r13,30504(r8)
>      f98:	66 70 00 01 	oris    r16,r19,1
>      f9c:	01 c5 00 00 	.long 0x1c50000
>      fa0:	06 78 00 00 	.long 0x6780000
>      fa4:	0d af 2f 00 	twi     13,r15,12032
>      fa8:	00 06 33 01 	.long 0x63301
>      fac:	01 c6 00 00 	.long 0x1c60000
>      fb0:	00 ee 00 00 	.long 0xee0000
>      fb4:	0d f8 2f 00 	twi     15,r24,12032
>      fb8:	00 04 e7 01 	.long 0x4e701
>      fbc:	01 c7 00 00 	.long 0x1c70000
>      fc0:	00 ee 00 00 	.long 0xee0000
>      fc4:	0e 9b 30 00 	twlei   r27,12288
>      fc8:	00 06 3e 00 	.long 0x63e00
>      fcc:	00 00 00 00 	.long 0x0
>      fd0:	00 14 14 00 	.long 0x141400
>      fd4:	00 00 00 00 	.long 0x0
>      fd8:	00 14 2c 01 	.long 0x142c01
>      fdc:	01 cd 2b 00 	.long 0x1cd2b00
>      fe0:	00 06 66 2b 	.long 0x6662b
>      fe4:	00 00 06 5b 	.long 0x65b
>      fe8:	2b 00 00 06 	cmplwi  cr6,r0,6
>      fec:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>      ff0:	1c 00 00 00 	mulli   r0,r0,0
>      ff4:	00 00 00 14 	.long 0x14
>      ff8:	e0 00 00 00 	.long 0xe0000000
>      ffc:	00 00 00 14 	.long 0x14
>     1000:	f4 00 00 10 	.long 0xf4000010
>     1004:	1e 2d 00 00 	mulli   r17,r13,0
>     1008:	03 ff 01 01 	.long 0x3ff0101
>     100c:	97 00 00 01 	stwu    r24,1(0)
>     1010:	06 2d 00 00 	.long 0x62d0000
>     1014:	00 b3 01 01 	.long 0xb30101
>     1018:	97 00 00 01 	stwu    r24,1(0)
>     101c:	06 00 24 00 	.long 0x6002400
>     1020:	00 00 00 00 	.long 0x0
>     1024:	00 14 fc 00 	.long 0x14fc00
>     1028:	00 00 00 00 	.long 0x0
>     102c:	00 15 d0 2e 	.long 0x15d02e
>     1030:	6c 65 6e 00 	xoris   r5,r3,28160
>     1034:	01 01 98 00 	.long 0x1019800
>     1038:	00 00 57 2f 	.long 0x572f
>     103c:	00 00 01 18 	.long 0x118
>     1040:	01 01 99 00 	.long 0x1019900
>     1044:	00 01 3a 00 	.long 0x13a00
>     1048:	00 0e d1 00 	.long 0xed100
>     104c:	00 31 01 00 	.long 0x310100
>     1050:	00 02 6a 01 	.long 0x26a01
>     1054:	02 01 01 00 	.long 0x2010100
>     1058:	00 00 57 00 	.long 0x5700
>     105c:	00 00 00 00 	.long 0x0
>     1060:	00 17 50 00 	.long 0x175000
>     1064:	00 00 00 00 	.long 0x0
>     1068:	00 19 8c 00 	.long 0x198c00
>     106c:	00 0f 20 00 	.long 0xf2000
>     1070:	00 10 db 27 	.long 0x10db27
>     1074:	00 00 01 3a 	.long 0x13a
>     1078:	01 02 00 00 	.long 0x1020000
>     107c:	00 05 55 00 	.long 0x55500
>     1080:	00 0f 58 27 	.long 0xf5827
>     1084:	00 00 06 60 	.long 0x660
>     1088:	01 02 00 00 	.long 0x1020000
>     108c:	00 10 db 00 	.long 0x10db00
>     1090:	00 0f 8e 27 	.long 0xf8e27
>     1094:	00 00 05 44 	.long 0x544
>     1098:	01 02 00 00 	.long 0x1020000
>     109c:	00 00 ee 00 	.long 0xee00
>     10a0:	00 0f c4 28 	.long 0xfc428
>     10a4:	6c 65 6e 00 	xoris   r5,r3,28160
>     10a8:	01 02 02 00 	.long 0x1020200
>     10ac:	00 00 42 00 	.long 0x4200
>     10b0:	00 0f fa 2f 	.long 0xffa2f
>     10b4:	00 00 06 99 	.long 0x699
>     10b8:	01 02 03 00 	.long 0x1020300
>     10bc:	00 00 42 00 	.long 0x4200
>     10c0:	00 10 30 2e 	.long 0x10302e
>     10c4:	62 75 66 00 	ori     r21,r19,26112
>     10c8:	01 02 04 00 	.long 0x1020400
>     10cc:	00 00 ee 2e 	.long 0xee2e
>     10d0:	6d 65 00 01 	xoris   r5,r11,1
>     10d4:	02 05 00 00 	.long 0x2050000
>     10d8:	00 42 00 07 	.long 0x420007
>     10dc:	08 00 00 00 	tdi     0,r0,0
>     10e0:	fb 32 00 00 	std     r25,0(r18)
>     10e4:	00 2c 01 01 	.long 0x2c0101
>     10e8:	62 01 00 00 	ori     r1,r16,0
>     10ec:	00 57 00 00 	.long 0x570000
>     10f0:	00 00 00 00 	.long 0x0
>     10f4:	19 90 00 00 	.long 0x19900000
>     10f8:	00 00 00 00 	.long 0x0
>     10fc:	1a 50 00 00 	.long 0x1a500000
>     1100:	10 53 00 00 	vaddubm v2,v19,v0
>     1104:	11 71 27 00 	vsubsbs v11,v17,v4
>     1108:	00 05 f6 01 	.long 0x5f601
>     110c:	01 61 00 00 	.long 0x1610000
>     1110:	02 b4 00 00 	.long 0x2b40000
>     1114:	10 8b 27 00 	vsubsbs v4,v11,v4
>     1118:	00 05 fe 01 	.long 0x5fe01
>     111c:	01 61 00 00 	.long 0x1610000
>     1120:	02 b4 00 00 	.long 0x2b40000
>     1124:	10 ae 2f 00 	vsubsbs v5,v14,v5
>     1128:	00 01 cd 01 	.long 0x1cd01
>     112c:	01 63 00 00 	.long 0x1630000
>     1130:	00 ee 00 00 	.long 0xee0000
>     1134:	10 d1 2f 00 	vsubsbs v6,v17,v5
>     1138:	00 01 e4 01 	.long 0x1e401
>     113c:	01 64 00 00 	.long 0x1640000
>     1140:	00 ee 00 00 	.long 0xee0000
>     1144:	10 f4 24 00 	vsububm v7,v20,v4
>     1148:	00 00 00 00 	.long 0x0
>     114c:	00 1a 10 00 	.long 0x1a1000
>     1150:	00 00 00 00 	.long 0x0
>     1154:	00 1a 24 2d 	.long 0x1a242d
>     1158:	00 00 03 ff 	.long 0x3ff
>     115c:	01 01 70 00 	.long 0x1017000
>     1160:	00 01 06 2d 	.long 0x1062d
>     1164:	00 00 00 b3 	.long 0xb3
>     1168:	01 01 70 00 	.long 0x1017000
>     116c:	00 01 06 00 	.long 0x10600
>     1170:	00 1e 00 00 	.long 0x1e0000
>     1174:	02 d1 01 2a 	.long 0x2d1012a
>     1178:	00 00 09 92 	.long 0x992
>     117c:	09 03 00 00 	tdgti   r3,0
>     1180:	00 00 00 00 	.long 0x0
>     1184:	50 18 1e 00 	rlwimi  r24,r0,3,24,0
>     1188:	00 04 08 01 	.long 0x40801
>     118c:	2a 00 00 00 	cmplwi  cr4,r0,0
>     1190:	ee 09 03 00 	.long 0xee090300
>     1194:	00 00 00 00 	.long 0x0
>     1198:	00 54 30 0b 	.long 0x54300b
>     119c:	00 00 00 f4 	.long 0xf4
>     11a0:	00 00 11 ac 	.long 0x11ac
>     11a4:	23 00 00 00 	subfic  r24,r0,0
>     11a8:	bd 3f ff 00 	stmw    r9,-256(r31)
>     11ac:	1e 00 00 00 	mulli   r16,r0,0
>     11b0:	d7 01 2b 00 	stfsu   f24,11008(r1)
>     11b4:	00 11 9b 09 	.long 0x119b09
>     11b8:	03 00 00 00 	.long 0x3000000
>     11bc:	00 00 00 10 	.long 0x10
>     11c0:	18 0b 00 00 	.long 0x180b0000
>     11c4:	00 3b 00 00 	.long 0x3b0000
>     11c8:	11 d2 23 00 	vaddsbs v14,v18,v4
>     11cc:	00 00 bd ff 	.long 0xbdff
>     11d0:	ff 00 1e 00 	.long 0xff001e00
>     11d4:	00 04 4e 01 	.long 0x44e01
>     11d8:	2c 00 00 11 	cmpwi   r0,17
>     11dc:	c1 09 03 00 	lfs     f8,768(r9)
>     11e0:	00 00 00 00 	.long 0x0
>     11e4:	00 54 38 1f 	.long 0x54381f
>     11e8:	64 74 00 01 	oris    r20,r3,1
>     11ec:	2c 00 00 08 	cmpwi   r0,8
>     11f0:	62 09 03 00 	ori     r9,r16,768
>     11f4:	00 00 00 00 	.long 0x0
>     11f8:	00 54 18 0b 	.long 0x54180b
>     11fc:	00 00 01 3a 	.long 0x13a
>     1200:	00 00 12 0c 	.long 0x120c
>     1204:	23 00 00 00 	subfic  r24,r0,0
>     1208:	bd 01 ff 00 	stmw    r8,-256(r1)
>     120c:	1e 00 00 06 	mulli   r16,r0,6
>     1210:	9e 01 2d 00 	stbu    r16,11520(r1)
>     1214:	00 11 fb 09 	.long 0x11fb09
>     1218:	03 00 00 00 	.long 0x3000000
>     121c:	00 00 00 00 	.long 0x0
>     1220:	00 1e 00 00 	.long 0x1e0000
>     1224:	02 f8 01 2f 	.long 0x2f8012f
>     1228:	00 00 00 57 	.long 0x57
>     122c:	09 03 00 00 	tdgti   r3,0
>     1230:	00 00 00 00 	.long 0x0
>     1234:	54 20 0b 00 	rlwinm  r0,r1,1,12,0
>     1238:	00 00 f4 00 	.long 0xf400
>     123c:	00 12 47 23 	.long 0x124723
>     1240:	00 00 00 bd 	.long 0xbd
>     1244:	01 ff 00 1e 	.long 0x1ff001e
>     1248:	00 00 02 be 	.long 0x2be
>     124c:	01 30 00 00 	.long 0x1300000
>     1250:	12 36 09 03 	.long 0x12360903
> 	...
>     125c:	1e 00 00 00 	mulli   r16,r0,0
>     1260:	95 01 31 00 	stwu    r8,12544(r1)
>     1264:	00 08 62 09 	.long 0x86209
>     1268:	03 00 00 00 	.long 0x3000000
>     126c:	00 00 00 54 	.long 0x54
>     1270:	28 0b 00 00 	cmplwi  r11,0
>     1274:	05 5b 00 00 	.long 0x55b0000
>     1278:	12 81 0c 00 	vsububm v20,v1,v1
>     127c:	00 00 bd 00 	.long 0xbd00
>     1280:	00 1f 62 62 	.long 0x1f6262
>     1284:	00 01 34 00 	.long 0x13400
>     1288:	00 12 71 09 	.long 0x127109
>     128c:	03 00 00 00 	.long 0x3000000
>     1290:	00 00 04 54 	.long 0x454
>     1294:	38 33 00 00 	addi    r1,r19,0
>     1298:	02 18 0a 91 	.long 0x2180a91
>     129c:	00 00 04 d6 	.long 0x4d6
>     12a0:	01 01 33 00 	.long 0x1013300
>     12a4:	00 03 2a 0a 	.long 0x32a0a
>     12a8:	92 00 00 04 	stw     r16,4(0)
>     12ac:	d6 01 01 33 	stfsu   f16,307(r1)
>     12b0:	00 00 05 ef 	.long 0x5ef
>     12b4:	0a 93 00 00 	tdlei   r19,0
>     12b8:	04 d6 01 01 	.long 0x4d60101
>     12bc:	33 00 00 03 	addic   r24,r0,3
>     12c0:	1e 0e 14 00 	mulli   r16,r14,5120
>     12c4:	00 05 02 01 	.long 0x50201
>     12c8:	01 33 00 00 	.long 0x1330000
>     12cc:	03 51 0e 14 	.long 0x3510e14
>     12d0:	00 00 05 02 	.long 0x502
>     12d4:	01 01 33 00 	.long 0x1013300
>     12d8:	00 01 b0 0e 	.long 0x1b00e
>     12dc:	16 00 00 00 	.long 0x16000000
>     12e0:	2d 01 01 33 	cmpwi   cr2,r1,307
>     12e4:	00 00 05 99 	.long 0x599
>     12e8:	01 33 00 00 	.long 0x1330000
>     12ec:	06 01 01 01 	.long 0x6010101
>     12f0:	34 00 00 06 	addic.  r0,r0,6
>     12f4:	0e 0f 21 00 	twlti   r15,8448
>     12f8:	00 05 02 01 	.long 0x50201
>     12fc:	09 03 00 00 	tdgti   r3,0
>     1300:	00 00 00 00 	.long 0x0
>     1304:	00 00 34 00 	.long 0x3400
>     1308:	00 04 ca 0f 	.long 0x4ca0f
>     130c:	22 00 00 00 	subfic  r16,r0,0
>     1310:	3b 01 09 03 	addi    r24,r1,2307
> 	...
> 
> Disassembly of section .debug_line:
> 
> 0000000000000000 <.debug_line>:
>    0:	00 00 04 95 	.long 0x495
>    4:	00 02 00 00 	.long 0x20000
>    8:	01 50 04 01 	.long 0x1500401
>    c:	fb 0e 0d 00 	std     r24,3328(r14)
>   10:	01 01 01 01 	.long 0x1010101
>   14:	00 00 00 01 	.long 0x1
>   18:	00 00 01 6b 	.long 0x16b
>   1c:	65 78 65 63 	oris    r24,r11,25955
>   20:	2f 61 72 63 	cmpdi   cr6,r1,29283
>   24:	68 2f 70 70 	xori    r15,r1,28784
>   28:	63 36 34 00 	ori     r22,r25,13312
>   2c:	2f 75 73 72 	cmpdi   cr6,r21,29554
>   30:	2f 69 6e 63 	cmpdi   cr6,r9,28259
>   34:	6c 75 64 65 	xoris   r21,r3,25701
>   38:	2f 73 79 73 	cmpdi   cr6,r19,31091
>   3c:	00 2f 75 73 	.long 0x2f7573
>   40:	72 2f 69 6e 	andi.   r15,r17,26990
>   44:	63 6c 75 64 	ori     r12,r27,30052
>   48:	65 2f 62 69 	oris    r15,r9,25193
>   4c:	74 73 00 2f 	andis.  r19,r3,47
>   50:	75 73 72 2f 	andis.  r19,r11,29231
>   54:	6c 69 62 36 	xoris   r9,r3,25142
>   58:	34 2f 67 63 	addic.  r1,r15,26467
>   5c:	63 2f 70 6f 	ori     r15,r25,28783
>   60:	77 65 72 70 	andis.  r5,r27,29296
>   64:	63 36 34 2d 	ori     r22,r25,13357
>   68:	73 75 73 65 	andi.   r21,r27,29541
>   6c:	2d 6c 69 6e 	cmpdi   cr2,r12,26990
>   70:	75 78 2f 34 	andis.  r24,r11,12084
>   74:	2e 33 2f 69 	cmpdi   cr4,r19,12137
>   78:	6e 63 6c 75 	xoris   r3,r19,27765
>   7c:	64 65 00 2f 	oris    r5,r3,47
>   80:	75 73 72 2f 	andis.  r19,r11,29231
>   84:	69 6e 63 6c 	xori    r14,r11,25452
>   88:	75 64 65 00 	andis.  r4,r11,25856
>   8c:	6b 65 78 65 	xori    r5,r27,30821
>   90:	63 2f 61 72 	ori     r15,r25,24946
>   94:	63 68 2f 70 	ori     r8,r27,12144
>   98:	70 63 36 34 	andi.   r3,r3,13876
>   9c:	2f 2e 2e 2f 	cmpdi   cr6,r14,11823
>   a0:	2e 2e 00 00 	cmpdi   cr4,r14,0
>   a4:	66 73 32 64 	oris    r19,r19,12900
>   a8:	74 2e 63 00 	andis.  r14,r1,25344
>   ac:	01 00 00 73 	.long 0x1000073
>   b0:	74 61 74 2e 	andis.  r1,r3,29742
>   b4:	68 00 02 00 	xori    r0,r0,512
>   b8:	00 73 74 64 	.long 0x737464
>   bc:	69 6f 2e 68 	xori    r15,r11,11880
>   c0:	00 03 00 00 	.long 0x30000
>   c4:	74 79 70 65 	andis.  r25,r3,28773
>   c8:	73 2e 68 00 	andi.   r14,r25,26624
>   cc:	03 00 00 74 	.long 0x3000074
>   d0:	79 70 65 73 	rldcr.  r16,r11,r12,53
>   d4:	2e 68 00 02 	cmpdi   cr4,r8,2
>   d8:	00 00 73 74 	.long 0x7374
>   dc:	64 64 65 66 	oris    r4,r3,25958
>   e0:	2e 68 00 04 	cmpdi   cr4,r8,4
>   e4:	00 00 74 69 	.long 0x7469
>   e8:	6d 65 2e 68 	xoris   r5,r11,11880
>   ec:	00 05 00 00 	.long 0x50000
>   f0:	73 74 61 74 	andi.   r20,r27,24948
>   f4:	2e 68 00 03 	cmpdi   cr4,r8,3
>   f8:	00 00 64 69 	.long 0x6469
>   fc:	72 65 6e 74 	andi.   r5,r19,28276
>  100:	2e 68 00 03 	cmpdi   cr4,r8,3
>  104:	00 00 73 74 	.long 0x7374
>  108:	64 69 6f 2e 	oris    r9,r3,28462
>  10c:	68 00 05 00 	xori    r0,r0,1280
>  110:	00 6c 69 62 	.long 0x6c6962
>  114:	69 6f 2e 68 	xori    r15,r11,11880
>  118:	00 05 00 00 	.long 0x50000
>  11c:	73 74 64 69 	andi.   r20,r27,25705
>  120:	6e 74 2e 68 	xoris   r20,r19,11880
>  124:	00 05 00 00 	.long 0x50000
>  128:	6b 65 78 65 	xori    r5,r27,30821
>  12c:	63 2e 68 00 	ori     r14,r25,26624
>  130:	06 00 00 6b 	.long 0x600006b
>  134:	65 78 65 63 	oris    r24,r11,25955
>  138:	2d 70 70 63 	cmpdi   cr2,r16,28771
>  13c:	36 34 2e 68 	addic.  r17,r20,11880
>  140:	00 01 00 00 	.long 0x10000
>  144:	63 72 61 73 	ori     r18,r27,24947
>  148:	68 64 75 6d 	xori    r4,r3,30061
>  14c:	70 2d 70 70 	andi.   r13,r1,28784
>  150:	63 36 34 2e 	ori     r22,r25,13358
>  154:	68 00 01 00 	xori    r0,r0,256
>  158:	00 00 00 09 	.long 0x9
>  15c:	02 00 00 00 	.long 0x2000000
>  160:	00 00 00 00 	.long 0x0
>  164:	00 03 36 01 	.long 0x33601
>  168:	69 1d 2e 31 	xori    r29,r8,11825
>  16c:	af 4b 4c 21 	lhau    r26,19489(r11)
>  170:	21 21 1d 22 	subfic  r9,r1,7458
>  174:	1f 21 21 03 	mulli   r25,r1,8451
>  178:	77 82 03 0d 	andis.  r2,r28,781
>  17c:	9e 31 1d 66 	stbu    r17,7526(r17)
>  180:	23 30 03 0b 	subfic  r25,r16,779
>  184:	66 32 68 6a 	oris    r18,r17,26730
>  188:	40 03 65 90 	bdnzf-  so,6718 <dtstruct+0x12e0>
>  18c:	9f 69 6d 6d 	stbu    r27,28013(r9)
>  190:	4c 2f 26 03 	.long 0x4c2f2603
>  194:	7a 20 34 9b 	.long 0x7a20349b
>  198:	2f 30 03 6b 	cmpdi   cr6,r16,875
>  19c:	82 68 65 49 	lwz     r19,25929(r8)
>  1a0:	31 9f 40 67 	addic   r12,r31,16487
>  1a4:	03 13 74 69 	.long 0x3137469
>  1a8:	1d 2e 23 3d 	mulli   r9,r14,9021
>  1ac:	1f 68 56 59 	mulli   r27,r8,22105
>  1b0:	67 1f 03 0b 	oris    r31,r24,779
>  1b4:	20 03 74 9e 	subfic  r0,r3,29854
>  1b8:	26 85 4d a7 	dozi    r20,r5,19879
>  1bc:	03 79 58 03 	.long 0x3795803
>  1c0:	d3 00 74 6d 	stfs    f24,29805(0)
>  1c4:	03 79 20 2e 	.long 0x379202e
>  1c8:	35 67 4b 21 	addic.  r11,r7,19233
>  1cc:	1e 22 1f 21 	mulli   r17,r2,7969
>  1d0:	2f 69 32 77 	cmpdi   cr6,r9,12919
>  1d4:	83 a1 5d 1e 	lwz     r29,23838(r1)
>  1d8:	22 bd 2f 2f 	subfic  r21,r29,12079
>  1dc:	1f 2f 1f 21 	mulli   r25,r15,7969
>  1e0:	51 03 74 20 	rlwimi  r3,r8,14,16,16
>  1e4:	2f 30 1f 21 	cmpdi   cr6,r16,7969
>  1e8:	23 87 21 1f 	subfic  r28,r7,8479
>  1ec:	3d 1f 21 03 	addis   r8,r31,8451
>  1f0:	74 74 03 0c 	andis.  r20,r3,780
>  1f4:	20 03 74 2e 	subfic  r0,r3,29742
>  1f8:	03 10 2e 03 	.long 0x3102e03
>  1fc:	0e 2e 03 72 	twi     17,r14,882
>  200:	20 03 10 20 	subfic  r0,r3,4128
>  204:	03 70 20 03 	.long 0x3702003
>  208:	0e 20 21 1f 	twi     17,r0,8479
>  20c:	03 72 2e 03 	.long 0x3722e03
>  210:	0f 20 03 71 	twi     25,r0,881
>  214:	20 03 0f 2e 	subfic  r0,r3,3886
>  218:	03 71 20 03 	.long 0x3712003
>  21c:	10 20 03 70 	.long 0x10200370
>  220:	20 03 10 20 	subfic  r0,r3,4128
>  224:	21 1f 2f 22 	subfic  r8,r31,12066
>  228:	59 3d 03 79 	rlmi.   r29,r9,r0,13,28
>  22c:	90 03 78 20 	stw     r0,30752(r3)
>  230:	03 09 20 21 	.long 0x3092021
>  234:	03 77 3c 1f 	.long 0x3773c1f
>  238:	28 21 1f 2f 	cmpldi  r1,7983
>  23c:	2f 4b 2f 21 	cmpwi   cr6,r11,12065
>  240:	2d 21 3d 03 	cmpdi   cr2,r1,15619
>  244:	58 58 5c 1e 	rlmi    r24,r2,r11,16,15
>  248:	22 03 71 58 	subfic  r16,r3,29016
>  24c:	3f 75 03 a9 	addis   r27,r21,937
>  250:	7f d6 ec 03 	.long 0x7fd6ec03
>  254:	78 20 28 67 	rldicr. r0,r1,37,33
>  258:	4b 21 1e 22 	ba      ff211e20 <bb+0xff1cc9e8>
>  25c:	1f 21 2f 03 	mulli   r25,r1,12035
>  260:	35 58 03 4e 	addic.  r10,r24,846
>  264:	f2 79 59 49 	.long 0xf2795949
>  268:	21 1f 21 03 	subfic  r8,r31,8451
>  26c:	0c 2e 03 74 	twlgti  r14,884
>  270:	20 40 21 21 	subfic  r2,r0,8481
>  274:	1f 21 34 1d 	mulli   r25,r1,13341
>  278:	23 1d 23 a1 	subfic  r24,r29,9121
>  27c:	2f 2f 21 1e 	cmpdi   cr6,r15,8478
>  280:	30 1f 1f 21 	addic   r0,r31,7969
>  284:	03 09 4a 03 	.long 0x3094a03
>  288:	72 20 2f 30 	andi.   r0,r17,12080
>  28c:	1f 21 24 79 	mulli   r25,r1,9337
>  290:	21 1f 3d 1f 	subfic  r8,r31,15647
>  294:	21 4b 1f 2f 	subfic  r10,r11,7983
>  298:	03 72 20 03 	.long 0x3722003
>  29c:	0d 20 21 1f 	twi     9,r0,8479
>  2a0:	03 73 20 03 	.long 0x3732003
>  2a4:	73 4a 03 1f 	andi.   r10,r26,799
>  2a8:	2e 03 61 20 	cmpwi   cr4,r3,24864
>  2ac:	03 1f 20 03 	.long 0x31f2003
>  2b0:	61 20 03 1f 	ori     r0,r9,799
>  2b4:	20 03 61 20 	subfic  r0,r3,24864
>  2b8:	21 3b 21 4b 	subfic  r9,r27,8523
>  2bc:	a1 21 21 1f 	lhz     r9,8479(r1)
>  2c0:	21 59 03 1e 	subfic  r10,r25,798
>  2c4:	4a 03 5a 20 	b       fffffffffe035ce4 <bb+0xfffffffffdff08ac>
>  2c8:	03 28 20 03 	.long 0x3282003
>  2cc:	58 20 03 26 	rlmi    r0,r1,r0,12,19
>  2d0:	20 21 1f 03 	subfic  r1,r1,7939
>  2d4:	5a 2e 03 27 	rlmi.   r14,r17,r0,12,19
>  2d8:	20 03 59 20 	subfic  r0,r3,22816
>  2dc:	03 27 2e 03 	.long 0x3272e03
>  2e0:	59 20 03 28 	rlmi    r0,r9,r0,12,20
>  2e4:	20 03 58 20 	subfic  r0,r3,22560
>  2e8:	03 28 20 21 	.long 0x3282021
>  2ec:	1f 2f 3d 2f 	mulli   r25,r15,15663
>  2f0:	59 21 1f 2f 	rlmi.   r1,r9,r3,28,23
>  2f4:	03 4f e4 03 	.long 0x34fe403
>  2f8:	2a ac 22 3b 	cmpldi  cr5,r12,8763
>  2fc:	1f 3d 2f 03 	mulli   r25,r29,12035
>  300:	cf 00 9e 25 	lfdu    f24,-25051(0)
>  304:	1b 08 20 33 	.long 0x1b082033
>  308:	03 29 2e 03 	.long 0x3292e03
>  30c:	57 20 04 02 	rlwinm  r0,r25,0,16,1
>  310:	03 be 01 2e 	.long 0x3be012e
>  314:	04 01 03 eb 	.long 0x40103eb
>  318:	7e 20 25 04 	.long 0x7e202504
>  31c:	02 03 90 01 	.long 0x2039001
>  320:	3c 04 01 03 	addis   r0,r4,259
>  324:	c9 7e 90 32 	lfd     f11,-28622(r30)
>  328:	03 0a 3c 03 	.long 0x30a3c03
>  32c:	6b 66 59 21 	xori    r6,r27,22817
>  330:	5a a8 03 cb 	rlmi.   r8,r21,r0,15,5
>  334:	00 66 21 3b 	.long 0x66213b
>  338:	21 21 03 bb 	subfic  r9,r1,955
>  33c:	7f 08 58 a1 	.long 0x7f0858a1
>  340:	93 6d 67 49 	stw     r27,26441(r13)
>  344:	30 48 31 47 	addic   r2,r8,12615
>  348:	03 09 2e a6 	.long 0x3092ea6
>  34c:	69 4f 1e 25 	xori    r15,r10,7717
>  350:	1d 30 1f 21 	mulli   r9,r16,7969
>  354:	2f 30 1e 30 	cmpdi   cr6,r16,7728
>  358:	3d 30 4b 1f 	addis   r9,r16,19231
>  35c:	21 21 a1 75 	subfic  r9,r1,-24203
>  360:	a1 4c 83 f3 	lhz     r10,-31757(r12)
>  364:	3d a0 30 03 	lis     r13,12291
>  368:	57 90 49 03 	rlwinm. r16,r28,9,4,1
>  36c:	cc 00 66 6e 	lfdu    f0,26222(0)
>  370:	03 78 20 98 	.long 0x3782098
>  374:	59 75 4b 2d 	rlmi.   r21,r11,r9,12,22
>  378:	3e 3d 30 75 	addis   r17,r29,12405
>  37c:	1f 21 23 32 	mulli   r25,r1,9010
>  380:	5a 59 3e 2c 	rlmi    r25,r18,r7,24,22
>  384:	22 31 03 1e 	subfic  r17,r17,798
>  388:	58 03 36 66 	rlmi    r3,r0,r6,25,19
>  38c:	04 02 03 61 	.long 0x4020361
>  390:	20 04 01 03 	subfic  r0,r4,259
>  394:	1f 20 04 02 	mulli   r25,r0,1026
>  398:	03 61 2e 04 	.long 0x3612e04
>  39c:	01 03 27 74 	.long 0x1032774
>  3a0:	32 03 74 4a 	addic   r16,r3,29770
>  3a4:	4c 67 2b 23 	.long 0x4c672b23
>  3a8:	30 04 02 03 	addic   r0,r4,515
>  3ac:	5c 20 04 01 	rlwnm.  r0,r1,r0,16,0
>  3b0:	03 24 3c 99 	.long 0x3243c99
>  3b4:	03 10 74 4b 	.long 0x310744b
>  3b8:	1f 21 21 3d 	mulli   r25,r1,8509
>  3bc:	03 b8 7f 08 	.long 0x3b87f08
>  3c0:	20 23 4b 1f 	subfic  r1,r3,19231
>  3c4:	21 03 0f 20 	subfic  r8,r3,3872
>  3c8:	1d 23 2b 23 	mulli   r9,r3,11043
>  3cc:	2f 4b 1f 2f 	cmpwi   cr6,r11,7983
>  3d0:	1f 67 2f 04 	mulli   r27,r7,12036
>  3d4:	03 03 aa 7d 	.long 0x303aa7d
>  3d8:	2e 04 01 03 	cmpwi   cr4,r4,259
>  3dc:	d7 02 66 31 	stfsu   f24,26161(r2)
>  3e0:	59 2f 3d 1f 	rlmi.   r15,r9,r7,20,15
>  3e4:	21 30 5b 2f 	subfic  r9,r16,23343
>  3e8:	03 1b 66 a1 	.long 0x31b66a1
>  3ec:	4b 03 9f 7f 	bla     ff039f7c <bb+0xfeff4b44>
>  3f0:	2e 77 21 1f 	cmpdi   cr4,r23,8479
>  3f4:	22 1f 1f 2f 	subfic  r16,r31,7983
>  3f8:	2f 30 1e 30 	cmpdi   cr6,r16,7728
>  3fc:	21 30 34 03 	subfic  r9,r16,13315
>  400:	7a 20 24 21 	rldicl. r0,r17,4,48
>  404:	1c 23 21 3d 	mulli   r1,r3,8509
>  408:	22 1e 31 1d 	subfic  r16,r30,12573
>  40c:	22 4b 21 30 	subfic  r18,r11,8496
>  410:	3d 22 2c 30 	addis   r9,r2,11312
>  414:	03 5c 4a 7f 	.long 0x35c4a7f
>  418:	03 32 ac 4b 	.long 0x332ac4b
>  41c:	2f 30 4e 03 	cmpdi   cr6,r16,19971
>  420:	18 3c 59 40 	.long 0x183c5940
>  424:	2b 33 1e 2f 	cmpldi  cr6,r19,7727
>  428:	4b 4b 59 2f 	bla     ff4b592c <bb+0xff4704f4>
>  42c:	4b 30 3a 22 	ba      ff303a20 <bb+0xff2be5e8>
>  430:	1e 3e 03 6c 	mulli   r17,r30,876
>  434:	3c 03 7a 66 	addis   r0,r3,31334
>  438:	03 33 90 a6 	.long 0x33390a6
>  43c:	03 78 2e 44 	.long 0x3782e44
>  440:	23 1f 1e 84 	subfic  r24,r31,7812
>  444:	31 1e 1f 31 	addic   r8,r30,7985
>  448:	21 4c 21 33 	subfic  r10,r12,8499
>  44c:	22 03 79 20 	subfic  r16,r3,31008
>  450:	25 1b 27 1e 	dozi    r8,r27,10014
>  454:	1b 27 c1 1e 	.long 0x1b27c11e
>  458:	26 1e 3e 22 	dozi    r16,r30,15906
>  45c:	22 21 1c 23 	subfic  r17,r1,7203
>  460:	22 1f 1d 22 	subfic  r16,r31,7458
>  464:	1e 26 03 7a 	mulli   r17,r6,890
>  468:	20 34 30 3e 	subfic  r1,r20,12350
>  46c:	1f 1f 22 3d 	mulli   r24,r31,8765
>  470:	21 75 2f 2d 	subfic  r11,r21,12077
>  474:	21 1f 21 1f 	subfic  r8,r31,8479
>  478:	21 3d 2f 2d 	subfic  r9,r29,12077
>  47c:	21 1f 21 1f 	subfic  r8,r31,8479
>  480:	21 3e 30 2c 	subfic  r9,r30,12332
>  484:	3e 03 a8 7e 	addis   r16,r3,-22402
>  488:	d6 67 21 28 	stfsu   f19,8488(r7)
>  48c:	03 77 20 21 	.long 0x3772021
>  490:	28 08 4e 59 	cmplwi  r8,20057
>  494:	02 0b 00 01 	.long 0x20b0001
>  498:	Address 0x0000000000000498 is out of bounds.
> 
> 
> Disassembly of section .opd:
> 
> 0000000000000000 <reserve>:
> 	...
> 
> 0000000000000018 <checkprop>:
>   18:	00 00 00 00 	.long 0x0
>   1c:	00 00 00 e0 	.long 0xe0
> 	...
> 
> 0000000000000030 <propnum>:
>   30:	00 00 00 00 	.long 0x0
>   34:	00 00 03 30 	.long 0x330
> 	...
> 
> 0000000000000048 <add_usable_mem_property>:
>   48:	00 00 00 00 	.long 0x0
>   4c:	00 00 04 80 	.long 0x480
> 	...
> 
> 0000000000000060 <add_dyn_reconf_usable_mem_property>:
>   60:	00 00 00 00 	.long 0x0
>   64:	00 00 08 30 	.long 0x830
> 	...
> 
> 0000000000000078 <putprops>:
>   78:	00 00 00 00 	.long 0x0
>   7c:	00 00 0c 70 	.long 0xc70
> 	...
> 
> 0000000000000090 <putnode>:
>   90:	00 00 00 00 	.long 0x0
>   94:	00 00 11 00 	.long 0x1100
> 	...
> 
> 00000000000000a8 <create_flatten_tree>:
>   a8:	00 00 00 00 	.long 0x0
>   ac:	00 00 17 50 	.long 0x1750
> 	...
> 
> 00000000000000c0 <comparefunc>:
>   c0:	00 00 00 00 	.long 0x0
>   c4:	00 00 19 90 	.long 0x1990
> 	...
> 
> Disassembly of section .rodata.str1.8:
> 
> 0000000000000000 <.rodata.str1.8>:
>    0:	75 6e 72 65 	andis.  r14,r11,29285
>    4:	63 6f 76 65 	ori     r15,r27,30309
>    8:	72 61 62 6c 	andi.   r1,r19,25196
>    c:	65 20 65 72 	oris    r0,r9,25970
>   10:	72 6f 72 3a 	andi.   r15,r19,29242
>   14:	20 65 78 68 	subfic  r3,r5,30824
>   18:	61 73 75 74 	ori     r19,r11,30068
>   1c:	65 64 20 72 	oris    r4,r11,8306
>   20:	65 73 65 72 	oris    r19,r11,25970
>   24:	76 61 74 69 	andis.  r1,r19,29801
>   28:	6f 6e 20 6d 	xoris   r14,r27,8301
>   2c:	65 74 61 20 	oris    r20,r11,24864
>   30:	64 61 74 61 	oris    r1,r3,29793
>   34:	0a 00 00 00 	tdlti   r0,0
>   38:	75 6e 72 65 	andis.  r14,r11,29285
>   3c:	63 6f 76 65 	ori     r15,r27,30309
>   40:	72 61 62 6c 	andi.   r1,r19,25196
>   44:	65 20 65 72 	oris    r0,r9,25970
>   48:	72 6f 72 3a 	andi.   r15,r19,29242
>   4c:	20 6e 6f 20 	subfic  r3,r14,28448
>   50:	70 72 6f 70 	andi.   r18,r3,28528
>   54:	65 72 74 79 	oris    r18,r11,29817
>   58:	20 64 61 74 	subfic  r3,r4,24948
>   5c:	61 00 00 00 	ori     r0,r8,0
>   60:	6c 69 6e 75 	xoris   r9,r3,28277
>   64:	78 2c 72 74 	.long 0x782c7274
>   68:	61 73 2d 62 	ori     r19,r11,11618
>   6c:	61 73 65 00 	ori     r19,r11,25856
>   70:	6c 69 6e 75 	xoris   r9,r3,28277
>   74:	78 2c 74 63 	rldicl. r12,r1,46,49
>   78:	65 2d 62 61 	oris    r13,r9,25185
>   7c:	73 65 00 00 	andi.   r5,r27,0
>   80:	72 74 61 73 	andi.   r20,r19,24947
>   84:	2d 73 69 7a 	cmpdi   cr2,r19,27002
>   88:	65 00 00 00 	oris    r0,r8,0
>   8c:	00 00 00 00 	.long 0x0
>   90:	6c 69 6e 75 	xoris   r9,r3,28277
>   94:	78 2c 74 63 	rldicl. r12,r1,46,49
>   98:	65 2d 73 69 	oris    r13,r9,29545
>   9c:	7a 65 00 00 	rotldi  r5,r19,0
>   a0:	6c 69 6e 75 	xoris   r9,r3,28277
>   a4:	78 2c 69 6e 	rldimi  r12,r1,45,37
>   a8:	69 74 72 64 	xori    r20,r11,29284
>   ac:	2d 73 74 61 	cmpdi   cr2,r19,29793
>   b0:	72 74 00 00 	andi.   r20,r19,0
>   b4:	00 00 00 00 	.long 0x0
>   b8:	6c 69 6e 75 	xoris   r9,r3,28277
>   bc:	78 2c 69 6e 	rldimi  r12,r1,45,37
>   c0:	69 74 72 64 	xori    r20,r11,29284
>   c4:	2d 65 6e 64 	cmpdi   cr2,r5,28260
> 	...
>   d0:	75 6e 72 65 	andis.  r14,r11,29285
>   d4:	63 6f 76 65 	ori     r15,r27,30309
>   d8:	72 61 62 6c 	andi.   r1,r19,25196
>   dc:	65 20 65 72 	oris    r0,r9,25970
>   e0:	72 6f 72 3a 	andi.   r15,r19,29242
>   e4:	20 73 69 7a 	subfic  r3,r19,27002
>   e8:	65 20 61 6e 	oris    r0,r9,24942
>   ec:	64 20 65 6e 	oris    r0,r1,25966
>   f0:	64 20 73 65 	oris    r0,r1,29541
>   f4:	74 20 61 74 	andis.  r0,r1,24948
>   f8:	20 73 61 6d 	subfic  r3,r19,24941
>   fc:	65 20 74 69 	oris    r0,r9,29801
>  100:	6d 65 0a 00 	xoris   r5,r11,2560
>  104:	00 00 00 00 	.long 0x0
>  108:	75 6e 72 65 	andis.  r14,r11,29285
>  10c:	63 6f 76 65 	ori     r15,r27,30309
>  110:	72 61 62 6c 	andi.   r1,r19,25196
>  114:	65 20 65 72 	oris    r0,r9,25970
>  118:	72 6f 72 3a 	andi.   r15,r19,29242
>  11c:	20 70 72 6f 	subfic  r3,r16,29295
>  120:	70 6e 61 6d 	andi.   r14,r3,24941
>  124:	65 73 20 6f 	oris    r19,r11,8303
>  128:	76 65 72 72 	andis.  r5,r19,29298
>  12c:	75 6e 0a 00 	andis.  r14,r11,2560
>  130:	2f 6d 65 6d 	cmpdi   cr6,r13,25965
>  134:	6f 72 79 40 	xoris   r18,r27,31040
> 	...
>  140:	75 6e 72 65 	andis.  r14,r11,29285
>  144:	63 6f 76 65 	ori     r15,r27,30309
>  148:	72 61 62 6c 	andi.   r1,r19,25196
>  14c:	65 20 65 72 	oris    r0,r9,25970
>  150:	72 6f 72 3a 	andi.   r15,r19,29242
>  154:	20 6e 6f 74 	subfic  r3,r14,28532
>  158:	20 65 6e 6f 	subfic  r3,r5,28271
>  15c:	75 67 68 20 	andis.  r7,r11,26656
>  160:	64 61 74 61 	oris    r1,r3,29793
>  164:	20 66 6f 72 	subfic  r3,r6,28530
>  168:	20 6d 65 6d 	subfic  r3,r13,25965
>  16c:	20 70 72 6f 	subfic  r3,r16,29295
>  170:	70 65 72 74 	andi.   r5,r3,29300
>  174:	79 0a 00 00 	rotldi  r10,r8,0
>  178:	75 6e 72 65 	andis.  r14,r11,29285
>  17c:	63 6f 76 65 	ori     r15,r27,30309
>  180:	72 61 62 6c 	andi.   r1,r19,25196
>  184:	65 20 65 72 	oris    r0,r9,25970
>  188:	72 6f 72 3a 	andi.   r15,r19,29242
>  18c:	20 65 72 72 	subfic  r3,r5,29298
>  190:	6f 72 20 73 	xoris   r18,r27,8307
>  194:	65 65 6b 69 	oris    r5,r11,27497
>  198:	6e 67 20 69 	xoris   r7,r19,8297
>  19c:	6e 20 22 25 	xoris   r0,r17,8741
>  1a0:	73 22 3a 20 	andi.   r2,r25,14880
>  1a4:	25 73 0a 00 	dozi    r11,r19,2560
>  1a8:	75 6e 72 65 	andis.  r14,r11,29285
>  1ac:	63 6f 76 65 	ori     r15,r27,30309
>  1b0:	72 61 62 6c 	andi.   r1,r19,25196
>  1b4:	65 20 65 72 	oris    r0,r9,25970
>  1b8:	72 6f 72 3a 	andi.   r15,r19,29242
>  1bc:	20 65 72 72 	subfic  r3,r5,29298
>  1c0:	6f 72 20 72 	xoris   r18,r27,8306
>  1c4:	65 61 64 69 	oris    r1,r11,25705
>  1c8:	6e 67 20 22 	xoris   r7,r19,8226
>  1cc:	25 73 22 3a 	dozi    r11,r19,8762
>  1d0:	20 25 73 0a 	subfic  r1,r5,29450
>  1d4:	00 00 00 00 	.long 0x0
>  1d8:	75 6e 72 65 	andis.  r14,r11,29285
>  1dc:	63 6f 76 65 	ori     r15,r27,30309
>  1e0:	72 61 62 6c 	andi.   r1,r19,25196
>  1e4:	65 20 65 72 	oris    r0,r9,25970
>  1e8:	72 6f 72 3a 	andi.   r15,r19,29242
>  1ec:	20 6d 65 6d 	subfic  r3,r13,25965
>  1f0:	20 70 72 6f 	subfic  r3,r16,29295
>  1f4:	70 65 72 74 	andi.   r5,r3,29300
>  1f8:	79 20 6f 76 	.long 0x79206f76
>  1fc:	65 72 66 6c 	oris    r18,r11,26220
>  200:	6f 77 0a 00 	xoris   r23,r27,2560
>  204:	00 00 00 00 	.long 0x0
>  208:	6c 69 6e 75 	xoris   r9,r3,28277
>  20c:	78 2c 75 73 	rldcr.  r12,r1,r14,53
>  210:	61 62 6c 65 	ori     r2,r11,27749
>  214:	2d 6d 65 6d 	cmpdi   cr2,r13,25965
>  218:	6f 72 79 00 	xoris   r18,r27,30976
>  21c:	00 00 00 00 	.long 0x0
>  220:	2f 69 62 6d 	cmpdi   cr6,r9,25197
>  224:	2c 64 79 6e 	cmpdi   r4,31086
>  228:	61 6d 69 63 	ori     r13,r11,26979
>  22c:	2d 72 65 63 	cmpdi   cr2,r18,25955
>  230:	6f 6e 66 69 	xoris   r14,r27,26217
>  234:	67 75 72 61 	oris    r21,r27,29281
>  238:	74 69 6f 6e 	andis.  r9,r3,28526
>  23c:	2d 6d 65 6d 	cmpdi   cr2,r13,25965
>  240:	6f 72 79 00 	xoris   r18,r27,30976
>  244:	00 00 00 00 	.long 0x0
>  248:	6c 69 6e 75 	xoris   r9,r3,28277
>  24c:	78 2c 64 72 	rldcr   r12,r1,r12,49
>  250:	63 6f 6e 66 	ori     r15,r27,28262
>  254:	2d 75 73 61 	cmpdi   cr2,r21,29537
>  258:	62 6c 65 2d 	ori     r12,r19,25901
>  25c:	6d 65 6d 6f 	xoris   r5,r11,28015
>  260:	72 79 00 00 	andi.   r25,r19,0
>  264:	00 00 00 00 	.long 0x0
>  268:	75 6e 72 65 	andis.  r14,r11,29285
>  26c:	63 6f 76 65 	ori     r15,r27,30309
>  270:	72 61 62 6c 	andi.   r1,r19,25196
>  274:	65 20 65 72 	oris    r0,r9,25970
>  278:	72 6f 72 3a 	andi.   r15,r19,29242
>  27c:	20 63 6f 75 	subfic  r3,r3,28533
>  280:	6c 64 20 6e 	xoris   r4,r3,8302
>  284:	6f 74 20 73 	xoris   r20,r27,8307
>  288:	74 61 74 20 	andis.  r1,r3,29728
>  28c:	22 25 73 22 	subfic  r17,r5,29474
>  290:	3a 20 25 73 	li      r17,9587
>  294:	0a 00 00 00 	tdlti   r0,0
>  298:	6c 69 6e 75 	xoris   r9,r3,28277
>  29c:	78 2c 63 72 	rldcr   r12,r1,r12,45
>  2a0:	61 73 68 6b 	ori     r19,r11,26731
>  2a4:	65 72 6e 65 	oris    r18,r11,28261
>  2a8:	6c 2d 62 61 	xoris   r13,r1,25185
>  2ac:	73 65 00 00 	andi.   r5,r27,0
>  2b0:	6c 69 6e 75 	xoris   r9,r3,28277
>  2b4:	78 2c 63 72 	rldcr   r12,r1,r12,45
>  2b8:	61 73 68 6b 	ori     r19,r11,26731
>  2bc:	65 72 6e 65 	oris    r18,r11,28261
>  2c0:	6c 2d 73 69 	xoris   r13,r1,29545
>  2c4:	7a 65 00 00 	rotldi  r5,r19,0
>  2c8:	6c 69 6e 75 	xoris   r9,r3,28277
>  2cc:	78 2c 70 63 	rldicl. r12,r1,46,33
>  2d0:	69 2d 64 6f 	xori    r13,r9,25711
>  2d4:	6d 61 69 6e 	xoris   r1,r11,26990
> 	...
>  2e0:	6c 69 6e 75 	xoris   r9,r3,28277
>  2e4:	78 2c 68 74 	.long 0x782c6874
>  2e8:	61 62 2d 62 	ori     r2,r11,11618
>  2ec:	61 73 65 00 	ori     r19,r11,25856
>  2f0:	6c 69 6e 75 	xoris   r9,r3,28277
>  2f4:	78 2c 68 74 	.long 0x782c6874
>  2f8:	61 62 2d 73 	ori     r2,r11,11635
>  2fc:	69 7a 65 00 	xori    r26,r11,25856
>  300:	6c 69 6e 75 	xoris   r9,r3,28277
>  304:	78 2c 6b 65 	rldicr. r12,r1,13,45
>  308:	72 6e 65 6c 	andi.   r14,r19,25964
>  30c:	2d 65 6e 64 	cmpdi   cr2,r5,28260
> 	...
>  318:	62 6f 6f 74 	ori     r15,r19,28532
>  31c:	61 72 67 73 	ori     r18,r11,26483
> 	...
>  328:	75 6e 72 65 	andis.  r14,r11,29285
>  32c:	63 6f 76 65 	ori     r15,r27,30309
>  330:	72 61 62 6c 	andi.   r1,r19,25196
>  334:	65 20 65 72 	oris    r0,r9,25970
>  338:	72 6f 72 3a 	andi.   r15,r19,29242
>  33c:	20 63 6f 75 	subfic  r3,r3,28533
>  340:	6c 64 20 6e 	xoris   r4,r3,8302
>  344:	6f 74 20 6f 	xoris   r20,r27,8303
>  348:	70 65 6e 20 	andi.   r5,r3,28192
>  34c:	22 25 73 22 	subfic  r17,r5,29474
>  350:	3a 20 25 73 	li      r17,9587
>  354:	0a 00 00 00 	tdlti   r0,0
>  358:	75 6e 72 65 	andis.  r14,r11,29285
>  35c:	63 6f 76 65 	ori     r15,r27,30309
>  360:	72 61 62 6c 	andi.   r1,r19,25196
>  364:	65 20 65 72 	oris    r0,r9,25970
>  368:	72 6f 72 3a 	andi.   r15,r19,29242
>  36c:	20 63 6f 75 	subfic  r3,r3,28533
>  370:	6c 64 20 6e 	xoris   r4,r3,8302
>  374:	6f 74 20 72 	xoris   r20,r27,8306
>  378:	65 61 64 20 	oris    r1,r11,25632
>  37c:	22 25 73 22 	subfic  r17,r5,29474
>  380:	3a 20 25 73 	li      r17,9587
>  384:	0a 00 00 00 	tdlti   r0,0
>  388:	69 62 6d 2c 	xori    r2,r11,27948
>  38c:	64 79 6e 61 	oris    r25,r3,28257
>  390:	6d 69 63 2d 	xoris   r9,r11,25389
>  394:	6d 65 6d 6f 	xoris   r5,r11,28015
>  398:	72 79 00 00 	andi.   r25,r19,0
>  39c:	00 00 00 00 	.long 0x0
>  3a0:	2f 00 00 00 	cmpwi   cr6,r0,0
>  3a4:	00 00 00 00 	.long 0x0
>  3a8:	75 6e 72 65 	andis.  r14,r11,29285
>  3ac:	63 6f 76 65 	ori     r15,r27,30309
>  3b0:	72 61 62 6c 	andi.   r1,r19,25196
>  3b4:	65 20 65 72 	oris    r0,r9,25970
>  3b8:	72 6f 72 3a 	andi.   r15,r19,29242
>  3bc:	20 63 6f 75 	subfic  r3,r3,28533
>  3c0:	6c 64 20 6e 	xoris   r4,r3,8302
>  3c4:	6f 74 20 73 	xoris   r20,r27,8307
>  3c8:	63 61 6e 20 	ori     r1,r27,28192
>  3cc:	22 25 73 22 	subfic  r17,r5,29474
>  3d0:	3a 20 25 73 	li      r17,9587
>  3d4:	0a 00 00 00 	tdlti   r0,0
>  3d8:	75 6e 72 65 	andis.  r14,r11,29285
>  3dc:	63 6f 76 65 	ori     r15,r27,30309
>  3e0:	72 61 62 6c 	andi.   r1,r19,25196
>  3e4:	65 20 65 72 	oris    r0,r9,25970
>  3e8:	72 6f 72 3a 	andi.   r15,r19,29242
>  3ec:	20 6e 6f 20 	subfic  r3,r14,28448
>  3f0:	64 69 72 65 	oris    r9,r3,29285
>  3f4:	63 74 6f 72 	ori     r20,r27,28530
>  3f8:	79 20 65 6e 	rldimi  r0,r9,44,53
>  3fc:	74 72 69 65 	andis.  r18,r3,26981
>  400:	73 20 69 6e 	andi.   r0,r25,26990
>  404:	20 22 25 73 	subfic  r1,r2,9587
>  408:	22 00 00 00 	subfic  r16,r0,0
>  40c:	00 00 00 00 	.long 0x0
>  410:	2f 63 68 6f 	cmpdi   cr6,r3,26735
>  414:	73 65 6e 2f 	andi.   r5,r27,28207
> 	...
>  420:	63 72 61 73 	ori     r18,r27,24947
>  424:	68 6b 65 72 	xori    r11,r3,25970
>  428:	6e 65 6c 3d 	xoris   r5,r19,27709
>  42c:	00 00 00 00 	.long 0x0
>  430:	72 6f 6f 74 	andi.   r15,r19,28532
>  434:	3d 00 00 00 	lis     r8,0
>  438:	72 00 00 00 	andi.   r0,r16,0
>  43c:	00 00 00 00 	.long 0x0
>  440:	75 6e 61 62 	andis.  r14,r11,24930
>  444:	6c 65 20 74 	xoris   r5,r3,8308
>  448:	6f 20 72 65 	xoris   r0,r25,29285
>  44c:	61 64 20 25 	ori     r4,r11,8229
>  450:	73 0a 00 00 	andi.   r10,r24,0
>  454:	00 00 00 00 	.long 0x0
>  458:	20 00 00 00 	subfic  r0,r0,0
>  45c:	00 00 00 00 	.long 0x0
>  460:	4d 6f 64 69 	.long 0x4d6f6469
>  464:	66 69 65 64 	oris    r9,r19,25956
>  468:	20 63 6d 64 	subfic  r3,r3,28004
>  46c:	6c 69 6e 65 	xoris   r9,r3,28261
>  470:	3a 25 73 0a 	addi    r17,r5,29450
>  474:	00 00 00 00 	.long 0x0
>  478:	2f 70 72 6f 	cmpdi   cr6,r16,29295
>  47c:	63 2f 64 65 	ori     r15,r25,25701
>  480:	76 69 63 65 	andis.  r9,r19,25445
>  484:	2d 74 72 65 	cmpdi   cr2,r20,29285
>  488:	65 2f 00 00 	oris    r15,r9,0
>  48c:	00 00 00 00 	.long 0x0
> 	...
> 
> Disassembly of section .debug_frame:
> 
> 0000000000000000 <.debug_frame>:
>    0:	00 00 00 0c 	.long 0xc
>    4:	ff ff ff ff 	fnmadd. f31,f31,f31,f31
>    8:	01 00 01 78 	.long 0x1000178
>    c:	41 0c 01 00 	bdnzt-  4*cr3+lt,10c <.debug_frame+0x10c>
>   10:	00 00 00 2c 	.long 0x2c
> 	...
>   24:	00 00 00 d4 	.long 0xd4
>   28:	58 9f 01 9e 	rlmi    r31,r4,r0,6,15
>   2c:	02 9d 03 9c 	.long 0x29d039c
>   30:	04 9b 05 09 	.long 0x49b0509
>   34:	41 00 4c 0e 	bdnzta- lt,4c0c <.comparefunc+0x327c>
>   38:	a0 01 11 41 	lhz     r0,4417(r1)
>   3c:	7e 00 00 00 	cmpw    cr4,r0,r0
>   40:	00 00 00 2c 	.long 0x2c
> 	...
>   4c:	00 00 00 e0 	.long 0xe0
>   50:	00 00 00 00 	.long 0x0
>   54:	00 00 02 4c 	.long 0x24c
>   58:	48 9e 02 09 	bl      9e0260 <bb+0x99ae28>
>   5c:	41 00 54 11 	bdnztl- lt,546c <dtstruct+0x34>
>   60:	41 7e 9f 01 	bdztl-  4*cr7+eq,ffffffffffff9f60 <bb+0xfffffffffffb4b28>
>   64:	9d 03 9c 04 	stbu    r8,-25596(r3)
>   68:	48 0e 90 01 	bl      e9068 <bb+0xa3c30>
>   6c:	00 00 00 00 	.long 0x0
>   70:	00 00 00 2c 	.long 0x2c
> 	...
>   7c:	00 00 03 30 	.long 0x330
>   80:	00 00 00 00 	.long 0x0
>   84:	00 00 01 4c 	.long 0x14c
>   88:	58 9f 01 9e 	rlmi    r31,r4,r0,6,15
>   8c:	02 9b 05 9d 	.long 0x29b059d
>   90:	03 9c 04 09 	.long 0x39c0409
>   94:	41 00 4c 0e 	bdnzta- lt,4c0c <.comparefunc+0x327c>
>   98:	a0 01 11 41 	lhz     r0,4417(r1)
>   9c:	7e 00 00 00 	cmpw    cr4,r0,r0
>   a0:	00 00 00 2c 	.long 0x2c
> 	...
>   ac:	00 00 04 80 	.long 0x480
>   b0:	00 00 00 00 	.long 0x0
>   b4:	00 00 03 b0 	.long 0x3b0
>   b8:	58 9f 01 9e 	rlmi    r31,r4,r0,6,15
>   bc:	02 9d 03 9c 	.long 0x29d039c
>   c0:	04 9b 05 09 	.long 0x49b0509
>   c4:	41 00 4c 0e 	bdnzta- lt,4c0c <.comparefunc+0x327c>
>   c8:	b0 89 01 11 	sth     r4,273(r9)
>   cc:	41 7e 00 00 	bdzt+   4*cr7+eq,cc <.debug_frame+0xcc>
>   d0:	00 00 00 34 	.long 0x34
> 	...
>   dc:	00 00 08 30 	.long 0x830
>   e0:	00 00 00 00 	.long 0x0
>   e4:	00 00 04 38 	.long 0x438
>   e8:	7c 0e d0 8b 	.long 0x7c0ed08b
>   ec:	01 9f 01 9e 	.long 0x19f019e
>   f0:	02 9c 04 9b 	.long 0x29c049b
>   f4:	05 97 09 96 	.long 0x5970996
>   f8:	0a 95 0b 94 	tdlei   r21,2964
>   fc:	0c 9d 03 9a 	tweqi   r29,922
>  100:	06 99 07 98 	.long 0x6990798
>  104:	08 11 41 7e 	tdi     0,r17,16766
>  108:	00 00 00 3c 	.long 0x3c
> 	...
>  114:	00 00 0c 70 	.long 0xc70
>  118:	00 00 00 00 	.long 0x0
>  11c:	00 00 04 90 	.long 0x490
>  120:	02 50 0e 80 	.long 0x2500e80
>  124:	03 9f 01 9e 	.long 0x39f019e
>  128:	02 9d 03 9c 	.long 0x29d039c
>  12c:	04 9b 05 9a 	.long 0x49b059a
>  130:	06 98 08 96 	.long 0x6980896
>  134:	0a 95 0b 94 	tdlei   r21,2964
>  138:	0c 93 0d 92 	tweqi   r19,3474
>  13c:	0e 91 0f 90 	twlei   r17,3984
>  140:	10 99 07 97 	.long 0x10990797
>  144:	09 11 41 7e 	tdgti   r17,16766
>  148:	00 00 00 34 	.long 0x34
> 	...
>  154:	00 00 11 00 	.long 0x1100
>  158:	00 00 00 00 	.long 0x0
>  15c:	00 00 06 4c 	.long 0x64c
>  160:	02 40 0e f0 	.long 0x2400ef0
>  164:	0a 9f 01 9e 	tdlei   r31,414
>  168:	02 9d 03 9c 	.long 0x29d039c
>  16c:	04 9b 05 99 	.long 0x49b0599
>  170:	07 98 08 97 	.long 0x7980897
>  174:	09 11 40 7f 	tdgti   r17,16511
>  178:	96 0a 9a 06 	stwu    r16,-26106(r10)
>  17c:	11 41 7e 00 	vsububs v10,v1,v15
>  180:	00 00 00 2c 	.long 0x2c
> 	...
>  18c:	00 00 17 50 	.long 0x1750
>  190:	00 00 00 00 	.long 0x0
>  194:	00 00 02 3c 	.long 0x23c
>  198:	68 0e b0 01 	xori    r14,r0,45057
>  19c:	9b 05 9f 01 	stb     r24,-24831(r5)
>  1a0:	9e 02 9d 03 	stbu    r16,-25341(r2)
>  1a4:	9c 04 9a 06 	stbu    r0,-26106(r4)
>  1a8:	99 07 11 41 	stb     r8,4417(r7)
>  1ac:	7e 00 00 00 	cmpw    cr4,r0,r0
>  1b0:	00 00 00 24 	.long 0x24
> 	...
>  1bc:	00 00 19 90 	.long 0x1990
>  1c0:	00 00 00 00 	.long 0x0
>  1c4:	00 00 00 c0 	.long 0xc0
>  1c8:	58 0e 90 01 	rlmi.   r14,r0,r18,0,0
>  1cc:	9d 03 9f 01 	stbu    r8,-24831(r3)
>  1d0:	9e 02 11 41 	stbu    r16,4417(r2)
>  1d4:	7e 00 00 00 	cmpw    cr4,r0,r0
> 
> Disassembly of section .debug_loc:
> 
> 0000000000000000 <.debug_loc>:
> 	...
>        c:	00 00 00 24 	.long 0x24
>       10:	00 01 51 00 	.long 0x15100
>       14:	00 00 00 00 	.long 0x0
>       18:	00 00 24 00 	.long 0x2400
>       1c:	00 00 00 00 	.long 0x0
>       20:	00 00 d4 00 	.long 0xd400
>       24:	03 71 a0 01 	.long 0x371a001
> 	...
>       44:	00 00 00 38 	.long 0x38
>       48:	00 01 53 00 	.long 0x15300
>       4c:	00 00 00 00 	.long 0x0
>       50:	00 00 38 00 	.long 0x3800
>       54:	00 00 00 00 	.long 0x0
>       58:	00 00 a4 00 	.long 0xa400
>       5c:	01 6c 00 00 	.long 0x16c0000
>       60:	00 00 00 00 	.long 0x0
>       64:	00 a4 00 00 	.long 0xa40000
>       68:	00 00 00 00 	.long 0x0
>       6c:	00 b8 00 01 	.long 0xb80001
>       70:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>       74:	00 00 00 00 	.long 0x0
>       78:	b8 00 00 00 	lmw     r0,0(0)
>       7c:	00 00 00 00 	.long 0x0
>       80:	d4 00 01 6c 	stfsu   f0,364(0)
> 	...
>       a0:	00 00 00 38 	.long 0x38
>       a4:	00 01 54 00 	.long 0x15400
>       a8:	00 00 00 00 	.long 0x0
>       ac:	00 00 38 00 	.long 0x3800
>       b0:	00 00 00 00 	.long 0x0
>       b4:	00 00 a0 00 	.long 0xa000
>       b8:	01 6b 00 00 	.long 0x16b0000
>       bc:	00 00 00 00 	.long 0x0
>       c0:	00 a0 00 00 	.long 0xa00000
>       c4:	00 00 00 00 	.long 0x0
>       c8:	00 b8 00 01 	.long 0xb80001
>       cc:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>       d0:	00 00 00 00 	.long 0x0
>       d4:	b8 00 00 00 	lmw     r0,0(0)
>       d8:	00 00 00 00 	.long 0x0
>       dc:	d4 00 01 6b 	stfsu   f0,363(0)
> 	...
>       f4:	00 00 00 40 	.long 0x40
>       f8:	00 00 00 00 	.long 0x0
>       fc:	00 00 00 b0 	.long 0xb0
>      100:	00 01 6f 00 	.long 0x16f00
>      104:	00 00 00 00 	.long 0x0
>      108:	00 00 bc 00 	.long 0xbc00
>      10c:	00 00 00 00 	.long 0x0
>      110:	00 00 d4 00 	.long 0xd400
>      114:	01 6f 00 00 	.long 0x16f0000
> 	...
>      12c:	00 e0 00 00 	.long 0xe00000
>      130:	00 00 00 00 	.long 0x0
>      134:	01 04 00 01 	.long 0x1040001
>      138:	51 00 00 00 	rlwimi  r0,r8,0,0,0
>      13c:	00 00 00 01 	.long 0x1
>      140:	04 00 00 00 	.long 0x4000000
>      144:	00 00 00 03 	.long 0x3
>      148:	2c 00 03 71 	cmpwi   r0,881
>      14c:	90 01 00 00 	stw     r0,0(r1)
> 	...
>      164:	00 e0 00 00 	.long 0xe00000
>      168:	00 00 00 00 	.long 0x0
>      16c:	01 0c 00 01 	.long 0x10c0001
>      170:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>      174:	00 00 00 01 	.long 0x1
>      178:	0c 00 00 00 	twi     0,r0,0
>      17c:	00 00 00 01 	.long 0x1
>      180:	7c 00 01 6d 	.long 0x7c00016d
>      184:	00 00 00 00 	.long 0x0
>      188:	00 00 01 8c 	.long 0x18c
>      18c:	00 00 00 00 	.long 0x0
>      190:	00 00 02 34 	.long 0x234
>      194:	00 01 6d 00 	.long 0x16d00
>      198:	00 00 00 00 	.long 0x0
>      19c:	00 02 44 00 	.long 0x24400
>      1a0:	00 00 00 00 	.long 0x0
>      1a4:	00 02 70 00 	.long 0x27000
>      1a8:	01 6d 00 00 	.long 0x16d0000
>      1ac:	00 00 00 00 	.long 0x0
>      1b0:	02 80 00 00 	.long 0x2800000
>      1b4:	00 00 00 00 	.long 0x0
>      1b8:	03 2c 00 01 	.long 0x32c0001
>      1bc:	6d 00 00 00 	xoris   r0,r8,0
> 	...
>      1d4:	e0 00 00 00 	.long 0xe0000000
>      1d8:	00 00 00 01 	.long 0x1
>      1dc:	0c 00 01 54 	twi     0,r0,340
>      1e0:	00 00 00 00 	.long 0x0
>      1e4:	00 00 01 0c 	.long 0x10c
>      1e8:	00 00 00 00 	.long 0x0
>      1ec:	00 00 01 58 	.long 0x158
>      1f0:	00 01 6e 00 	.long 0x16e00
>      1f4:	00 00 00 00 	.long 0x0
>      1f8:	00 01 6c 00 	.long 0x16c00
>      1fc:	00 00 00 00 	.long 0x0
>      200:	00 01 80 00 	.long 0x18000
>      204:	01 6e 00 00 	.long 0x16e0000
>      208:	00 00 00 00 	.long 0x0
>      20c:	01 8c 00 00 	.long 0x18c0000
>      210:	00 00 00 00 	.long 0x0
>      214:	02 10 00 01 	.long 0x2100001
>      218:	6e 00 00 00 	xoris   r0,r16,0
>      21c:	00 00 00 02 	.long 0x2
>      220:	80 00 00 00 	lwz     r0,0(0)
>      224:	00 00 00 03 	.long 0x3
>      228:	2c 00 01 6e 	cmpwi   r0,366
> 	...
>      240:	00 00 00 e0 	.long 0xe0
>      244:	00 00 00 00 	.long 0x0
>      248:	00 00 01 0c 	.long 0x10c
>      24c:	00 01 55 00 	.long 0x15500
>      250:	00 00 00 00 	.long 0x0
>      254:	00 01 0c 00 	.long 0x10c00
>      258:	00 00 00 00 	.long 0x0
>      25c:	00 01 78 00 	.long 0x17800
>      260:	01 6c 00 00 	.long 0x16c0000
>      264:	00 00 00 00 	.long 0x0
>      268:	01 8c 00 00 	.long 0x18c0000
>      26c:	00 00 00 00 	.long 0x0
>      270:	02 30 00 01 	.long 0x2300001
>      274:	6c 00 00 00 	xoris   r0,r0,0
>      278:	00 00 00 02 	.long 0x2
>      27c:	44 00 00 00 	.long 0x44000000
>      280:	00 00 00 02 	.long 0x2
>      284:	6c 00 01 6c 	xoris   r0,r0,364
>      288:	00 00 00 00 	.long 0x0
>      28c:	00 00 02 80 	.long 0x280
>      290:	00 00 00 00 	.long 0x0
>      294:	00 00 03 2c 	.long 0x32c
>      298:	00 01 6c 00 	.long 0x16c00
> 	...
>      2b0:	00 03 30 00 	.long 0x33000
>      2b4:	00 00 00 00 	.long 0x0
>      2b8:	00 03 54 00 	.long 0x35400
>      2bc:	01 51 00 00 	.long 0x1510000
>      2c0:	00 00 00 00 	.long 0x0
>      2c4:	03 54 00 00 	.long 0x3540000
>      2c8:	00 00 00 00 	.long 0x0
>      2cc:	04 7c 00 03 	.long 0x47c0003
>      2d0:	71 a0 01 00 	andi.   r0,r13,256
> 	...
>      2e8:	00 03 30 00 	.long 0x33000
>      2ec:	00 00 00 00 	.long 0x0
>      2f0:	00 03 64 00 	.long 0x36400
>      2f4:	01 53 00 00 	.long 0x1530000
>      2f8:	00 00 00 00 	.long 0x0
>      2fc:	03 64 00 00 	.long 0x3640000
>      300:	00 00 00 00 	.long 0x0
>      304:	03 dc 00 01 	.long 0x3dc0001
>      308:	6c 00 00 00 	xoris   r0,r0,0
>      30c:	00 00 00 03 	.long 0x3
>      310:	f0 00 00 00 	.long 0xf0000000
>      314:	00 00 00 04 	.long 0x4
>      318:	38 00 01 6c 	li      r0,364
>      31c:	00 00 00 00 	.long 0x0
>      320:	00 00 04 4c 	.long 0x44c
>      324:	00 00 00 00 	.long 0x0
>      328:	00 00 04 7c 	.long 0x47c
>      32c:	00 01 6c 00 	.long 0x16c00
> 	...
>      344:	00 03 6c 00 	.long 0x36c00
>      348:	00 00 00 00 	.long 0x0
>      34c:	00 03 94 00 	.long 0x39400
>      350:	01 6f 00 00 	.long 0x16f0000
>      354:	00 00 00 00 	.long 0x0
>      358:	03 94 00 00 	.long 0x3940000
>      35c:	00 00 00 00 	.long 0x0
>      360:	03 a8 00 01 	.long 0x3a80001
>      364:	6d 00 00 00 	xoris   r0,r8,0
>      368:	00 00 00 03 	.long 0x3
>      36c:	a8 00 00 00 	lha     r0,0(0)
>      370:	00 00 00 03 	.long 0x3
>      374:	e8 00 01 6f 	.long 0xe800016f
>      378:	00 00 00 00 	.long 0x0
>      37c:	00 00 03 f0 	.long 0x3f0
>      380:	00 00 00 00 	.long 0x0
>      384:	00 00 04 14 	.long 0x414
>      388:	00 01 6f 00 	.long 0x16f00
>      38c:	00 00 00 00 	.long 0x0
>      390:	00 04 14 00 	.long 0x41400
>      394:	00 00 00 00 	.long 0x0
>      398:	00 04 3c 00 	.long 0x43c00
>      39c:	01 6d 00 00 	.long 0x16d0000
>      3a0:	00 00 00 00 	.long 0x0
>      3a4:	04 3c 00 00 	.long 0x43c0000
>      3a8:	00 00 00 00 	.long 0x0
>      3ac:	04 44 00 01 	.long 0x4440001
>      3b0:	6f 00 00 00 	xoris   r0,r24,0
>      3b4:	00 00 00 04 	.long 0x4
>      3b8:	4c 00 00 00 	mcrf    cr0,cr0
>      3bc:	00 00 00 04 	.long 0x4
>      3c0:	60 00 01 6d 	ori     r0,r0,365
>      3c4:	00 00 00 00 	.long 0x0
>      3c8:	00 00 04 68 	.long 0x468
>      3cc:	00 00 00 00 	.long 0x0
>      3d0:	00 00 04 6c 	.long 0x46c
>      3d4:	00 01 6d 00 	.long 0x16d00
>      3d8:	00 00 00 00 	.long 0x0
>      3dc:	00 04 6c 00 	.long 0x46c00
>      3e0:	00 00 00 00 	.long 0x0
>      3e4:	00 04 7c 00 	.long 0x47c00
>      3e8:	01 6f 00 00 	.long 0x16f0000
> 	...
>      400:	04 80 00 00 	.long 0x4800000
>      404:	00 00 00 00 	.long 0x0
>      408:	04 a4 00 01 	.long 0x4a40001
>      40c:	51 00 00 00 	rlwimi  r0,r8,0,0,0
>      410:	00 00 00 04 	.long 0x4
>      414:	a4 00 00 00 	lhzu    r0,0(0)
>      418:	00 00 00 08 	.long 0x8
>      41c:	30 00 04 71 	addic   r0,r0,1137
>      420:	b0 89 01 00 	sth     r4,256(r9)
> 	...
>      438:	00 04 80 00 	.long 0x48000
>      43c:	00 00 00 00 	.long 0x0
>      440:	00 04 bc 00 	.long 0x4bc00
>      444:	01 53 00 00 	.long 0x1530000
>      448:	00 00 00 00 	.long 0x0
>      44c:	04 bc 00 00 	.long 0x4bc0000
>      450:	00 00 00 00 	.long 0x0
>      454:	06 c8 00 01 	.long 0x6c80001
>      458:	6b 00 00 00 	xori    r0,r24,0
>      45c:	00 00 00 06 	.long 0x6
>      460:	fc 00 00 00 	fcmpu   cr0,f0,f0
>      464:	00 00 00 07 	.long 0x7
>      468:	08 00 01 6b 	tdi     0,r0,363
>      46c:	00 00 00 00 	.long 0x0
>      470:	00 00 07 20 	.long 0x720
>      474:	00 00 00 00 	.long 0x0
>      478:	00 00 07 38 	.long 0x738
>      47c:	00 01 6b 00 	.long 0x16b00
>      480:	00 00 00 00 	.long 0x0
>      484:	00 07 9c 00 	.long 0x79c00
>      488:	00 00 00 00 	.long 0x0
>      48c:	00 08 30 00 	.long 0x83000
>      490:	01 6b 00 00 	.long 0x16b0000
> 	...
>      4a8:	04 80 00 00 	.long 0x4800000
>      4ac:	00 00 00 00 	.long 0x0
>      4b0:	04 b4 00 01 	.long 0x4b40001
>      4b4:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      4b8:	00 00 00 04 	.long 0x4
>      4bc:	b4 00 00 00 	sthu    r0,0(0)
>      4c0:	00 00 00 05 	.long 0x5
>      4c4:	30 00 01 6f 	addic   r0,r0,367
>      4c8:	00 00 00 00 	.long 0x0
>      4cc:	00 00 06 fc 	.long 0x6fc
>      4d0:	00 00 00 00 	.long 0x0
>      4d4:	00 00 07 18 	.long 0x718
>      4d8:	00 01 6f 00 	.long 0x16f00
>      4dc:	00 00 00 00 	.long 0x0
>      4e0:	00 07 cc 00 	.long 0x7cc00
>      4e4:	00 00 00 00 	.long 0x0
>      4e8:	00 08 30 00 	.long 0x83000
>      4ec:	01 6f 00 00 	.long 0x16f0000
> 	...
>      504:	05 90 00 00 	.long 0x5900000
>      508:	00 00 00 00 	.long 0x0
>      50c:	06 5c 00 01 	.long 0x65c0001
>      510:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      514:	00 00 00 06 	.long 0x6
>      518:	5c 00 00 00 	rlwnm   r0,r0,r0,0,0
>      51c:	00 00 00 06 	.long 0x6
>      520:	68 00 01 50 	xori    r0,r0,336
>      524:	00 00 00 00 	.long 0x0
>      528:	00 00 06 68 	.long 0x668
>      52c:	00 00 00 00 	.long 0x0
>      530:	00 00 06 cc 	.long 0x6cc
>      534:	00 01 54 00 	.long 0x15400
>      538:	00 00 00 00 	.long 0x0
>      53c:	00 07 20 00 	.long 0x72000
>      540:	00 00 00 00 	.long 0x0
>      544:	00 07 60 00 	.long 0x76000
>      548:	01 54 00 00 	.long 0x1540000
>      54c:	00 00 00 00 	.long 0x0
>      550:	07 bc 00 00 	.long 0x7bc0000
>      554:	00 00 00 00 	.long 0x0
>      558:	07 cc 00 01 	.long 0x7cc0001
>      55c:	54 00 00 00 	rlwinm  r0,r0,0,0,0
> 	...
>      570:	00 00 00 05 	.long 0x5
>      574:	bc 00 00 00 	stmw    r0,0(0)
>      578:	00 00 00 06 	.long 0x6
>      57c:	2c 00 01 58 	cmpwi   r0,344
>      580:	00 00 00 00 	.long 0x0
>      584:	00 00 06 2c 	.long 0x62c
>      588:	00 00 00 00 	.long 0x0
>      58c:	00 00 06 7c 	.long 0x67c
>      590:	00 01 5b 00 	.long 0x15b00
>      594:	00 00 00 00 	.long 0x0
>      598:	00 06 7c 00 	.long 0x67c00
>      59c:	00 00 00 00 	.long 0x0
>      5a0:	00 06 cc 00 	.long 0x6cc00
>      5a4:	01 58 00 00 	.long 0x1580000
>      5a8:	00 00 00 00 	.long 0x0
>      5ac:	07 20 00 00 	.long 0x7200000
>      5b0:	00 00 00 00 	.long 0x0
>      5b4:	07 60 00 01 	.long 0x7600001
>      5b8:	58 00 00 00 	rlmi    r0,r0,r0,0,0
> 	...
>      5cc:	00 00 00 05 	.long 0x5
>      5d0:	bc 00 00 00 	stmw    r0,0(0)
>      5d4:	00 00 00 06 	.long 0x6
>      5d8:	cc 00 01 57 	lfdu    f0,343(0)
>      5dc:	00 00 00 00 	.long 0x0
>      5e0:	00 00 07 20 	.long 0x720
>      5e4:	00 00 00 00 	.long 0x0
>      5e8:	00 00 07 60 	.long 0x760
>      5ec:	00 01 57 00 	.long 0x15700
> 	...
>      604:	00 05 a8 00 	.long 0x5a800
>      608:	00 00 00 00 	.long 0x0
>      60c:	00 05 d0 00 	.long 0x5d000
>      610:	01 5a 00 00 	.long 0x15a0000
>      614:	00 00 00 00 	.long 0x0
>      618:	05 d8 00 00 	.long 0x5d80000
>      61c:	00 00 00 00 	.long 0x0
>      620:	05 e8 00 01 	.long 0x5e80001
>      624:	5b 00 00 00 	rlmi    r0,r24,r0,0,0
>      628:	00 00 00 05 	.long 0x5
>      62c:	f0 00 00 00 	.long 0xf0000000
>      630:	00 00 00 06 	.long 0x6
>      634:	44 00 01 5a 	sc      10
>      638:	00 00 00 00 	.long 0x0
>      63c:	00 00 06 44 	.long 0x644
>      640:	00 00 00 00 	.long 0x0
>      644:	00 00 06 78 	.long 0x678
>      648:	00 01 58 00 	.long 0x15800
>      64c:	00 00 00 00 	.long 0x0
>      650:	00 06 78 00 	.long 0x67800
>      654:	00 00 00 00 	.long 0x0
>      658:	00 06 cc 00 	.long 0x6cc00
>      65c:	01 5a 00 00 	.long 0x15a0000
>      660:	00 00 00 00 	.long 0x0
>      664:	07 20 00 00 	.long 0x7200000
>      668:	00 00 00 00 	.long 0x0
>      66c:	07 60 00 01 	.long 0x7600001
>      670:	5a 00 00 00 	rlmi    r0,r16,r0,0,0
> 	...
>      684:	00 00 00 08 	.long 0x8
>      688:	30 00 00 00 	addic   r0,r0,0
>      68c:	00 00 00 08 	.long 0x8
>      690:	6c 00 01 51 	xoris   r0,r0,337
>      694:	00 00 00 00 	.long 0x0
>      698:	00 00 08 6c 	.long 0x86c
>      69c:	00 00 00 00 	.long 0x0
>      6a0:	00 00 0c 68 	.long 0xc68
>      6a4:	00 04 71 d0 	.long 0x471d0
>      6a8:	8b 01 00 00 	lbz     r24,0(r1)
> 	...
>      6c0:	08 30 00 00 	tdlgti  r16,0
>      6c4:	00 00 00 00 	.long 0x0
>      6c8:	08 84 00 01 	tdeqi   r4,1
>      6cc:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>      6d0:	00 00 00 08 	.long 0x8
>      6d4:	84 00 00 00 	lwzu    r0,0(0)
>      6d8:	00 00 00 08 	.long 0x8
>      6dc:	ec 00 01 69 	.long 0xec000169
>      6e0:	00 00 00 00 	.long 0x0
>      6e4:	00 00 09 0c 	.long 0x90c
>      6e8:	00 00 00 00 	.long 0x0
>      6ec:	00 00 0b d4 	.long 0xbd4
>      6f0:	00 01 69 00 	.long 0x16900
>      6f4:	00 00 00 00 	.long 0x0
>      6f8:	00 0b f4 00 	.long 0xbf400
>      6fc:	00 00 00 00 	.long 0x0
>      700:	00 0c 68 00 	.long 0xc6800
>      704:	01 69 00 00 	.long 0x1690000
> 	...
>      71c:	09 6c 00 00 	tdi     11,r12,0
>      720:	00 00 00 00 	.long 0x0
>      724:	0b 34 00 01 	tdi     25,r20,1
>      728:	6d 00 00 00 	xoris   r0,r8,0
> 	...
>      73c:	00 00 00 09 	.long 0x9
>      740:	6c 00 00 00 	xoris   r0,r0,0
>      744:	00 00 00 0a 	.long 0xa
>      748:	60 00 01 6c 	ori     r0,r0,364
>      74c:	00 00 00 00 	.long 0x0
>      750:	00 00 0a 60 	.long 0xa60
>      754:	00 00 00 00 	.long 0x0
>      758:	00 00 0a 6c 	.long 0xa6c
>      75c:	00 01 50 00 	.long 0x15000
>      760:	00 00 00 00 	.long 0x0
>      764:	00 0a 6c 00 	.long 0xa6c00
>      768:	00 00 00 00 	.long 0x0
>      76c:	00 0b 58 00 	.long 0xb5800
>      770:	01 6c 00 00 	.long 0x16c0000
> 	...
>      788:	09 c0 00 00 	tdi     14,r0,0
>      78c:	00 00 00 00 	.long 0x0
>      790:	0a cc 00 01 	tdi     22,r12,1
>      794:	57 00 00 00 	rlwinm  r0,r24,0,0,0
>      798:	00 00 00 0b 	.long 0xb
>      79c:	30 00 00 00 	addic   r0,r0,0
>      7a0:	00 00 00 0b 	.long 0xb
>      7a4:	74 00 01 57 	andis.  r0,r0,343
> 	...
>      7bc:	00 00 09 c0 	.long 0x9c0
>      7c0:	00 00 00 00 	.long 0x0
>      7c4:	00 00 09 d4 	.long 0x9d4
>      7c8:	00 01 58 00 	.long 0x15800
>      7cc:	00 00 00 00 	.long 0x0
>      7d0:	00 09 fc 00 	.long 0x9fc00
>      7d4:	00 00 00 00 	.long 0x0
>      7d8:	00 0a 94 00 	.long 0xa9400
>      7dc:	01 58 00 00 	.long 0x1580000
> 	...
>      7f4:	09 50 00 00 	tdi     10,r16,0
>      7f8:	00 00 00 00 	.long 0x0
>      7fc:	09 98 00 01 	tdgei   r24,1
>      800:	6e 00 00 00 	xoris   r0,r16,0
>      804:	00 00 00 09 	.long 0x9
>      808:	98 00 00 00 	stb     r0,0(0)
>      80c:	00 00 00 09 	.long 0x9
>      810:	d0 00 01 5a 	stfs    f0,346(0)
>      814:	00 00 00 00 	.long 0x0
>      818:	00 00 09 dc 	.long 0x9dc
>      81c:	00 00 00 00 	.long 0x0
>      820:	00 00 09 f0 	.long 0x9f0
>      824:	00 01 5b 00 	.long 0x15b00
>      828:	00 00 00 00 	.long 0x0
>      82c:	00 09 f8 00 	.long 0x9f800
>      830:	00 00 00 00 	.long 0x0
>      834:	00 0a 48 00 	.long 0xa4800
>      838:	01 5a 00 00 	.long 0x15a0000
>      83c:	00 00 00 00 	.long 0x0
>      840:	0a 48 00 00 	tdi     18,r8,0
>      844:	00 00 00 00 	.long 0x0
>      848:	0a 70 00 01 	tdi     19,r16,1
>      84c:	5b 00 00 00 	rlmi    r0,r24,r0,0,0
>      850:	00 00 00 0a 	.long 0xa
>      854:	84 00 00 00 	lwzu    r0,0(0)
>      858:	00 00 00 0a 	.long 0xa
>      85c:	b4 00 01 5a 	sthu    r0,346(0)
>      860:	00 00 00 00 	.long 0x0
>      864:	00 00 0a b4 	.long 0xab4
>      868:	00 00 00 00 	.long 0x0
>      86c:	00 00 0b 70 	.long 0xb70
>      870:	00 01 6e 00 	.long 0x16e00
>      874:	00 00 00 00 	.long 0x0
>      878:	00 0b 70 00 	.long 0xb7000
>      87c:	00 00 00 00 	.long 0x0
>      880:	00 0b 74 00 	.long 0xb7400
>      884:	01 5a 00 00 	.long 0x15a0000
> 	...
>      89c:	09 58 00 00 	tdi     10,r24,0
>      8a0:	00 00 00 00 	.long 0x0
>      8a4:	0b e0 00 01 	tdi     31,r0,1
>      8a8:	6b 00 00 00 	xori    r0,r24,0
> 	...
>      8bc:	00 00 00 09 	.long 0x9
>      8c0:	ac 00 00 00 	lhau    r0,0(0)
>      8c4:	00 00 00 0a 	.long 0xa
>      8c8:	c0 00 01 55 	lfs     f0,341(0)
>      8cc:	00 00 00 00 	.long 0x0
>      8d0:	00 00 0b 30 	.long 0xb30
>      8d4:	00 00 00 00 	.long 0x0
>      8d8:	00 00 0b 74 	.long 0xb74
>      8dc:	00 01 55 00 	.long 0x15500
> 	...
>      8f4:	00 0c 70 00 	.long 0xc7000
>      8f8:	00 00 00 00 	.long 0x0
>      8fc:	00 0c c0 00 	.long 0xcc000
>      900:	01 51 00 00 	.long 0x1510000
>      904:	00 00 00 00 	.long 0x0
>      908:	0c c0 00 00 	twllei  r0,0
>      90c:	00 00 00 00 	.long 0x0
>      910:	11 00 00 03 	.long 0x11000003
>      914:	71 80 03 00 	andi.   r0,r12,768
> 	...
>      92c:	00 0c 70 00 	.long 0xc7000
>      930:	00 00 00 00 	.long 0x0
>      934:	00 0c cc 00 	.long 0xccc00
>      938:	01 53 00 00 	.long 0x1530000
>      93c:	00 00 00 00 	.long 0x0
>      940:	0c cc 00 00 	twllei  r12,0
>      944:	00 00 00 00 	.long 0x0
>      948:	0d fc 00 01 	twi     15,r28,1
>      94c:	69 00 00 00 	xori    r0,r8,0
>      950:	00 00 00 0e 	.long 0xe
>      954:	18 00 00 00 	.long 0x18000000
>      958:	00 00 00 11 	.long 0x11
>      95c:	00 00 01 69 	.long 0x169
> 	...
>      974:	00 00 0c 70 	.long 0xc70
>      978:	00 00 00 00 	.long 0x0
>      97c:	00 00 0c f8 	.long 0xcf8
>      980:	00 01 54 00 	.long 0x15400
>      984:	00 00 00 00 	.long 0x0
>      988:	00 0d 54 00 	.long 0xd5400
>      98c:	00 00 00 00 	.long 0x0
>      990:	00 0d 64 00 	.long 0xd6400
>      994:	01 54 00 00 	.long 0x1540000
>      998:	00 00 00 00 	.long 0x0
>      99c:	0d ac 00 00 	twi     13,r12,0
>      9a0:	00 00 00 00 	.long 0x0
>      9a4:	0d bc 00 01 	twi     13,r28,1
>      9a8:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      9ac:	00 00 00 10 	.long 0x10
>      9b0:	c4 00 00 00 	lfsu    f0,0(0)
>      9b4:	00 00 00 10 	.long 0x10
>      9b8:	d8 00 01 54 	stfd    f0,340(0)
> 	...
>      9d0:	00 00 0c 70 	.long 0xc70
>      9d4:	00 00 00 00 	.long 0x0
>      9d8:	00 00 0c cc 	.long 0xccc
>      9dc:	00 01 55 00 	.long 0x15500
>      9e0:	00 00 00 00 	.long 0x0
>      9e4:	00 0c cc 00 	.long 0xccc00
>      9e8:	00 00 00 00 	.long 0x0
>      9ec:	00 0d f4 00 	.long 0xdf400
>      9f0:	01 67 00 00 	.long 0x1670000
>      9f4:	00 00 00 00 	.long 0x0
>      9f8:	0e 18 00 00 	twlti   r24,0
>      9fc:	00 00 00 00 	.long 0x0
>      a00:	11 00 00 01 	.long 0x11000001
>      a04:	67 00 00 00 	oris    r0,r24,0
> 	...
>      a18:	00 00 00 0c 	.long 0xc
>      a1c:	f8 00 00 00 	std     r0,0(0)
>      a20:	00 00 00 0e 	.long 0xe
>      a24:	14 00 01 6f 	.long 0x1400016f
>      a28:	00 00 00 00 	.long 0x0
>      a2c:	00 00 0e 18 	.long 0xe18
>      a30:	00 00 00 00 	.long 0x0
>      a34:	00 00 10 c4 	.long 0x10c4
>      a38:	00 01 6f 00 	.long 0x16f00
>      a3c:	00 00 00 00 	.long 0x0
>      a40:	00 10 d8 00 	.long 0x10d800
>      a44:	00 00 00 00 	.long 0x0
>      a48:	00 11 00 00 	.long 0x110000
>      a4c:	01 6f 00 00 	.long 0x16f0000
> 	...
>      a64:	0c dc 00 00 	twllei  r28,0
>      a68:	00 00 00 00 	.long 0x0
>      a6c:	0e 04 00 01 	twlti   r4,1
>      a70:	6b 00 00 00 	xori    r0,r24,0
>      a74:	00 00 00 0e 	.long 0xe
>      a78:	18 00 00 00 	.long 0x18000000
>      a7c:	00 00 00 10 	.long 0x10
>      a80:	c4 00 01 6b 	lfsu    f0,363(0)
>      a84:	00 00 00 00 	.long 0x0
>      a88:	00 00 10 d8 	.long 0x10d8
>      a8c:	00 00 00 00 	.long 0x0
>      a90:	00 00 11 00 	.long 0x1100
>      a94:	00 01 6b 00 	.long 0x16b00
> 	...
>      aac:	00 0c f8 00 	.long 0xcf800
>      ab0:	00 00 00 00 	.long 0x0
>      ab4:	00 0e 0c 00 	.long 0xe0c00
>      ab8:	01 6d 00 00 	.long 0x16d0000
>      abc:	00 00 00 00 	.long 0x0
>      ac0:	0e 18 00 00 	twlti   r24,0
>      ac4:	00 00 00 00 	.long 0x0
>      ac8:	0f 44 00 01 	twi     26,r4,1
>      acc:	6d 00 00 00 	xoris   r0,r8,0
>      ad0:	00 00 00 0f 	.long 0xf
>      ad4:	94 00 00 00 	stwu    r0,0(0)
>      ad8:	00 00 00 0f 	.long 0xf
>      adc:	98 00 01 53 	stb     r0,339(0)
>      ae0:	00 00 00 00 	.long 0x0
>      ae4:	00 00 10 d8 	.long 0x10d8
>      ae8:	00 00 00 00 	.long 0x0
>      aec:	00 00 11 00 	.long 0x1100
>      af0:	00 01 6d 00 	.long 0x16d00
> 	...
>      b08:	00 0c f8 00 	.long 0xcf800
>      b0c:	00 00 00 00 	.long 0x0
>      b10:	00 0d e0 00 	.long 0xde000
>      b14:	01 63 00 00 	.long 0x1630000
>      b18:	00 00 00 00 	.long 0x0
>      b1c:	0e 18 00 00 	twlti   r24,0
>      b20:	00 00 00 00 	.long 0x0
>      b24:	10 c4 00 01 	.long 0x10c40001
>      b28:	63 00 00 00 	ori     r0,r24,0
>      b2c:	00 00 00 10 	.long 0x10
>      b30:	d8 00 00 00 	stfd    f0,0(0)
>      b34:	00 00 00 11 	.long 0x11
>      b38:	00 00 01 63 	.long 0x163
> 	...
>      b50:	00 00 11 00 	.long 0x1100
>      b54:	00 00 00 00 	.long 0x0
>      b58:	00 00 11 40 	.long 0x1140
>      b5c:	00 01 51 00 	.long 0x15100
>      b60:	00 00 00 00 	.long 0x0
>      b64:	00 11 40 00 	.long 0x114000
>      b68:	00 00 00 00 	.long 0x0
>      b6c:	00 17 4c 00 	.long 0x174c00
>      b70:	03 71 f0 0a 	.long 0x371f00a
> 	...
>      b88:	00 00 12 18 	.long 0x1218
>      b8c:	00 00 00 00 	.long 0x0
>      b90:	00 00 13 84 	.long 0x1384
>      b94:	00 01 6f 00 	.long 0x16f00
>      b98:	00 00 00 00 	.long 0x0
>      b9c:	00 13 88 00 	.long 0x138800
>      ba0:	00 00 00 00 	.long 0x0
>      ba4:	00 15 c8 00 	.long 0x15c800
>      ba8:	01 6f 00 00 	.long 0x16f0000
>      bac:	00 00 00 00 	.long 0x0
>      bb0:	16 1c 00 00 	.long 0x161c0000
>      bb4:	00 00 00 00 	.long 0x0
>      bb8:	17 4c 00 01 	.long 0x174c0001
>      bbc:	6f 00 00 00 	xoris   r0,r24,0
> 	...
>      bd0:	00 00 00 11 	.long 0x11
>      bd4:	ec 00 00 00 	.long 0xec000000
>      bd8:	00 00 00 13 	.long 0x13
>      bdc:	58 00 01 66 	rlmi    r0,r0,r0,5,19
>      be0:	00 00 00 00 	.long 0x0
>      be4:	00 00 13 88 	.long 0x1388
>      be8:	00 00 00 00 	.long 0x0
>      bec:	00 00 15 c8 	.long 0x15c8
>      bf0:	00 01 66 00 	.long 0x16600
>      bf4:	00 00 00 00 	.long 0x0
>      bf8:	00 16 1c 00 	.long 0x161c00
>      bfc:	00 00 00 00 	.long 0x0
>      c00:	00 17 4c 00 	.long 0x174c00
>      c04:	01 66 00 00 	.long 0x1660000
> 	...
>      c1c:	12 10 00 00 	vaddubm v16,v16,v0
>      c20:	00 00 00 00 	.long 0x0
>      c24:	15 c8 00 03 	.long 0x15c80003
>      c28:	91 80 76 00 	stw     r12,30208(0)
>      c2c:	00 00 00 00 	.long 0x0
>      c30:	00 16 1c 00 	.long 0x161c00
>      c34:	00 00 00 00 	.long 0x0
>      c38:	00 17 4c 00 	.long 0x174c00
>      c3c:	03 91 80 76 	.long 0x3918076
> 	...
>      c54:	00 00 11 c8 	.long 0x11c8
>      c58:	00 00 00 00 	.long 0x0
>      c5c:	00 00 11 cc 	.long 0x11cc
>      c60:	00 01 53 00 	.long 0x15300
>      c64:	00 00 00 00 	.long 0x0
>      c68:	00 13 88 00 	.long 0x138800
>      c6c:	00 00 00 00 	.long 0x0
>      c70:	00 17 4c 00 	.long 0x174c00
>      c74:	01 69 00 00 	.long 0x1690000
> 	...
>      c8c:	12 58 00 00 	vaddubm v18,v24,v0
>      c90:	00 00 00 00 	.long 0x0
>      c94:	13 74 00 01 	.long 0x13740001
>      c98:	6c 00 00 00 	xoris   r0,r0,0
>      c9c:	00 00 00 14 	.long 0x14
>      ca0:	98 00 00 00 	stb     r0,0(0)
>      ca4:	00 00 00 14 	.long 0x14
>      ca8:	e0 00 01 6c 	.long 0xe000016c
> 	...
>      cc0:	00 00 12 4c 	.long 0x124c
>      cc4:	00 00 00 00 	.long 0x0
>      cc8:	00 00 13 88 	.long 0x1388
>      ccc:	00 03 91 88 	.long 0x39188
>      cd0:	76 00 00 00 	andis.  r0,r16,0
>      cd4:	00 00 00 13 	.long 0x13
>      cd8:	94 00 00 00 	stwu    r0,0(0)
>      cdc:	00 00 00 14 	.long 0x14
>      ce0:	6c 00 03 71 	xoris   r0,r0,881
>      ce4:	f8 00 00 00 	std     r0,0(0)
>      ce8:	00 00 00 00 	.long 0x0
>      cec:	14 6c 00 00 	.long 0x146c0000
>      cf0:	00 00 00 00 	.long 0x0
>      cf4:	14 7c 00 03 	.long 0x147c0003
>      cf8:	91 88 76 00 	stw     r12,30208(r8)
>      cfc:	00 00 00 00 	.long 0x0
>      d00:	00 14 7c 00 	.long 0x147c00
>      d04:	00 00 00 00 	.long 0x0
>      d08:	00 14 98 00 	.long 0x149800
>      d0c:	03 71 f8 00 	.long 0x371f800
>      d10:	00 00 00 00 	.long 0x0
>      d14:	00 00 14 98 	.long 0x1498
>      d18:	00 00 00 00 	.long 0x0
>      d1c:	00 00 14 e0 	.long 0x14e0
>      d20:	00 03 91 88 	.long 0x39188
>      d24:	76 00 00 00 	andis.  r0,r16,0
>      d28:	00 00 00 16 	.long 0x16
>      d2c:	1c 00 00 00 	mulli   r0,r0,0
>      d30:	00 00 00 16 	.long 0x16
>      d34:	a0 00 03 71 	lhz     r0,881(0)
>      d38:	f8 00 00 00 	std     r0,0(0)
>      d3c:	00 00 00 00 	.long 0x0
>      d40:	16 a0 00 00 	.long 0x16a00000
>      d44:	00 00 00 00 	.long 0x0
>      d48:	16 ac 00 01 	.long 0x16ac0001
>      d4c:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>      d50:	00 00 00 16 	.long 0x16
>      d54:	ac 00 00 00 	lhau    r0,0(0)
>      d58:	00 00 00 17 	.long 0x17
>      d5c:	14 00 03 91 	.long 0x14000391
>      d60:	88 76 00 00 	lbz     r3,0(r22)
>      d64:	00 00 00 00 	.long 0x0
>      d68:	17 14 00 00 	.long 0x17140000
>      d6c:	00 00 00 00 	.long 0x0
>      d70:	17 20 00 01 	.long 0x17200001
>      d74:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>      d78:	00 00 00 17 	.long 0x17
>      d7c:	20 00 00 00 	subfic  r0,r0,0
>      d80:	00 00 00 17 	.long 0x17
>      d84:	2c 00 03 91 	cmpwi   r0,913
>      d88:	88 76 00 00 	lbz     r3,0(r22)
>      d8c:	00 00 00 00 	.long 0x0
>      d90:	17 2c 00 00 	.long 0x172c0000
>      d94:	00 00 00 00 	.long 0x0
>      d98:	17 4c 00 03 	.long 0x174c0003
>      d9c:	71 f8 00 00 	andi.   r24,r15,0
> 	...
>      db4:	00 14 10 00 	.long 0x141000
>      db8:	00 00 00 00 	.long 0x0
>      dbc:	00 14 20 00 	.long 0x142000
>      dc0:	01 53 00 00 	.long 0x1530000
>      dc4:	00 00 00 00 	.long 0x0
>      dc8:	14 7c 00 00 	.long 0x147c0000
>      dcc:	00 00 00 00 	.long 0x0
>      dd0:	14 8c 00 01 	.long 0x148c0001
>      dd4:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>      dd8:	00 00 00 16 	.long 0x16
>      ddc:	58 00 00 00 	rlmi    r0,r0,r0,0,0
>      de0:	00 00 00 16 	.long 0x16
>      de4:	5c 00 01 53 	rlwnm.  r0,r0,r0,5,9
> 	...
>      dfc:	00 00 12 4c 	.long 0x124c
>      e00:	00 00 00 00 	.long 0x0
>      e04:	00 00 13 88 	.long 0x1388
>      e08:	00 03 91 90 	.long 0x39190
>      e0c:	76 00 00 00 	andis.  r0,r16,0
>      e10:	00 00 00 13 	.long 0x13
>      e14:	c4 00 00 00 	lfsu    f0,0(0)
>      e18:	00 00 00 14 	.long 0x14
>      e1c:	50 00 03 71 	rlwimi. r0,r0,0,13,24
>      e20:	80 01 00 00 	lwz     r0,0(r1)
>      e24:	00 00 00 00 	.long 0x0
>      e28:	14 50 00 00 	.long 0x14500000
>      e2c:	00 00 00 00 	.long 0x0
>      e30:	14 7c 00 03 	.long 0x147c0003
>      e34:	91 90 76 00 	stw     r12,30208(r16)
>      e38:	00 00 00 00 	.long 0x0
>      e3c:	00 14 7c 00 	.long 0x147c00
>      e40:	00 00 00 00 	.long 0x0
>      e44:	00 14 80 00 	.long 0x148000
>      e48:	03 71 80 01 	.long 0x3718001
>      e4c:	00 00 00 00 	.long 0x0
>      e50:	00 00 14 80 	.long 0x1480
>      e54:	00 00 00 00 	.long 0x0
>      e58:	00 00 14 e0 	.long 0x14e0
>      e5c:	00 03 91 90 	.long 0x39190
>      e60:	76 00 00 00 	andis.  r0,r16,0
>      e64:	00 00 00 16 	.long 0x16
>      e68:	58 00 00 00 	rlmi    r0,r0,r0,0,0
>      e6c:	00 00 00 17 	.long 0x17
>      e70:	2c 00 03 91 	cmpwi   r0,913
>      e74:	90 76 00 00 	stw     r3,0(r22)
>      e78:	00 00 00 00 	.long 0x0
>      e7c:	17 2c 00 00 	.long 0x172c0000
>      e80:	00 00 00 00 	.long 0x0
>      e84:	17 4c 00 03 	.long 0x174c0003
>      e88:	71 80 01 00 	andi.   r0,r12,256
> 	...
>      ea0:	00 14 64 00 	.long 0x146400
>      ea4:	00 00 00 00 	.long 0x0
>      ea8:	00 14 80 00 	.long 0x148000
>      eac:	01 6c 00 00 	.long 0x16c0000
>      eb0:	00 00 00 00 	.long 0x0
>      eb4:	17 14 00 00 	.long 0x17140000
>      eb8:	00 00 00 00 	.long 0x0
>      ebc:	17 2c 00 01 	.long 0x172c0001
>      ec0:	6c 00 00 00 	xoris   r0,r0,0
> 	...
>      ed4:	00 00 00 12 	.long 0x12
>      ed8:	34 00 00 00 	addic.  r0,r0,0
>      edc:	00 00 00 14 	.long 0x14
>      ee0:	e0 00 03 91 	.long 0xe0000391
>      ee4:	88 76 00 00 	lbz     r3,0(r22)
>      ee8:	00 00 00 00 	.long 0x0
>      eec:	15 94 00 00 	.long 0x15940000
>      ef0:	00 00 00 00 	.long 0x0
>      ef4:	15 c8 00 03 	.long 0x15c80003
>      ef8:	71 f8 00 00 	andi.   r24,r15,0
>      efc:	00 00 00 00 	.long 0x0
>      f00:	00 16 1c 00 	.long 0x161c00
>      f04:	00 00 00 00 	.long 0x0
>      f08:	00 17 4c 00 	.long 0x174c00
>      f0c:	03 91 88 76 	.long 0x3918876
> 	...
>      f24:	00 00 17 50 	.long 0x1750
>      f28:	00 00 00 00 	.long 0x0
>      f2c:	00 00 17 78 	.long 0x1778
>      f30:	00 01 51 00 	.long 0x15100
>      f34:	00 00 00 00 	.long 0x0
>      f38:	00 17 78 00 	.long 0x177800
>      f3c:	00 00 00 00 	.long 0x0
>      f40:	00 19 8c 00 	.long 0x198c00
>      f44:	03 71 b0 01 	.long 0x371b001
> 	...
>      f5c:	00 00 17 50 	.long 0x1750
>      f60:	00 00 00 00 	.long 0x0
>      f64:	00 00 17 98 	.long 0x1798
>      f68:	00 01 53 00 	.long 0x15300
>      f6c:	00 00 00 00 	.long 0x0
>      f70:	00 17 98 00 	.long 0x179800
>      f74:	00 00 00 00 	.long 0x0
>      f78:	00 18 c0 00 	.long 0x18c000
>      f7c:	01 6c 00 00 	.long 0x16c0000
> 	...
>      f94:	17 50 00 00 	.long 0x17500000
>      f98:	00 00 00 00 	.long 0x0
>      f9c:	17 c0 00 01 	.long 0x17c00001
>      fa0:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      fa4:	00 00 00 17 	.long 0x17
>      fa8:	c0 00 00 00 	lfs     f0,0(0)
>      fac:	00 00 00 19 	.long 0x19
>      fb0:	60 00 01 69 	ori     r0,r0,361
> 	...
>      fc8:	00 00 17 50 	.long 0x1750
>      fcc:	00 00 00 00 	.long 0x0
>      fd0:	00 00 17 c0 	.long 0x17c0
>      fd4:	00 01 55 00 	.long 0x15500
>      fd8:	00 00 00 00 	.long 0x0
>      fdc:	00 17 c0 00 	.long 0x17c000
>      fe0:	00 00 00 00 	.long 0x0
>      fe4:	00 17 f4 00 	.long 0x17f400
>      fe8:	01 6e 00 00 	.long 0x16e0000
> 	...
>     1000:	17 f8 00 00 	.long 0x17f80000
>     1004:	00 00 00 00 	.long 0x0
>     1008:	18 5c 00 01 	.long 0x185c0001
>     100c:	5b 00 00 00 	rlmi    r0,r24,r0,0,0
>     1010:	00 00 00 18 	.long 0x18
>     1014:	6c 00 00 00 	xoris   r0,r0,0
>     1018:	00 00 00 18 	.long 0x18
>     101c:	7c 00 01 53 	.long 0x7c000153
> 	...
>     1034:	00 00 19 00 	.long 0x1900
>     1038:	00 00 00 00 	.long 0x0
>     103c:	00 00 19 70 	.long 0x1970
>     1040:	00 01 6d 00 	.long 0x16d00
> 	...
>     1058:	00 19 90 00 	.long 0x199000
>     105c:	00 00 00 00 	.long 0x0
>     1060:	00 19 a8 00 	.long 0x19a800
>     1064:	01 51 00 00 	.long 0x1510000
>     1068:	00 00 00 00 	.long 0x0
>     106c:	19 a8 00 00 	.long 0x19a80000
>     1070:	00 00 00 00 	.long 0x0
>     1074:	1a 50 00 03 	.long 0x1a500003
>     1078:	71 90 01 00 	andi.   r16,r12,256
> 	...
>     1090:	00 19 90 00 	.long 0x199000
>     1094:	00 00 00 00 	.long 0x0
>     1098:	00 19 c0 00 	.long 0x19c000
>     109c:	01 53 00 00 	.long 0x1530000
> 	...
>     10b4:	19 90 00 00 	.long 0x19900000
>     10b8:	00 00 00 00 	.long 0x0
>     10bc:	19 b4 00 01 	.long 0x19b40001
>     10c0:	54 00 00 00 	rlwinm  r0,r0,0,0,0
> 	...
>     10d4:	00 00 00 19 	.long 0x19
>     10d8:	b8 00 00 00 	lmw     r0,0(0)
>     10dc:	00 00 00 1a 	.long 0x1a
>     10e0:	3c 00 01 6f 	lis     r0,367
> 	...
>     10f8:	00 00 19 bc 	.long 0x19bc
>     10fc:	00 00 00 00 	.long 0x0
>     1100:	00 00 1a 38 	.long 0x1a38
>     1104:	00 01 6e 00 	.long 0x16e00
> 	...
> 
> Disassembly of section .debug_pubnames:
> 
> 0000000000000000 <.debug_pubnames>:
>    0:	00 00 00 4f 	.long 0x4f
>    4:	00 02 00 00 	.long 0x20000
>    8:	00 00 00 00 	.long 0x0
>    c:	13 1d 00 00 	vaddubm v24,v29,v0
>   10:	06 7e 72 65 	.long 0x67e7265
>   14:	73 65 72 76 	andi.   r5,r27,29302
>   18:	65 00 00 00 	oris    r0,r8,0
>   1c:	10 4d 63 72 	.long 0x104d6372
>   20:	65 61 74 65 	oris    r1,r11,29797
>   24:	5f 66 6c 61 	rlwnm.  r6,r27,r13,17,16
>   28:	74 74 65 6e 	andis.  r20,r3,25966
>   2c:	5f 74 72 65 	rlwnm.  r20,r27,r14,9,18
>   30:	65 00 00 00 	oris    r0,r8,0
>   34:	12 f0 6c 6d 	.long 0x12f06c6d
>   38:	62 5f 73 69 	ori     r31,r18,29545
>   3c:	7a 65 00 00 	rotldi  r5,r19,0
>   40:	00 13 06 6e 	.long 0x13066e
>   44:	75 6d 5f 6f 	andis.  r13,r11,24431
>   48:	66 5f 6c 6d 	oris    r31,r18,27757
>   4c:	62 73 00 00 	ori     r19,r19,0
>   50:	Address 0x0000000000000050 is out of bounds.
> 
> 
> Disassembly of section .debug_aranges:
> 
> 0000000000000000 <.debug_aranges>:
>    0:	00 00 00 2c 	.long 0x2c
>    4:	00 02 00 00 	.long 0x20000
>    8:	00 00 08 00 	.long 0x800
> 	...
>   1c:	00 00 1a 50 	.long 0x1a50
> 	...
> 
> Disassembly of section .debug_ranges:
> 
> 0000000000000000 <.debug_ranges>:
>    0:	00 00 00 00 	.long 0x0
>    4:	00 00 03 64 	.long 0x364
>    8:	00 00 00 00 	.long 0x0
>    c:	00 00 03 68 	.long 0x368
>   10:	00 00 00 00 	.long 0x0
>   14:	00 00 03 a8 	.long 0x3a8
>   18:	00 00 00 00 	.long 0x0
>   1c:	00 00 03 bc 	.long 0x3bc
> 	...
>   34:	00 00 0c dc 	.long 0xcdc
>   38:	00 00 00 00 	.long 0x0
>   3c:	00 00 0c e0 	.long 0xce0
>   40:	00 00 00 00 	.long 0x0
>   44:	00 00 0c f0 	.long 0xcf0
>   48:	00 00 00 00 	.long 0x0
>   4c:	00 00 0d 14 	.long 0xd14
> 	...
>   64:	00 00 0d 28 	.long 0xd28
>   68:	00 00 00 00 	.long 0x0
>   6c:	00 00 0d 38 	.long 0xd38
>   70:	00 00 00 00 	.long 0x0
>   74:	00 00 0e 84 	.long 0xe84
>   78:	00 00 00 00 	.long 0x0
>   7c:	00 00 0e 94 	.long 0xe94
> 	...
>   94:	00 00 12 50 	.long 0x1250
>   98:	00 00 00 00 	.long 0x0
>   9c:	00 00 12 54 	.long 0x1254
>   a0:	00 00 00 00 	.long 0x0
>   a4:	00 00 12 d0 	.long 0x12d0
>   a8:	00 00 00 00 	.long 0x0
>   ac:	00 00 12 dc 	.long 0x12dc
>   b0:	00 00 00 00 	.long 0x0
>   b4:	00 00 12 5c 	.long 0x125c
>   b8:	00 00 00 00 	.long 0x0
>   bc:	00 00 12 78 	.long 0x1278
> 	...
>   d4:	00 00 12 cc 	.long 0x12cc
>   d8:	00 00 00 00 	.long 0x0
>   dc:	00 00 12 d0 	.long 0x12d0
>   e0:	00 00 00 00 	.long 0x0
>   e4:	00 00 12 dc 	.long 0x12dc
>   e8:	00 00 00 00 	.long 0x0
>   ec:	00 00 12 e8 	.long 0x12e8
> 	...
>  104:	00 00 12 cc 	.long 0x12cc
>  108:	00 00 00 00 	.long 0x0
>  10c:	00 00 12 d0 	.long 0x12d0
>  110:	00 00 00 00 	.long 0x0
>  114:	00 00 12 dc 	.long 0x12dc
>  118:	00 00 00 00 	.long 0x0
>  11c:	00 00 12 e8 	.long 0x12e8
> 	...
>  134:	00 00 13 90 	.long 0x1390
>  138:	00 00 00 00 	.long 0x0
>  13c:	00 00 14 a0 	.long 0x14a0
>  140:	00 00 00 00 	.long 0x0
>  144:	00 00 16 1c 	.long 0x161c
>  148:	00 00 00 00 	.long 0x0
>  14c:	00 00 17 40 	.long 0x1740
> 	...
>  164:	00 00 13 b0 	.long 0x13b0
>  168:	00 00 00 00 	.long 0x0
>  16c:	00 00 14 a0 	.long 0x14a0
>  170:	00 00 00 00 	.long 0x0
>  174:	00 00 17 14 	.long 0x1714
>  178:	00 00 00 00 	.long 0x0
>  17c:	00 00 17 40 	.long 0x1740
> 	...
> 
> Disassembly of section .debug_str:
> 
> 0000000000000000 <.debug_str>:
>    0:	5f 5f 6f 66 	rlwnm   r31,r26,r13,29,19
>    4:	66 5f 74 00 	oris    r31,r18,29696
>    8:	5f 5f 67 69 	rlwnm.  r31,r26,r12,29,20
>    c:	64 5f 74 00 	oris    r31,r2,29696
>   10:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>   14:	72 65 61 64 	andi.   r5,r19,24932
>   18:	5f 70 74 72 	rlwnm   r16,r27,r14,17,25
>   1c:	00 5f 63 68 	.long 0x5f6368
>   20:	61 69 6e 00 	ori     r9,r11,28160
>   24:	73 74 5f 63 	andi.   r20,r27,24419
>   28:	74 69 6d 00 	andis.  r9,r3,27904
>   2c:	63 6f 6d 70 	ori     r15,r27,28016
>   30:	61 72 65 66 	ori     r18,r11,25958
>   34:	75 6e 63 00 	andis.  r14,r11,25344
>   38:	73 69 7a 65 	andi.   r9,r27,31333
>   3c:	5f 74 00 77 	rlwnm.  r20,r27,r0,1,27
>   40:	68 65 72 65 	xori    r5,r3,29285
>   44:	00 5f 73 68 	.long 0x5f7368
>   48:	6f 72 74 62 	xoris   r18,r27,29794
>   4c:	75 66 00 5f 	andis.  r6,r11,95
>   50:	5f 70 61 74 	rlwnm   r16,r27,r12,5,26
>   54:	68 00 74 79 	xori    r0,r0,29817
>   58:	70 65 00 61 	andi.   r5,r3,97
>   5c:	64 64 5f 64 	oris    r4,r3,24420
>   60:	79 6e 5f 72 	rldcr   r14,r11,r11,61
>   64:	65 63 6f 6e 	oris    r3,r11,28526
>   68:	66 5f 75 73 	oris    r31,r18,30067
>   6c:	61 62 6c 65 	ori     r2,r11,27749
>   70:	5f 6d 65 6d 	rlwnm.  r13,r27,r12,21,22
>   74:	5f 70 72 6f 	rlwnm.  r16,r27,r14,9,23
>   78:	70 65 72 74 	andi.   r5,r3,29300
>   7c:	79 00 74 6f 	rldimi. r0,r8,46,49
>   80:	74 61 6c 73 	andis.  r1,r3,27763
>   84:	69 7a 65 00 	xori    r26,r11,25856
>   88:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>   8c:	62 75 66 5f 	ori     r21,r19,26207
>   90:	62 61 73 65 	ori     r1,r19,29541
>   94:	00 64 74 5f 	.long 0x64745f
>   98:	6c 65 6e 00 	xoris   r5,r3,28160
>   9c:	6c 6f 6e 67 	xoris   r15,r3,28263
>   a0:	20 6c 6f 6e 	subfic  r3,r12,28526
>   a4:	67 20 75 6e 	oris    r0,r25,30062
>   a8:	73 69 67 6e 	andi.   r9,r27,26478
>   ac:	65 64 20 69 	oris    r4,r11,8297
>   b0:	6e 74 00 5f 	xoris   r20,r19,95
>   b4:	5f 73 32 5f 	rlwnm.  r19,r27,r6,9,15
>   b8:	6c 65 6e 00 	xoris   r5,r3,28160
>   bc:	72 6e 67 73 	andi.   r14,r19,26483
>   c0:	5f 63 6e 74 	rlwnm   r3,r27,r13,25,26
>   c4:	00 6c 61 73 	.long 0x6c6173
>   c8:	74 5f 63 6f 	andis.  r31,r2,25455
>   cc:	6d 70 5f 76 	xoris   r16,r11,24438
>   d0:	65 72 73 69 	oris    r18,r11,29545
>   d4:	6f 6e 00 70 	xoris   r14,r27,112
>   d8:	72 6f 70 6e 	andi.   r15,r19,28782
>   dc:	61 6d 65 73 	ori     r13,r11,25971
>   e0:	00 70 75 74 	.long 0x707574
>   e4:	6e 6f 64 65 	xoris   r15,r19,25701
>   e8:	00 73 74 61 	.long 0x737461
>   ec:	74 00 6c 6f 	andis.  r0,r0,27759
>   f0:	6e 67 20 6c 	xoris   r7,r19,8300
>   f4:	6f 6e 67 20 	xoris   r14,r27,26400
>   f8:	69 6e 74 00 	xori    r14,r11,29696
>   fc:	73 69 67 6e 	andi.   r9,r27,26478
>  100:	65 64 20 63 	oris    r4,r11,8291
>  104:	68 61 72 00 	xori    r1,r3,29184
>  108:	73 74 5f 69 	andi.   r20,r27,24425
>  10c:	6e 6f 00 5f 	xoris   r15,r19,95
>  110:	5f 6d 6f 64 	rlwnm   r13,r27,r13,29,18
>  114:	65 5f 74 00 	oris    r31,r10,29696
>  118:	69 6e 69 74 	xori    r14,r11,26996
>  11c:	72 64 5f 65 	andi.   r4,r19,24421
>  120:	6e 64 00 5f 	xoris   r4,r19,95
>  124:	76 74 61 62 	andis.  r20,r19,24930
>  128:	6c 65 5f 6f 	xoris   r5,r3,24431
>  12c:	66 66 73 65 	oris    r6,r19,29541
>  130:	74 00 5f 66 	andis.  r0,r0,24422
>  134:	69 6c 65 6e 	xori    r12,r11,25966
>  138:	6f 00 62 75 	xoris   r0,r24,25205
>  13c:	66 70 00 5f 	oris    r16,r19,95
>  140:	5f 75 6e 75 	rlwnm.  r21,r27,r13,25,26
>  144:	73 65 64 34 	andi.   r5,r27,25652
>  148:	00 5f 5f 75 	.long 0x5f5f75
>  14c:	6e 75 73 65 	xoris   r21,r19,29541
>  150:	64 35 00 5f 	oris    r21,r1,95
>  154:	5f 75 6e 75 	rlwnm.  r21,r27,r13,25,26
>  158:	73 65 64 36 	andi.   r5,r27,25654
>  15c:	00 5f 5f 62 	.long 0x5f5f62
>  160:	6c 6b 63 6e 	xoris   r11,r3,25454
>  164:	74 5f 74 00 	andis.  r31,r2,29696
>  168:	6c 6f 6e 67 	xoris   r15,r3,28263
>  16c:	20 69 6e 74 	subfic  r3,r9,28276
>  170:	00 64 5f 72 	.long 0x645f72
>  174:	65 63 6c 65 	oris    r3,r11,27749
>  178:	6e 00 5f 66 	xoris   r0,r16,24422
>  17c:	6c 61 67 73 	xoris   r1,r3,26483
>  180:	00 72 6c 65 	.long 0x726c65
>  184:	6e 00 5f 5f 	xoris   r0,r16,24415
>  188:	73 73 69 7a 	andi.   r19,r27,27002
>  18c:	65 5f 74 00 	oris    r31,r10,29696
>  190:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>  194:	62 75 66 5f 	ori     r21,r19,26207
>  198:	65 6e 64 00 	oris    r14,r11,25600
>  19c:	5f 63 75 72 	rlwnm   r3,r27,r14,21,25
>  1a0:	5f 63 6f 6c 	rlwnm   r3,r27,r13,29,22
>  1a4:	75 6d 6e 00 	andis.  r13,r11,28160
>  1a8:	73 74 61 74 	andi.   r20,r27,24948
>  1ac:	62 75 66 00 	ori     r21,r19,26112
>  1b0:	72 65 75 73 	andi.   r5,r19,30067
>  1b4:	65 5f 69 6e 	oris    r31,r10,26990
>  1b8:	69 74 72 64 	xori    r20,r11,29284
>  1bc:	00 73 74 5f 	.long 0x73745f
>  1c0:	61 74 69 6d 	ori     r20,r11,26989
>  1c4:	00 5f 6f 66 	.long 0x5f6f66
>  1c8:	66 73 65 74 	oris    r19,r19,25972
>  1cc:	00 73 74 72 	.long 0x737472
>  1d0:	31 00 64 5f 	addic   r8,r0,25695
>  1d4:	6e 61 6d 65 	xoris   r1,r19,28005
>  1d8:	00 6d 65 6d 	.long 0x6d656d
>  1dc:	5f 72 67 6e 	rlwnm   r18,r27,r12,29,23
>  1e0:	73 5f 74 00 	andi.   r31,r26,29696
>  1e4:	73 74 72 32 	andi.   r20,r27,29234
>  1e8:	00 6f 66 66 	.long 0x6f6666
>  1ec:	5f 74 00 6d 	rlwnm.  r20,r27,r0,1,22
>  1f0:	65 6d 6f 72 	oris    r13,r11,28530
>  1f4:	79 5f 72 61 	rldicl. r31,r10,14,41
>  1f8:	6e 67 65 00 	xoris   r7,r19,25856
>  1fc:	73 74 5f 62 	andi.   r20,r27,24418
>  200:	6c 6f 63 6b 	xoris   r15,r3,25451
>  204:	73 00 73 74 	andi.   r0,r24,29556
>  208:	5f 75 69 64 	rlwnm   r21,r27,r13,5,18
>  20c:	00 5f 49 4f 	.long 0x5f494f
>  210:	5f 6d 61 72 	rlwnm   r13,r27,r12,5,25
>  214:	6b 65 72 00 	xori    r5,r27,29184
>  218:	73 74 64 69 	andi.   r20,r27,25705
>  21c:	6e 00 75 6e 	xoris   r0,r16,30062
>  220:	73 69 67 6e 	andi.   r9,r27,26478
>  224:	65 64 20 69 	oris    r4,r11,8297
>  228:	6e 74 00 62 	xoris   r20,r19,98
>  22c:	6f 6f 74 62 	xoris   r15,r27,29794
>  230:	6c 6f 63 6b 	xoris   r15,r3,25451
>  234:	00 74 6d 70 	.long 0x746d70
>  238:	5f 69 6e 64 	rlwnm   r9,r27,r13,25,18
>  23c:	78 00 67 65 	rldicr. r0,r0,12,61
>  240:	74 6c 69 6e 	andis.  r12,r3,26990
>  244:	65 00 5f 5f 	oris    r0,r8,24415
>  248:	73 74 72 65 	andi.   r20,r27,29285
>  24c:	61 6d 00 74 	ori     r13,r11,116
>  250:	69 6d 65 73 	xori    r13,r11,25971
>  254:	70 65 63 00 	andi.   r5,r3,25344
>  258:	6c 6f 6e 67 	xoris   r15,r3,28263
>  25c:	20 75 6e 73 	subfic  r3,r21,28275
>  260:	69 67 6e 65 	xori    r7,r11,28261
>  264:	64 20 69 6e 	oris    r0,r1,26990
>  268:	74 00 63 72 	andis.  r0,r0,25458
>  26c:	65 61 74 65 	oris    r1,r11,29797
>  270:	5f 66 6c 61 	rlwnm.  r6,r27,r13,17,16
>  274:	74 74 65 6e 	andis.  r20,r3,25966
>  278:	5f 74 72 65 	rlwnm.  r20,r27,r14,9,18
>  27c:	65 00 6f 66 	oris    r0,r8,28518
>  280:	66 5f 64 74 	oris    r31,r18,25716
>  284:	5f 73 74 72 	rlwnm   r19,r27,r14,17,25
>  288:	69 6e 67 73 	xori    r14,r11,26483
>  28c:	00 5f 49 4f 	.long 0x5f494f
>  290:	5f 77 72 69 	rlwnm.  r23,r27,r14,9,20
>  294:	74 65 5f 70 	andis.  r5,r3,24432
>  298:	74 72 00 6e 	andis.  r18,r3,110
>  29c:	61 6d 65 00 	ori     r13,r11,25856
>  2a0:	5f 5f 73 74 	rlwnm   r31,r26,r14,13,26
>  2a4:	61 74 62 75 	ori     r20,r11,25205
>  2a8:	66 00 5f 73 	oris    r0,r16,24435
>  2ac:	62 75 66 00 	ori     r21,r19,26112
>  2b0:	5f 5f 72 65 	rlwnm.  r31,r26,r14,9,18
>  2b4:	73 75 6c 74 	andi.   r21,r27,27764
>  2b8:	00 64 61 74 	.long 0x646174
>  2bc:	61 00 6c 6f 	ori     r0,r8,27759
>  2c0:	63 61 6c 5f 	ori     r1,r27,27743
>  2c4:	63 6d 64 6c 	ori     r13,r27,25708
>  2c8:	69 6e 65 00 	xori    r14,r11,25856
>  2cc:	73 69 7a 65 	andi.   r9,r27,31333
>  2d0:	00 70 61 74 	.long 0x706174
>  2d4:	68 6e 61 6d 	xori    r14,r3,24941
>  2d8:	65 00 64 5f 	oris    r0,r8,25695
>  2dc:	6f 66 66 00 	xoris   r6,r27,26112
>  2e0:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>  2e4:	73 61 76 65 	andi.   r1,r27,30309
>  2e8:	5f 62 61 73 	rlwnm.  r2,r27,r12,5,25
>  2ec:	65 00 5f 5f 	oris    r0,r8,24415
>  2f0:	6e 6c 69 6e 	xoris   r12,r19,26990
>  2f4:	6b 5f 74 00 	xori    r31,r26,29696
>  2f8:	63 72 61 73 	ori     r18,r27,24947
>  2fc:	68 5f 70 61 	xori    r31,r2,28769
>  300:	72 61 6d 00 	andi.   r1,r19,27904
>  304:	5f 5f 73 31 	rlwnm.  r31,r26,r14,12,24
>  308:	00 6c 6f 63 	.long 0x6c6f63
>  30c:	5f 62 61 73 	rlwnm.  r2,r27,r12,5,25
>  310:	65 00 5f 6c 	oris    r0,r8,24428
>  314:	6f 63 6b 00 	xoris   r3,r27,27392
>  318:	5f 6d 6f 64 	rlwnm   r13,r27,r13,29,18
>  31c:	65 00 69 6e 	oris    r0,r8,26990
>  320:	69 74 72 64 	xori    r20,r11,29284
>  324:	5f 62 61 73 	rlwnm.  r2,r27,r12,5,25
>  328:	65 00 73 74 	oris    r0,r8,29556
>  32c:	64 6f 75 74 	oris    r15,r3,30068
>  330:	00 73 74 5f 	.long 0x73745f
>  334:	73 69 7a 65 	andi.   r9,r27,31333
>  338:	00 63 6d 64 	.long 0x636d64
>  33c:	5f 6c 65 6e 	rlwnm   r12,r27,r12,21,23
>  340:	00 73 74 5f 	.long 0x73745f
>  344:	6d 6f 64 65 	xoris   r15,r11,25701
>  348:	00 76 65 72 	.long 0x766572
>  34c:	73 69 6f 6e 	andi.   r9,r27,28526
>  350:	00 69 6e 69 	.long 0x696e69
>  354:	74 72 64 5f 	andis.  r18,r3,25695
>  358:	73 69 7a 65 	andi.   r9,r27,31333
>  35c:	00 5f 49 4f 	.long 0x5f494f
>  360:	5f 72 65 61 	rlwnm.  r18,r27,r12,21,16
>  364:	64 5f 65 6e 	oris    r31,r2,25966
>  368:	64 00 61 64 	oris    r0,r0,24932
>  36c:	64 5f 75 73 	oris    r31,r2,30067
>  370:	61 62 6c 65 	ori     r2,r11,27749
>  374:	5f 6d 65 6d 	rlwnm.  r13,r27,r12,21,22
>  378:	5f 70 72 6f 	rlwnm.  r16,r27,r14,9,23
>  37c:	70 65 72 74 	andi.   r5,r3,29300
>  380:	79 00 74 76 	.long 0x79007476
>  384:	5f 6e 73 65 	rlwnm.  r14,r27,r14,13,18
>  388:	63 00 6c 6f 	ori     r0,r24,27759
>  38c:	63 5f 65 6e 	ori     r31,r26,25966
>  390:	64 00 5f 5f 	oris    r0,r0,24415
>  394:	64 65 76 5f 	oris    r5,r3,30303
>  398:	74 00 66 69 	andis.  r0,r0,26217
>  39c:	6c 65 6e 61 	xoris   r5,r3,28257
>  3a0:	6d 65 00 70 	xoris   r5,r11,112
>  3a4:	72 6f 70 6e 	andi.   r15,r19,28782
>  3a8:	75 6d 00 63 	andis.  r13,r11,99
>  3ac:	68 65 63 6b 	xori    r5,r3,25451
>  3b0:	70 72 6f 70 	andi.   r18,r3,28528
>  3b4:	00 6f 66 66 	.long 0x6f6666
>  3b8:	5f 64 74 5f 	rlwnm.  r4,r27,r14,17,15
>  3bc:	73 74 72 75 	andi.   r20,r27,29301
>  3c0:	63 74 00 70 	ori     r20,r27,112
>  3c4:	61 72 61 6d 	ori     r18,r11,24941
>  3c8:	00 75 69 6e 	.long 0x75696e
>  3cc:	74 36 34 5f 	andis.  r22,r1,13407
>  3d0:	74 00 64 69 	andis.  r0,r0,25705
>  3d4:	72 65 6e 74 	andi.   r5,r19,28276
>  3d8:	00 64 5f 69 	.long 0x645f69
>  3dc:	6e 6f 00 5f 	xoris   r15,r19,95
>  3e0:	49 4f 5f 6c 	b       14f634c <bb+0x14b0f14>
>  3e4:	6f 63 6b 5f 	xoris   r3,r27,27487
>  3e8:	74 00 5f 49 	andis.  r0,r0,24393
>  3ec:	4f 5f 46 49 	.long 0x4f5f4649
>  3f0:	4c 45 00 5f 	.long 0x4c45005f
>  3f4:	5f 62 6c 6b 	rlwnm.  r2,r27,r13,17,21
>  3f8:	73 69 7a 65 	andi.   r9,r27,31333
>  3fc:	5f 74 00 5f 	rlwnm.  r20,r27,r0,1,15
>  400:	5f 73 31 5f 	rlwnm.  r19,r27,r6,5,15
>  404:	6c 65 6e 00 	xoris   r5,r3,28160
>  408:	70 61 74 68 	andi.   r1,r3,29800
>  40c:	73 74 61 72 	andi.   r20,r27,24946
>  410:	74 00 72 61 	andis.  r0,r0,29281
>  414:	6e 67 65 00 	xoris   r7,r19,25856
>  418:	5f 70 6f 73 	rlwnm.  r16,r27,r13,29,25
>  41c:	00 5f 6f 6c 	.long 0x5f6f6c
>  420:	64 5f 6f 66 	oris    r31,r2,28518
>  424:	66 73 65 74 	oris    r19,r19,25972
>  428:	00 74 76 5f 	.long 0x74765f
>  42c:	73 65 63 00 	andi.   r5,r27,25344
>  430:	5f 6d 61 72 	rlwnm   r13,r27,r12,5,25
>  434:	6b 65 72 73 	xori    r5,r27,29299
>  438:	00 72 61 6e 	.long 0x72616e
>  43c:	67 65 73 00 	oris    r5,r27,29440
>  440:	6d 65 6d 5f 	xoris   r5,r11,27999
>  444:	72 67 6e 73 	andi.   r7,r19,28275
>  448:	00 62 61 73 	.long 0x626173
>  44c:	65 00 64 74 	oris    r0,r8,25716
>  450:	73 74 72 75 	andi.   r20,r27,29301
>  454:	63 74 00 6b 	ori     r20,r27,107
>  458:	65 78 65 63 	oris    r24,r11,25955
>  45c:	2f 61 72 63 	cmpdi   cr6,r1,29283
>  460:	68 2f 70 70 	xori    r15,r1,28784
>  464:	63 36 34 2f 	ori     r22,r25,13359
>  468:	66 73 32 64 	oris    r19,r19,12900
>  46c:	74 2e 63 00 	andis.  r14,r1,25344
>  470:	75 6e 73 69 	andis.  r14,r11,29545
>  474:	67 6e 65 64 	oris    r14,r27,25956
>  478:	20 63 68 61 	subfic  r3,r3,26721
>  47c:	72 00 64 5f 	andi.   r0,r16,25695
>  480:	74 79 70 65 	andis.  r25,r3,28773
>  484:	00 6f 66 66 	.long 0x6f6666
>  488:	5f 6d 65 6d 	rlwnm.  r13,r27,r12,21,22
>  48c:	5f 72 73 76 	rlwnm   r18,r27,r14,13,27
>  490:	6d 61 70 00 	xoris   r1,r11,28672
>  494:	73 68 6f 72 	andi.   r8,r27,28530
>  498:	74 20 69 6e 	andis.  r0,r1,26990
>  49c:	74 00 6d 61 	andis.  r0,r0,28001
>  4a0:	67 69 63 00 	oris    r9,r27,25344
>  4a4:	73 74 5f 62 	andi.   r20,r27,24418
>  4a8:	6c 6b 73 69 	xoris   r11,r3,29545
>  4ac:	7a 65 00 6c 	rldimi  r5,r19,0,33
>  4b0:	73 74 61 74 	andi.   r20,r27,24948
>  4b4:	00 46 49 4c 	.long 0x46494c
>  4b8:	45 00 5f 5f 	.long 0x45005f5f
>  4bc:	6c 69 6e 65 	xoris   r9,r3,28261
>  4c0:	70 74 72 00 	andi.   r20,r3,29184
>  4c4:	6e 6c 69 73 	xoris   r12,r19,26995
>  4c8:	74 00 6e 75 	andis.  r0,r0,28277
>  4cc:	6d 5f 6f 66 	xoris   r31,r10,28518
>  4d0:	5f 6c 6d 62 	rlwnm   r12,r27,r13,21,17
>  4d4:	73 00 5f 5f 	andi.   r0,r24,24415
>  4d8:	69 6e 6f 5f 	xori    r14,r11,28511
>  4dc:	74 00 73 74 	andis.  r0,r0,29556
>  4e0:	5f 6e 6c 69 	rlwnm.  r14,r27,r13,17,20
>  4e4:	6e 6b 00 6f 	xoris   r11,r19,111
>  4e8:	6c 64 5f 70 	xoris   r4,r3,24432
>  4ec:	61 72 61 6d 	ori     r18,r11,24941
>  4f0:	00 73 74 5f 	.long 0x73745f
>  4f4:	72 64 65 76 	andi.   r4,r19,25974
>  4f8:	00 6c 65 6e 	.long 0x6c656e
>  4fc:	67 74 68 00 	oris    r20,r27,26624
>  500:	63 68 61 72 	ori     r8,r27,24946
>  504:	00 62 61 73 	.long 0x626173
>  508:	65 6e 61 6d 	oris    r14,r11,24941
>  50c:	65 00 5f 5f 	oris    r0,r8,24415
>  510:	74 69 6d 65 	andis.  r9,r3,28005
>  514:	5f 74 00 47 	rlwnm.  r20,r27,r0,1,3
>  518:	4e 55 20 43 	.long 0x4e552043
>  51c:	20 34 2e 33 	subfic  r1,r20,11827
>  520:	2e 32 20 5b 	cmpdi   cr4,r18,8283
>  524:	67 63 63 2d 	oris    r3,r27,25389
>  528:	34 5f 33 2d 	addic.  r2,r31,13101
>  52c:	62 72 61 6e 	ori     r18,r19,24942
>  530:	63 68 20 72 	ori     r8,r27,8306
>  534:	65 76 69 73 	oris    r22,r11,26995
>  538:	69 6f 6e 20 	xori    r15,r11,28192
>  53c:	31 34 31 32 	addic   r9,r20,12594
>  540:	39 31 5d 00 	addi    r9,r17,23808
>  544:	63 6d 64 6c 	ori     r13,r27,25708
>  548:	69 6e 65 00 	xori    r14,r11,25856
>  54c:	5f 5f 75 69 	rlwnm.  r31,r26,r14,21,20
>  550:	64 5f 74 00 	oris    r31,r2,29696
>  554:	5f 6e 65 78 	rlwnm   r14,r27,r12,21,28
>  558:	74 00 5f 5f 	andis.  r0,r0,24415
>  55c:	6f 66 66 36 	xoris   r6,r27,26166
>  560:	34 5f 74 00 	addic.  r2,r31,29696
>  564:	6f 66 66 73 	xoris   r6,r27,26227
>  568:	65 74 00 5f 	oris    r20,r11,95
>  56c:	49 4f 5f 72 	ba      14f5f70 <bb+0x14b0b38>
>  570:	65 61 64 5f 	oris    r1,r11,25695
>  574:	62 61 73 65 	ori     r1,r19,29541
>  578:	00 5f 49 4f 	.long 0x5f494f
>  57c:	5f 73 61 76 	rlwnm   r19,r27,r12,5,27
>  580:	65 5f 65 6e 	oris    r31,r10,25966
>  584:	64 00 73 68 	oris    r0,r0,29544
>  588:	6f 72 74 20 	xoris   r18,r27,29728
>  58c:	75 6e 73 69 	andis.  r14,r11,29545
>  590:	67 6e 65 64 	oris    r14,r27,25956
>  594:	20 69 6e 74 	subfic  r3,r9,28276
>  598:	00 75 73 61 	.long 0x757361
>  59c:	62 6c 65 6d 	ori     r12,r19,25965
>  5a0:	65 6d 5f 72 	oris    r13,r11,24434
>  5a4:	67 6e 73 00 	oris    r14,r27,29440
>  5a8:	73 74 5f 67 	andi.   r20,r27,24423
>  5ac:	69 64 00 5f 	xori    r4,r11,95
>  5b0:	5f 70 61 64 	rlwnm   r16,r27,r12,5,18
>  5b4:	31 00 5f 5f 	addic   r8,r0,24415
>  5b8:	70 61 64 32 	andi.   r1,r3,25650
>  5bc:	00 5f 5f 70 	.long 0x5f5f70
>  5c0:	61 64 33 00 	ori     r4,r11,13056
>  5c4:	5f 5f 70 61 	rlwnm.  r31,r26,r14,1,16
>  5c8:	64 34 00 5f 	oris    r20,r1,95
>  5cc:	5f 70 61 64 	rlwnm   r16,r27,r12,5,18
>  5d0:	35 00 5f 49 	addic.  r8,r0,24393
>  5d4:	4f 5f 77 72 	.long 0x4f5f7772
>  5d8:	69 74 65 5f 	xori    r20,r11,25951
>  5dc:	65 6e 64 00 	oris    r14,r11,25600
>  5e0:	66 6e 61 6d 	oris    r14,r19,24941
>  5e4:	65 00 5f 75 	oris    r0,r8,24437
>  5e8:	6e 75 73 65 	xoris   r21,r19,29541
>  5ec:	64 32 00 73 	oris    r18,r1,115
>  5f0:	74 64 65 72 	andis.  r4,r3,25970
>  5f4:	72 00 64 65 	andi.   r0,r16,25701
>  5f8:	6e 74 72 79 	xoris   r20,r19,29305
>  5fc:	31 00 64 65 	addic   r8,r0,25701
>  600:	6e 74 72 79 	xoris   r20,r19,29305
>  604:	32 00 72 65 	addic   r16,r0,29285
>  608:	73 65 72 76 	andi.   r5,r27,29302
>  60c:	65 00 6c 6d 	oris    r0,r8,27757
>  610:	62 5f 73 69 	ori     r31,r18,29545
>  614:	7a 65 00 70 	rldcl   r5,r19,r0,33
>  618:	75 74 70 72 	andis.  r20,r11,28786
>  61c:	6f 70 73 00 	xoris   r16,r27,29440
>  620:	62 6f 6f 74 	ori     r15,r19,28532
>  624:	5f 70 68 79 	rlwnm.  r16,r27,r13,1,28
>  628:	73 69 64 00 	andi.   r9,r27,25600
>  62c:	73 74 5f 64 	andi.   r20,r27,24420
>  630:	65 76 00 6c 	oris    r22,r11,108
>  634:	61 73 74 5f 	ori     r19,r11,29791
>  638:	63 6d 64 6c 	ori     r13,r27,25708
>  63c:	69 6e 65 00 	xori    r14,r11,25856
>  640:	5f 66 6c 61 	rlwnm.  r6,r27,r13,17,16
>  644:	67 73 32 00 	oris    r19,r27,12800
>  648:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>  64c:	62 61 63 6b 	ori     r1,r19,25451
>  650:	75 70 5f 62 	andis.  r16,r11,24418
>  654:	61 73 65 00 	ori     r19,r11,25856
>  658:	73 74 5f 6d 	andi.   r20,r27,24429
>  65c:	74 69 6d 00 	andis.  r9,r3,27904
>  660:	73 69 7a 65 	andi.   r9,r27,31333
>  664:	70 00 62 6e 	andi.   r0,r0,25198
>  668:	61 6d 65 00 	ori     r13,r11,25856
>  66c:	2f 68 6f 6d 	cmpdi   cr6,r8,28525
>  670:	65 2f 6d 6f 	oris    r15,r9,28015
>  674:	68 61 6e 2f 	xori    r1,r3,28207
>  678:	6b 65 78 65 	xori    r5,r27,30821
>  67c:	63 2d 74 6f 	ori     r13,r25,29807
>  680:	6f 6c 73 00 	xoris   r12,r27,29440
>  684:	73 74 61 72 	andi.   r20,r27,24946
>  688:	74 00 5f 49 	andis.  r0,r0,24393
>  68c:	4f 5f 77 72 	.long 0x4f5f7772
>  690:	69 74 65 5f 	xori    r20,r11,25951
>  694:	62 61 73 65 	ori     r1,r19,29541
>  698:	00 74 6c 65 	.long 0x746c65
>  69c:	6e 00 6d 65 	xoris   r0,r16,28005
>  6a0:	6d 5f 72 73 	xoris   r31,r10,29299
>  6a4:	72 76 00 6e 	andi.   r22,r19,110
>  6a8:	75 6d 6c 69 	andis.  r13,r11,27753
>  6ac:	73 74 00 6e 	andi.   r20,r27,110
>  6b0:	61 6d 65 6c 	ori     r13,r11,25964
>  6b4:	69 73 74 00 	xori    r19,r11,29696
> 
> Disassembly of section .comment:
> 
> 0000000000000000 <.comment>:
>    0:	00 47 43 43 	.long 0x474343
>    4:	3a 20 28 53 	li      r17,10323
>    8:	55 53 45 20 	rlwinm  r19,r10,8,20,16
>    c:	4c 69 6e 75 	.long 0x4c696e75
>   10:	78 29 20 34 	.long 0x78292034
>   14:	2e 33 2e 32 	cmpdi   cr4,r19,11826
>   18:	20 5b 67 63 	subfic  r2,r27,26467
>   1c:	63 2d 34 5f 	ori     r13,r25,13407
>   20:	33 2d 62 72 	addic   r25,r13,25202
>   24:	61 6e 63 68 	ori     r14,r11,25448
>   28:	20 72 65 76 	subfic  r3,r18,25974
>   2c:	69 73 69 6f 	xori    r19,r11,26991
>   30:	6e 20 31 34 	xoris   r0,r17,12596
>   34:	31 32 39 31 	addic   r9,r18,14641
>   38:	Address 0x0000000000000038 is out of bounds.
> 
> 
> Disassembly of section .comment.SUSE.OPTs:
> 
> 0000000000000000 <.comment.SUSE.OPTs>:
>    0:	4f 73 70 57 	.long 0x4f737057
>    4:	Address 0x0000000000000004 is out of bounds.
> 

> 
> kexec/arch/ppc64/fs2dt.o:     file format elf64-powerpc
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <.reserve>:
>        0:	7c 08 02 a6 	mflr    r0
>        4:	fb 61 ff d8 	std     r27,-40(r1)
>        8:	fb 81 ff e0 	std     r28,-32(r1)
>        c:	fb a1 ff e8 	std     r29,-24(r1)
>       10:	fb c1 ff f0 	std     r30,-16(r1)
>       14:	fb e1 ff f8 	std     r31,-8(r1)
>       18:	eb a2 00 00 	ld      r29,0(r2)
>       1c:	f8 01 00 10 	std     r0,16(r1)
>       20:	f8 21 ff 61 	stdu    r1,-160(r1)
>       24:	7c 7c 1b 78 	mr      r28,r3
>       28:	7c 9b 23 78 	mr      r27,r4
>       2c:	e8 1d 00 08 	ld      r0,8(r29)
>       30:	2f a0 00 00 	cmpdi   cr7,r0,0
>       34:	41 de 00 84 	beq-    cr7,b8 <.reserve+0xb8>
>       38:	39 3d 00 18 	addi    r9,r29,24
>       3c:	3b e0 00 00 	li      r31,0
>       40:	e8 09 00 00 	ld      r0,0(r9)
>       44:	3b ff 00 02 	addi    r31,r31,2
>       48:	39 29 00 10 	addi    r9,r9,16
>       4c:	3b df 00 01 	addi    r30,r31,1
>       50:	2f a0 00 00 	cmpdi   cr7,r0,0
>       54:	40 fe ff ec 	bne-    cr7,40 <.reserve+0x40>
>       58:	38 1f 00 04 	addi    r0,r31,4
>       5c:	39 7f 00 03 	addi    r11,r31,3
>       60:	2b a0 01 ff 	cmpldi  cr7,r0,511
>       64:	40 9d 00 14 	ble-    cr7,78 <.reserve+0x78>
>       68:	e8 62 00 08 	ld      r3,8(r2)
>       6c:	48 00 00 01 	bl      6c <.reserve+0x6c>
>       70:	60 00 00 00 	nop
>       74:	39 7f 00 03 	addi    r11,r31,3
>       78:	7b e0 1f 24 	rldicr  r0,r31,3,60
>       7c:	7b c9 1f 24 	rldicr  r9,r30,3,60
>       80:	79 6b 1f 24 	rldicr  r11,r11,3,60
>       84:	38 21 00 a0 	addi    r1,r1,160
>       88:	7f 9d 01 2a 	stdx    r28,r29,r0
>       8c:	38 00 00 00 	li      r0,0
>       90:	7f 7d 49 2a 	stdx    r27,r29,r9
>       94:	7c 1d 59 2a 	stdx    r0,r29,r11
>       98:	e8 01 00 10 	ld      r0,16(r1)
>       9c:	eb 61 ff d8 	ld      r27,-40(r1)
>       a0:	eb 81 ff e0 	ld      r28,-32(r1)
>       a4:	eb a1 ff e8 	ld      r29,-24(r1)
>       a8:	eb c1 ff f0 	ld      r30,-16(r1)
>       ac:	eb e1 ff f8 	ld      r31,-8(r1)
>       b0:	7c 08 03 a6 	mtlr    r0
>       b4:	4e 80 00 20 	blr
>       b8:	3b e0 00 00 	li      r31,0
>       bc:	3b c0 00 01 	li      r30,1
>       c0:	39 60 00 03 	li      r11,3
>       c4:	4b ff ff b4 	b       78 <.reserve+0x78>
>       c8:	00 00 00 00 	.long 0x0
>       cc:	00 00 00 01 	.long 0x1
>       d0:	80 05 00 00 	lwz     r0,0(r5)
>       d4:	60 00 00 00 	nop
>       d8:	60 00 00 00 	nop
>       dc:	60 00 00 00 	nop
> 
> 00000000000000e0 <.checkprop>:
>       e0:	7c 08 02 a6 	mflr    r0
>       e4:	fb c1 ff f0 	std     r30,-16(r1)
>       e8:	7c 9e 23 79 	mr.     r30,r4
>       ec:	fb 81 ff e0 	std     r28,-32(r1)
>       f0:	fb a1 ff e8 	std     r29,-24(r1)
>       f4:	fb e1 ff f8 	std     r31,-8(r1)
>       f8:	f8 01 00 10 	std     r0,16(r1)
>       fc:	7c 7d 1b 78 	mr      r29,r3
>      100:	f8 21 ff 71 	stdu    r1,-144(r1)
>      104:	7c bc 2b 78 	mr      r28,r5
>      108:	41 82 00 88 	beq-    190 <.checkprop+0xb0>
>      10c:	eb e2 00 00 	ld      r31,0(r2)
>      110:	e8 82 00 18 	ld      r4,24(r2)
>      114:	7f a3 eb 78 	mr      r3,r29
>      118:	48 00 00 01 	bl      118 <.checkprop+0x38>
>      11c:	60 00 00 00 	nop
>      120:	2f a3 00 00 	cmpdi   cr7,r3,0
>      124:	40 9e 00 ac 	bne-    cr7,1d0 <.checkprop+0xf0>
>      128:	80 1e 00 00 	lwz     r0,0(r30)
>      12c:	f8 1f 10 00 	std     r0,4096(r31)
>      130:	e8 1f 10 08 	ld      r0,4104(r31)
>      134:	2f a0 00 00 	cmpdi   cr7,r0,0
>      138:	41 9e 00 10 	beq-    cr7,148 <.checkprop+0x68>
>      13c:	e8 1f 10 10 	ld      r0,4112(r31)
>      140:	2f a0 00 00 	cmpdi   cr7,r0,0
>      144:	40 9e 00 bc 	bne-    cr7,200 <.checkprop+0x120>
>      148:	e8 7f 10 00 	ld      r3,4096(r31)
>      14c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      150:	41 9e 00 1c 	beq-    cr7,16c <.checkprop+0x8c>
>      154:	eb df 10 08 	ld      r30,4104(r31)
>      158:	2f be 00 00 	cmpdi   cr7,r30,0
>      15c:	40 9e 00 b4 	bne-    cr7,210 <.checkprop+0x130>
>      160:	e8 9f 10 10 	ld      r4,4112(r31)
>      164:	2f a4 00 00 	cmpdi   cr7,r4,0
>      168:	40 9e 00 e8 	bne-    cr7,250 <.checkprop+0x170>
>      16c:	38 21 00 90 	addi    r1,r1,144
>      170:	e8 01 00 10 	ld      r0,16(r1)
>      174:	eb 81 ff e0 	ld      r28,-32(r1)
>      178:	eb a1 ff e8 	ld      r29,-24(r1)
>      17c:	eb c1 ff f0 	ld      r30,-16(r1)
>      180:	eb e1 ff f8 	ld      r31,-8(r1)
>      184:	7c 08 03 a6 	mtlr    r0
>      188:	4e 80 00 20 	blr
>      18c:	60 00 00 00 	nop
>      190:	eb e2 00 00 	ld      r31,0(r2)
>      194:	e8 1f 10 00 	ld      r0,4096(r31)
>      198:	2f a0 00 00 	cmpdi   cr7,r0,0
>      19c:	40 9e 00 1c 	bne-    cr7,1b8 <.checkprop+0xd8>
>      1a0:	e8 1f 10 08 	ld      r0,4104(r31)
>      1a4:	2f a0 00 00 	cmpdi   cr7,r0,0
>      1a8:	40 9e 00 10 	bne-    cr7,1b8 <.checkprop+0xd8>
>      1ac:	e8 1f 10 10 	ld      r0,4112(r31)
>      1b0:	2f a0 00 00 	cmpdi   cr7,r0,0
>      1b4:	41 9e ff 5c 	beq+    cr7,110 <.checkprop+0x30>
>      1b8:	e8 62 00 10 	ld      r3,16(r2)
>      1bc:	48 00 00 01 	bl      1bc <.checkprop+0xdc>
>      1c0:	60 00 00 00 	nop
>      1c4:	4b ff ff 6c 	b       130 <.checkprop+0x50>
>      1c8:	60 00 00 00 	nop
>      1cc:	60 00 00 00 	nop
>      1d0:	e8 82 00 20 	ld      r4,32(r2)
>      1d4:	7f a3 eb 78 	mr      r3,r29
>      1d8:	48 00 00 01 	bl      1d8 <.checkprop+0xf8>
>      1dc:	60 00 00 00 	nop
>      1e0:	2f a3 00 00 	cmpdi   cr7,r3,0
>      1e4:	40 9e 00 9c 	bne-    cr7,280 <.checkprop+0x1a0>
>      1e8:	e8 1e 00 00 	ld      r0,0(r30)
>      1ec:	f8 1f 10 00 	std     r0,4096(r31)
>      1f0:	4b ff ff 40 	b       130 <.checkprop+0x50>
>      1f4:	60 00 00 00 	nop
>      1f8:	60 00 00 00 	nop
>      1fc:	60 00 00 00 	nop
>      200:	e8 62 00 50 	ld      r3,80(r2)
>      204:	48 00 00 01 	bl      204 <.checkprop+0x124>
>      208:	60 00 00 00 	nop
>      20c:	4b ff ff 3c 	b       148 <.checkprop+0x68>
>      210:	7f c4 f3 78 	mr      r4,r30
>      214:	48 00 00 01 	bl      214 <.checkprop+0x134>
>      218:	38 00 00 00 	li      r0,0
>      21c:	38 21 00 90 	addi    r1,r1,144
>      220:	f8 1f 10 00 	std     r0,4096(r31)
>      224:	f8 1f 10 08 	std     r0,4104(r31)
>      228:	e8 01 00 10 	ld      r0,16(r1)
>      22c:	eb 81 ff e0 	ld      r28,-32(r1)
>      230:	eb a1 ff e8 	ld      r29,-24(r1)
>      234:	eb c1 ff f0 	ld      r30,-16(r1)
>      238:	eb e1 ff f8 	ld      r31,-8(r1)
>      23c:	7c 08 03 a6 	mtlr    r0
>      240:	4e 80 00 20 	blr
>      244:	60 00 00 00 	nop
>      248:	60 00 00 00 	nop
>      24c:	60 00 00 00 	nop
>      250:	7c 83 20 50 	subf    r4,r3,r4
>      254:	48 00 00 01 	bl      254 <.checkprop+0x174>
>      258:	fb df 10 00 	std     r30,4096(r31)
>      25c:	fb df 10 10 	std     r30,4112(r31)
>      260:	38 21 00 90 	addi    r1,r1,144
>      264:	e8 01 00 10 	ld      r0,16(r1)
>      268:	eb 81 ff e0 	ld      r28,-32(r1)
>      26c:	eb a1 ff e8 	ld      r29,-24(r1)
>      270:	eb c1 ff f0 	ld      r30,-16(r1)
>      274:	eb e1 ff f8 	ld      r31,-8(r1)
>      278:	7c 08 03 a6 	mtlr    r0
>      27c:	4e 80 00 20 	blr
>      280:	e8 82 00 28 	ld      r4,40(r2)
>      284:	7f a3 eb 78 	mr      r3,r29
>      288:	48 00 00 01 	bl      288 <.checkprop+0x1a8>
>      28c:	60 00 00 00 	nop
>      290:	2f a3 00 00 	cmpdi   cr7,r3,0
>      294:	40 9e 00 1c 	bne-    cr7,2b0 <.checkprop+0x1d0>
>      298:	80 1e 00 00 	lwz     r0,0(r30)
>      29c:	f8 1f 10 08 	std     r0,4104(r31)
>      2a0:	4b ff fe 90 	b       130 <.checkprop+0x50>
>      2a4:	60 00 00 00 	nop
>      2a8:	60 00 00 00 	nop
>      2ac:	60 00 00 00 	nop
>      2b0:	e8 82 00 30 	ld      r4,48(r2)
>      2b4:	7f a3 eb 78 	mr      r3,r29
>      2b8:	48 00 00 01 	bl      2b8 <.checkprop+0x1d8>
>      2bc:	60 00 00 00 	nop
>      2c0:	2f a3 00 00 	cmpdi   cr7,r3,0
>      2c4:	41 9e ff d4 	beq+    cr7,298 <.checkprop+0x1b8>
>      2c8:	e9 22 00 38 	ld      r9,56(r2)
>      2cc:	88 09 00 00 	lbz     r0,0(r9)
>      2d0:	2f 80 00 00 	cmpwi   cr7,r0,0
>      2d4:	41 9e fe 5c 	beq+    cr7,130 <.checkprop+0x50>
>      2d8:	e8 82 00 40 	ld      r4,64(r2)
>      2dc:	7f a3 eb 78 	mr      r3,r29
>      2e0:	48 00 00 01 	bl      2e0 <.checkprop+0x200>
>      2e4:	60 00 00 00 	nop
>      2e8:	2f a3 00 00 	cmpdi   cr7,r3,0
>      2ec:	40 9e 00 10 	bne-    cr7,2fc <.checkprop+0x21c>
>      2f0:	2f 9c 00 08 	cmpwi   cr7,r28,8
>      2f4:	40 9e fe 34 	bne+    cr7,128 <.checkprop+0x48>
>      2f8:	4b ff fe f0 	b       1e8 <.checkprop+0x108>
>      2fc:	e8 82 00 48 	ld      r4,72(r2)
>      300:	7f a3 eb 78 	mr      r3,r29
>      304:	48 00 00 01 	bl      304 <.checkprop+0x224>
>      308:	60 00 00 00 	nop
>      30c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      310:	40 9e fe 20 	bne+    cr7,130 <.checkprop+0x50>
>      314:	e8 1e 00 00 	ld      r0,0(r30)
>      318:	f8 1f 10 10 	std     r0,4112(r31)
>      31c:	4b ff fe 14 	b       130 <.checkprop+0x50>
>      320:	00 00 00 00 	.long 0x0
>      324:	00 00 00 01 	.long 0x1
>      328:	80 04 00 00 	lwz     r0,0(r4)
>      32c:	60 00 00 00 	nop
> 
> 0000000000000330 <.propnum>:
>      330:	7c 08 02 a6 	mflr    r0
>      334:	fb 81 ff e0 	std     r28,-32(r1)
>      338:	fb a1 ff e8 	std     r29,-24(r1)
>      33c:	fb 61 ff d8 	std     r27,-40(r1)
>      340:	fb c1 ff f0 	std     r30,-16(r1)
>      344:	fb e1 ff f8 	std     r31,-8(r1)
>      348:	eb a2 00 00 	ld      r29,0(r2)
>      34c:	f8 01 00 10 	std     r0,16(r1)
>      350:	f8 21 ff 61 	stdu    r1,-160(r1)
>      354:	7c 7c 1b 78 	mr      r28,r3
>      358:	88 1d 10 18 	lbz     r0,4120(r29)
>      35c:	2f 80 00 00 	cmpwi   cr7,r0,0
>      360:	41 9e 01 00 	beq-    cr7,460 <.propnum+0x130>
>      364:	7f bb eb 78 	mr      r27,r29
>      368:	3b e0 00 00 	li      r31,0
>      36c:	3b dd 10 18 	addi    r30,r29,4120
>      370:	48 00 00 38 	b       3a8 <.propnum+0x78>
>      374:	60 00 00 00 	nop
>      378:	60 00 00 00 	nop
>      37c:	60 00 00 00 	nop
>      380:	48 00 00 01 	bl      380 <.propnum+0x50>
>      384:	60 00 00 00 	nop
>      388:	38 63 00 01 	addi    r3,r3,1
>      38c:	7c 63 fa 14 	add     r3,r3,r31
>      390:	78 7d 00 20 	clrldi  r29,r3,32
>      394:	7d 3b ea 14 	add     r9,r27,r29
>      398:	7f bf eb 78 	mr      r31,r29
>      39c:	88 09 10 18 	lbz     r0,4120(r9)
>      3a0:	2f 80 00 00 	cmpwi   cr7,r0,0
>      3a4:	41 9e 00 4c 	beq-    cr7,3f0 <.propnum+0xc0>
>      3a8:	7f be fa 14 	add     r29,r30,r31
>      3ac:	7f 83 e3 78 	mr      r3,r28
>      3b0:	7f a4 eb 78 	mr      r4,r29
>      3b4:	48 00 00 01 	bl      3b4 <.propnum+0x84>
>      3b8:	60 00 00 00 	nop
>      3bc:	2f a3 00 00 	cmpdi   cr7,r3,0
>      3c0:	7f a3 eb 78 	mr      r3,r29
>      3c4:	40 9e ff bc 	bne+    cr7,380 <.propnum+0x50>
>      3c8:	38 21 00 a0 	addi    r1,r1,160
>      3cc:	7f e3 fb 78 	mr      r3,r31
>      3d0:	e8 01 00 10 	ld      r0,16(r1)
>      3d4:	eb 61 ff d8 	ld      r27,-40(r1)
>      3d8:	eb 81 ff e0 	ld      r28,-32(r1)
>      3dc:	eb a1 ff e8 	ld      r29,-24(r1)
>      3e0:	eb c1 ff f0 	ld      r30,-16(r1)
>      3e4:	eb e1 ff f8 	ld      r31,-8(r1)
>      3e8:	7c 08 03 a6 	mtlr    r0
>      3ec:	4e 80 00 20 	blr
>      3f0:	7f bf eb 78 	mr      r31,r29
>      3f4:	7f 83 e3 78 	mr      r3,r28
>      3f8:	48 00 00 01 	bl      3f8 <.propnum+0xc8>
>      3fc:	60 00 00 00 	nop
>      400:	20 1d 40 00 	subfic  r0,r29,16384
>      404:	38 63 00 01 	addi    r3,r3,1
>      408:	78 00 00 20 	clrldi  r0,r0,32
>      40c:	7f a0 18 40 	cmpld   cr7,r0,r3
>      410:	41 9c 00 40 	blt-    cr7,450 <.propnum+0x120>
>      414:	7c 7e ea 14 	add     r3,r30,r29
>      418:	7f 84 e3 78 	mr      r4,r28
>      41c:	48 00 00 01 	bl      41c <.propnum+0xec>
>      420:	60 00 00 00 	nop
>      424:	38 21 00 a0 	addi    r1,r1,160
>      428:	7f e3 fb 78 	mr      r3,r31
>      42c:	e8 01 00 10 	ld      r0,16(r1)
>      430:	eb 61 ff d8 	ld      r27,-40(r1)
>      434:	eb 81 ff e0 	ld      r28,-32(r1)
>      438:	eb a1 ff e8 	ld      r29,-24(r1)
>      43c:	eb c1 ff f0 	ld      r30,-16(r1)
>      440:	eb e1 ff f8 	ld      r31,-8(r1)
>      444:	7c 08 03 a6 	mtlr    r0
>      448:	4e 80 00 20 	blr
>      44c:	60 00 00 00 	nop
>      450:	e8 62 00 58 	ld      r3,88(r2)
>      454:	48 00 00 01 	bl      454 <.propnum+0x124>
>      458:	60 00 00 00 	nop
>      45c:	4b ff ff b8 	b       414 <.propnum+0xe4>
>      460:	3b dd 10 18 	addi    r30,r29,4120
>      464:	3b a0 00 00 	li      r29,0
>      468:	3b e0 00 00 	li      r31,0
>      46c:	4b ff ff 88 	b       3f4 <.propnum+0xc4>
>      470:	00 00 00 00 	.long 0x0
>      474:	00 00 00 01 	.long 0x1
>      478:	80 05 00 00 	lwz     r0,0(r5)
>      47c:	60 00 00 00 	nop
> 
> 0000000000000480 <.add_usable_mem_property>:
>      480:	7c 08 02 a6 	mflr    r0
>      484:	fb 61 ff d8 	std     r27,-40(r1)
>      488:	fb 81 ff e0 	std     r28,-32(r1)
>      48c:	fb a1 ff e8 	std     r29,-24(r1)
>      490:	fb c1 ff f0 	std     r30,-16(r1)
>      494:	fb e1 ff f8 	std     r31,-8(r1)
>      498:	eb c2 00 00 	ld      r30,0(r2)
>      49c:	f8 01 00 10 	std     r0,16(r1)
>      4a0:	f8 21 bb 51 	stdu    r1,-17584(r1)
>      4a4:	7c 7b 1b 78 	mr      r27,r3
>      4a8:	7c 9f 23 78 	mr      r31,r4
>      4ac:	3b 9e 50 18 	addi    r28,r30,20504
>      4b0:	7f 84 e3 78 	mr      r4,r28
>      4b4:	3b a1 00 80 	addi    r29,r1,128
>      4b8:	7f a3 eb 78 	mr      r3,r29
>      4bc:	48 00 00 01 	bl      4bc <.add_usable_mem_property+0x3c>
>      4c0:	60 00 00 00 	nop
>      4c4:	38 80 00 2f 	li      r4,47
>      4c8:	7f a3 eb 78 	mr      r3,r29
>      4cc:	48 00 00 01 	bl      4cc <.add_usable_mem_property+0x4c>
>      4d0:	60 00 00 00 	nop
>      4d4:	38 00 00 00 	li      r0,0
>      4d8:	38 80 00 2f 	li      r4,47
>      4dc:	7c 69 1b 78 	mr      r9,r3
>      4e0:	7f a3 eb 78 	mr      r3,r29
>      4e4:	98 09 00 00 	stb     r0,0(r9)
>      4e8:	48 00 00 01 	bl      4e8 <.add_usable_mem_property+0x68>
>      4ec:	60 00 00 00 	nop
>      4f0:	e8 82 00 60 	ld      r4,96(r2)
>      4f4:	38 a0 00 08 	li      r5,8
>      4f8:	48 00 00 01 	bl      4f8 <.add_usable_mem_property+0x78>
>      4fc:	60 00 00 00 	nop
>      500:	2f a3 00 00 	cmpdi   cr7,r3,0
>      504:	40 9e 01 f8 	bne-    cr7,6fc <.add_usable_mem_property+0x27c>
>      508:	2b 9f 00 0f 	cmplwi  cr7,r31,15
>      50c:	40 9d 02 c4 	ble-    cr7,7d0 <.add_usable_mem_property+0x350>
>      510:	7f 63 db 78 	mr      r3,r27
>      514:	38 80 00 00 	li      r4,0
>      518:	38 a0 00 00 	li      r5,0
>      51c:	48 00 00 01 	bl      51c <.add_usable_mem_property+0x9c>
>      520:	60 00 00 00 	nop
>      524:	2f a3 00 00 	cmpdi   cr7,r3,0
>      528:	41 9c 02 d0 	blt-    cr7,7f8 <.add_usable_mem_property+0x378>
>      52c:	3b e1 00 70 	addi    r31,r1,112
>      530:	7f 63 db 78 	mr      r3,r27
>      534:	38 a0 00 10 	li      r5,16
>      538:	7f e4 fb 78 	mr      r4,r31
>      53c:	48 00 00 01 	bl      53c <.add_usable_mem_property+0xbc>
>      540:	60 00 00 00 	nop
>      544:	2f a3 00 10 	cmpdi   cr7,r3,16
>      548:	41 9e 00 2c 	beq-    cr7,574 <.add_usable_mem_property+0xf4>
>      54c:	48 00 00 01 	bl      54c <.add_usable_mem_property+0xcc>
>      550:	60 00 00 00 	nop
>      554:	e8 63 00 02 	lwa     r3,0(r3)
>      558:	48 00 00 01 	bl      558 <.add_usable_mem_property+0xd8>
>      55c:	60 00 00 00 	nop
>      560:	7f 84 e3 78 	mr      r4,r28
>      564:	7c 65 1b 78 	mr      r5,r3
>      568:	e8 62 00 78 	ld      r3,120(r2)
>      56c:	48 00 00 01 	bl      56c <.add_usable_mem_property+0xec>
>      570:	60 00 00 00 	nop
>      574:	e8 a1 00 70 	ld      r5,112(r1)
>      578:	e9 21 00 78 	ld      r9,120(r1)
>      57c:	7c a0 28 f8 	not     r0,r5
>      580:	7f a0 48 40 	cmpld   cr7,r0,r9
>      584:	41 9c 02 1c 	blt-    cr7,7a0 <.add_usable_mem_property+0x320>
>      588:	e9 62 00 88 	ld      r11,136(r2)
>      58c:	7c 85 4a 14 	add     r4,r5,r9
>      590:	81 2b 00 00 	lwz     r9,0(r11)
>      594:	2f a9 00 00 	cmpdi   cr7,r9,0
>      598:	41 9e 01 88 	beq-    cr7,720 <.add_usable_mem_property+0x2a0>
>      59c:	39 29 ff ff 	addi    r9,r9,-1
>      5a0:	eb ab 00 08 	ld      r29,8(r11)
>      5a4:	39 40 00 00 	li      r10,0
>      5a8:	38 c0 00 00 	li      r6,0
>      5ac:	79 29 00 20 	clrldi  r9,r9,32
>      5b0:	39 29 00 01 	addi    r9,r9,1
>      5b4:	1c 69 00 18 	mulli   r3,r9,24
>      5b8:	48 00 00 48 	b       600 <.add_usable_mem_property+0x180>
>      5bc:	60 00 00 00 	nop
>      5c0:	7f a4 38 40 	cmpld   cr7,r4,r7
>      5c4:	41 9c 00 50 	blt-    cr7,614 <.add_usable_mem_property+0x194>
>      5c8:	39 6a 00 01 	addi    r11,r10,1
>      5cc:	79 4a 1f 24 	rldicr  r10,r10,3,60
>      5d0:	7c 08 38 50 	subf    r0,r8,r7
>      5d4:	7d 6b 07 b4 	extsw   r11,r11
>      5d8:	7d 5f 52 14 	add     r10,r31,r10
>      5dc:	79 69 1f 24 	rldicr  r9,r11,3,60
>      5e0:	f9 0a 04 10 	std     r8,1040(r10)
>      5e4:	39 6b 00 01 	addi    r11,r11,1
>      5e8:	7d 3f 4a 14 	add     r9,r31,r9
>      5ec:	7d 6a 07 b4 	extsw   r10,r11
>      5f0:	f8 09 04 10 	std     r0,1040(r9)
>      5f4:	38 c6 00 18 	addi    r6,r6,24
>      5f8:	7f a6 18 00 	cmpd    cr7,r6,r3
>      5fc:	41 9e 00 84 	beq-    cr7,680 <.add_usable_mem_property+0x200>
>      600:	7f a9 eb 78 	mr      r9,r29
>      604:	7d 09 30 6a 	ldux    r8,r9,r6
>      608:	7f a5 40 40 	cmpld   cr7,r5,r8
>      60c:	e8 e9 00 08 	ld      r7,8(r9)
>      610:	40 9d ff b0 	ble+    cr7,5c0 <.add_usable_mem_property+0x140>
>      614:	7f a5 38 40 	cmpld   cr7,r5,r7
>      618:	40 9c ff dc 	bge+    cr7,5f4 <.add_usable_mem_property+0x174>
>      61c:	7f a4 40 40 	cmpld   cr7,r4,r8
>      620:	40 9d ff d4 	ble+    cr7,5f4 <.add_usable_mem_property+0x174>
>      624:	7f a5 40 40 	cmpld   cr7,r5,r8
>      628:	7c ab 2b 78 	mr      r11,r5
>      62c:	40 9c 00 08 	bge-    cr7,634 <.add_usable_mem_property+0x1b4>
>      630:	7d 0b 43 78 	mr      r11,r8
>      634:	38 0a 00 01 	addi    r0,r10,1
>      638:	7f a4 38 40 	cmpld   cr7,r4,r7
>      63c:	79 49 1f 24 	rldicr  r9,r10,3,60
>      640:	7c 08 07 b4 	extsw   r8,r0
>      644:	7d 3f 4a 14 	add     r9,r31,r9
>      648:	79 00 1f 24 	rldicr  r0,r8,3,60
>      64c:	f9 69 04 10 	std     r11,1040(r9)
>      650:	7d 5f 02 14 	add     r10,r31,r0
>      654:	7c 80 23 78 	mr      r0,r4
>      658:	40 9d 00 08 	ble-    cr7,660 <.add_usable_mem_property+0x1e0>
>      65c:	7c e0 3b 78 	mr      r0,r7
>      660:	38 c6 00 18 	addi    r6,r6,24
>      664:	7c 0b 00 50 	subf    r0,r11,r0
>      668:	39 28 00 01 	addi    r9,r8,1
>      66c:	7f a6 18 00 	cmpd    cr7,r6,r3
>      670:	f8 0a 04 10 	std     r0,1040(r10)
>      674:	7d 2a 07 b4 	extsw   r10,r9
>      678:	40 9e ff 88 	bne+    cr7,600 <.add_usable_mem_property+0x180>
>      67c:	60 00 00 00 	nop
>      680:	2f aa 00 00 	cmpdi   cr7,r10,0
>      684:	41 9e 00 9c 	beq-    cr7,720 <.add_usable_mem_property+0x2a0>
>      688:	eb be 54 18 	ld      r29,21528(r30)
>      68c:	79 40 1f 24 	rldicr  r0,r10,3,60
>      690:	e8 62 00 90 	ld      r3,144(r2)
>      694:	7c 1f 07 b4 	extsw   r31,r0
>      698:	38 00 00 03 	li      r0,3
>      69c:	93 fd 00 04 	stw     r31,4(r29)
>      6a0:	90 1d 00 00 	stw     r0,0(r29)
>      6a4:	3b bd 00 04 	addi    r29,r29,4
>      6a8:	39 3f 00 03 	addi    r9,r31,3
>      6ac:	3b 9d 00 04 	addi    r28,r29,4
>      6b0:	7d 29 16 70 	srawi   r9,r9,2
>      6b4:	7d 29 01 94 	addze   r9,r9
>      6b8:	fb 9e 54 18 	std     r28,21528(r30)
>      6bc:	7d 29 07 b4 	extsw   r9,r9
>      6c0:	3b 9c 00 04 	addi    r28,r28,4
>      6c4:	79 3b 17 64 	rldicr  r27,r9,2,61
>      6c8:	48 00 00 31 	bl      6f8 <.add_usable_mem_property+0x278>
>      6cc:	2f 9f 00 07 	cmpwi   cr7,r31,7
>      6d0:	90 7d 00 04 	stw     r3,4(r29)
>      6d4:	fb 9e 54 18 	std     r28,21528(r30)
>      6d8:	41 dd 00 90 	bgt-    cr7,768 <.add_usable_mem_property+0x2e8>
>      6dc:	e8 7e 54 18 	ld      r3,21528(r30)
>      6e0:	7f e5 fb 78 	mr      r5,r31
>      6e4:	38 81 04 80 	addi    r4,r1,1152
>      6e8:	48 00 00 01 	bl      6e8 <.add_usable_mem_property+0x268>
>      6ec:	60 00 00 00 	nop
>      6f0:	e8 1e 54 18 	ld      r0,21528(r30)
>      6f4:	7c 00 da 14 	add     r0,r0,r27
>      6f8:	f8 1e 54 18 	std     r0,21528(r30)
>      6fc:	38 21 44 b0 	addi    r1,r1,17584
>      700:	e8 01 00 10 	ld      r0,16(r1)
>      704:	eb 61 ff d8 	ld      r27,-40(r1)
>      708:	eb 81 ff e0 	ld      r28,-32(r1)
>      70c:	eb a1 ff e8 	ld      r29,-24(r1)
>      710:	eb c1 ff f0 	ld      r30,-16(r1)
>      714:	eb e1 ff f8 	ld      r31,-8(r1)
>      718:	7c 08 03 a6 	mtlr    r0
>      71c:	4e 80 00 20 	blr
>      720:	eb be 54 18 	ld      r29,21528(r30)
>      724:	39 20 00 00 	li      r9,0
>      728:	38 00 00 10 	li      r0,16
>      72c:	e8 62 00 90 	ld      r3,144(r2)
>      730:	3b e0 00 10 	li      r31,16
>      734:	3b 60 00 10 	li      r27,16
>      738:	f9 21 04 88 	std     r9,1160(r1)
>      73c:	f9 21 04 80 	std     r9,1152(r1)
>      740:	39 20 00 03 	li      r9,3
>      744:	90 1d 00 04 	stw     r0,4(r29)
>      748:	91 3d 00 00 	stw     r9,0(r29)
>      74c:	3b bd 00 04 	addi    r29,r29,4
>      750:	3b 9d 00 04 	addi    r28,r29,4
>      754:	fb 9e 54 18 	std     r28,21528(r30)
>      758:	3b 9c 00 04 	addi    r28,r28,4
>      75c:	48 00 00 31 	bl      78c <.add_usable_mem_property+0x30c>
>      760:	90 7d 00 04 	stw     r3,4(r29)
>      764:	fb 9e 54 18 	std     r28,21528(r30)
>      768:	7b 80 f7 e3 	rldicl. r0,r28,62,63
>      76c:	41 82 ff 70 	beq+    6dc <.add_usable_mem_property+0x25c>
>      770:	38 1c 00 04 	addi    r0,r28,4
>      774:	7f e5 fb 78 	mr      r5,r31
>      778:	38 81 04 80 	addi    r4,r1,1152
>      77c:	f8 1e 54 18 	std     r0,21528(r30)
>      780:	e8 7e 54 18 	ld      r3,21528(r30)
>      784:	48 00 00 01 	bl      784 <.add_usable_mem_property+0x304>
>      788:	60 00 00 00 	nop
>      78c:	e8 1e 54 18 	ld      r0,21528(r30)
>      790:	7c 00 da 14 	add     r0,r0,r27
>      794:	f8 1e 54 18 	std     r0,21528(r30)
>      798:	4b ff ff 64 	b       6fc <.add_usable_mem_property+0x27c>
>      79c:	60 00 00 00 	nop
>      7a0:	e8 62 00 80 	ld      r3,128(r2)
>      7a4:	48 00 00 01 	bl      7a4 <.add_usable_mem_property+0x324>
>      7a8:	60 00 00 00 	nop
>      7ac:	e9 21 00 78 	ld      r9,120(r1)
>      7b0:	e8 a1 00 70 	ld      r5,112(r1)
>      7b4:	e9 62 00 88 	ld      r11,136(r2)
>      7b8:	7c 85 4a 14 	add     r4,r5,r9
>      7bc:	81 2b 00 00 	lwz     r9,0(r11)
>      7c0:	2f a9 00 00 	cmpdi   cr7,r9,0
>      7c4:	40 9e fd d8 	bne+    cr7,59c <.add_usable_mem_property+0x11c>
>      7c8:	4b ff ff 58 	b       720 <.add_usable_mem_property+0x2a0>
>      7cc:	60 00 00 00 	nop
>      7d0:	e8 62 00 68 	ld      r3,104(r2)
>      7d4:	48 00 00 01 	bl      7d4 <.add_usable_mem_property+0x354>
>      7d8:	60 00 00 00 	nop
>      7dc:	7f 63 db 78 	mr      r3,r27
>      7e0:	38 80 00 00 	li      r4,0
>      7e4:	38 a0 00 00 	li      r5,0
>      7e8:	48 00 00 01 	bl      7e8 <.add_usable_mem_property+0x368>
>      7ec:	60 00 00 00 	nop
>      7f0:	2f a3 00 00 	cmpdi   cr7,r3,0
>      7f4:	40 9c fd 38 	bge+    cr7,52c <.add_usable_mem_property+0xac>
>      7f8:	48 00 00 01 	bl      7f8 <.add_usable_mem_property+0x378>
>      7fc:	60 00 00 00 	nop
>      800:	e8 63 00 02 	lwa     r3,0(r3)
>      804:	48 00 00 01 	bl      804 <.add_usable_mem_property+0x384>
>      808:	60 00 00 00 	nop
>      80c:	7f 84 e3 78 	mr      r4,r28
>      810:	7c 65 1b 78 	mr      r5,r3
>      814:	e8 62 00 70 	ld      r3,112(r2)
>      818:	48 00 00 01 	bl      818 <.add_usable_mem_property+0x398>
>      81c:	60 00 00 00 	nop
>      820:	4b ff fd 0c 	b       52c <.add_usable_mem_property+0xac>
>      824:	00 00 00 00 	.long 0x0
>      828:	00 00 00 01 	.long 0x1
>      82c:	80 05 00 00 	lwz     r0,0(r5)
> 
> 0000000000000830 <.add_dyn_reconf_usable_mem_property>:
>      830:	7c 08 02 a6 	mflr    r0
>      834:	fb 01 ff c0 	std     r24,-64(r1)
>      838:	fb 21 ff c8 	std     r25,-56(r1)
>      83c:	fb 41 ff d0 	std     r26,-48(r1)
>      840:	fb a1 ff e8 	std     r29,-24(r1)
>      844:	fa 81 ff a0 	std     r20,-96(r1)
>      848:	fa a1 ff a8 	std     r21,-88(r1)
>      84c:	f8 01 00 10 	std     r0,16(r1)
>      850:	fa c1 ff b0 	std     r22,-80(r1)
>      854:	fa e1 ff b8 	std     r23,-72(r1)
>      858:	fb 61 ff d8 	std     r27,-40(r1)
>      85c:	fb 81 ff e0 	std     r28,-32(r1)
>      860:	fb c1 ff f0 	std     r30,-16(r1)
>      864:	fb e1 ff f8 	std     r31,-8(r1)
>      868:	f8 21 ba 31 	stdu    r1,-17872(r1)
>      86c:	eb 42 00 00 	ld      r26,0(r2)
>      870:	7c 79 1b 78 	mr      r25,r3
>      874:	3b 1a 50 18 	addi    r24,r26,20504
>      878:	7f 04 c3 78 	mr      r4,r24
>      87c:	3b a1 01 70 	addi    r29,r1,368
>      880:	7f a3 eb 78 	mr      r3,r29
>      884:	48 00 00 01 	bl      884 <.add_dyn_reconf_usable_mem_property+0x54>
>      888:	60 00 00 00 	nop
>      88c:	38 80 00 2f 	li      r4,47
>      890:	7f a3 eb 78 	mr      r3,r29
>      894:	48 00 00 01 	bl      894 <.add_dyn_reconf_usable_mem_property+0x64>
>      898:	60 00 00 00 	nop
>      89c:	38 00 00 00 	li      r0,0
>      8a0:	38 80 00 2f 	li      r4,47
>      8a4:	7c 69 1b 78 	mr      r9,r3
>      8a8:	7f a3 eb 78 	mr      r3,r29
>      8ac:	98 09 00 00 	stb     r0,0(r9)
>      8b0:	48 00 00 01 	bl      8b0 <.add_dyn_reconf_usable_mem_property+0x80>
>      8b4:	60 00 00 00 	nop
>      8b8:	e8 82 00 98 	ld      r4,152(r2)
>      8bc:	48 00 00 01 	bl      8bc <.add_dyn_reconf_usable_mem_property+0x8c>
>      8c0:	60 00 00 00 	nop
>      8c4:	2f a3 00 00 	cmpdi   cr7,r3,0
>      8c8:	41 9e 00 44 	beq-    cr7,90c <.add_dyn_reconf_usable_mem_property+0xdc>
>      8cc:	38 21 45 d0 	addi    r1,r1,17872
>      8d0:	e8 01 00 10 	ld      r0,16(r1)
>      8d4:	ea 81 ff a0 	ld      r20,-96(r1)
>      8d8:	ea a1 ff a8 	ld      r21,-88(r1)
>      8dc:	ea c1 ff b0 	ld      r22,-80(r1)
>      8e0:	ea e1 ff b8 	ld      r23,-72(r1)
>      8e4:	eb 01 ff c0 	ld      r24,-64(r1)
>      8e8:	eb 21 ff c8 	ld      r25,-56(r1)
>      8ec:	eb 41 ff d0 	ld      r26,-48(r1)
>      8f0:	7c 08 03 a6 	mtlr    r0
>      8f4:	eb 61 ff d8 	ld      r27,-40(r1)
>      8f8:	eb 81 ff e0 	ld      r28,-32(r1)
>      8fc:	eb a1 ff e8 	ld      r29,-24(r1)
>      900:	eb c1 ff f0 	ld      r30,-16(r1)
>      904:	eb e1 ff f8 	ld      r31,-8(r1)
>      908:	4e 80 00 20 	blr
>      90c:	7f 23 cb 78 	mr      r3,r25
>      910:	38 80 00 04 	li      r4,4
>      914:	38 a0 00 00 	li      r5,0
>      918:	48 00 00 01 	bl      918 <.add_dyn_reconf_usable_mem_property+0xe8>
>      91c:	60 00 00 00 	nop
>      920:	2f a3 00 00 	cmpdi   cr7,r3,0
>      924:	41 9c 02 d0 	blt-    cr7,bf4 <.add_dyn_reconf_usable_mem_property+0x3c4>
>      928:	ea a2 00 a0 	ld      r21,160(r2)
>      92c:	80 15 00 00 	lwz     r0,0(r21)
>      930:	2f 80 00 00 	cmpwi   cr7,r0,0
>      934:	41 9e 02 ec 	beq-    cr7,c20 <.add_dyn_reconf_usable_mem_property+0x3f0>
>      938:	3b e1 00 70 	addi    r31,r1,112
>      93c:	7f 23 cb 78 	mr      r3,r25
>      940:	ea c2 00 88 	ld      r22,136(r2)
>      944:	ea e2 00 a8 	ld      r23,168(r2)
>      948:	38 a0 00 18 	li      r5,24
>      94c:	3b c0 00 00 	li      r30,0
>      950:	7f e4 fb 78 	mr      r4,r31
>      954:	3b 60 00 00 	li      r27,0
>      958:	48 00 00 01 	bl      958 <.add_dyn_reconf_usable_mem_property+0x128>
>      95c:	60 00 00 00 	nop
>      960:	7e d4 b3 78 	mr      r20,r22
>      964:	2f a3 00 00 	cmpdi   cr7,r3,0
>      968:	41 9c 01 6c 	blt-    cr7,ad4 <.add_dyn_reconf_usable_mem_property+0x2a4>
>      96c:	60 00 00 00 	nop
>      970:	eb a1 00 70 	ld      r29,112(r1)
>      974:	e9 37 00 00 	ld      r9,0(r23)
>      978:	7f a0 e8 f8 	not     r0,r29
>      97c:	7f 9d 4a 14 	add     r28,r29,r9
>      980:	7f bc 00 40 	cmpld   cr7,r28,r0
>      984:	41 9d 01 9c 	bgt-    cr7,b20 <.add_dyn_reconf_usable_mem_property+0x2f0>
>      988:	81 36 00 00 	lwz     r9,0(r22)
>      98c:	38 1e 00 01 	addi    r0,r30,1
>      990:	39 00 00 00 	li      r8,0
>      994:	7c 0a 07 b4 	extsw   r10,r0
>      998:	2f a9 00 00 	cmpdi   cr7,r9,0
>      99c:	41 9e 00 f8 	beq-    cr7,a94 <.add_dyn_reconf_usable_mem_property+0x264>
>      9a0:	39 29 ff ff 	addi    r9,r9,-1
>      9a4:	e8 74 00 08 	ld      r3,8(r20)
>      9a8:	38 a0 00 00 	li      r5,0
>      9ac:	38 c0 00 00 	li      r6,0
>      9b0:	79 29 00 20 	clrldi  r9,r9,32
>      9b4:	39 29 00 01 	addi    r9,r9,1
>      9b8:	1c 89 00 18 	mulli   r4,r9,24
>      9bc:	48 00 00 4c 	b       a08 <.add_dyn_reconf_usable_mem_property+0x1d8>
>      9c0:	7f bc 40 40 	cmpld   cr7,r28,r8
>      9c4:	41 9c 00 58 	blt-    cr7,a1c <.add_dyn_reconf_usable_mem_property+0x1ec>
>      9c8:	39 6a 00 01 	addi    r11,r10,1
>      9cc:	79 4a 1f 24 	rldicr  r10,r10,3,60
>      9d0:	7d 07 40 50 	subf    r8,r7,r8
>      9d4:	38 05 00 01 	addi    r0,r5,1
>      9d8:	7d 6b 07 b4 	extsw   r11,r11
>      9dc:	7d 5f 52 14 	add     r10,r31,r10
>      9e0:	7c 05 07 b4 	extsw   r5,r0
>      9e4:	79 69 1f 24 	rldicr  r9,r11,3,60
>      9e8:	f8 ea 05 00 	std     r7,1280(r10)
>      9ec:	39 6b 00 01 	addi    r11,r11,1
>      9f0:	7d 3f 4a 14 	add     r9,r31,r9
>      9f4:	7d 6a 07 b4 	extsw   r10,r11
>      9f8:	f9 09 05 00 	std     r8,1280(r9)
>      9fc:	38 c6 00 18 	addi    r6,r6,24
>      a00:	7f a6 20 00 	cmpd    cr7,r6,r4
>      a04:	41 9e 00 8c 	beq-    cr7,a90 <.add_dyn_reconf_usable_mem_property+0x260>
>      a08:	7c 69 1b 78 	mr      r9,r3
>      a0c:	7c e9 30 6a 	ldux    r7,r9,r6
>      a10:	7f bd 38 40 	cmpld   cr7,r29,r7
>      a14:	e9 09 00 08 	ld      r8,8(r9)
>      a18:	40 9d ff a8 	ble+    cr7,9c0 <.add_dyn_reconf_usable_mem_property+0x190>
>      a1c:	7f bd 40 40 	cmpld   cr7,r29,r8
>      a20:	40 9c ff dc 	bge+    cr7,9fc <.add_dyn_reconf_usable_mem_property+0x1cc>
>      a24:	7f bc 38 40 	cmpld   cr7,r28,r7
>      a28:	40 9d ff d4 	ble+    cr7,9fc <.add_dyn_reconf_usable_mem_property+0x1cc>
>      a2c:	7f a7 e8 40 	cmpld   cr7,r7,r29
>      a30:	40 9c 00 08 	bge-    cr7,a38 <.add_dyn_reconf_usable_mem_property+0x208>
>      a34:	7f a7 eb 78 	mr      r7,r29
>      a38:	38 0a 00 01 	addi    r0,r10,1
>      a3c:	7f bc 40 40 	cmpld   cr7,r28,r8
>      a40:	79 49 1f 24 	rldicr  r9,r10,3,60
>      a44:	7c 0b 07 b4 	extsw   r11,r0
>      a48:	7d 3f 4a 14 	add     r9,r31,r9
>      a4c:	79 60 1f 24 	rldicr  r0,r11,3,60
>      a50:	f8 e9 05 00 	std     r7,1280(r9)
>      a54:	7d 5f 02 14 	add     r10,r31,r0
>      a58:	7f 80 e3 78 	mr      r0,r28
>      a5c:	40 9d 00 08 	ble-    cr7,a64 <.add_dyn_reconf_usable_mem_property+0x234>
>      a60:	7d 00 43 78 	mr      r0,r8
>      a64:	38 c6 00 18 	addi    r6,r6,24
>      a68:	7c 07 00 50 	subf    r0,r7,r0
>      a6c:	39 6b 00 01 	addi    r11,r11,1
>      a70:	39 25 00 01 	addi    r9,r5,1
>      a74:	7f a6 20 00 	cmpd    cr7,r6,r4
>      a78:	f8 0a 05 00 	std     r0,1280(r10)
>      a7c:	7d 25 07 b4 	extsw   r5,r9
>      a80:	7d 6a 07 b4 	extsw   r10,r11
>      a84:	40 9e ff 84 	bne+    cr7,a08 <.add_dyn_reconf_usable_mem_property+0x1d8>
>      a88:	60 00 00 00 	nop
>      a8c:	60 00 00 00 	nop
>      a90:	7c a8 2b 78 	mr      r8,r5
>      a94:	38 1b 00 01 	addi    r0,r27,1
>      a98:	81 75 00 00 	lwz     r11,0(r21)
>      a9c:	7b c9 1f 24 	rldicr  r9,r30,3,60
>      aa0:	7c 1b 07 b4 	extsw   r27,r0
>      aa4:	7d 3f 4a 14 	add     r9,r31,r9
>      aa8:	7f 8b d8 40 	cmplw   cr7,r11,r27
>      aac:	f9 09 05 00 	std     r8,1280(r9)
>      ab0:	40 9d 00 80 	ble-    cr7,b30 <.add_dyn_reconf_usable_mem_property+0x300>
>      ab4:	7f 23 cb 78 	mr      r3,r25
>      ab8:	7f e4 fb 78 	mr      r4,r31
>      abc:	38 a0 00 18 	li      r5,24
>      ac0:	7d 5e 53 78 	mr      r30,r10
>      ac4:	48 00 00 01 	bl      ac4 <.add_dyn_reconf_usable_mem_property+0x294>
>      ac8:	60 00 00 00 	nop
>      acc:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ad0:	40 9c fe a0 	bge+    cr7,970 <.add_dyn_reconf_usable_mem_property+0x140>
>      ad4:	48 00 00 01 	bl      ad4 <.add_dyn_reconf_usable_mem_property+0x2a4>
>      ad8:	60 00 00 00 	nop
>      adc:	e8 63 00 02 	lwa     r3,0(r3)
>      ae0:	48 00 00 01 	bl      ae0 <.add_dyn_reconf_usable_mem_property+0x2b0>
>      ae4:	60 00 00 00 	nop
>      ae8:	7f 04 c3 78 	mr      r4,r24
>      aec:	7c 65 1b 78 	mr      r5,r3
>      af0:	e8 62 00 78 	ld      r3,120(r2)
>      af4:	48 00 00 01 	bl      af4 <.add_dyn_reconf_usable_mem_property+0x2c4>
>      af8:	60 00 00 00 	nop
>      afc:	eb a1 00 70 	ld      r29,112(r1)
>      b00:	e9 37 00 00 	ld      r9,0(r23)
>      b04:	7f a0 e8 f8 	not     r0,r29
>      b08:	7f 9d 4a 14 	add     r28,r29,r9
>      b0c:	7f bc 00 40 	cmpld   cr7,r28,r0
>      b10:	40 9d fe 78 	ble+    cr7,988 <.add_dyn_reconf_usable_mem_property+0x158>
>      b14:	60 00 00 00 	nop
>      b18:	60 00 00 00 	nop
>      b1c:	60 00 00 00 	nop
>      b20:	e8 62 00 80 	ld      r3,128(r2)
>      b24:	48 00 00 01 	bl      b24 <.add_dyn_reconf_usable_mem_property+0x2f4>
>      b28:	60 00 00 00 	nop
>      b2c:	4b ff fe 5c 	b       988 <.add_dyn_reconf_usable_mem_property+0x158>
>      b30:	eb ba 54 18 	ld      r29,21528(r26)
>      b34:	79 40 1f 24 	rldicr  r0,r10,3,60
>      b38:	e8 62 00 b0 	ld      r3,176(r2)
>      b3c:	7c 1f 07 b4 	extsw   r31,r0
>      b40:	38 00 00 03 	li      r0,3
>      b44:	93 fd 00 04 	stw     r31,4(r29)
>      b48:	90 1d 00 00 	stw     r0,0(r29)
>      b4c:	3b bd 00 04 	addi    r29,r29,4
>      b50:	39 3f 00 03 	addi    r9,r31,3
>      b54:	3b 9d 00 04 	addi    r28,r29,4
>      b58:	7d 29 16 70 	srawi   r9,r9,2
>      b5c:	7d 29 01 94 	addze   r9,r9
>      b60:	fb 9a 54 18 	std     r28,21528(r26)
>      b64:	7d 29 07 b4 	extsw   r9,r9
>      b68:	3b 9c 00 04 	addi    r28,r28,4
>      b6c:	79 3e 17 64 	rldicr  r30,r9,2,61
>      b70:	48 00 00 31 	bl      ba0 <.add_dyn_reconf_usable_mem_property+0x370>
>      b74:	2f 9f 00 07 	cmpwi   cr7,r31,7
>      b78:	90 7d 00 04 	stw     r3,4(r29)
>      b7c:	fb 9a 54 18 	std     r28,21528(r26)
>      b80:	40 9d 00 14 	ble-    cr7,b94 <.add_dyn_reconf_usable_mem_property+0x364>
>      b84:	7b 80 f7 e3 	rldicl. r0,r28,62,63
>      b88:	41 82 00 0c 	beq-    b94 <.add_dyn_reconf_usable_mem_property+0x364>
>      b8c:	38 1c 00 04 	addi    r0,r28,4
>      b90:	f8 1a 54 18 	std     r0,21528(r26)
>      b94:	e8 7a 54 18 	ld      r3,21528(r26)
>      b98:	7f e5 fb 78 	mr      r5,r31
>      b9c:	38 81 05 70 	addi    r4,r1,1392
>      ba0:	48 00 00 01 	bl      ba0 <.add_dyn_reconf_usable_mem_property+0x370>
>      ba4:	60 00 00 00 	nop
>      ba8:	e8 1a 54 18 	ld      r0,21528(r26)
>      bac:	38 21 45 d0 	addi    r1,r1,17872
>      bb0:	7c 00 f2 14 	add     r0,r0,r30
>      bb4:	f8 1a 54 18 	std     r0,21528(r26)
>      bb8:	e8 01 00 10 	ld      r0,16(r1)
>      bbc:	ea 81 ff a0 	ld      r20,-96(r1)
>      bc0:	ea a1 ff a8 	ld      r21,-88(r1)
>      bc4:	ea c1 ff b0 	ld      r22,-80(r1)
>      bc8:	ea e1 ff b8 	ld      r23,-72(r1)
>      bcc:	eb 01 ff c0 	ld      r24,-64(r1)
>      bd0:	eb 21 ff c8 	ld      r25,-56(r1)
>      bd4:	eb 41 ff d0 	ld      r26,-48(r1)
>      bd8:	7c 08 03 a6 	mtlr    r0
>      bdc:	eb 61 ff d8 	ld      r27,-40(r1)
>      be0:	eb 81 ff e0 	ld      r28,-32(r1)
>      be4:	eb a1 ff e8 	ld      r29,-24(r1)
>      be8:	eb c1 ff f0 	ld      r30,-16(r1)
>      bec:	eb e1 ff f8 	ld      r31,-8(r1)
>      bf0:	4e 80 00 20 	blr
>      bf4:	48 00 00 01 	bl      bf4 <.add_dyn_reconf_usable_mem_property+0x3c4>
>      bf8:	60 00 00 00 	nop
>      bfc:	e8 63 00 02 	lwa     r3,0(r3)
>      c00:	48 00 00 01 	bl      c00 <.add_dyn_reconf_usable_mem_property+0x3d0>
>      c04:	60 00 00 00 	nop
>      c08:	7f 04 c3 78 	mr      r4,r24
>      c0c:	7c 65 1b 78 	mr      r5,r3
>      c10:	e8 62 00 70 	ld      r3,112(r2)
>      c14:	48 00 00 01 	bl      c14 <.add_dyn_reconf_usable_mem_property+0x3e4>
>      c18:	60 00 00 00 	nop
>      c1c:	4b ff fd 0c 	b       928 <.add_dyn_reconf_usable_mem_property+0xf8>
>      c20:	eb ba 54 18 	ld      r29,21528(r26)
>      c24:	e8 62 00 b0 	ld      r3,176(r2)
>      c28:	3b e0 00 00 	li      r31,0
>      c2c:	3b c0 00 00 	li      r30,0
>      c30:	90 1d 00 04 	stw     r0,4(r29)
>      c34:	38 00 00 03 	li      r0,3
>      c38:	90 1d 00 00 	stw     r0,0(r29)
>      c3c:	3b bd 00 04 	addi    r29,r29,4
>      c40:	3b 9d 00 04 	addi    r28,r29,4
>      c44:	fb 9a 54 18 	std     r28,21528(r26)
>      c48:	3b 9c 00 04 	addi    r28,r28,4
>      c4c:	48 00 00 31 	bl      c7c <.putprops+0xc>
>      c50:	90 7d 00 04 	stw     r3,4(r29)
>      c54:	fb 9a 54 18 	std     r28,21528(r26)
>      c58:	4b ff ff 3c 	b       b94 <.add_dyn_reconf_usable_mem_property+0x364>
>      c5c:	00 00 00 00 	.long 0x0
>      c60:	00 00 00 01 	.long 0x1
>      c64:	80 0c 00 00 	lwz     r0,0(r12)
>      c68:	60 00 00 00 	nop
>      c6c:	60 00 00 00 	nop
> 
> 0000000000000c70 <.putprops>:
>      c70:	7c 08 02 a6 	mflr    r0
>      c74:	2f 85 00 00 	cmpwi   cr7,r5,0
>      c78:	fa e1 ff b8 	std     r23,-72(r1)
>      c7c:	fb 21 ff c8 	std     r25,-56(r1)
>      c80:	fa 01 ff 80 	std     r16,-128(r1)
>      c84:	fa 21 ff 88 	std     r17,-120(r1)
>      c88:	fa 41 ff 90 	std     r18,-112(r1)
>      c8c:	fa 61 ff 98 	std     r19,-104(r1)
>      c90:	f8 01 00 10 	std     r0,16(r1)
>      c94:	fa 81 ff a0 	std     r20,-96(r1)
>      c98:	fa a1 ff a8 	std     r21,-88(r1)
>      c9c:	fa c1 ff b0 	std     r22,-80(r1)
>      ca0:	fb 01 ff c0 	std     r24,-64(r1)
>      ca4:	fb 41 ff d0 	std     r26,-48(r1)
>      ca8:	fb 61 ff d8 	std     r27,-40(r1)
>      cac:	fb 81 ff e0 	std     r28,-32(r1)
>      cb0:	fb a1 ff e8 	std     r29,-24(r1)
>      cb4:	fb c1 ff f0 	std     r30,-16(r1)
>      cb8:	fb e1 ff f8 	std     r31,-8(r1)
>      cbc:	f8 21 fe 81 	stdu    r1,-384(r1)
>      cc0:	7c b7 2b 78 	mr      r23,r5
>      cc4:	7c 79 1b 78 	mr      r25,r3
>      cc8:	40 9d 03 f8 	ble-    cr7,10c0 <.putprops+0x450>
>      ccc:	eb 02 00 00 	ld      r24,0(r2)
>      cd0:	38 00 00 00 	li      r0,0
>      cd4:	7c 9a 23 78 	mr      r26,r4
>      cd8:	3b 60 00 00 	li      r27,0
>      cdc:	3a 81 00 70 	addi    r20,r1,112
>      ce0:	60 12 80 00 	ori     r18,r0,32768
>      ce4:	3a 00 00 03 	li      r16,3
>      ce8:	3a d8 50 18 	addi    r22,r24,20504
>      cec:	7f 11 c3 78 	mr      r17,r24
>      cf0:	7e d5 b3 78 	mr      r21,r22
>      cf4:	48 00 00 60 	b       d54 <.putprops+0xe4>
>      cf8:	60 00 00 00 	nop
>      cfc:	60 00 00 00 	nop
>      d00:	38 60 00 01 	li      r3,1
>      d04:	7e a4 ab 78 	mr      r4,r21
>      d08:	7e 85 a3 78 	mr      r5,r20
>      d0c:	48 00 00 01 	bl      d0c <.putprops+0x9c>
>      d10:	60 00 00 00 	nop
>      d14:	2f a3 00 00 	cmpdi   cr7,r3,0
>      d18:	40 9e 01 08 	bne-    cr7,e20 <.putprops+0x1b0>
>      d1c:	80 18 54 20 	lwz     r0,21536(r24)
>      d20:	2f 80 00 00 	cmpwi   cr7,r0,0
>      d24:	41 9e 01 30 	beq-    cr7,e54 <.putprops+0x1e4>
>      d28:	e8 82 00 d0 	ld      r4,208(r2)
>      d2c:	7f c3 f3 78 	mr      r3,r30
>      d30:	48 00 00 01 	bl      d30 <.putprops+0xc0>
>      d34:	60 00 00 00 	nop
>      d38:	2f a3 00 00 	cmpdi   cr7,r3,0
>      d3c:	40 9e 01 60 	bne-    cr7,e9c <.putprops+0x22c>
>      d40:	38 1b 00 01 	addi    r0,r27,1
>      d44:	3b 5a 00 08 	addi    r26,r26,8
>      d48:	7c 1b 07 b4 	extsw   r27,r0
>      d4c:	7f 97 d8 00 	cmpw    cr7,r23,r27
>      d50:	40 9d 00 60 	ble-    cr7,db0 <.putprops+0x140>
>      d54:	eb fa 00 00 	ld      r31,0(r26)
>      d58:	7f 23 cb 78 	mr      r3,r25
>      d5c:	3b df 00 13 	addi    r30,r31,19
>      d60:	7f c4 f3 78 	mr      r4,r30
>      d64:	48 00 00 01 	bl      d64 <.putprops+0xf4>
>      d68:	60 00 00 00 	nop
>      d6c:	88 1f 00 13 	lbz     r0,19(r31)
>      d70:	2f 80 00 2e 	cmpwi   cr7,r0,46
>      d74:	40 9e ff 8c 	bne+    cr7,d00 <.putprops+0x90>
>      d78:	88 1f 00 14 	lbz     r0,20(r31)
>      d7c:	2f a0 00 00 	cmpdi   cr7,r0,0
>      d80:	41 fe ff c0 	beq-    cr7,d40 <.putprops+0xd0>
>      d84:	2f 80 00 2e 	cmpwi   cr7,r0,46
>      d88:	40 9e ff 78 	bne+    cr7,d00 <.putprops+0x90>
>      d8c:	88 1f 00 15 	lbz     r0,21(r31)
>      d90:	2f 80 00 00 	cmpwi   cr7,r0,0
>      d94:	40 de ff 6c 	bne+    cr7,d00 <.putprops+0x90>
>      d98:	38 1b 00 01 	addi    r0,r27,1
>      d9c:	3b 5a 00 08 	addi    r26,r26,8
>      da0:	7c 1b 07 b4 	extsw   r27,r0
>      da4:	7f 97 d8 00 	cmpw    cr7,r23,r27
>      da8:	41 9d ff ac 	bgt+    cr7,d54 <.putprops+0xe4>
>      dac:	60 00 00 00 	nop
>      db0:	38 00 00 00 	li      r0,0
>      db4:	7e c3 b3 78 	mr      r3,r22
>      db8:	38 80 00 00 	li      r4,0
>      dbc:	38 a0 00 00 	li      r5,0
>      dc0:	98 19 00 00 	stb     r0,0(r25)
>      dc4:	48 00 00 19 	bl      ddc <.putprops+0x16c>
>      dc8:	38 21 01 80 	addi    r1,r1,384
>      dcc:	e8 01 00 10 	ld      r0,16(r1)
>      dd0:	ea 01 ff 80 	ld      r16,-128(r1)
>      dd4:	ea 21 ff 88 	ld      r17,-120(r1)
>      dd8:	ea 41 ff 90 	ld      r18,-112(r1)
>      ddc:	ea 61 ff 98 	ld      r19,-104(r1)
>      de0:	ea 81 ff a0 	ld      r20,-96(r1)
>      de4:	ea a1 ff a8 	ld      r21,-88(r1)
>      de8:	ea c1 ff b0 	ld      r22,-80(r1)
>      dec:	7c 08 03 a6 	mtlr    r0
>      df0:	ea e1 ff b8 	ld      r23,-72(r1)
>      df4:	eb 01 ff c0 	ld      r24,-64(r1)
>      df8:	eb 21 ff c8 	ld      r25,-56(r1)
>      dfc:	eb 41 ff d0 	ld      r26,-48(r1)
>      e00:	eb 61 ff d8 	ld      r27,-40(r1)
>      e04:	eb 81 ff e0 	ld      r28,-32(r1)
>      e08:	eb a1 ff e8 	ld      r29,-24(r1)
>      e0c:	eb c1 ff f0 	ld      r30,-16(r1)
>      e10:	eb e1 ff f8 	ld      r31,-8(r1)
>      e14:	4e 80 00 20 	blr
>      e18:	60 00 00 00 	nop
>      e1c:	60 00 00 00 	nop
>      e20:	48 00 00 01 	bl      e20 <.putprops+0x1b0>
>      e24:	60 00 00 00 	nop
>      e28:	e8 63 00 02 	lwa     r3,0(r3)
>      e2c:	48 00 00 01 	bl      e2c <.putprops+0x1bc>
>      e30:	60 00 00 00 	nop
>      e34:	7e a4 ab 78 	mr      r4,r21
>      e38:	7c 65 1b 78 	mr      r5,r3
>      e3c:	e8 62 00 b8 	ld      r3,184(r2)
>      e40:	48 00 00 01 	bl      e40 <.putprops+0x1d0>
>      e44:	60 00 00 00 	nop
>      e48:	80 18 54 20 	lwz     r0,21536(r24)
>      e4c:	2f 80 00 00 	cmpwi   cr7,r0,0
>      e50:	40 9e fe d8 	bne+    cr7,d28 <.putprops+0xb8>
>      e54:	e8 82 00 c0 	ld      r4,192(r2)
>      e58:	7f 23 cb 78 	mr      r3,r25
>      e5c:	48 00 00 01 	bl      e5c <.putprops+0x1ec>
>      e60:	60 00 00 00 	nop
>      e64:	2f a3 00 00 	cmpdi   cr7,r3,0
>      e68:	41 9e fe d8 	beq+    cr7,d40 <.putprops+0xd0>
>      e6c:	e8 82 00 c8 	ld      r4,200(r2)
>      e70:	7f 23 cb 78 	mr      r3,r25
>      e74:	48 00 00 01 	bl      e74 <.putprops+0x204>
>      e78:	60 00 00 00 	nop
>      e7c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      e80:	41 9e fe c0 	beq+    cr7,d40 <.putprops+0xd0>
>      e84:	e8 82 00 d0 	ld      r4,208(r2)
>      e88:	7f c3 f3 78 	mr      r3,r30
>      e8c:	48 00 00 01 	bl      e8c <.putprops+0x21c>
>      e90:	60 00 00 00 	nop
>      e94:	2f a3 00 00 	cmpdi   cr7,r3,0
>      e98:	41 9e fe a8 	beq+    cr7,d40 <.putprops+0xd0>
>      e9c:	e8 82 00 d8 	ld      r4,216(r2)
>      ea0:	7f c3 f3 78 	mr      r3,r30
>      ea4:	48 00 00 01 	bl      ea4 <.putprops+0x234>
>      ea8:	60 00 00 00 	nop
>      eac:	2f a3 00 00 	cmpdi   cr7,r3,0
>      eb0:	41 9e fe 90 	beq+    cr7,d40 <.putprops+0xd0>
>      eb4:	e8 82 00 e0 	ld      r4,224(r2)
>      eb8:	7f c3 f3 78 	mr      r3,r30
>      ebc:	48 00 00 01 	bl      ebc <.putprops+0x24c>
>      ec0:	60 00 00 00 	nop
>      ec4:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ec8:	41 9e fe 78 	beq+    cr7,d40 <.putprops+0xd0>
>      ecc:	e8 82 00 e8 	ld      r4,232(r2)
>      ed0:	7f c3 f3 78 	mr      r3,r30
>      ed4:	48 00 00 01 	bl      ed4 <.putprops+0x264>
>      ed8:	60 00 00 00 	nop
>      edc:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ee0:	41 9e fe 60 	beq+    cr7,d40 <.putprops+0xd0>
>      ee4:	e8 82 00 40 	ld      r4,64(r2)
>      ee8:	7f c3 f3 78 	mr      r3,r30
>      eec:	48 00 00 01 	bl      eec <.putprops+0x27c>
>      ef0:	60 00 00 00 	nop
>      ef4:	2f a3 00 00 	cmpdi   cr7,r3,0
>      ef8:	40 9e 01 d0 	bne-    cr7,10c8 <.putprops+0x458>
>      efc:	e9 22 00 38 	ld      r9,56(r2)
>      f00:	88 09 00 00 	lbz     r0,0(r9)
>      f04:	2f 80 00 00 	cmpwi   cr7,r0,0
>      f08:	41 9e fe 38 	beq+    cr7,d40 <.putprops+0xd0>
>      f0c:	e8 82 00 f0 	ld      r4,240(r2)
>      f10:	7f c3 f3 78 	mr      r3,r30
>      f14:	48 00 00 01 	bl      f14 <.putprops+0x2a4>
>      f18:	60 00 00 00 	nop
>      f1c:	2f a3 00 00 	cmpdi   cr7,r3,0
>      f20:	41 9e fe 20 	beq+    cr7,d40 <.putprops+0xd0>
>      f24:	80 01 00 88 	lwz     r0,136(r1)
>      f28:	54 00 04 26 	rlwinm  r0,r0,0,16,19
>      f2c:	7f 80 90 00 	cmpw    cr7,r0,r18
>      f30:	40 9e fe 10 	bne+    cr7,d40 <.putprops+0xd0>
>      f34:	ea 61 00 a6 	lwa     r19,164(r1)
>      f38:	eb b8 54 18 	ld      r29,21528(r24)
>      f3c:	7f 23 cb 78 	mr      r3,r25
>      f40:	92 1d 00 00 	stw     r16,0(r29)
>      f44:	92 7d 00 04 	stw     r19,4(r29)
>      f48:	3b bd 00 04 	addi    r29,r29,4
>      f4c:	3b 9d 00 04 	addi    r28,r29,4
>      f50:	fb 98 54 18 	std     r28,21528(r24)
>      f54:	3b 9c 00 04 	addi    r28,r28,4
>      f58:	48 00 00 31 	bl      f88 <.putprops+0x318>
>      f5c:	2f 93 00 07 	cmpwi   cr7,r19,7
>      f60:	90 7d 00 04 	stw     r3,4(r29)
>      f64:	fb 98 54 18 	std     r28,21528(r24)
>      f68:	40 9d 00 14 	ble-    cr7,f7c <.putprops+0x30c>
>      f6c:	7b 80 f7 e3 	rldicl. r0,r28,62,63
>      f70:	41 82 00 0c 	beq-    f7c <.putprops+0x30c>
>      f74:	38 1c 00 04 	addi    r0,r28,4
>      f78:	f8 11 54 18 	std     r0,21528(r17)
>      f7c:	7e a3 ab 78 	mr      r3,r21
>      f80:	38 80 00 00 	li      r4,0
>      f84:	48 00 00 01 	bl      f84 <.putprops+0x314>
>      f88:	60 00 00 00 	nop
>      f8c:	2f 83 ff ff 	cmpwi   cr7,r3,-1
>      f90:	7c 7d 1b 78 	mr      r29,r3
>      f94:	40 9e 00 2c 	bne-    cr7,fc0 <.putprops+0x350>
>      f98:	48 00 00 01 	bl      f98 <.putprops+0x328>
>      f9c:	60 00 00 00 	nop
>      fa0:	e8 63 00 02 	lwa     r3,0(r3)
>      fa4:	48 00 00 01 	bl      fa4 <.putprops+0x334>
>      fa8:	60 00 00 00 	nop
>      fac:	7e a4 ab 78 	mr      r4,r21
>      fb0:	7c 65 1b 78 	mr      r5,r3
>      fb4:	e8 62 00 f8 	ld      r3,248(r2)
>      fb8:	48 00 00 01 	bl      fb8 <.putprops+0x348>
>      fbc:	60 00 00 00 	nop
>      fc0:	e8 98 54 18 	ld      r4,21528(r24)
>      fc4:	7f a3 eb 78 	mr      r3,r29
>      fc8:	7e 65 9b 78 	mr      r5,r19
>      fcc:	48 00 00 01 	bl      fcc <.putprops+0x35c>
>      fd0:	60 00 00 00 	nop
>      fd4:	7f a3 98 00 	cmpd    cr7,r3,r19
>      fd8:	41 9e 00 2c 	beq-    cr7,1004 <.putprops+0x394>
>      fdc:	48 00 00 01 	bl      fdc <.putprops+0x36c>
>      fe0:	60 00 00 00 	nop
>      fe4:	e8 63 00 02 	lwa     r3,0(r3)
>      fe8:	48 00 00 01 	bl      fe8 <.putprops+0x378>
>      fec:	60 00 00 00 	nop
>      ff0:	7e a4 ab 78 	mr      r4,r21
>      ff4:	7c 65 1b 78 	mr      r5,r3
>      ff8:	e8 62 01 00 	ld      r3,256(r2)
>      ffc:	48 00 00 01 	bl      ffc <.putprops+0x38c>
>     1000:	60 00 00 00 	nop
>     1004:	e8 98 54 18 	ld      r4,21528(r24)
>     1008:	7f 23 cb 78 	mr      r3,r25
>     100c:	7e 65 9b 78 	mr      r5,r19
>     1010:	48 00 00 19 	bl      1028 <.putprops+0x3b8>
>     1014:	38 13 00 03 	addi    r0,r19,3
>     1018:	e9 38 54 18 	ld      r9,21528(r24)
>     101c:	7c 00 16 70 	srawi   r0,r0,2
>     1020:	7c 00 01 94 	addze   r0,r0
>     1024:	7c 00 07 b4 	extsw   r0,r0
>     1028:	78 00 17 64 	rldicr  r0,r0,2,61
>     102c:	7d 29 02 14 	add     r9,r9,r0
>     1030:	f9 38 54 18 	std     r9,21528(r24)
>     1034:	88 1f 00 13 	lbz     r0,19(r31)
>     1038:	2f 80 00 72 	cmpwi   cr7,r0,114
>     103c:	40 9e 00 44 	bne-    cr7,1080 <.putprops+0x410>
>     1040:	88 1f 00 14 	lbz     r0,20(r31)
>     1044:	2f 80 00 65 	cmpwi   cr7,r0,101
>     1048:	40 9e 00 38 	bne-    cr7,1080 <.putprops+0x410>
>     104c:	88 1f 00 15 	lbz     r0,21(r31)
>     1050:	2f 80 00 67 	cmpwi   cr7,r0,103
>     1054:	40 9e 00 2c 	bne-    cr7,1080 <.putprops+0x410>
>     1058:	88 1f 00 16 	lbz     r0,22(r31)
>     105c:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1060:	40 9e 00 20 	bne-    cr7,1080 <.putprops+0x410>
>     1064:	e9 22 00 88 	ld      r9,136(r2)
>     1068:	80 09 00 00 	lwz     r0,0(r9)
>     106c:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1070:	41 9e 00 10 	beq-    cr7,1080 <.putprops+0x410>
>     1074:	7e 64 9b 78 	mr      r4,r19
>     1078:	7f a3 eb 78 	mr      r3,r29
>     107c:	48 00 00 49 	bl      10c4 <.putprops+0x454>
>     1080:	e8 82 01 08 	ld      r4,264(r2)
>     1084:	7f c3 f3 78 	mr      r3,r30
>     1088:	48 00 00 01 	bl      1088 <.putprops+0x418>
>     108c:	60 00 00 00 	nop
>     1090:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1094:	40 9e 00 1c 	bne-    cr7,10b0 <.putprops+0x440>
>     1098:	e9 22 00 88 	ld      r9,136(r2)
>     109c:	80 09 00 00 	lwz     r0,0(r9)
>     10a0:	2f 80 00 00 	cmpwi   cr7,r0,0
>     10a4:	41 9e 00 0c 	beq-    cr7,10b0 <.putprops+0x440>
>     10a8:	7f a3 eb 78 	mr      r3,r29
>     10ac:	48 00 00 61 	bl      110c <.putnode+0x1c>
>     10b0:	7f a3 eb 78 	mr      r3,r29
>     10b4:	48 00 00 01 	bl      10b4 <.putprops+0x444>
>     10b8:	60 00 00 00 	nop
>     10bc:	4b ff fc 84 	b       d40 <.putprops+0xd0>
>     10c0:	ea c2 01 10 	ld      r22,272(r2)
>     10c4:	4b ff fc ec 	b       db0 <.putprops+0x140>
>     10c8:	e8 82 00 48 	ld      r4,72(r2)
>     10cc:	7f c3 f3 78 	mr      r3,r30
>     10d0:	48 00 00 01 	bl      10d0 <.putprops+0x460>
>     10d4:	60 00 00 00 	nop
>     10d8:	2f a3 00 00 	cmpdi   cr7,r3,0
>     10dc:	40 9e fe 30 	bne+    cr7,f0c <.putprops+0x29c>
>     10e0:	4b ff fe 1c 	b       efc <.putprops+0x28c>
>     10e4:	00 00 00 00 	.long 0x0
>     10e8:	00 00 00 01 	.long 0x1
>     10ec:	80 10 00 00 	lwz     r0,0(r16)
> 
> 00000000000010f0 <.putnode>:
>     10f0:	7c 08 02 a6 	mflr    r0
>     10f4:	fb 41 ff d0 	std     r26,-48(r1)
>     10f8:	fa c1 ff b0 	std     r22,-80(r1)
>     10fc:	7d 80 00 26 	mfcr    r12
>     1100:	f8 01 00 10 	std     r0,16(r1)
>     1104:	fa e1 ff b8 	std     r23,-72(r1)
>     1108:	38 00 00 01 	li      r0,1
>     110c:	fb 01 ff c0 	std     r24,-64(r1)
>     1110:	fb 21 ff c8 	std     r25,-56(r1)
>     1114:	fb 61 ff d8 	std     r27,-40(r1)
>     1118:	fb 81 ff e0 	std     r28,-32(r1)
>     111c:	fb a1 ff e8 	std     r29,-24(r1)
>     1120:	fb c1 ff f0 	std     r30,-16(r1)
>     1124:	91 81 00 08 	stw     r12,8(r1)
>     1128:	fb e1 ff f8 	std     r31,-8(r1)
>     112c:	f8 21 fa 91 	stdu    r1,-1392(r1)
>     1130:	eb 42 00 00 	ld      r26,0(r2)
>     1134:	e9 3a 54 18 	ld      r9,21528(r26)
>     1138:	90 09 00 00 	stw     r0,0(r9)
>     113c:	38 69 00 04 	addi    r3,r9,4
>     1140:	f8 7a 54 18 	std     r3,21528(r26)
>     1144:	e8 9a 54 28 	ld      r4,21544(r26)
>     1148:	88 04 00 00 	lbz     r0,0(r4)
>     114c:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1150:	40 9e 00 08 	bne-    cr7,1158 <.putnode+0x68>
>     1154:	e8 82 01 18 	ld      r4,280(r2)
>     1158:	48 00 00 01 	bl      1158 <.putnode+0x68>
>     115c:	60 00 00 00 	nop
>     1160:	e9 3a 54 18 	ld      r9,21528(r26)
>     1164:	80 09 00 00 	lwz     r0,0(r9)
>     1168:	2f 80 00 00 	cmpwi   cr7,r0,0
>     116c:	41 9e 00 18 	beq-    cr7,1184 <.putnode+0x94>
>     1170:	39 29 00 04 	addi    r9,r9,4
>     1174:	f9 3a 54 18 	std     r9,21528(r26)
>     1178:	80 09 00 00 	lwz     r0,0(r9)
>     117c:	2f 80 00 00 	cmpwi   cr7,r0,0
>     1180:	40 9e ff f0 	bne+    cr7,1170 <.putnode+0x80>
>     1184:	88 09 ff ff 	lbz     r0,-1(r9)
>     1188:	2f 80 00 00 	cmpwi   cr7,r0,0
>     118c:	41 9e 00 0c 	beq-    cr7,1198 <.putnode+0xa8>
>     1190:	38 09 00 04 	addi    r0,r9,4
>     1194:	f8 1a 54 18 	std     r0,21528(r26)
>     1198:	e8 c2 01 20 	ld      r6,288(r2)
>     119c:	3b 1a 50 18 	addi    r24,r26,20504
>     11a0:	38 81 00 70 	addi    r4,r1,112
>     11a4:	38 a0 00 00 	li      r5,0
>     11a8:	7f 03 c3 78 	mr      r3,r24
>     11ac:	48 00 00 01 	bl      11ac <.putnode+0xbc>
>     11b0:	60 00 00 00 	nop
>     11b4:	2e 03 00 00 	cmpwi   cr4,r3,0
>     11b8:	7c 79 1b 78 	mr      r25,r3
>     11bc:	41 90 04 24 	blt-    cr4,15e0 <.putnode+0x4f0>
>     11c0:	2f b9 00 00 	cmpdi   cr7,r25,0
>     11c4:	41 9e 03 fc 	beq-    cr7,15c0 <.putnode+0x4d0>
>     11c8:	38 80 00 2f 	li      r4,47
>     11cc:	7f 03 c3 78 	mr      r3,r24
>     11d0:	48 00 00 01 	bl      11d0 <.putnode+0xe0>
>     11d4:	60 00 00 00 	nop
>     11d8:	7c 76 1b 78 	mr      r22,r3
>     11dc:	7f 03 c3 78 	mr      r3,r24
>     11e0:	48 00 00 01 	bl      11e0 <.putnode+0xf0>
>     11e4:	60 00 00 00 	nop
>     11e8:	38 00 2f 00 	li      r0,12032
>     11ec:	7c 18 1b 2e 	sthx    r0,r24,r3
>     11f0:	7f 03 c3 78 	mr      r3,r24
>     11f4:	48 00 00 01 	bl      11f4 <.putnode+0x104>
>     11f8:	60 00 00 00 	nop
>     11fc:	e8 81 00 70 	ld      r4,112(r1)
>     1200:	7f 25 cb 78 	mr      r5,r25
>     1204:	7f f8 1a 14 	add     r31,r24,r3
>     1208:	7f e3 fb 78 	mr      r3,r31
>     120c:	48 00 00 79 	bl      1284 <.putnode+0x194>
>     1210:	ea e2 01 38 	ld      r23,312(r2)
>     1214:	e8 17 00 00 	ld      r0,0(r23)
>     1218:	2f a0 00 00 	cmpdi   cr7,r0,0
>     121c:	40 9e 02 b4 	bne-    cr7,14d0 <.putnode+0x3e0>
>     1220:	eb 62 01 40 	ld      r27,320(r2)
>     1224:	7e c3 b3 78 	mr      r3,r22
>     1228:	7f 64 db 78 	mr      r4,r27
>     122c:	48 00 00 01 	bl      122c <.putnode+0x13c>
>     1230:	60 00 00 00 	nop
>     1234:	2c 23 00 00 	cmpdi   r3,0
>     1238:	41 82 01 48 	beq-    1380 <.putnode+0x290>
>     123c:	40 91 00 d4 	ble-    cr4,1310 <.putnode+0x220>
>     1240:	7f 1b c3 78 	mr      r27,r24
>     1244:	3b 80 00 00 	li      r28,0
>     1248:	3b a0 00 00 	li      r29,0
>     124c:	3b c1 00 88 	addi    r30,r1,136
>     1250:	48 00 00 40 	b       1290 <.putnode+0x1a0>
>     1254:	60 00 00 00 	nop
>     1258:	60 00 00 00 	nop
>     125c:	60 00 00 00 	nop
>     1260:	48 00 00 01 	bl      1260 <.putnode+0x170>
>     1264:	60 00 00 00 	nop
>     1268:	2f a3 00 00 	cmpdi   cr7,r3,0
>     126c:	40 9e 02 24 	bne-    cr7,1490 <.putnode+0x3a0>
>     1270:	80 01 00 a0 	lwz     r0,160(r1)
>     1274:	54 00 04 26 	rlwinm  r0,r0,0,16,19
>     1278:	2f 80 40 00 	cmpwi   cr7,r0,16384
>     127c:	41 9e 02 4c 	beq-    cr7,14c8 <.putnode+0x3d8>
>     1280:	38 1c 00 01 	addi    r0,r28,1
>     1284:	7c 1c 07 b4 	extsw   r28,r0
>     1288:	7f 99 e0 00 	cmpw    cr7,r25,r28
>     128c:	40 9d 00 84 	ble-    cr7,1310 <.putnode+0x220>
>     1290:	e9 21 00 70 	ld      r9,112(r1)
>     1294:	7f e3 fb 78 	mr      r3,r31
>     1298:	7c 89 e8 2a 	ldx     r4,r9,r29
>     129c:	38 84 00 13 	addi    r4,r4,19
>     12a0:	48 00 00 01 	bl      12a0 <.putnode+0x1b0>
>     12a4:	60 00 00 00 	nop
>     12a8:	e9 21 00 70 	ld      r9,112(r1)
>     12ac:	7c 69 e8 2a 	ldx     r3,r9,r29
>     12b0:	3b bd 00 08 	addi    r29,r29,8
>     12b4:	48 00 00 01 	bl      12b4 <.putnode+0x1c4>
>     12b8:	60 00 00 00 	nop
>     12bc:	88 1f 00 00 	lbz     r0,0(r31)
>     12c0:	7f 64 db 78 	mr      r4,r27
>     12c4:	7f c5 f3 78 	mr      r5,r30
>     12c8:	38 60 00 01 	li      r3,1
>     12cc:	2f 80 00 2e 	cmpwi   cr7,r0,46
>     12d0:	40 9e ff 90 	bne+    cr7,1260 <.putnode+0x170>
>     12d4:	88 1f 00 01 	lbz     r0,1(r31)
>     12d8:	2f a0 00 00 	cmpdi   cr7,r0,0
>     12dc:	41 fe ff a4 	beq-    cr7,1280 <.putnode+0x190>
>     12e0:	2f 80 00 2e 	cmpwi   cr7,r0,46
>     12e4:	40 9e ff 7c 	bne+    cr7,1260 <.putnode+0x170>
>     12e8:	88 1f 00 02 	lbz     r0,2(r31)
>     12ec:	2f 80 00 00 	cmpwi   cr7,r0,0
>     12f0:	40 de ff 70 	bne+    cr7,1260 <.putnode+0x170>
>     12f4:	38 1c 00 01 	addi    r0,r28,1
>     12f8:	7c 1c 07 b4 	extsw   r28,r0
>     12fc:	7f 99 e0 00 	cmpw    cr7,r25,r28
>     1300:	41 9d ff 90 	bgt+    cr7,1290 <.putnode+0x1a0>
>     1304:	60 00 00 00 	nop
>     1308:	60 00 00 00 	nop
>     130c:	60 00 00 00 	nop
>     1310:	e9 7a 54 18 	ld      r11,21528(r26)
>     1314:	38 00 00 02 	li      r0,2
>     1318:	90 0b 00 00 	stw     r0,0(r11)
>     131c:	39 2b 00 04 	addi    r9,r11,4
>     1320:	38 00 00 00 	li      r0,0
>     1324:	f9 3a 54 18 	std     r9,21528(r26)
>     1328:	98 1f ff ff 	stb     r0,-1(r31)
>     132c:	e8 61 00 70 	ld      r3,112(r1)
>     1330:	48 00 00 01 	bl      1330 <.putnode+0x240>
>     1334:	60 00 00 00 	nop
>     1338:	38 21 05 70 	addi    r1,r1,1392
>     133c:	e8 01 00 10 	ld      r0,16(r1)
>     1340:	81 81 00 08 	lwz     r12,8(r1)
>     1344:	ea c1 ff b0 	ld      r22,-80(r1)
>     1348:	ea e1 ff b8 	ld      r23,-72(r1)
>     134c:	eb 01 ff c0 	ld      r24,-64(r1)
>     1350:	eb 21 ff c8 	ld      r25,-56(r1)
>     1354:	eb 41 ff d0 	ld      r26,-48(r1)
>     1358:	eb 61 ff d8 	ld      r27,-40(r1)
>     135c:	7c 08 03 a6 	mtlr    r0
>     1360:	eb 81 ff e0 	ld      r28,-32(r1)
>     1364:	eb a1 ff e8 	ld      r29,-24(r1)
>     1368:	7d 90 81 20 	mtocrf  8,r12
>     136c:	eb c1 ff f0 	ld      r30,-16(r1)
>     1370:	eb e1 ff f8 	ld      r31,-8(r1)
>     1374:	4e 80 00 20 	blr
>     1378:	60 00 00 00 	nop
>     137c:	60 00 00 00 	nop
>     1380:	f8 61 00 78 	std     r3,120(r1)
>     1384:	eb c2 01 50 	ld      r30,336(r2)
>     1388:	7f c3 f3 78 	mr      r3,r30
>     138c:	48 00 00 01 	bl      138c <.putnode+0x29c>
>     1390:	60 00 00 00 	nop
>     1394:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1398:	f8 61 00 78 	std     r3,120(r1)
>     139c:	40 9e 02 70 	bne-    cr7,160c <.putnode+0x51c>
>     13a0:	3b 81 01 18 	addi    r28,r1,280
>     13a4:	38 00 00 00 	li      r0,0
>     13a8:	7f 04 c3 78 	mr      r4,r24
>     13ac:	7f 83 e3 78 	mr      r3,r28
>     13b0:	f8 01 00 80 	std     r0,128(r1)
>     13b4:	48 00 00 01 	bl      13b4 <.putnode+0x2c4>
>     13b8:	60 00 00 00 	nop
>     13bc:	7f 83 e3 78 	mr      r3,r28
>     13c0:	48 00 00 01 	bl      13c0 <.putnode+0x2d0>
>     13c4:	60 00 00 00 	nop
>     13c8:	eb a2 00 f0 	ld      r29,240(r2)
>     13cc:	e8 82 01 68 	ld      r4,360(r2)
>     13d0:	7d 5c 1a 14 	add     r10,r28,r3
>     13d4:	7c 68 1b 78 	mr      r8,r3
>     13d8:	7f 83 e3 78 	mr      r3,r28
>     13dc:	80 1d 00 00 	lwz     r0,0(r29)
>     13e0:	81 3d 00 04 	lwz     r9,4(r29)
>     13e4:	89 7d 00 08 	lbz     r11,8(r29)
>     13e8:	7c 1c 41 2e 	stwx    r0,r28,r8
>     13ec:	91 2a 00 04 	stw     r9,4(r10)
>     13f0:	99 6a 00 08 	stb     r11,8(r10)
>     13f4:	48 00 00 01 	bl      13f4 <.putnode+0x304>
>     13f8:	60 00 00 00 	nop
>     13fc:	2c 23 00 00 	cmpdi   r3,0
>     1400:	41 82 00 6c 	beq-    146c <.putnode+0x37c>
>     1404:	7c 66 1b 78 	mr      r6,r3
>     1408:	38 81 00 78 	addi    r4,r1,120
>     140c:	38 61 00 80 	addi    r3,r1,128
>     1410:	38 a0 00 0a 	li      r5,10
>     1414:	48 00 00 01 	bl      1414 <.putnode+0x324>
>     1418:	60 00 00 00 	nop
>     141c:	2f a3 ff ff 	cmpdi   cr7,r3,-1
>     1420:	41 9e 02 fc 	beq-    cr7,171c <.putnode+0x62c>
>     1424:	eb 81 00 80 	ld      r28,128(r1)
>     1428:	e8 82 01 60 	ld      r4,352(r2)
>     142c:	7f 83 e3 78 	mr      r3,r28
>     1430:	48 00 00 01 	bl      1430 <.putnode+0x340>
>     1434:	60 00 00 00 	nop
>     1438:	2f a3 00 00 	cmpdi   cr7,r3,0
>     143c:	41 9e 00 34 	beq-    cr7,1470 <.putnode+0x380>
>     1440:	e8 82 01 78 	ld      r4,376(r2)
>     1444:	48 00 00 01 	bl      1444 <.putnode+0x354>
>     1448:	60 00 00 00 	nop
>     144c:	e8 01 00 78 	ld      r0,120(r1)
>     1450:	7c 7c 1b 78 	mr      r28,r3
>     1454:	2f a0 00 00 	cmpdi   cr7,r0,0
>     1458:	40 9e 02 ac 	bne-    cr7,1704 <.putnode+0x614>
>     145c:	7f 84 e3 78 	mr      r4,r28
>     1460:	7f c3 f3 78 	mr      r3,r30
>     1464:	48 00 00 01 	bl      1464 <.putnode+0x374>
>     1468:	60 00 00 00 	nop
>     146c:	eb 81 00 80 	ld      r28,128(r1)
>     1470:	2f bc 00 00 	cmpdi   cr7,r28,0
>     1474:	41 9e 01 d4 	beq-    cr7,1648 <.putnode+0x558>
>     1478:	7f 83 e3 78 	mr      r3,r28
>     147c:	48 00 00 01 	bl      147c <.putnode+0x38c>
>     1480:	60 00 00 00 	nop
>     1484:	48 00 01 c4 	b       1648 <.putnode+0x558>
>     1488:	60 00 00 00 	nop
>     148c:	60 00 00 00 	nop
>     1490:	48 00 00 01 	bl      1490 <.putnode+0x3a0>
>     1494:	60 00 00 00 	nop
>     1498:	e8 63 00 02 	lwa     r3,0(r3)
>     149c:	48 00 00 01 	bl      149c <.putnode+0x3ac>
>     14a0:	60 00 00 00 	nop
>     14a4:	7f 64 db 78 	mr      r4,r27
>     14a8:	7c 65 1b 78 	mr      r5,r3
>     14ac:	e8 62 00 b8 	ld      r3,184(r2)
>     14b0:	48 00 00 01 	bl      14b0 <.putnode+0x3c0>
>     14b4:	60 00 00 00 	nop
>     14b8:	80 01 00 a0 	lwz     r0,160(r1)
>     14bc:	54 00 04 26 	rlwinm  r0,r0,0,16,19
>     14c0:	2f 80 40 00 	cmpwi   cr7,r0,16384
>     14c4:	40 9e fd bc 	bne+    cr7,1280 <.putnode+0x190>
>     14c8:	48 00 00 91 	bl      1558 <.putnode+0x468>
>     14cc:	4b ff fd b4 	b       1280 <.putnode+0x190>
>     14d0:	eb 62 01 40 	ld      r27,320(r2)
>     14d4:	7e c3 b3 78 	mr      r3,r22
>     14d8:	7f 64 db 78 	mr      r4,r27
>     14dc:	48 00 00 01 	bl      14dc <.putnode+0x3ec>
>     14e0:	60 00 00 00 	nop
>     14e4:	2f a3 00 00 	cmpdi   cr7,r3,0
>     14e8:	40 9e fd 54 	bne+    cr7,123c <.putnode+0x14c>
>     14ec:	eb 9a 54 18 	ld      r28,21528(r26)
>     14f0:	38 00 00 08 	li      r0,8
>     14f4:	39 20 00 03 	li      r9,3
>     14f8:	e8 62 00 40 	ld      r3,64(r2)
>     14fc:	90 1c 00 04 	stw     r0,4(r28)
>     1500:	91 3c 00 00 	stw     r9,0(r28)
>     1504:	3b 9c 00 04 	addi    r28,r28,4
>     1508:	3b bc 00 04 	addi    r29,r28,4
>     150c:	fb ba 54 18 	std     r29,21528(r26)
>     1510:	3b bd 00 04 	addi    r29,r29,4
>     1514:	48 00 00 31 	bl      1544 <.putnode+0x454>
>     1518:	7b a0 f7 e3 	rldicl. r0,r29,62,63
>     151c:	90 7c 00 04 	stw     r3,4(r28)
>     1520:	fb ba 54 18 	std     r29,21528(r26)
>     1524:	41 82 00 0c 	beq-    1530 <.putnode+0x440>
>     1528:	38 1d 00 04 	addi    r0,r29,4
>     152c:	f8 1a 54 18 	std     r0,21528(r26)
>     1530:	e9 3a 54 18 	ld      r9,21528(r26)
>     1534:	e8 17 00 00 	ld      r0,0(r23)
>     1538:	e8 62 00 48 	ld      r3,72(r2)
>     153c:	f8 09 00 00 	std     r0,0(r9)
>     1540:	38 00 00 03 	li      r0,3
>     1544:	39 20 00 08 	li      r9,8
>     1548:	eb da 54 18 	ld      r30,21528(r26)
>     154c:	90 1e 00 08 	stw     r0,8(r30)
>     1550:	38 1e 00 10 	addi    r0,r30,16
>     1554:	91 3e 00 0c 	stw     r9,12(r30)
>     1558:	f8 1a 54 18 	std     r0,21528(r26)
>     155c:	48 00 00 31 	bl      158c <.putnode+0x49c>
>     1560:	e8 82 01 48 	ld      r4,328(r2)
>     1564:	39 3e 00 14 	addi    r9,r30,20
>     1568:	90 7e 00 10 	stw     r3,16(r30)
>     156c:	79 20 f7 e3 	rldicl. r0,r9,62,63
>     1570:	f9 3a 54 18 	std     r9,21528(r26)
>     1574:	e8 04 00 00 	ld      r0,0(r4)
>     1578:	e9 37 00 00 	ld      r9,0(r23)
>     157c:	7c 00 4a 14 	add     r0,r0,r9
>     1580:	f8 01 00 78 	std     r0,120(r1)
>     1584:	41 82 00 0c 	beq-    1590 <.putnode+0x4a0>
>     1588:	38 1e 00 18 	addi    r0,r30,24
>     158c:	f8 1a 54 18 	std     r0,21528(r26)
>     1590:	e9 3a 54 18 	ld      r9,21528(r26)
>     1594:	e8 01 00 78 	ld      r0,120(r1)
>     1598:	f8 09 00 00 	std     r0,0(r9)
>     159c:	e9 7a 54 18 	ld      r11,21528(r26)
>     15a0:	e8 77 00 00 	ld      r3,0(r23)
>     15a4:	e8 84 00 00 	ld      r4,0(r4)
>     15a8:	39 6b 00 08 	addi    r11,r11,8
>     15ac:	f9 7a 54 18 	std     r11,21528(r26)
>     15b0:	48 00 00 01 	bl      15b0 <.putnode+0x4c0>
>     15b4:	4b ff fc 70 	b       1224 <.putnode+0x134>
>     15b8:	60 00 00 00 	nop
>     15bc:	60 00 00 00 	nop
>     15c0:	e8 62 01 30 	ld      r3,304(r2)
>     15c4:	7f 04 c3 78 	mr      r4,r24
>     15c8:	48 00 00 01 	bl      15c8 <.putnode+0x4d8>
>     15cc:	60 00 00 00 	nop
>     15d0:	4b ff fb f8 	b       11c8 <.putnode+0xd8>
>     15d4:	60 00 00 00 	nop
>     15d8:	60 00 00 00 	nop
>     15dc:	60 00 00 00 	nop
>     15e0:	48 00 00 01 	bl      15e0 <.putnode+0x4f0>
>     15e4:	60 00 00 00 	nop
>     15e8:	e8 63 00 02 	lwa     r3,0(r3)
>     15ec:	48 00 00 01 	bl      15ec <.putnode+0x4fc>
>     15f0:	60 00 00 00 	nop
>     15f4:	7f 04 c3 78 	mr      r4,r24
>     15f8:	7c 65 1b 78 	mr      r5,r3
>     15fc:	e8 62 01 28 	ld      r3,296(r2)
>     1600:	48 00 00 01 	bl      1600 <.putnode+0x510>
>     1604:	60 00 00 00 	nop
>     1608:	4b ff fb b8 	b       11c0 <.putnode+0xd0>
>     160c:	e8 82 01 58 	ld      r4,344(r2)
>     1610:	7f c3 f3 78 	mr      r3,r30
>     1614:	48 00 00 01 	bl      1614 <.putnode+0x524>
>     1618:	60 00 00 00 	nop
>     161c:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1620:	41 9e 00 0c 	beq-    cr7,162c <.putnode+0x53c>
>     1624:	38 00 00 01 	li      r0,1
>     1628:	90 1a 54 20 	stw     r0,21536(r26)
>     162c:	e8 82 01 60 	ld      r4,352(r2)
>     1630:	7f c3 f3 78 	mr      r3,r30
>     1634:	48 00 00 01 	bl      1634 <.putnode+0x544>
>     1638:	60 00 00 00 	nop
>     163c:	2f a3 00 00 	cmpdi   cr7,r3,0
>     1640:	41 de fd 60 	beq+    cr7,13a0 <.putnode+0x2b0>
>     1644:	eb a2 00 f0 	ld      r29,240(r2)
>     1648:	7f c3 f3 78 	mr      r3,r30
>     164c:	48 00 00 01 	bl      164c <.putnode+0x55c>
>     1650:	60 00 00 00 	nop
>     1654:	38 00 20 00 	li      r0,8192
>     1658:	7c 1e 1b 2e 	sthx    r0,r30,r3
>     165c:	7f c3 f3 78 	mr      r3,r30
>     1660:	48 00 00 01 	bl      1660 <.putnode+0x570>
>     1664:	60 00 00 00 	nop
>     1668:	e9 3a 54 18 	ld      r9,21528(r26)
>     166c:	38 00 00 03 	li      r0,3
>     1670:	38 63 00 01 	addi    r3,r3,1
>     1674:	f8 61 00 78 	std     r3,120(r1)
>     1678:	7f a3 eb 78 	mr      r3,r29
>     167c:	90 09 00 00 	stw     r0,0(r9)
>     1680:	3b 89 00 04 	addi    r28,r9,4
>     1684:	3b bc 00 04 	addi    r29,r28,4
>     1688:	e8 01 00 78 	ld      r0,120(r1)
>     168c:	90 09 00 04 	stw     r0,4(r9)
>     1690:	fb ba 54 18 	std     r29,21528(r26)
>     1694:	3b bd 00 04 	addi    r29,r29,4
>     1698:	48 00 00 31 	bl      16c8 <.putnode+0x5d8>
>     169c:	90 7c 00 04 	stw     r3,4(r28)
>     16a0:	fb ba 54 18 	std     r29,21528(r26)
>     16a4:	e8 a1 00 78 	ld      r5,120(r1)
>     16a8:	2b a5 00 07 	cmpldi  cr7,r5,7
>     16ac:	40 9d 00 14 	ble-    cr7,16c0 <.putnode+0x5d0>
>     16b0:	7b a0 f7 e3 	rldicl. r0,r29,62,63
>     16b4:	41 82 00 0c 	beq-    16c0 <.putnode+0x5d0>
>     16b8:	38 1d 00 04 	addi    r0,r29,4
>     16bc:	f8 1a 54 18 	std     r0,21528(r26)
>     16c0:	e8 7a 54 18 	ld      r3,21528(r26)
>     16c4:	7f c4 f3 78 	mr      r4,r30
>     16c8:	48 00 00 01 	bl      16c8 <.putnode+0x5d8>
>     16cc:	60 00 00 00 	nop
>     16d0:	e9 21 00 78 	ld      r9,120(r1)
>     16d4:	e8 1a 54 18 	ld      r0,21528(r26)
>     16d8:	7f c5 f3 78 	mr      r5,r30
>     16dc:	e9 62 01 80 	ld      r11,384(r2)
>     16e0:	e8 82 01 88 	ld      r4,392(r2)
>     16e4:	39 29 00 03 	addi    r9,r9,3
>     16e8:	e8 6b 00 00 	ld      r3,0(r11)
>     16ec:	79 29 07 64 	rldicr  r9,r9,0,61
>     16f0:	7c 00 4a 14 	add     r0,r0,r9
>     16f4:	f8 1a 54 18 	std     r0,21528(r26)
>     16f8:	48 00 00 01 	bl      16f8 <.putnode+0x608>
>     16fc:	60 00 00 00 	nop
>     1700:	4b ff fb 3c 	b       123c <.putnode+0x14c>
>     1704:	7f c3 f3 78 	mr      r3,r30
>     1708:	48 00 00 01 	bl      1708 <.putnode+0x618>
>     170c:	60 00 00 00 	nop
>     1710:	38 00 20 00 	li      r0,8192
>     1714:	7c 1e 1b 2e 	sthx    r0,r30,r3
>     1718:	4b ff fd 44 	b       145c <.putnode+0x36c>
>     171c:	e8 62 01 70 	ld      r3,368(r2)
>     1720:	7f 84 e3 78 	mr      r4,r28
>     1724:	48 00 00 01 	bl      1724 <.putnode+0x634>
>     1728:	60 00 00 00 	nop
>     172c:	4b ff fc f8 	b       1424 <.putnode+0x334>
>     1730:	00 00 00 00 	.long 0x0
>     1734:	00 00 00 03 	.long 0x3
>     1738:	80 0a 00 00 	lwz     r0,0(r10)
>     173c:	60 00 00 00 	nop
> 
> 0000000000001740 <.create_flatten_tree>:
>     1740:	7c 08 02 a6 	mflr    r0
>     1744:	fb 21 ff c8 	std     r25,-56(r1)
>     1748:	fb 41 ff d0 	std     r26,-48(r1)
>     174c:	fb 81 ff e0 	std     r28,-32(r1)
>     1750:	fb a1 ff e8 	std     r29,-24(r1)
>     1754:	fb c1 ff f0 	std     r30,-16(r1)
>     1758:	fb e1 ff f8 	std     r31,-8(r1)
>     175c:	f8 01 00 10 	std     r0,16(r1)
>     1760:	fb 61 ff d8 	std     r27,-40(r1)
>     1764:	f8 21 ff 51 	stdu    r1,-176(r1)
>     1768:	e9 22 01 90 	ld      r9,400(r2)
>     176c:	eb e2 00 00 	ld      r31,0(r2)
>     1770:	7c be 2b 78 	mr      r30,r5
>     1774:	7c 7c 1b 78 	mr      r28,r3
>     1778:	7c 99 23 78 	mr      r25,r4
>     177c:	3b bf 50 18 	addi    r29,r31,20504
>     1780:	3b 5f 54 30 	addi    r26,r31,21552
>     1784:	7f a3 eb 78 	mr      r3,r29
>     1788:	89 09 00 12 	lbz     r8,18(r9)
>     178c:	e8 09 00 00 	ld      r0,0(r9)
>     1790:	e9 69 00 08 	ld      r11,8(r9)
>     1794:	a1 49 00 10 	lhz     r10,16(r9)
>     1798:	99 1d 00 12 	stb     r8,18(r29)
>     179c:	f8 1f 50 18 	std     r0,20504(r31)
>     17a0:	f9 7d 00 08 	std     r11,8(r29)
>     17a4:	b1 5d 00 10 	sth     r10,16(r29)
>     17a8:	48 00 00 01 	bl      17a8 <.create_flatten_tree+0x68>
>     17ac:	60 00 00 00 	nop
>     17b0:	2f be 00 00 	cmpdi   cr7,r30,0
>     17b4:	fb 5f 54 18 	std     r26,21528(r31)
>     17b8:	7f bd 1a 14 	add     r29,r29,r3
>     17bc:	fb bf 54 28 	std     r29,21544(r31)
>     17c0:	41 9e 00 14 	beq-    cr7,17d4 <.create_flatten_tree+0x94>
>     17c4:	e8 62 01 50 	ld      r3,336(r2)
>     17c8:	7f c4 f3 78 	mr      r4,r30
>     17cc:	48 00 00 01 	bl      17cc <.create_flatten_tree+0x8c>
>     17d0:	60 00 00 00 	nop
>     17d4:	48 00 00 91 	bl      1864 <.create_flatten_tree+0x124>
>     17d8:	e9 3f 54 18 	ld      r9,21528(r31)
>     17dc:	38 00 00 09 	li      r0,9
>     17e0:	3f df 00 04 	addis   r30,r31,4
>     17e4:	39 60 00 01 	li      r11,1
>     17e8:	90 09 00 00 	stw     r0,0(r9)
>     17ec:	38 00 00 20 	li      r0,32
>     17f0:	39 49 00 04 	addi    r10,r9,4
>     17f4:	39 20 00 40 	li      r9,64
>     17f8:	90 1e 54 40 	stw     r0,21568(r30)
>     17fc:	f9 5f 54 18 	std     r10,21528(r31)
>     1800:	e8 1f 00 08 	ld      r0,8(r31)
>     1804:	2f a0 00 00 	cmpdi   cr7,r0,0
>     1808:	41 de 00 28 	beq-    cr7,1830 <.create_flatten_tree+0xf0>
>     180c:	60 00 00 00 	nop
>     1810:	39 6b 00 02 	addi    r11,r11,2
>     1814:	79 60 1f 24 	rldicr  r0,r11,3,60
>     1818:	7d 3f 00 2a 	ldx     r9,r31,r0
>     181c:	2f a9 00 00 	cmpdi   cr7,r9,0
>     1820:	40 fe ff f0 	bne-    cr7,1810 <.create_flatten_tree+0xd0>
>     1824:	55 69 18 38 	rlwinm  r9,r11,3,0,28
>     1828:	39 29 00 38 	addi    r9,r9,56
>     182c:	79 29 00 20 	clrldi  r9,r9,32
>     1830:	7c 1a 50 50 	subf    r0,r26,r10
>     1834:	91 3e 54 38 	stw     r9,21560(r30)
>     1838:	e8 62 01 98 	ld      r3,408(r2)
>     183c:	78 00 07 64 	rldicr  r0,r0,0,61
>     1840:	7c 09 02 14 	add     r0,r9,r0
>     1844:	90 1e 54 3c 	stw     r0,21564(r30)
>     1848:	48 00 00 31 	bl      1878 <.create_flatten_tree+0x138>
>     184c:	81 3e 54 3c 	lwz     r9,21564(r30)
>     1850:	3c 00 d0 0d 	lis     r0,-12275
>     1854:	39 60 00 02 	li      r11,2
>     1858:	38 63 00 03 	addi    r3,r3,3
>     185c:	60 00 fe ed 	ori     r0,r0,65261
>     1860:	91 7e 54 48 	stw     r11,21576(r30)
>     1864:	91 7e 54 44 	stw     r11,21572(r30)
>     1868:	78 63 07 64 	rldicr  r3,r3,0,61
>     186c:	90 1e 54 30 	stw     r0,21552(r30)
>     1870:	7d 29 1a 14 	add     r9,r9,r3
>     1874:	38 60 00 00 	li      r3,0
>     1878:	79 29 00 20 	clrldi  r9,r9,32
>     187c:	91 3e 54 34 	stw     r9,21556(r30)
>     1880:	7d 24 4b 78 	mr      r4,r9
>     1884:	48 00 00 01 	bl      1884 <.create_flatten_tree+0x144>
>     1888:	80 7e 54 34 	lwz     r3,21556(r30)
>     188c:	48 00 00 01 	bl      188c <.create_flatten_tree+0x14c>
>     1890:	60 00 00 00 	nop
>     1894:	38 9e 54 30 	addi    r4,r30,21552
>     1898:	f8 7c 00 00 	std     r3,0(r28)
>     189c:	7c 7b 1b 78 	mr      r27,r3
>     18a0:	80 be 54 40 	lwz     r5,21568(r30)
>     18a4:	48 00 00 01 	bl      18a4 <.create_flatten_tree+0x164>
>     18a8:	60 00 00 00 	nop
>     18ac:	83 9e 54 40 	lwz     r28,21568(r30)
>     18b0:	80 be 54 38 	lwz     r5,21560(r30)
>     18b4:	7f e4 fb 78 	mr      r4,r31
>     18b8:	7c bc 28 50 	subf    r5,r28,r5
>     18bc:	7c 7b e2 14 	add     r3,r27,r28
>     18c0:	78 a5 00 20 	clrldi  r5,r5,32
>     18c4:	48 00 00 01 	bl      18c4 <.create_flatten_tree+0x184>
>     18c8:	60 00 00 00 	nop
>     18cc:	80 1e 54 38 	lwz     r0,21560(r30)
>     18d0:	83 be 54 40 	lwz     r29,21568(r30)
>     18d4:	7f 44 d3 78 	mr      r4,r26
>     18d8:	80 be 54 3c 	lwz     r5,21564(r30)
>     18dc:	7f bd 00 50 	subf    r29,r29,r0
>     18e0:	7c a0 28 50 	subf    r5,r0,r5
>     18e4:	7b bd 00 20 	clrldi  r29,r29,32
>     18e8:	78 a5 00 20 	clrldi  r5,r5,32
>     18ec:	7f bd e2 14 	add     r29,r29,r28
>     18f0:	7c 7b ea 14 	add     r3,r27,r29
>     18f4:	48 00 00 01 	bl      18f4 <.create_flatten_tree+0x1b4>
>     18f8:	60 00 00 00 	nop
>     18fc:	81 3e 54 3c 	lwz     r9,21564(r30)
>     1900:	80 1e 54 38 	lwz     r0,21560(r30)
>     1904:	38 9f 10 18 	addi    r4,r31,4120
>     1908:	80 be 54 34 	lwz     r5,21556(r30)
>     190c:	7c 00 48 50 	subf    r0,r0,r9
>     1910:	7c a9 28 50 	subf    r5,r9,r5
>     1914:	78 00 00 20 	clrldi  r0,r0,32
>     1918:	78 a5 00 20 	clrldi  r5,r5,32
>     191c:	7f bd 02 14 	add     r29,r29,r0
>     1920:	7c 7b ea 14 	add     r3,r27,r29
>     1924:	48 00 00 01 	bl      1924 <.create_flatten_tree+0x1e4>
>     1928:	60 00 00 00 	nop
>     192c:	81 3e 54 3c 	lwz     r9,21564(r30)
>     1930:	80 1e 54 34 	lwz     r0,21556(r30)
>     1934:	38 21 00 b0 	addi    r1,r1,176
>     1938:	38 60 00 00 	li      r3,0
>     193c:	7c 09 00 50 	subf    r0,r9,r0
>     1940:	7c 00 ea 14 	add     r0,r0,r29
>     1944:	f8 19 00 00 	std     r0,0(r25)
>     1948:	e8 01 00 10 	ld      r0,16(r1)
>     194c:	eb 21 ff c8 	ld      r25,-56(r1)
>     1950:	eb 41 ff d0 	ld      r26,-48(r1)
>     1954:	eb 61 ff d8 	ld      r27,-40(r1)
>     1958:	eb 81 ff e0 	ld      r28,-32(r1)
>     195c:	eb a1 ff e8 	ld      r29,-24(r1)
>     1960:	eb c1 ff f0 	ld      r30,-16(r1)
>     1964:	eb e1 ff f8 	ld      r31,-8(r1)
>     1968:	7c 08 03 a6 	mtlr    r0
>     196c:	4e 80 00 20 	blr
>     1970:	00 00 00 00 	.long 0x0
>     1974:	00 00 00 01 	.long 0x1
>     1978:	80 07 00 00 	lwz     r0,0(r7)
>     197c:	60 00 00 00 	nop
> 
> 0000000000001980 <.comparefunc>:
>     1980:	7c 08 02 a6 	mflr    r0
>     1984:	fb c1 ff f0 	std     r30,-16(r1)
>     1988:	fb e1 ff f8 	std     r31,-8(r1)
>     198c:	fb a1 ff e8 	std     r29,-24(r1)
>     1990:	f8 01 00 10 	std     r0,16(r1)
>     1994:	f8 21 ff 71 	stdu    r1,-144(r1)
>     1998:	e9 23 00 00 	ld      r9,0(r3)
>     199c:	e9 64 00 00 	ld      r11,0(r4)
>     19a0:	38 80 00 40 	li      r4,64
>     19a4:	3b e9 00 13 	addi    r31,r9,19
>     19a8:	3b cb 00 13 	addi    r30,r11,19
>     19ac:	7f e3 fb 78 	mr      r3,r31
>     19b0:	48 00 00 01 	bl      19b0 <.comparefunc+0x30>
>     19b4:	60 00 00 00 	nop
>     19b8:	2f a3 00 00 	cmpdi   cr7,r3,0
>     19bc:	41 9e 00 44 	beq-    cr7,1a00 <.comparefunc+0x80>
>     19c0:	7f c3 f3 78 	mr      r3,r30
>     19c4:	38 80 00 40 	li      r4,64
>     19c8:	48 00 00 01 	bl      19c8 <.comparefunc+0x48>
>     19cc:	60 00 00 00 	nop
>     19d0:	2f a3 00 00 	cmpdi   cr7,r3,0
>     19d4:	41 9e 00 2c 	beq-    cr7,1a00 <.comparefunc+0x80>
>     19d8:	7f e3 fb 78 	mr      r3,r31
>     19dc:	48 00 00 01 	bl      19dc <.comparefunc+0x5c>
>     19e0:	60 00 00 00 	nop
>     19e4:	7c 7d 1b 78 	mr      r29,r3
>     19e8:	7f c3 f3 78 	mr      r3,r30
>     19ec:	48 00 00 01 	bl      19ec <.comparefunc+0x6c>
>     19f0:	60 00 00 00 	nop
>     19f4:	38 00 00 01 	li      r0,1
>     19f8:	7f bd 18 40 	cmpld   cr7,r29,r3
>     19fc:	41 9d 00 18 	bgt-    cr7,1a14 <.comparefunc+0x94>
>     1a00:	7f e3 fb 78 	mr      r3,r31
>     1a04:	7f c4 f3 78 	mr      r4,r30
>     1a08:	48 00 00 01 	bl      1a08 <.comparefunc+0x88>
>     1a0c:	60 00 00 00 	nop
>     1a10:	7c 60 1b 78 	mr      r0,r3
>     1a14:	38 21 00 90 	addi    r1,r1,144
>     1a18:	7c 03 03 78 	mr      r3,r0
>     1a1c:	e8 01 00 10 	ld      r0,16(r1)
>     1a20:	eb a1 ff e8 	ld      r29,-24(r1)
>     1a24:	eb c1 ff f0 	ld      r30,-16(r1)
>     1a28:	eb e1 ff f8 	ld      r31,-8(r1)
>     1a2c:	7c 08 03 a6 	mtlr    r0
>     1a30:	4e 80 00 20 	blr
>     1a34:	00 00 00 00 	.long 0x0
>     1a38:	00 00 00 01 	.long 0x1
>     1a3c:	80 03 00 00 	lwz     r0,0(r3)
> 
> Disassembly of section .data:
> 
> 0000000000000000 <local_cmdline>:
> 	...
> 
> Disassembly of section .bss:
> 
> 0000000000000000 <mem_rsrv>:
> 	...
> 
> 0000000000001000 <base.4421>:
> 	...
> 
> 0000000000001008 <size.4422>:
> 	...
> 
> 0000000000001010 <end.4423>:
> 	...
> 
> 0000000000001018 <propnames>:
> 	...
> 
> 0000000000005018 <pathname>:
> 	...
> 
> 0000000000005418 <dt>:
> 	...
> 
> 0000000000005420 <crash_param>:
> 	...
> 
> 0000000000005428 <pathstart>:
> 	...
> 
> 0000000000005430 <dtstruct>:
> 	...
> 
> 0000000000045430 <bb>:
> 	...
> 
> Disassembly of section .toc:
> 
> 0000000000000000 <.toc>:
> 	...
>   14:	00 00 00 38 	.long 0x38
>   18:	00 00 00 00 	.long 0x0
>   1c:	00 00 00 60 	.long 0x60
>   20:	00 00 00 00 	.long 0x0
>   24:	00 00 00 70 	.long 0x70
>   28:	00 00 00 00 	.long 0x0
>   2c:	00 00 00 80 	.long 0x80
>   30:	00 00 00 00 	.long 0x0
>   34:	00 00 00 90 	.long 0x90
> 	...
>   44:	00 00 00 a0 	.long 0xa0
>   48:	00 00 00 00 	.long 0x0
>   4c:	00 00 00 b8 	.long 0xb8
>   50:	00 00 00 00 	.long 0x0
>   54:	00 00 00 d0 	.long 0xd0
>   58:	00 00 00 00 	.long 0x0
>   5c:	00 00 01 08 	.long 0x108
>   60:	00 00 00 00 	.long 0x0
>   64:	00 00 01 30 	.long 0x130
>   68:	00 00 00 00 	.long 0x0
>   6c:	00 00 01 40 	.long 0x140
>   70:	00 00 00 00 	.long 0x0
>   74:	00 00 01 78 	.long 0x178
>   78:	00 00 00 00 	.long 0x0
>   7c:	00 00 01 a8 	.long 0x1a8
>   80:	00 00 00 00 	.long 0x0
>   84:	00 00 01 d8 	.long 0x1d8
> 	...
>   94:	00 00 02 08 	.long 0x208
>   98:	00 00 00 00 	.long 0x0
>   9c:	00 00 02 20 	.long 0x220
> 	...
>   b4:	00 00 02 48 	.long 0x248
>   b8:	00 00 00 00 	.long 0x0
>   bc:	00 00 02 68 	.long 0x268
>   c0:	00 00 00 00 	.long 0x0
>   c4:	00 00 02 98 	.long 0x298
>   c8:	00 00 00 00 	.long 0x0
>   cc:	00 00 02 b0 	.long 0x2b0
>   d0:	00 00 00 00 	.long 0x0
>   d4:	00 00 02 c8 	.long 0x2c8
>   d8:	00 00 00 00 	.long 0x0
>   dc:	00 00 02 e0 	.long 0x2e0
>   e0:	00 00 00 00 	.long 0x0
>   e4:	00 00 02 f0 	.long 0x2f0
>   e8:	00 00 00 00 	.long 0x0
>   ec:	00 00 03 00 	.long 0x300
>   f0:	00 00 00 00 	.long 0x0
>   f4:	00 00 03 18 	.long 0x318
>   f8:	00 00 00 00 	.long 0x0
>   fc:	00 00 03 28 	.long 0x328
>  100:	00 00 00 00 	.long 0x0
>  104:	00 00 03 58 	.long 0x358
>  108:	00 00 00 00 	.long 0x0
>  10c:	00 00 03 88 	.long 0x388
>  110:	00 00 00 00 	.long 0x0
>  114:	00 00 50 18 	.long 0x5018
>  118:	00 00 00 00 	.long 0x0
>  11c:	00 00 03 a0 	.long 0x3a0
>  120:	00 00 00 00 	.long 0x0
>  124:	00 00 00 c0 	.long 0xc0
>  128:	00 00 00 00 	.long 0x0
>  12c:	00 00 03 a8 	.long 0x3a8
>  130:	00 00 00 00 	.long 0x0
>  134:	00 00 03 d8 	.long 0x3d8
> 	...
>  144:	00 00 04 10 	.long 0x410
> 	...
>  15c:	00 00 04 20 	.long 0x420
>  160:	00 00 00 00 	.long 0x0
>  164:	00 00 04 30 	.long 0x430
>  168:	00 00 00 00 	.long 0x0
>  16c:	00 00 04 38 	.long 0x438
>  170:	00 00 00 00 	.long 0x0
>  174:	00 00 04 40 	.long 0x440
>  178:	00 00 00 00 	.long 0x0
>  17c:	00 00 04 58 	.long 0x458
> 	...
>  18c:	00 00 04 60 	.long 0x460
>  190:	00 00 00 00 	.long 0x0
>  194:	00 00 04 78 	.long 0x478
>  198:	00 00 00 00 	.long 0x0
>  19c:	00 00 04 90 	.long 0x490
> 
> Disassembly of section .debug_abbrev:
> 
> 0000000000000000 <.debug_abbrev>:
>    0:	01 11 01 25 	.long 0x1110125
>    4:	0e 13 0b 03 	twlti   r19,2819
>    8:	0e 1b 0e 11 	twlti   r27,3601
>    c:	01 12 01 10 	.long 0x1120110
>   10:	06 00 00 02 	.long 0x6000002
>   14:	24 00 0b 0b 	dozi    r0,r0,2827
>   18:	3e 0b 03 0e 	addis   r16,r11,782
>   1c:	00 00 03 24 	.long 0x324
>   20:	00 0b 0b 3e 	.long 0xb0b3e
>   24:	0b 03 08 00 	tdnei   r3,2048
>   28:	00 04 16 00 	.long 0x41600
>   2c:	03 0e 3a 0b 	.long 0x30e3a0b
>   30:	3b 0b 49 13 	addi    r24,r11,18707
>   34:	00 00 05 24 	.long 0x524
>   38:	00 0b 0b 3e 	.long 0xb0b3e
>   3c:	0b 00 00 06 	tdnei   r0,6
>   40:	0f 00 0b 0b 	twnei   r0,2827
>   44:	00 00 07 0f 	.long 0x70f
>   48:	00 0b 0b 49 	.long 0xb0b49
>   4c:	13 00 00 08 	vmuloub v24,v0,v0
>   50:	13 01 03 0e 	vpkpx   v24,v1,v0
>   54:	0b 0b 3a 0b 	tdnei   r11,14859
>   58:	3b 0b 01 13 	addi    r24,r11,275
>   5c:	00 00 09 0d 	.long 0x90d
>   60:	00 03 0e 3a 	.long 0x30e3a
>   64:	0b 3b 0b 49 	tdi     25,r27,2889
>   68:	13 38 0a 00 	vaddubs v25,v24,v1
>   6c:	00 0a 13 01 	.long 0xa1301
>   70:	03 0e 0b 05 	.long 0x30e0b05
>   74:	3a 0b 3b 0b 	addi    r16,r11,15115
>   78:	01 13 00 00 	.long 0x1130000
>   7c:	0b 01 01 49 	tdnei   r1,329
>   80:	13 01 13 00 	vaddsbs v24,v1,v2
>   84:	00 0c 21 00 	.long 0xc2100
>   88:	49 13 2f 0b 	bla     1132f08 <bb+0x10edad8>
>   8c:	00 00 0d 26 	.long 0xd26
>   90:	00 49 13 00 	.long 0x491300
>   94:	00 0e 26 00 	.long 0xe2600
>   98:	00 00 0f 0d 	.long 0xf0d
>   9c:	00 03 0e 3a 	.long 0x30e3a
>   a0:	0b 3b 05 49 	tdi     25,r27,1353
>   a4:	13 38 0a 00 	vaddubs v25,v24,v1
>   a8:	00 10 16 00 	.long 0x101600
>   ac:	03 0e 3a 0b 	.long 0x30e3a0b
>   b0:	3b 0b 00 00 	addi    r24,r11,0
>   b4:	11 0d 00 03 	.long 0x110d0003
>   b8:	08 3a 0b 3b 	tdlgti  r26,2875
>   bc:	0b 49 13 38 	tdi     26,r9,4920
>   c0:	0a 00 00 12 	tdlti   r0,18
>   c4:	2e 01 3f 0c 	cmpwi   cr4,r1,16140
>   c8:	03 0e 3a 0b 	.long 0x30e3a0b
>   cc:	3b 05 27 0c 	addi    r24,r5,9996
>   d0:	49 13 20 0b 	bla     1132008 <bb+0x10ecbd8>
>   d4:	01 13 00 00 	.long 0x1130000
>   d8:	13 05 00 03 	.long 0x13050003
>   dc:	0e 3a 0b 3b 	twi     17,r26,2875
>   e0:	05 49 13 00 	.long 0x5491300
>   e4:	00 14 2e 01 	.long 0x142e01
>   e8:	3f 0c 03 0e 	addis   r24,r12,782
>   ec:	3a 0b 3b 0b 	addi    r16,r11,15115
>   f0:	27 0c 49 13 	dozi    r24,r12,18707
>   f4:	20 0b 01 13 	subfic  r0,r11,275
>   f8:	00 00 15 05 	.long 0x1505
>   fc:	00 03 0e 3a 	.long 0x30e3a
>  100:	0b 3b 0b 49 	tdi     25,r27,2889
>  104:	13 00 00 16 	.long 0x13000016
>  108:	05 00 03 08 	.long 0x5000308
>  10c:	3a 0b 3b 0b 	addi    r16,r11,15115
>  110:	49 13 00 00 	b       1130110 <bb+0x10eace0>
>  114:	17 2e 01 3f 	.long 0x172e013f
>  118:	0c 03 0e 3a 	twi     0,r3,3642
>  11c:	0b 3b 0b 27 	tdi     25,r27,2855
>  120:	0c 11 01 12 	twi     0,r17,274
>  124:	01 40 06 01 	.long 0x1400601
>  128:	13 00 00 18 	.long 0x13000018
>  12c:	05 00 03 0e 	.long 0x500030e
>  130:	3a 0b 3b 0b 	addi    r16,r11,15115
>  134:	49 13 02 06 	ba      1130204 <bb+0x10eadd4>
>  138:	00 00 19 34 	.long 0x1934
>  13c:	00 03 0e 3a 	.long 0x30e3a
>  140:	0b 3b 0b 49 	tdi     25,r27,2889
>  144:	13 02 06 00 	vsububs v24,v2,v0
>  148:	00 1a 2e 01 	.long 0x1a2e01
>  14c:	03 0e 3a 0b 	.long 0x30e3a0b
>  150:	3b 0b 27 0c 	addi    r24,r11,9996
>  154:	11 01 12 01 	.long 0x11011201
>  158:	40 06 01 13 	bdnzfla- 4*cr1+eq,110 <.debug_abbrev+0x110>
>  15c:	00 00 1b 05 	.long 0x1b05
>  160:	00 03 08 3a 	.long 0x3083a
>  164:	0b 3b 0b 49 	tdi     25,r27,2889
>  168:	13 02 06 00 	vsububs v24,v2,v0
>  16c:	00 1c 0b 01 	.long 0x1c0b01
>  170:	11 01 12 01 	.long 0x11011201
>  174:	01 13 00 00 	.long 0x1130000
>  178:	1d 34 00 03 	mulli   r9,r20,3
>  17c:	0e 3a 0b 3b 	twi     17,r26,2875
>  180:	0b 49 13 00 	tdi     26,r9,4864
>  184:	00 1e 34 00 	.long 0x1e3400
>  188:	03 0e 3a 0b 	.long 0x30e3a0b
>  18c:	3b 0b 49 13 	addi    r24,r11,18707
>  190:	02 0a 00 00 	.long 0x20a0000
>  194:	1f 34 00 03 	mulli   r25,r20,3
>  198:	08 3a 0b 3b 	tdlgti  r26,2875
>  19c:	0b 49 13 02 	tdi     26,r9,4866
>  1a0:	0a 00 00 20 	tdlti   r0,32
>  1a4:	2e 01 03 0e 	cmpwi   cr4,r1,782
>  1a8:	3a 0b 3b 0b 	addi    r16,r11,15115
>  1ac:	27 0c 49 13 	dozi    r24,r12,18707
>  1b0:	11 01 12 01 	.long 0x11011201
>  1b4:	40 06 01 13 	bdnzfla- 4*cr1+eq,110 <.debug_abbrev+0x110>
>  1b8:	00 00 21 0b 	.long 0x210b
>  1bc:	01 55 06 00 	.long 0x1550600
>  1c0:	00 22 34 00 	.long 0x223400
>  1c4:	03 08 3a 0b 	.long 0x3083a0b
>  1c8:	3b 0b 49 13 	addi    r24,r11,18707
>  1cc:	02 06 00 00 	.long 0x2060000
>  1d0:	23 21 00 49 	subfic  r25,r1,73
>  1d4:	13 2f 05 00 	.long 0x132f0500
>  1d8:	00 24 0b 01 	.long 0x240b01
>  1dc:	11 01 12 01 	.long 0x11011201
>  1e0:	00 00 25 2e 	.long 0x252e
>  1e4:	01 03 0e 3a 	.long 0x1030e3a
>  1e8:	0b 3b 05 27 	tdi     25,r27,1319
>  1ec:	0c 11 01 12 	twi     0,r17,274
>  1f0:	01 40 06 01 	.long 0x1400601
>  1f4:	13 00 00 26 	vmsumuhm v24,v0,v0,v0
>  1f8:	05 00 03 08 	.long 0x5000308
>  1fc:	3a 0b 3b 05 	addi    r16,r11,15109
>  200:	49 13 02 06 	ba      1130204 <bb+0x10eadd4>
>  204:	00 00 27 05 	.long 0x2705
>  208:	00 03 0e 3a 	.long 0x30e3a
>  20c:	0b 3b 05 49 	tdi     25,r27,1353
>  210:	13 02 06 00 	vsububs v24,v2,v0
>  214:	00 28 34 00 	.long 0x283400
>  218:	03 08 3a 0b 	.long 0x3083a0b
>  21c:	3b 05 49 13 	addi    r24,r5,18707
>  220:	02 06 00 00 	.long 0x2060000
>  224:	29 34 00 03 	cmpldi  cr2,r20,3
>  228:	0e 3a 0b 3b 	twi     17,r26,2875
>  22c:	05 49 13 02 	.long 0x5491302
>  230:	0a 00 00 2a 	tdlti   r0,42
>  234:	1d 01 31 13 	mulli   r8,r1,12563
>  238:	55 06 58 0b 	rlwinm. r6,r8,11,0,5
>  23c:	59 05 01 13 	rlmi.   r5,r8,r0,4,9
>  240:	00 00 2b 05 	.long 0x2b05
>  244:	00 31 13 00 	.long 0x311300
>  248:	00 2c 0b 01 	.long 0x2c0b01
>  24c:	55 06 01 13 	rlwinm. r6,r8,0,4,9
>  250:	00 00 2d 34 	.long 0x2d34
>  254:	00 03 0e 3a 	.long 0x30e3a
>  258:	0b 3b 05 49 	tdi     25,r27,1353
>  25c:	13 00 00 2e 	vmaddfp v24,v0,v0,v0
>  260:	34 00 03 08 	addic.  r0,r0,776
>  264:	3a 0b 3b 05 	addi    r16,r11,15109
>  268:	49 13 00 00 	b       1130268 <bb+0x10eae38>
>  26c:	2f 34 00 03 	cmpdi   cr6,r20,3
>  270:	0e 3a 0b 3b 	twi     17,r26,2875
>  274:	05 49 13 02 	.long 0x5491302
>  278:	06 00 00 30 	.long 0x6000030
>  27c:	1d 01 31 13 	mulli   r8,r1,12563
>  280:	11 01 12 01 	.long 0x11011201
>  284:	58 0b 59 05 	rlmi.   r11,r0,r11,4,2
>  288:	00 00 31 2e 	.long 0x312e
>  28c:	01 3f 0c 03 	.long 0x13f0c03
>  290:	0e 3a 0b 3b 	twi     17,r26,2875
>  294:	05 27 0c 49 	.long 0x5270c49
>  298:	13 11 01 12 	.long 0x13110112
>  29c:	01 40 06 01 	.long 0x1400601
>  2a0:	13 00 00 32 	.long 0x13000032
>  2a4:	2e 01 03 0e 	cmpwi   cr4,r1,782
>  2a8:	3a 0b 3b 05 	addi    r16,r11,15109
>  2ac:	27 0c 49 13 	dozi    r24,r12,18707
>  2b0:	11 01 12 01 	.long 0x11011201
>  2b4:	40 06 01 13 	bdnzfla- 4*cr1+eq,110 <.debug_abbrev+0x110>
>  2b8:	00 00 33 34 	.long 0x3334
>  2bc:	00 03 0e 3a 	.long 0x30e3a
>  2c0:	0b 3b 0b 49 	tdi     25,r27,2889
>  2c4:	13 3f 0c 3c 	.long 0x133f0c3c
>  2c8:	0c 00 00 34 	twi     0,r0,52
>  2cc:	34 00 03 0e 	addic.  r0,r0,782
>  2d0:	3a 0b 3b 0b 	addi    r16,r11,15115
>  2d4:	49 13 3f 0c 	b       11341e0 <bb+0x10eedb0>
>  2d8:	02 0a 00 00 	.long 0x20a0000
> 	...
> 
> Disassembly of section .debug_info:
> 
> 0000000000000000 <.debug_info>:
>        0:	00 00 13 04 	.long 0x1304
>        4:	00 02 00 00 	.long 0x20000
>        8:	00 00 08 01 	.long 0x801
>        c:	00 00 05 10 	.long 0x510
>       10:	01 00 00 04 	.long 0x1000004
>       14:	50 00 00 06 	rlwimi  r0,r0,0,0,3
>       18:	65 00 00 00 	oris    r0,r8,0
> 	...
>       24:	00 00 00 1a 	.long 0x1a
>       28:	40 00 00 00 	bdnzf-  lt,28 <.debug_info+0x28>
>       2c:	00 02 01 08 	.long 0x20108
>       30:	00 00 04 69 	.long 0x469
>       34:	02 02 07 00 	.long 0x2020700
>       38:	00 05 7f 02 	.long 0x57f02
>       3c:	04 07 00 00 	.long 0x4070000
>       40:	02 17 02 08 	.long 0x2170208
>       44:	07 00 00 02 	.long 0x7000002
>       48:	51 02 01 06 	rlwimi  r2,r8,0,4,3
>       4c:	00 00 00 f5 	.long 0xf5
>       50:	02 02 05 00 	.long 0x2020500
>       54:	00 04 8d 03 	.long 0x48d03
>       58:	04 05 69 6e 	.long 0x405696e
>       5c:	74 00 02 08 	andis.  r0,r0,520
>       60:	05 00 00 01 	.long 0x5000001
>       64:	61 04 00 00 	ori     r4,r8,0
>       68:	03 8b 04 86 	.long 0x38b0486
>       6c:	00 00 00 42 	.long 0x42
>       70:	04 00 00 05 	.long 0x4000005
>       74:	45 04 87 00 	.long 0x45048700
>       78:	00 00 3b 04 	.long 0x3b04
>       7c:	00 00 00 08 	.long 0x8
>       80:	04 88 00 00 	.long 0x4880000
>       84:	00 3b 04 00 	.long 0x3b0400
>       88:	00 04 cf 04 	.long 0x4cf04
>       8c:	89 00 00 00 	lbz     r8,0(0)
>       90:	42 04 00 00 	bc-     16,4*cr1+lt,90 <.debug_info+0x90>
>       94:	01 08 04 8b 	.long 0x108048b
>       98:	00 00 00 3b 	.long 0x3b
>       9c:	04 00 00 02 	.long 0x4000002
>       a0:	e7 04 8c 00 	.long 0xe7048c00
>       a4:	00 00 42 04 	.long 0x4204
>       a8:	00 00 00 00 	.long 0x0
>       ac:	04 8d 00 00 	.long 0x48d0000
>       b0:	00 5e 04 00 	.long 0x5e0400
>       b4:	00 05 53 04 	.long 0x55304
>       b8:	8e 00 00 00 	lbzu    r16,0(0)
>       bc:	5e 05 08 07 	rlwnm.  r5,r16,r1,0,3
>       c0:	04 00 00 05 	.long 0x4000005
>       c4:	07 04 95 00 	.long 0x7049500
>       c8:	00 00 5e 06 	.long 0x5e06
>       cc:	08 04 00 00 	tdi     0,r4,0
>       d0:	03 ec 04 a4 	.long 0x3ec04a4
>       d4:	00 00 00 5e 	.long 0x5e
>       d8:	04 00 00 01 	.long 0x4000001
>       dc:	56 04 a9 00 	rlwinm  r4,r16,21,4,0
>       e0:	00 00 5e 04 	.long 0x5e04
>       e4:	00 00 01 7f 	.long 0x17f
>       e8:	04 b4 00 00 	.long 0x4b40000
>       ec:	00 5e 07 08 	.long 0x5e0708
>       f0:	00 00 00 f4 	.long 0xf4
>       f4:	02 01 08 00 	.long 0x2010800
>       f8:	00 04 f9 04 	.long 0x4f904
>       fc:	00 00 01 e2 	.long 0x1e2
>      100:	05 58 00 00 	.long 0x5580000
>      104:	00 a7 04 00 	.long 0xa70400
>      108:	00 00 38 06 	.long 0x3806
>      10c:	d6 00 00 00 	stfsu   f16,0(0)
>      110:	42 08 00 00 	bc-     16,4*cr2+lt,110 <.debug_info+0x110>
>      114:	02 48 10 07 	.long 0x2481007
>      118:	7a 00 00 01 	rotldi. r0,r16,0
>      11c:	3a 09 00 00 	addi    r16,r9,0
>      120:	04 22 07 7b 	.long 0x422077b
>      124:	00 00 00 c0 	.long 0xc0
>      128:	02 23 00 09 	.long 0x2230009
>      12c:	00 00 03 7b 	.long 0x37b
>      130:	07 7c 00 00 	.long 0x77c0000
>      134:	00 5e 02 23 	.long 0x5e0223
>      138:	08 00 02 08 	tdi     0,r0,520
>      13c:	07 00 00 00 	.long 0x7000000
>      140:	95 02 08 05 	stwu    r8,2053(r2)
>      144:	00 00 00 e7 	.long 0xe7
>      148:	08 00 00 00 	tdi     0,r0,0
>      14c:	e2 90 08 8d 	.long 0xe290088d
>      150:	00 00 02 45 	.long 0x245
>      154:	09 00 00 06 	tdgti   r0,6
>      158:	25 08 8e 00 	dozi    r8,r8,-29184
>      15c:	00 00 65 02 	.long 0x6502
>      160:	23 00 09 00 	subfic  r24,r0,2304
>      164:	00 01 01 08 	.long 0x10108
>      168:	90 00 00 00 	stw     r0,0(0)
>      16c:	86 02 23 08 	lwzu    r16,8968(r2)
>      170:	09 00 00 04 	tdgti   r0,4
>      174:	d7 08 94 00 	stfsu   f24,-27648(r8)
>      178:	00 00 9c 02 	.long 0x9c02
>      17c:	23 10 09 00 	subfic  r24,r16,2304
>      180:	00 03 3a 08 	.long 0x33a08
>      184:	95 00 00 00 	stwu    r8,0(0)
>      188:	91 02 23 18 	stw     r8,8984(r2)
>      18c:	09 00 00 01 	tdgti   r0,1
>      190:	ff 08 96 00 	.long 0xff089600
>      194:	00 00 70 02 	.long 0x7002
>      198:	23 1c 09 00 	subfic  r24,r28,2304
>      19c:	00 05 a1 08 	.long 0x5a108
>      1a0:	97 00 00 00 	stwu    r24,0(0)
>      1a4:	7b 02 23 20 	rldicl  r2,r24,4,44
>      1a8:	09 00 00 05 	tdgti   r0,5
>      1ac:	af 08 98 00 	lhau    r24,-26624(r8)
>      1b0:	00 00 57 02 	.long 0x5702
>      1b4:	23 24 09 00 	subfic  r25,r4,2304
>      1b8:	00 04 ea 08 	.long 0x4ea08
>      1bc:	99 00 00 00 	stb     r8,0(0)
>      1c0:	65 02 23 28 	oris    r2,r8,9000
>      1c4:	09 00 00 03 	tdgti   r0,3
>      1c8:	2a 08 9b 00 	cmplwi  cr4,r8,39680
>      1cc:	00 00 a7 02 	.long 0xa702
>      1d0:	23 30 09 00 	subfic  r25,r16,2304
>      1d4:	00 04 9d 08 	.long 0x49d08
>      1d8:	9f 00 00 00 	stbu    r24,0(0)
>      1dc:	cd 02 23 38 	lfdu    f8,9016(r2)
>      1e0:	09 00 00 01 	tdgti   r0,1
>      1e4:	f5 08 a2 00 	.long 0xf508a200
>      1e8:	00 00 d8 02 	.long 0xd802
>      1ec:	23 40 09 00 	subfic  r26,r0,2304
>      1f0:	00 01 b6 08 	.long 0x1b608
>      1f4:	ad 00 00 01 	lhau    r8,1(0)
>      1f8:	11 02 23 48 	vmulesh v8,v2,v4
>      1fc:	09 00 00 06 	tdgti   r0,6
>      200:	51 08 ae 00 	rlwimi  r8,r8,21,24,0
>      204:	00 01 11 02 	.long 0x11102
>      208:	23 58 09 00 	subfic  r26,r24,2304
>      20c:	00 00 24 08 	.long 0x2408
>      210:	af 00 00 01 	lhau    r24,1(0)
>      214:	11 02 23 68 	vmsumshm v8,v2,v4,v13
>      218:	09 00 00 01 	tdgti   r0,1
>      21c:	38 08 bb 00 	addi    r0,r8,-17664
>      220:	00 00 42 02 	.long 0x4202
>      224:	23 78 09 00 	subfic  r27,r24,2304
>      228:	00 01 42 08 	.long 0x14208
>      22c:	bc 00 00 00 	stmw    r0,0(0)
>      230:	42 03 23 80 	bc-     16,so,25b0 <.comparefunc+0xc30>
>      234:	01 09 00 00 	.long 0x1090000
>      238:	01 4c 08 bd 	.long 0x14c08bd
>      23c:	00 00 00 42 	.long 0x42
>      240:	03 23 88 01 	.long 0x3238801
>      244:	00 0a 00 00 	.long 0xa0000
>      248:	03 cb 01 18 	.long 0x3cb0118
>      24c:	09 18 00 00 	tdgti   r24,0
>      250:	02 99 09 00 	.long 0x2990900
>      254:	00 03 d2 09 	.long 0x3d209
>      258:	1a 00 00 00 	.long 0x1a000000
>      25c:	86 02 23 00 	lwzu    r16,8960(r2)
>      260:	09 00 00 02 	tdgti   r0,2
>      264:	d3 09 1b 00 	stfs    f24,6912(r9)
>      268:	00 00 a7 02 	.long 0xa702
>      26c:	23 08 09 00 	subfic  r24,r8,2304
>      270:	00 01 6a 09 	.long 0x16a09
>      274:	20 00 00 00 	subfic  r0,r0,0
>      278:	34 02 23 10 	addic.  r0,r2,8976
>      27c:	09 00 00 04 	tdgti   r0,4
>      280:	77 09 21 00 	andis.  r9,r24,8448
>      284:	00 00 2d 02 	.long 0x2d02
>      288:	23 12 09 00 	subfic  r24,r18,2304
>      28c:	00 01 cb 09 	.long 0x1cb09
>      290:	22 00 00 02 	subfic  r16,r0,2
>      294:	99 02 23 13 	stb     r8,8979(r2)
>      298:	00 0b 00 00 	.long 0xb0000
>      29c:	00 f4 00 00 	.long 0xf40000
>      2a0:	02 a9 0c 00 	.long 0x2a90c00
>      2a4:	00 00 bd ff 	.long 0xbdff
>      2a8:	00 07 08 00 	.long 0x70800
>      2ac:	00 02 af 0d 	.long 0x2af0d
>      2b0:	00 00 00 f4 	.long 0xf4
>      2b4:	07 08 00 00 	.long 0x7080000
>      2b8:	02 ba 0e 04 	.long 0x2ba0e04
>      2bc:	00 00 04 ae 	.long 0x4ae
>      2c0:	0a 31 00 00 	tdi     17,r17,0
>      2c4:	02 c6 08 00 	.long 0x2c60800
>      2c8:	00 03 e3 d8 	.long 0x3e3d8
>      2cc:	0a 2d 00 00 	tdi     17,r13,0
>      2d0:	04 92 0f 00 	.long 0x4920f00
>      2d4:	00 01 73 0b 	.long 0x1730b
>      2d8:	01 10 00 00 	.long 0x1100000
>      2dc:	00 57 02 23 	.long 0x570223
>      2e0:	00 0f 00 00 	.long 0xf0000
>      2e4:	00 10 0b 01 	.long 0x100b01
>      2e8:	15 00 00 00 	.long 0x15000000
>      2ec:	ee 02 23 08 	.long 0xee022308
>      2f0:	0f 00 00 03 	twnei   r0,3
>      2f4:	56 0b 01 16 	rlwinm  r11,r16,0,4,11
>      2f8:	00 00 00 ee 	.long 0xee
>      2fc:	02 23 10 0f 	.long 0x223100f
>      300:	00 00 05 64 	.long 0x564
>      304:	0b 01 17 00 	tdnei   r1,5888
>      308:	00 00 ee 02 	.long 0xee02
>      30c:	23 18 0f 00 	subfic  r24,r24,3840
>      310:	00 06 83 0b 	.long 0x6830b
>      314:	01 18 00 00 	.long 0x1180000
>      318:	00 ee 02 23 	.long 0xee0223
>      31c:	20 0f 00 00 	subfic  r0,r15,0
>      320:	02 86 0b 01 	.long 0x2860b01
>      324:	19 00 00 00 	.long 0x19000000
>      328:	ee 02 23 28 	.long 0xee022328
>      32c:	0f 00 00 05 	twnei   r0,5
>      330:	cb 0b 01 1a 	lfd     f24,282(r11)
>      334:	00 00 00 ee 	.long 0xee
>      338:	02 23 30 0f 	.long 0x223300f
>      33c:	00 00 00 88 	.long 0x88
>      340:	0b 01 1b 00 	tdnei   r1,6912
>      344:	00 00 ee 02 	.long 0xee02
>      348:	23 38 0f 00 	subfic  r25,r24,3840
>      34c:	00 01 89 0b 	.long 0x1890b
>      350:	01 1c 00 00 	.long 0x11c0000
>      354:	00 ee 02 23 	.long 0xee0223
>      358:	40 0f 00 00 	bdnzf-  4*cr3+so,358 <.debug_info+0x358>
>      35c:	02 d9 0b 01 	.long 0x2d90b01
>      360:	1e 00 00 00 	mulli   r16,r0,0
>      364:	ee 02 23 48 	.long 0xee022348
>      368:	0f 00 00 06 	twnei   r0,6
>      36c:	41 0b 01 1f 	bdnztla- 4*cr2+so,11c <.debug_info+0x11c>
>      370:	00 00 00 ee 	.long 0xee
>      374:	02 23 50 0f 	.long 0x223500f
>      378:	00 00 05 72 	.long 0x572
>      37c:	0b 01 20 00 	tdnei   r1,8192
>      380:	00 00 ee 02 	.long 0xee02
>      384:	23 58 0f 00 	subfic  r26,r24,3840
>      388:	00 04 29 0b 	.long 0x4290b
>      38c:	01 22 00 00 	.long 0x1220000
>      390:	04 d0 02 23 	.long 0x4d00223
>      394:	60 0f 00 00 	ori     r15,r0,0
>      398:	00 1d 0b 01 	.long 0x1d0b01
>      39c:	24 00 00 04 	dozi    r0,r0,4
>      3a0:	d6 02 23 68 	stfsu   f16,9064(r2)
>      3a4:	0f 00 00 01 	twnei   r0,1
>      3a8:	2b 0b 01 26 	cmplwi  cr6,r11,294
>      3ac:	00 00 00 57 	.long 0x57
>      3b0:	02 23 70 0f 	.long 0x223700f
>      3b4:	00 00 06 39 	.long 0x639
>      3b8:	0b 01 2a 00 	tdnei   r1,10752
>      3bc:	00 00 57 02 	.long 0x5702
>      3c0:	23 74 0f 00 	subfic  r27,r20,3840
>      3c4:	00 04 16 0b 	.long 0x4160b
>      3c8:	01 2c 00 00 	.long 0x12c0000
>      3cc:	00 a7 02 23 	.long 0xa70223
>      3d0:	78 0f 00 00 	rotldi  r15,r0,0
>      3d4:	01 95 0b 01 	.long 0x1950b01
>      3d8:	30 00 00 00 	addic   r0,r0,0
>      3dc:	34 03 23 80 	addic.  r0,r3,9088
>      3e0:	01 0f 00 00 	.long 0x10f0000
>      3e4:	01 1c 0b 01 	.long 0x11c0b01
>      3e8:	31 00 00 00 	addic   r8,r0,0
>      3ec:	49 03 23 82 	ba      1032380 <bb+0xfecf50>
>      3f0:	01 0f 00 00 	.long 0x10f0000
>      3f4:	00 45 0b 01 	.long 0x450b01
>      3f8:	32 00 00 04 	addic   r16,r0,4
>      3fc:	dc 03 23 83 	stfdu   f0,9091(r3)
>      400:	01 0f 00 00 	.long 0x10f0000
>      404:	03 0b 0b 01 	.long 0x30b0b01
>      408:	36 00 00 04 	addic.  r16,r0,4
>      40c:	ec 03 23 88 	.long 0xec032388
>      410:	01 0f 00 00 	.long 0x10f0000
>      414:	01 be 0b 01 	.long 0x1be0b01
>      418:	3f 00 00 00 	lis     r24,0
>      41c:	b2 03 23 90 	sth     r16,9104(r3)
>      420:	01 0f 00 00 	.long 0x10f0000
>      424:	05 a8 0b 01 	.long 0x5a80b01
>      428:	48 00 00 00 	b       428 <.debug_info+0x428>
>      42c:	cb 03 23 98 	lfd     f24,9112(r3)
>      430:	01 0f 00 00 	.long 0x10f0000
>      434:	05 af 0b 01 	.long 0x5af0b01
>      438:	49 00 00 00 	b       1000438 <bb+0xfbb008>
>      43c:	cb 03 23 a0 	lfd     f24,9120(r3)
>      440:	01 0f 00 00 	.long 0x10f0000
>      444:	05 b6 0b 01 	.long 0x5b60b01
>      448:	4a 00 00 00 	b       fffffffffe000448 <bb+0xfffffffffdfbb018>
>      44c:	cb 03 23 a8 	lfd     f24,9128(r3)
>      450:	01 0f 00 00 	.long 0x10f0000
>      454:	05 bd 0b 01 	.long 0x5bd0b01
>      458:	4b 00 00 00 	b       ffffffffff000458 <bb+0xfffffffffefbb028>
>      45c:	cb 03 23 b0 	lfd     f24,9136(r3)
>      460:	01 0f 00 00 	.long 0x10f0000
>      464:	05 c4 0b 01 	.long 0x5c40b01
>      468:	4c 00 00 01 	.long 0x4c000001
>      46c:	06 03 23 b8 	.long 0x60323b8
>      470:	01 0f 00 00 	.long 0x10f0000
>      474:	03 11 0b 01 	.long 0x3110b01
>      478:	4e 00 00 00 	mcrf    cr4,cr0
>      47c:	57 03 23 c0 	rlwinm  r3,r24,4,15,0
>      480:	01 0f 00 00 	.long 0x10f0000
>      484:	05 df 0b 01 	.long 0x5df0b01
>      488:	50 00 00 04 	rlwimi  r0,r0,0,0,2
>      48c:	f2 03 23 c4 	.long 0xf20323c4
>      490:	01 00 10 00 	.long 0x1001000
>      494:	00 03 d8 0b 	.long 0x3d80b
>      498:	b4 08 00 00 	sthu    r0,0(r8)
>      49c:	02 06 18 0b 	.long 0x206180b
>      4a0:	ba 00 00 04 	lmw     r16,4(0)
>      4a4:	d0 09 00 00 	stfs    f0,0(r9)
>      4a8:	05 4d 0b bb 	.long 0x54d0bbb
>      4ac:	00 00 04 d0 	.long 0x4d0
>      4b0:	02 23 00 09 	.long 0x2230009
>      4b4:	00 00 02 a3 	.long 0x2a3
>      4b8:	0b bc 00 00 	tdi     29,r28,0
>      4bc:	04 d6 02 23 	.long 0x4d60223
>      4c0:	08 09 00 00 	tdi     0,r9,0
>      4c4:	04 11 0b c0 	.long 0x4110bc0
>      4c8:	00 00 00 57 	.long 0x57
>      4cc:	02 23 10 00 	.long 0x2231000
>      4d0:	07 08 00 00 	.long 0x7080000
>      4d4:	04 99 07 08 	.long 0x4990708
>      4d8:	00 00 02 c6 	.long 0x2c6
>      4dc:	0b 00 00 00 	tdnei   r0,0
>      4e0:	f4 00 00 04 	.long 0xf4000004
>      4e4:	ec 0c 00 00 	.long 0xec0c0000
>      4e8:	00 bd 00 00 	.long 0xbd0000
>      4ec:	07 08 00 00 	.long 0x7080000
>      4f0:	04 92 0b 00 	.long 0x4920b00
>      4f4:	00 00 f4 00 	.long 0xf400
>      4f8:	00 05 02 0c 	.long 0x5020c
>      4fc:	00 00 00 bd 	.long 0xbd
>      500:	13 00 04 00 	vsububm v24,v0,v0
>      504:	00 03 c2 0c 	.long 0x3c20c
>      508:	38 00 00 00 	li      r0,0
>      50c:	42 07 08 00 	bc-     16,4*cr1+so,d0c <.debug_info+0xd0c>
>      510:	00 05 13 0d 	.long 0x5130d
>      514:	00 00 00 2d 	.long 0x2d
>      518:	08 00 00 01 	tdi     0,r0,1
>      51c:	e8 18 0d 69 	ldu     r0,3432(r24)
>      520:	00 00 05 4f 	.long 0x54f
>      524:	09 00 00 06 	tdgti   r0,6
>      528:	7d 0d 6a 00 	.long 0x7d0d6a00
>      52c:	00 01 3a 02 	.long 0x13a02
>      530:	23 00 11 65 	subfic  r24,r0,4453
>      534:	6e 64 00 0d 	xoris   r4,r19,13
>      538:	6a 00 00 01 	xori    r0,r16,1
>      53c:	3a 02 23 08 	addi    r16,r2,8968
>      540:	09 00 00 00 	tdgti   r0,0
>      544:	56 0d 6b 00 	rlwinm  r13,r16,13,12,0
>      548:	00 00 3b 02 	.long 0x3b02
>      54c:	23 10 00 07 	subfic  r24,r16,7
>      550:	08 00 00 05 	tdi     0,r0,5
>      554:	18 07 08 00 	.long 0x18070800
>      558:	00 00 ee 08 	.long 0xee08
>      55c:	00 00 02 24 	.long 0x224
>      560:	20 0e 19 00 	subfic  r0,r14,6400
>      564:	00 05 d8 09 	.long 0x5d809
>      568:	00 00 04 97 	.long 0x497
>      56c:	0e 1a 00 00 	twlti   r26,0
>      570:	00 3b 02 23 	.long 0x3b0223
>      574:	00 09 00 00 	.long 0x90000
>      578:	00 7e 0e 1b 	.long 0x7e0e1b
>      57c:	00 00 00 3b 	.long 0x3b
>      580:	02 23 04 09 	.long 0x2230409
>      584:	00 00 03 ae 	.long 0x3ae
>      588:	0e 1c 00 00 	twlti   r28,0
>      58c:	00 3b 02 23 	.long 0x3b0223
>      590:	08 09 00 00 	tdi     0,r9,0
>      594:	02 77 0e 1d 	.long 0x2770e1d
>      598:	00 00 00 3b 	.long 0x3b
>      59c:	02 23 0c 09 	.long 0x2230c09
>      5a0:	00 00 04 7e 	.long 0x47e
>      5a4:	0e 1e 00 00 	twlti   r30,0
>      5a8:	00 3b 02 23 	.long 0x3b0223
>      5ac:	10 09 00 00 	vaddubm v0,v9,v0
>      5b0:	03 42 0e 1f 	.long 0x3420e1f
>      5b4:	00 00 00 3b 	.long 0x3b
>      5b8:	02 23 14 09 	.long 0x2231409
>      5bc:	00 00 00 be 	.long 0xbe
>      5c0:	0e 20 00 00 	twi     17,r0,0
>      5c4:	00 3b 02 23 	.long 0x3b0223
>      5c8:	18 09 00 00 	.long 0x18090000
>      5cc:	06 19 0e 21 	.long 0x6190e21
>      5d0:	00 00 00 3b 	.long 0x3b
>      5d4:	02 23 1c 00 	.long 0x2231c00
>      5d8:	08 00 00 04 	tdi     0,r0,4
>      5dc:	39 10 0e 28 	addi    r8,r16,3624
>      5e0:	00 00 06 01 	.long 0x601
>      5e4:	09 00 00 02 	tdgti   r0,2
>      5e8:	c5 0e 29 00 	lfsu    f8,10496(r14)
>      5ec:	00 00 3b 02 	.long 0x3b02
>      5f0:	23 00 09 00 	subfic  r24,r0,2304
>      5f4:	00 04 32 0e 	.long 0x4320e
>      5f8:	2a 00 00 05 	cmplwi  cr4,r0,5
>      5fc:	4f 02 23 08 	.long 0x4f022308
>      600:	00 04 00 00 	.long 0x40000
>      604:	01 d2 0e 2b 	.long 0x1d20e2b
>      608:	00 00 05 d8 	.long 0x5d8
>      60c:	12 01 00 00 	vaddubm v16,v1,v0
>      610:	04 a8 02 01 	.long 0x4a80201
>      614:	cb 01 00 00 	lfd     f24,0(r1)
>      618:	00 57 03 00 	.long 0x570300
>      61c:	00 06 38 13 	.long 0x63813
>      620:	00 00 00 4f 	.long 0x4f
>      624:	02 01 ca 00 	.long 0x201ca00
>      628:	00 02 a9 13 	.long 0x2a913
>      62c:	00 00 02 99 	.long 0x299
>      630:	02 01 ca 00 	.long 0x201ca00
>      634:	00 06 38 00 	.long 0x63800
>      638:	07 08 00 00 	.long 0x7080000
>      63c:	01 48 14 01 	.long 0x1481401
>      640:	00 00 02 37 	.long 0x237
>      644:	03 75 01 00 	.long 0x3750100
>      648:	00 00 e3 03 	.long 0xe303
>      64c:	00 00 06 72 	.long 0x672
>      650:	15 00 00 04 	.long 0x15000004
>      654:	b3 03 74 00 	sth     r24,29696(r3)
>      658:	00 05 55 16 	.long 0x55516
>      65c:	5f 5f 6e 00 	rlwnm   r31,r26,r13,24,0
>      660:	03 74 00 00 	.long 0x3740000
>      664:	06 72 15 00 	.long 0x6721500
>      668:	00 02 3f 03 	.long 0x23f03
>      66c:	74 00 00 06 	andis.  r0,r0,6
>      670:	78 00 07 08 	rldic   r0,r0,0,28
>      674:	00 00 01 06 	.long 0x106
>      678:	07 08 00 00 	.long 0x7080000
>      67c:	02 bb 17 01 	.long 0x2bb1701
>      680:	00 00 05 ff 	.long 0x5ff
>      684:	01 35 01 00 	.long 0x1350100
> 	...
>      694:	00 00 d4 00 	.long 0xd400
>      698:	00 00 00 00 	.long 0x0
>      69c:	00 06 cd 18 	.long 0x6cd18
>      6a0:	00 00 00 3f 	.long 0x3f
>      6a4:	01 34 00 00 	.long 0x1340000
>      6a8:	01 3a 00 00 	.long 0x13a0000
>      6ac:	00 38 18 00 	.long 0x381800
>      6b0:	00 04 f2 01 	.long 0x4f201
>      6b4:	34 00 00 01 	addic.  r0,r0,1
>      6b8:	3a 00 00 00 	li      r16,0
>      6bc:	94 19 00 00 	stwu    r0,0(r25)
>      6c0:	05 5d 01 36 	.long 0x55d0136
>      6c4:	00 00 01 06 	.long 0x106
>      6c8:	00 00 00 f0 	.long 0xf0
>      6cc:	00 1a 00 00 	.long 0x1a0000
>      6d0:	03 a4 01 45 	.long 0x3a40145
>      6d4:	01 00 00 00 	.long 0x1000000
>      6d8:	00 00 00 00 	.long 0x0
>      6dc:	e0 00 00 00 	.long 0xe0000000
>      6e0:	00 00 00 03 	.long 0x3
>      6e4:	2c 00 00 01 	cmpwi   r0,1
>      6e8:	26 00 00 08 	dozi    r16,r0,8
>      6ec:	62 18 00 00 	ori     r24,r16,0
>      6f0:	02 94 01 44 	.long 0x2940144
>      6f4:	00 00 00 ee 	.long 0xee
>      6f8:	00 00 01 5e 	.long 0x15e
>      6fc:	18 00 00 02 	.long 0x18000002
>      700:	b2 01 44 00 	sth     r16,17408(r1)
>      704:	00 08 62 00 	.long 0x86200
>      708:	00 01 cd 1b 	.long 0x1cd1b
>      70c:	6c 65 6e 00 	xoris   r5,r3,28160
>      710:	01 44 00 00 	.long 0x1440000
>      714:	00 57 00 00 	.long 0x570000
>      718:	02 3c 1c 00 	.long 0x23c1c00
>      71c:	00 00 00 00 	.long 0x0
>      720:	00 01 10 00 	.long 0x11000
>      724:	00 00 00 00 	.long 0x0
>      728:	00 01 20 00 	.long 0x12000
>      72c:	00 07 46 1d 	.long 0x7461d
>      730:	00 00 03 f8 	.long 0x3f8
>      734:	01 4a 00 00 	.long 0x14a0000
>      738:	01 06 1d 00 	.long 0x1061d00
>      73c:	00 00 ac 01 	.long 0xac01
>      740:	4a 00 00 01 	bl      fffffffffe000740 <bb+0xfffffffffdfbb310>
>      744:	06 00 1c 00 	.long 0x6001c00
>      748:	00 00 00 00 	.long 0x0
>      74c:	00 01 d0 00 	.long 0x1d000
>      750:	00 00 00 00 	.long 0x0
>      754:	00 01 e0 00 	.long 0x1e000
>      758:	00 07 72 1d 	.long 0x7721d
>      75c:	00 00 03 f8 	.long 0x3f8
>      760:	01 4c 00 00 	.long 0x14c0000
>      764:	01 06 1d 00 	.long 0x1061d00
>      768:	00 00 ac 01 	.long 0xac01
>      76c:	4c 00 00 01 	.long 0x4c000001
>      770:	06 00 1c 00 	.long 0x6001c00
>      774:	00 00 00 00 	.long 0x0
>      778:	00 02 80 00 	.long 0x28000
>      77c:	00 00 00 00 	.long 0x0
>      780:	00 02 90 00 	.long 0x29000
>      784:	00 07 9e 1d 	.long 0x79e1d
>      788:	00 00 03 f8 	.long 0x3f8
>      78c:	01 4e 00 00 	.long 0x14e0000
>      790:	01 06 1d 00 	.long 0x1061d00
>      794:	00 00 ac 01 	.long 0xac01
>      798:	4e 00 00 01 	.long 0x4e000001
>      79c:	06 00 1c 00 	.long 0x6001c00
>      7a0:	00 00 00 00 	.long 0x0
>      7a4:	00 02 b0 00 	.long 0x2b000
>      7a8:	00 00 00 00 	.long 0x0
>      7ac:	00 02 c0 00 	.long 0x2c000
>      7b0:	00 07 ca 1d 	.long 0x7ca1d
>      7b4:	00 00 03 f8 	.long 0x3f8
>      7b8:	01 4f 00 00 	.long 0x14f0000
>      7bc:	01 06 1d 00 	.long 0x1061d00
>      7c0:	00 00 ac 01 	.long 0xac01
>      7c4:	4f 00 00 01 	.long 0x4f000001
>      7c8:	06 00 1c 00 	.long 0x6001c00
>      7cc:	00 00 00 00 	.long 0x0
>      7d0:	00 02 d8 00 	.long 0x2d800
>      7d4:	00 00 00 00 	.long 0x0
>      7d8:	00 02 e8 00 	.long 0x2e800
>      7dc:	00 07 f6 1d 	.long 0x7f61d
>      7e0:	00 00 03 f8 	.long 0x3f8
>      7e4:	01 51 00 00 	.long 0x1510000
>      7e8:	01 06 1d 00 	.long 0x1061d00
>      7ec:	00 00 ac 01 	.long 0xac01
>      7f0:	51 00 00 01 	rlwimi. r0,r8,0,0,0
>      7f4:	06 00 1c 00 	.long 0x6001c00
>      7f8:	00 00 00 00 	.long 0x0
>      7fc:	00 02 fc 00 	.long 0x2fc00
>      800:	00 00 00 00 	.long 0x0
>      804:	00 03 0c 00 	.long 0x30c00
>      808:	00 08 22 1d 	.long 0x8221d
>      80c:	00 00 03 f8 	.long 0x3f8
>      810:	01 56 00 00 	.long 0x1560000
>      814:	01 06 1d 00 	.long 0x1061d00
>      818:	00 00 ac 01 	.long 0xac01
>      81c:	56 00 00 01 	rlwinm. r0,r16,0,0,0
>      820:	06 00 1e 00 	.long 0x6001e00
>      824:	00 04 42 01 	.long 0x44201
>      828:	46 00 00 01 	.long 0x46000001
>      82c:	3a 09 03 00 	addi    r16,r9,768
>      830:	00 00 00 00 	.long 0x0
>      834:	00 10 00 1e 	.long 0x10001e
>      838:	00 00 02 c5 	.long 0x2c5
>      83c:	01 46 00 00 	.long 0x1460000
>      840:	01 3a 09 03 	.long 0x13a0903
>      844:	00 00 00 00 	.long 0x0
>      848:	00 00 10 08 	.long 0x1008
>      84c:	1f 65 6e 64 	mulli   r27,r5,28260
>      850:	00 01 46 00 	.long 0x14600
>      854:	00 01 3a 09 	.long 0x13a09
>      858:	03 00 00 00 	.long 0x3000000
>      85c:	00 00 00 10 	.long 0x10
>      860:	10 00 07 08 	vsum4sbs v0,v0,v0
>      864:	00 00 00 3b 	.long 0x3b
>      868:	20 00 00 03 	subfic  r0,r0,3
>      86c:	9c 01 6a 01 	stbu    r0,27137(r1)
>      870:	00 00 00 3b 	.long 0x3b
>      874:	00 00 00 00 	.long 0x0
>      878:	00 00 03 30 	.long 0x330
>      87c:	00 00 00 00 	.long 0x0
>      880:	00 00 04 7c 	.long 0x47c
>      884:	00 00 02 ab 	.long 0x2ab
>      888:	00 00 08 c7 	.long 0x8c7
>      88c:	18 00 00 02 	.long 0x18000002
>      890:	94 01 69 00 	stwu    r0,26880(r1)
>      894:	00 02 a9 00 	.long 0x2a900
>      898:	00 02 e3 19 	.long 0x2e319
>      89c:	00 00 05 5d 	.long 0x55d
>      8a0:	01 6b 00 00 	.long 0x16b0000
>      8a4:	00 3b 00 00 	.long 0x3b0000
>      8a8:	03 3f 21 00 	.long 0x33f2100
>      8ac:	00 00 00 1d 	.long 0x1d
>      8b0:	00 00 03 f8 	.long 0x3f8
>      8b4:	01 6e 00 00 	.long 0x16e0000
>      8b8:	01 06 1d 00 	.long 0x1061d00
>      8bc:	00 00 ac 01 	.long 0xac01
>      8c0:	6e 00 00 01 	xoris   r0,r16,1
>      8c4:	06 00 00 1a 	.long 0x600001a
>      8c8:	00 00 03 63 	.long 0x363
>      8cc:	01 c0 01 00 	.long 0x1c00100
>      8d0:	00 00 00 00 	.long 0x0
>      8d4:	00 04 80 00 	.long 0x48000
>      8d8:	00 00 00 00 	.long 0x0
>      8dc:	00 08 30 00 	.long 0x83000
>      8e0:	00 03 fa 00 	.long 0x3fa00
>      8e4:	00 09 92 1b 	.long 0x9921b
>      8e8:	66 64 00 01 	oris    r4,r19,1
>      8ec:	bf 00 00 00 	stmw    r24,0(0)
>      8f0:	57 00 00 04 	rlwinm  r0,r24,0,0,2
>      8f4:	33 1b 6c 65 	addic   r24,r27,27749
>      8f8:	6e 00 01 bf 	xoris   r0,r16,447
>      8fc:	00 00 00 57 	.long 0x57
>      900:	00 00 04 a2 	.long 0x4a2
>      904:	1e 00 00 05 	mulli   r16,r0,5
>      908:	d9 01 c1 00 	stfd    f8,-16128(r1)
>      90c:	00 09 92 04 	.long 0x99204
>      910:	91 d0 f7 7e 	stw     r14,-2178(r16)
>      914:	1d 00 00 06 	mulli   r8,r0,6
>      918:	5f 01 c1 00 	rlwnm   r1,r24,r24,4,0
>      91c:	00 00 ee 1f 	.long 0xee1f
>      920:	62 75 66 00 	ori     r21,r19,26112
>      924:	01 c2 00 00 	.long 0x1c20000
>      928:	09 a3 04 91 	tdi     13,r3,1169
>      92c:	c0 f7 7e 1e 	lfs     f7,32286(r23)
>      930:	00 00 04 32 	.long 0x432
>      934:	01 c3 00 00 	.long 0x1c30000
>      938:	09 b3 04 91 	tdi     13,r19,1169
>      93c:	d0 ff 7e 1d 	stfs    f7,32285(r31)
>      940:	00 00 04 42 	.long 0x442
>      944:	01 c4 00 00 	.long 0x1c40000
>      948:	05 02 22 65 	.long 0x5022265
>      94c:	6e 64 00 01 	xoris   r4,r19,1
>      950:	c4 00 00 05 	lfsu    f0,5(0)
>      954:	02 00 00 04 	.long 0x2000004
>      958:	fe 19 00 00 	fcmpu   cr4,f25,f0
>      95c:	03 02 01 c4 	.long 0x30201c4
>      960:	00 00 05 02 	.long 0x502
>      964:	00 00 05 6d 	.long 0x56d
>      968:	19 00 00 03 	.long 0x19000003
>      96c:	83 01 c4 00 	lwz     r24,-15360(r1)
>      970:	00 05 02 00 	.long 0x50200
>      974:	00 05 c9 1d 	.long 0x5c91d
>      978:	00 00 04 0b 	.long 0x40b
>      97c:	01 c5 00 00 	.long 0x1c50000
>      980:	00 57 19 00 	.long 0x571900
>      984:	00 01 7a 01 	.long 0x17a01
>      988:	c5 00 00 00 	lfsu    f8,0(0)
>      98c:	57 00 00 05 	rlwinm. r0,r24,0,0,2
>      990:	ff 00 0b 00 	.long 0xff000b00
>      994:	00 00 f4 00 	.long 0xf400
>      998:	00 09 a3 23 	.long 0x9a323
>      99c:	00 00 00 bd 	.long 0xbd
>      9a0:	03 ff 00 0b 	.long 0x3ff000b
>      9a4:	00 00 05 02 	.long 0x502
>      9a8:	00 00 09 b3 	.long 0x9b3
>      9ac:	0c 00 00 00 	twi     0,r0,0
>      9b0:	bd 01 00 0b 	stmw    r8,11(r1)
>      9b4:	00 00 05 02 	.long 0x502
>      9b8:	00 00 09 c4 	.long 0x9c4
>      9bc:	23 00 00 00 	subfic  r24,r0,0
>      9c0:	bd 07 ff 00 	stmw    r8,-256(r7)
>      9c4:	1a 00 00 00 	.long 0x1a000000
>      9c8:	5b 01 7c 01 	rlmi.   r1,r24,r15,16,0
>      9cc:	00 00 00 00 	.long 0x0
>      9d0:	00 00 08 30 	.long 0x830
>      9d4:	00 00 00 00 	.long 0x0
>      9d8:	00 00 0c 68 	.long 0xc68
>      9dc:	00 00 06 81 	.long 0x681
>      9e0:	00 00 0a d3 	.long 0xad3
>      9e4:	1b 66 64 00 	.long 0x1b666400
>      9e8:	01 7b 00 00 	.long 0x17b0000
>      9ec:	00 57 00 00 	.long 0x570000
>      9f0:	06 ba 1e 00 	.long 0x6ba1e00
>      9f4:	00 05 d9 01 	.long 0x5d901
>      9f8:	7d 00 00 09 	.long 0x7d000009
>      9fc:	92 04 91 a0 	stw     r16,-28256(r4)
>      a00:	f7 7e 1d 00 	.long 0xf77e1d00
>      a04:	00 06 5f 01 	.long 0x65f01
>      a08:	7d 00 00 00 	cmpw    cr2,r0,r0
>      a0c:	ee 1f 62 75 	.long 0xee1f6275
>      a10:	66 00 01 7e 	oris    r0,r16,382
>      a14:	00 00 0a d3 	.long 0xad3
>      a18:	04 91 a0 f5 	.long 0x491a0f5
>      a1c:	7e 1e 00 00 	cmpw    cr4,r30,r0
>      a20:	04 32 01 7f 	.long 0x432017f
>      a24:	00 00 09 b3 	.long 0x9b3
>      a28:	04 91 a0 ff 	.long 0x491a0ff
>      a2c:	7e 19 00 00 	cmpw    cr4,r25,r0
>      a30:	04 42 01 80 	.long 0x4420180
>      a34:	00 00 05 02 	.long 0x502
>      a38:	00 00 07 16 	.long 0x716
>      a3c:	22 65 6e 64 	subfic  r19,r5,28260
>      a40:	00 01 80 00 	.long 0x18000
>      a44:	00 05 02 00 	.long 0x50200
>      a48:	00 07 39 19 	.long 0x73919
>      a4c:	00 00 03 02 	.long 0x302
>      a50:	01 80 00 00 	.long 0x1800000
>      a54:	05 02 00 00 	.long 0x5020000
>      a58:	07 82 19 00 	.long 0x7821900
>      a5c:	00 03 83 01 	.long 0x38301
>      a60:	80 00 00 05 	lwz     r0,5(0)
>      a64:	02 00 00 07 	.long 0x2000007
>      a68:	b8 1d 00 00 	lmw     r0,0(r29)
>      a6c:	04 0b 01 81 	.long 0x40b0181
>      a70:	00 00 00 57 	.long 0x57
>      a74:	19 00 00 01 	.long 0x19000001
>      a78:	7a 01 81 00 	rldicl  r1,r16,16,4
>      a7c:	00 00 57 00 	.long 0x5700
>      a80:	00 07 ee 22 	.long 0x7ee22
>      a84:	69 00 01 81 	xori    r0,r8,385
>      a88:	00 00 00 57 	.long 0x57
>      a8c:	00 00 08 96 	.long 0x896
>      a90:	19 00 00 00 	.long 0x19000000
>      a94:	b5 01 82 00 	sthu    r8,-32256(r1)
>      a98:	00 00 57 00 	.long 0x5700
>      a9c:	00 08 b9 1d 	.long 0x8b91d
>      aa0:	00 00 02 2e 	.long 0x22e
>      aa4:	01 82 00 00 	.long 0x1820000
>      aa8:	00 57 24 00 	.long 0x572400
>      aac:	00 00 00 00 	.long 0x0
>      ab0:	00 08 b8 00 	.long 0x8b800
>      ab4:	00 00 00 00 	.long 0x0
>      ab8:	00 08 c4 1d 	.long 0x8c41d
>      abc:	00 00 03 f8 	.long 0x3f8
>      ac0:	01 88 00 00 	.long 0x1880000
>      ac4:	01 06 1d 00 	.long 0x1061d00
>      ac8:	00 00 ac 01 	.long 0xac01
>      acc:	88 00 00 01 	lbz     r0,1(0)
>      ad0:	06 00 00 0b 	.long 0x600000b
>      ad4:	00 00 05 02 	.long 0x502
>      ad8:	00 00 0a e3 	.long 0xae3
>      adc:	0c 00 00 00 	twi     0,r0,0
>      ae0:	bd 1f 00 25 	stmw    r8,37(r31)
>      ae4:	00 00 06 10 	.long 0x610
>      ae8:	01 01 07 01 	.long 0x1010701
>      aec:	00 00 00 00 	.long 0x0
>      af0:	00 00 0c 70 	.long 0xc70
>      af4:	00 00 00 00 	.long 0x0
>      af8:	00 00 10 f0 	.long 0x10f0
>      afc:	00 00 08 ef 	.long 0x8ef
>      b00:	00 00 0e 17 	.long 0xe17
>      b04:	26 66 6e 00 	dozi    r19,r6,28160
>      b08:	01 01 06 00 	.long 0x1010600
>      b0c:	00 00 ee 00 	.long 0xee00
>      b10:	00 09 27 27 	.long 0x92727
>      b14:	00 00 04 bd 	.long 0x4bd
>      b18:	01 01 06 00 	.long 0x1010600
>      b1c:	00 0e 17 00 	.long 0xe1700
>      b20:	00 09 70 27 	.long 0x97027
>      b24:	00 00 06 a0 	.long 0x6a0
>      b28:	01 01 06 00 	.long 0x1010600
>      b2c:	00 00 57 00 	.long 0x5700
>      b30:	00 09 cc 28 	.long 0x9cc28
>      b34:	64 70 00 01 	oris    r16,r3,1
>      b38:	01 08 00 00 	.long 0x1080000
>      b3c:	0e 1d 00 00 	twlti   r29,0
>      b40:	0a 15 28 69 	tdlti   r21,10345
>      b44:	00 01 01 09 	.long 0x10109
>      b48:	00 00 00 57 	.long 0x57
>      b4c:	00 00 0a 5e 	.long 0xa5e
>      b50:	28 66 64 00 	cmpldi  r6,25600
>      b54:	01 01 09 00 	.long 0x1010900
>      b58:	00 00 57 00 	.long 0x5700
>      b5c:	00 0a a7 28 	.long 0xaa728
>      b60:	6c 65 6e 00 	xoris   r5,r3,28160
>      b64:	01 01 09 00 	.long 0x1010900
>      b68:	00 00 57 00 	.long 0x5700
>      b6c:	00 0b 03 29 	.long 0xb0329
>      b70:	00 00 01 a1 	.long 0x1a1
>      b74:	01 01 0a 00 	.long 0x1010a00
>      b78:	00 01 48 03 	.long 0x14803
>      b7c:	91 f0 7d 2a 	stw     r15,32042(r16)
>      b80:	00 00 06 0c 	.long 0x60c
>      b84:	00 00 00 30 	.long 0x30
>      b88:	01 01 13 00 	.long 0x1011300
>      b8c:	00 0b 9a 2b 	.long 0xb9a2b
>      b90:	00 00 06 2b 	.long 0x62b
>      b94:	2b 00 00 06 	cmplwi  cr6,r0,6
>      b98:	1f 00 2c 00 	mulli   r24,r0,11264
>      b9c:	00 00 60 00 	.long 0x6000
>      ba0:	00 0b bc 2d 	.long 0xbbc2d
>      ba4:	00 00 03 f8 	.long 0x3f8
>      ba8:	01 01 21 00 	.long 0x1012100
>      bac:	00 01 06 2d 	.long 0x1062d
>      bb0:	00 00 00 ac 	.long 0xac
>      bb4:	01 01 21 00 	.long 0x1012100
>      bb8:	00 01 06 00 	.long 0x10600
>      bbc:	1c 00 00 00 	mulli   r0,r0,0
>      bc0:	00 00 00 0d 	.long 0xd
>      bc4:	6c 00 00 00 	xoris   r0,r0,0
>      bc8:	00 00 00 0d 	.long 0xd
>      bcc:	7c 00 00 0b 	.long 0x7c00000b
>      bd0:	fc 24 00 00 	.long 0xfc240000
>      bd4:	00 00 00 00 	.long 0x0
>      bd8:	0d 6c 00 00 	twi     11,r12,0
>      bdc:	00 00 00 00 	.long 0x0
>      be0:	0d 7c 2d 00 	twi     11,r28,11520
>      be4:	00 02 fd 01 	.long 0x2fd01
>      be8:	01 10 00 00 	.long 0x1100000
>      bec:	05 0d 2d 00 	.long 0x50d2d00
>      bf0:	00 02 a9 01 	.long 0x2a901
>      bf4:	01 10 00 00 	.long 0x1100000
>      bf8:	00 57 00 00 	.long 0x570000
>      bfc:	1c 00 00 00 	mulli   r0,r0,0
>      c00:	00 00 00 0d 	.long 0xd
>      c04:	84 00 00 00 	lwzu    r0,0(0)
>      c08:	00 00 00 0d 	.long 0xd
>      c0c:	8c 00 00 0c 	lbzu    r0,12(0)
>      c10:	3c 24 00 00 	addis   r1,r4,0
>      c14:	00 00 00 00 	.long 0x0
>      c18:	0d 84 00 00 	twgei   r4,0
>      c1c:	00 00 00 00 	.long 0x0
>      c20:	0d 8c 2d 00 	twgei   r12,11520
>      c24:	00 02 fd 01 	.long 0x2fd01
>      c28:	01 10 00 00 	.long 0x1100000
>      c2c:	05 0d 2d 00 	.long 0x50d2d00
>      c30:	00 02 a9 01 	.long 0x2a901
>      c34:	01 10 00 00 	.long 0x1100000
>      c38:	00 57 00 00 	.long 0x570000
>      c3c:	1c 00 00 00 	mulli   r0,r0,0
>      c40:	00 00 00 0e 	.long 0xe
>      c44:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      c48:	00 00 00 0e 	.long 0xe
>      c4c:	64 00 00 0c 	oris    r0,r0,12
>      c50:	6a 2d 00 00 	xori    r13,r17,0
>      c54:	03 f8 01 01 	.long 0x3f80101
>      c58:	17 00 00 01 	.long 0x17000001
>      c5c:	06 2d 00 00 	.long 0x62d0000
>      c60:	00 ac 01 01 	.long 0xac0101
>      c64:	17 00 00 01 	.long 0x17000001
>      c68:	06 00 1c 00 	.long 0x6001c00
>      c6c:	00 00 00 00 	.long 0x0
>      c70:	00 0e 6c 00 	.long 0xe6c00
>      c74:	00 00 00 00 	.long 0x0
>      c78:	00 0e 7c 00 	.long 0xe7c00
>      c7c:	00 0c 98 2d 	.long 0xc982d
>      c80:	00 00 03 f8 	.long 0x3f8
>      c84:	01 01 1a 00 	.long 0x1011a00
>      c88:	00 01 06 2d 	.long 0x1062d
>      c8c:	00 00 00 ac 	.long 0xac
>      c90:	01 01 1a 00 	.long 0x1011a00
>      c94:	00 01 06 00 	.long 0x10600
>      c98:	1c 00 00 00 	mulli   r0,r0,0
>      c9c:	00 00 00 0e 	.long 0xe
>      ca0:	9c 00 00 00 	stbu    r0,0(0)
>      ca4:	00 00 00 0e 	.long 0xe
>      ca8:	ac 00 00 0c 	lhau    r0,12(0)
>      cac:	c6 2d 00 00 	lfsu    f17,0(r13)
>      cb0:	03 f8 01 01 	.long 0x3f80101
>      cb4:	22 00 00 01 	subfic  r16,r0,1
>      cb8:	06 2d 00 00 	.long 0x62d0000
>      cbc:	00 ac 01 01 	.long 0xac0101
>      cc0:	22 00 00 01 	subfic  r16,r0,1
>      cc4:	06 00 1c 00 	.long 0x6001c00
>      cc8:	00 00 00 00 	.long 0x0
>      ccc:	00 0e b4 00 	.long 0xeb400
>      cd0:	00 00 00 00 	.long 0x0
>      cd4:	00 0e c4 00 	.long 0xec400
>      cd8:	00 0c f4 2d 	.long 0xcf42d
>      cdc:	00 00 03 f8 	.long 0x3f8
>      ce0:	01 01 23 00 	.long 0x1012300
>      ce4:	00 01 06 2d 	.long 0x1062d
>      ce8:	00 00 00 ac 	.long 0xac
>      cec:	01 01 23 00 	.long 0x1012300
>      cf0:	00 01 06 00 	.long 0x10600
>      cf4:	1c 00 00 00 	mulli   r0,r0,0
>      cf8:	00 00 00 0e 	.long 0xe
>      cfc:	cc 00 00 00 	lfdu    f0,0(0)
>      d00:	00 00 00 0e 	.long 0xe
>      d04:	dc 00 00 0d 	stfdu   f0,13(0)
>      d08:	22 2d 00 00 	subfic  r17,r13,0
>      d0c:	03 f8 01 01 	.long 0x3f80101
>      d10:	24 00 00 01 	dozi    r0,r0,1
>      d14:	06 2d 00 00 	.long 0x62d0000
>      d18:	00 ac 01 01 	.long 0xac0101
>      d1c:	24 00 00 01 	dozi    r0,r0,1
>      d20:	06 00 1c 00 	.long 0x6001c00
>      d24:	00 00 00 00 	.long 0x0
>      d28:	00 0e e4 00 	.long 0xee400
>      d2c:	00 00 00 00 	.long 0x0
>      d30:	00 0e f4 00 	.long 0xef400
>      d34:	00 0d 50 2d 	.long 0xd502d
>      d38:	00 00 03 f8 	.long 0x3f8
>      d3c:	01 01 2a 00 	.long 0x1012a00
>      d40:	00 01 06 2d 	.long 0x1062d
>      d44:	00 00 00 ac 	.long 0xac
>      d48:	01 01 2a 00 	.long 0x1012a00
>      d4c:	00 01 06 00 	.long 0x10600
>      d50:	1c 00 00 00 	mulli   r0,r0,0
>      d54:	00 00 00 0f 	.long 0xf
>      d58:	0c 00 00 00 	twi     0,r0,0
>      d5c:	00 00 00 0f 	.long 0xf
>      d60:	1c 00 00 0d 	mulli   r0,r0,13
>      d64:	7e 2d 00 00 	cmpd    cr4,r13,r0
>      d68:	03 f8 01 01 	.long 0x3f80101
>      d6c:	32 00 00 01 	addic   r16,r0,1
>      d70:	06 2d 00 00 	.long 0x62d0000
>      d74:	00 ac 01 01 	.long 0xac0101
>      d78:	32 00 00 01 	addic   r16,r0,1
>      d7c:	06 00 1c 00 	.long 0x6001c00
>      d80:	00 00 00 00 	.long 0x0
>      d84:	00 10 34 00 	.long 0x103400
>      d88:	00 00 00 00 	.long 0x0
>      d8c:	00 10 58 00 	.long 0x105800
>      d90:	00 0d be 24 	.long 0xdbe24
>      d94:	00 00 00 00 	.long 0x0
>      d98:	00 00 10 34 	.long 0x1034
>      d9c:	00 00 00 00 	.long 0x0
>      da0:	00 00 10 58 	.long 0x1058
>      da4:	2d 00 00 02 	cmpwi   cr2,r0,2
>      da8:	fd 01 01 4d 	.long 0xfd01014d
>      dac:	00 00 05 0d 	.long 0x50d
>      db0:	2d 00 00 02 	cmpwi   cr2,r0,2
>      db4:	a9 01 01 4d 	lha     r8,333(r1)
>      db8:	00 00 00 57 	.long 0x57
>      dbc:	00 00 1c 00 	.long 0x1c00
>      dc0:	00 00 00 00 	.long 0x0
>      dc4:	00 10 80 00 	.long 0x108000
>      dc8:	00 00 00 00 	.long 0x0
>      dcc:	00 10 90 00 	.long 0x109000
>      dd0:	00 0d ec 2d 	.long 0xdec2d
>      dd4:	00 00 03 f8 	.long 0x3f8
>      dd8:	01 01 4f 00 	.long 0x1014f00
>      ddc:	00 01 06 2d 	.long 0x1062d
>      de0:	00 00 00 ac 	.long 0xac
>      de4:	01 01 4f 00 	.long 0x1014f00
>      de8:	00 01 06 00 	.long 0x10600
>      dec:	24 00 00 00 	dozi    r0,r0,0
>      df0:	00 00 00 10 	.long 0x10
>      df4:	c8 00 00 00 	lfd     f0,0(0)
>      df8:	00 00 00 10 	.long 0x10
>      dfc:	d8 2d 00 00 	stfd    f1,0(r13)
>      e00:	03 f8 01 01 	.long 0x3f80101
>      e04:	2b 00 00 01 	cmplwi  cr6,r0,1
>      e08:	06 2d 00 00 	.long 0x62d0000
>      e0c:	00 ac 01 01 	.long 0xac0101
>      e10:	2b 00 00 01 	cmplwi  cr6,r0,1
>      e14:	06 00 00 07 	.long 0x6000007
>      e18:	08 00 00 0e 	tdi     0,r0,14
>      e1c:	1d 07 08 00 	mulli   r8,r7,2048
>      e20:	00 02 45 25 	.long 0x24525
>      e24:	00 00 00 da 	.long 0xda
>      e28:	01 01 75 01 	.long 0x1017501
>      e2c:	00 00 00 00 	.long 0x0
>      e30:	00 00 10 f0 	.long 0x10f0
>      e34:	00 00 00 00 	.long 0x0
>      e38:	00 00 17 3c 	.long 0x173c
>      e3c:	00 00 0b 4c 	.long 0xb4c
>      e40:	00 00 10 4d 	.long 0x104d
>      e44:	28 64 6e 00 	cmpldi  r4,28160
>      e48:	01 01 76 00 	.long 0x1017600
>      e4c:	00 00 ee 00 	.long 0xee00
>      e50:	00 0b 84 2e 	.long 0xb842e
>      e54:	64 70 00 01 	oris    r16,r3,1
>      e58:	01 77 00 00 	.long 0x1770000
>      e5c:	0e 1d 2f 00 	twlti   r29,12032
>      e60:	00 04 fe 01 	.long 0x4fe01
>      e64:	01 78 00 00 	.long 0x1780000
>      e68:	00 ee 00 00 	.long 0xee0000
>      e6c:	0b cd 2f 00 	tdi     30,r13,12032
>      e70:	00 06 a8 01 	.long 0x6a801
>      e74:	01 79 00 00 	.long 0x1790000
>      e78:	0e 17 00 00 	twlti   r23,0
>      e7c:	0c 16 2f 00 	twi     0,r22,12032
>      e80:	00 06 a0 01 	.long 0x6a001
>      e84:	01 7a 00 00 	.long 0x17a0000
>      e88:	00 57 00 00 	.long 0x570000
>      e8c:	0c 50 28 69 	twllti  r16,10345
>      e90:	00 01 01 7a 	.long 0x1017a
>      e94:	00 00 00 57 	.long 0x57
>      e98:	00 00 0c 86 	.long 0xc86
>      e9c:	29 00 00 01 	cmplwi  cr2,r0,1
>      ea0:	a1 01 01 7b 	lhz     r8,379(r1)
>      ea4:	00 00 01 48 	.long 0x148
>      ea8:	03 91 98 76 	.long 0x3919876
>      eac:	1c 00 00 00 	mulli   r0,r0,0
>      eb0:	00 00 00 12 	.long 0x12
>      eb4:	24 00 00 00 	dozi    r0,r0,0
>      eb8:	00 00 00 12 	.long 0x12
>      ebc:	34 00 00 0e 	addic.  r0,r0,14
>      ec0:	da 2d 00 00 	stfd    f17,0(r13)
>      ec4:	03 f8 01 01 	.long 0x3f80101
>      ec8:	b2 00 00 01 	sth     r16,1(0)
>      ecc:	06 2d 00 00 	.long 0x62d0000
>      ed0:	00 ac 01 01 	.long 0xac0101
>      ed4:	b2 00 00 01 	sth     r16,1(0)
>      ed8:	06 00 2a 00 	.long 0x6002a00
>      edc:	00 06 0c 00 	.long 0x60c00
>      ee0:	00 00 90 01 	.long 0x9001
>      ee4:	01 f0 00 00 	.long 0x1f00000
>      ee8:	0e f5 2b 00 	twi     23,r21,11008
>      eec:	00 06 2b 2b 	.long 0x62b2b
>      ef0:	00 00 06 1f 	.long 0x61f
>      ef4:	00 2c 00 00 	.long 0x2c0000
>      ef8:	00 d0 00 00 	.long 0xd00000
>      efc:	0f 1d 21 00 	twnei   r29,8448
>      f00:	00 01 00 2d 	.long 0x1002d
>      f04:	00 00 02 fd 	.long 0x2fd
>      f08:	01 01 ed 00 	.long 0x101ed00
>      f0c:	00 05 0d 2d 	.long 0x50d2d
>      f10:	00 00 02 a9 	.long 0x2a9
>      f14:	01 01 ed 00 	.long 0x101ed00
>      f18:	00 00 57 00 	.long 0x5700
>      f1c:	00 1c 00 00 	.long 0x1c0000
>      f20:	00 00 00 00 	.long 0x0
>      f24:	12 e0 00 00 	vaddubm v23,v0,v0
>      f28:	00 00 00 00 	.long 0x0
>      f2c:	12 e8 00 00 	vaddubm v23,v8,v0
>      f30:	0f 5d 24 00 	twi     26,r29,9216
>      f34:	00 00 00 00 	.long 0x0
>      f38:	00 12 e0 00 	.long 0x12e000
>      f3c:	00 00 00 00 	.long 0x0
>      f40:	00 12 e8 2d 	.long 0x12e82d
>      f44:	00 00 02 fd 	.long 0x2fd
>      f48:	01 01 ed 00 	.long 0x101ed00
>      f4c:	00 05 0d 2d 	.long 0x50d2d
>      f50:	00 00 02 a9 	.long 0x2a9
>      f54:	01 01 ed 00 	.long 0x101ed00
>      f58:	00 00 57 00 	.long 0x5700
>      f5c:	00 2c 00 00 	.long 0x2c0000
>      f60:	01 30 00 00 	.long 0x1300000
>      f64:	0f f0 2f 00 	twi     31,r16,12032
>      f68:	00 03 32 01 	.long 0x33201
>      f6c:	01 b3 00 00 	.long 0x1b30000
>      f70:	01 06 00 00 	.long 0x1060000
>      f74:	0c bc 2d 00 	twlgei  r28,11520
>      f78:	00 03 bc 01 	.long 0x3bc01
>      f7c:	01 b4 00 00 	.long 0x1b40000
>      f80:	00 ee 21 00 	.long 0xee2100
>      f84:	00 01 60 29 	.long 0x16029
>      f88:	00 00 03 93 	.long 0x393
>      f8c:	01 01 c1 00 	.long 0x101c100
>      f90:	00 09 92 03 	.long 0x99203
>      f94:	91 a8 77 28 	stw     r13,30504(r8)
>      f98:	66 70 00 01 	oris    r16,r19,1
>      f9c:	01 c2 00 00 	.long 0x1c20000
>      fa0:	06 78 00 00 	.long 0x6780000
>      fa4:	0d af 2f 00 	twi     13,r15,12032
>      fa8:	00 06 2c 01 	.long 0x62c01
>      fac:	01 c3 00 00 	.long 0x1c30000
>      fb0:	00 ee 00 00 	.long 0xee0000
>      fb4:	0d f8 2f 00 	twi     15,r24,12032
>      fb8:	00 04 e0 01 	.long 0x4e001
>      fbc:	01 c4 00 00 	.long 0x1c40000
>      fc0:	00 ee 00 00 	.long 0xee0000
>      fc4:	0e 9b 30 00 	twlei   r27,12288
>      fc8:	00 06 3e 00 	.long 0x63e00
>      fcc:	00 00 00 00 	.long 0x0
>      fd0:	00 14 04 00 	.long 0x140400
>      fd4:	00 00 00 00 	.long 0x0
>      fd8:	00 14 1c 01 	.long 0x141c01
>      fdc:	01 ca 2b 00 	.long 0x1ca2b00
>      fe0:	00 06 66 2b 	.long 0x6662b
>      fe4:	00 00 06 5b 	.long 0x65b
>      fe8:	2b 00 00 06 	cmplwi  cr6,r0,6
>      fec:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>      ff0:	1c 00 00 00 	mulli   r0,r0,0
>      ff4:	00 00 00 14 	.long 0x14
>      ff8:	d0 00 00 00 	stfs    f0,0(0)
>      ffc:	00 00 00 14 	.long 0x14
>     1000:	e4 00 00 10 	.long 0xe4000010
>     1004:	1e 2d 00 00 	mulli   r17,r13,0
>     1008:	03 f8 01 01 	.long 0x3f80101
>     100c:	94 00 00 01 	stwu    r0,1(0)
>     1010:	06 2d 00 00 	.long 0x62d0000
>     1014:	00 ac 01 01 	.long 0xac0101
>     1018:	94 00 00 01 	stwu    r0,1(0)
>     101c:	06 00 24 00 	.long 0x6002400
>     1020:	00 00 00 00 	.long 0x0
>     1024:	00 14 ec 00 	.long 0x14ec00
>     1028:	00 00 00 00 	.long 0x0
>     102c:	00 15 c0 2e 	.long 0x15c02e
>     1030:	6c 65 6e 00 	xoris   r5,r3,28160
>     1034:	01 01 95 00 	.long 0x1019500
>     1038:	00 00 57 2f 	.long 0x572f
>     103c:	00 00 01 11 	.long 0x111
>     1040:	01 01 96 00 	.long 0x1019600
>     1044:	00 01 3a 00 	.long 0x13a00
>     1048:	00 0e d1 00 	.long 0xed100
>     104c:	00 31 01 00 	.long 0x310100
>     1050:	00 02 63 01 	.long 0x26301
>     1054:	01 fe 01 00 	.long 0x1fe0100
>     1058:	00 00 57 00 	.long 0x5700
>     105c:	00 00 00 00 	.long 0x0
>     1060:	00 17 40 00 	.long 0x174000
>     1064:	00 00 00 00 	.long 0x0
>     1068:	00 19 7c 00 	.long 0x197c00
>     106c:	00 0f 20 00 	.long 0xf2000
>     1070:	00 10 db 27 	.long 0x10db27
>     1074:	00 00 01 33 	.long 0x133
>     1078:	01 01 fd 00 	.long 0x101fd00
>     107c:	00 05 55 00 	.long 0x55500
>     1080:	00 0f 58 27 	.long 0xf5827
>     1084:	00 00 06 59 	.long 0x659
>     1088:	01 01 fd 00 	.long 0x101fd00
>     108c:	00 10 db 00 	.long 0x10db00
>     1090:	00 0f 8e 27 	.long 0xf8e27
>     1094:	00 00 05 3d 	.long 0x53d
>     1098:	01 01 fd 00 	.long 0x101fd00
>     109c:	00 00 ee 00 	.long 0xee00
>     10a0:	00 0f c4 28 	.long 0xfc428
>     10a4:	6c 65 6e 00 	xoris   r5,r3,28160
>     10a8:	01 01 ff 00 	.long 0x101ff00
>     10ac:	00 00 42 00 	.long 0x4200
>     10b0:	00 0f fa 2f 	.long 0xffa2f
>     10b4:	00 00 06 92 	.long 0x692
>     10b8:	01 02 00 00 	.long 0x1020000
>     10bc:	00 00 42 00 	.long 0x4200
>     10c0:	00 10 30 2e 	.long 0x10302e
>     10c4:	62 75 66 00 	ori     r21,r19,26112
>     10c8:	01 02 01 00 	.long 0x1020100
>     10cc:	00 00 ee 2e 	.long 0xee2e
>     10d0:	6d 65 00 01 	xoris   r5,r11,1
>     10d4:	02 02 00 00 	.long 0x2020000
>     10d8:	00 42 00 07 	.long 0x420007
>     10dc:	08 00 00 00 	tdi     0,r0,0
>     10e0:	fb 32 00 00 	std     r25,0(r18)
>     10e4:	00 2c 01 01 	.long 0x2c0101
>     10e8:	5f 01 00 00 	rlwnm   r1,r24,r0,0,0
>     10ec:	00 57 00 00 	.long 0x570000
>     10f0:	00 00 00 00 	.long 0x0
>     10f4:	19 80 00 00 	.long 0x19800000
>     10f8:	00 00 00 00 	.long 0x0
>     10fc:	1a 40 00 00 	.long 0x1a400000
>     1100:	10 53 00 00 	vaddubm v2,v19,v0
>     1104:	11 71 27 00 	vsubsbs v11,v17,v4
>     1108:	00 05 ef 01 	.long 0x5ef01
>     110c:	01 5e 00 00 	.long 0x15e0000
>     1110:	02 b4 00 00 	.long 0x2b40000
>     1114:	10 8b 27 00 	vsubsbs v4,v11,v4
>     1118:	00 05 f7 01 	.long 0x5f701
>     111c:	01 5e 00 00 	.long 0x15e0000
>     1120:	02 b4 00 00 	.long 0x2b40000
>     1124:	10 ae 2f 00 	vsubsbs v5,v14,v5
>     1128:	00 01 c6 01 	.long 0x1c601
>     112c:	01 60 00 00 	.long 0x1600000
>     1130:	00 ee 00 00 	.long 0xee0000
>     1134:	10 d1 2f 00 	vsubsbs v6,v17,v5
>     1138:	00 01 dd 01 	.long 0x1dd01
>     113c:	01 61 00 00 	.long 0x1610000
>     1140:	00 ee 00 00 	.long 0xee0000
>     1144:	10 f4 24 00 	vsububm v7,v20,v4
>     1148:	00 00 00 00 	.long 0x0
>     114c:	00 1a 00 00 	.long 0x1a0000
>     1150:	00 00 00 00 	.long 0x0
>     1154:	00 1a 14 2d 	.long 0x1a142d
>     1158:	00 00 03 f8 	.long 0x3f8
>     115c:	01 01 6d 00 	.long 0x1016d00
>     1160:	00 01 06 2d 	.long 0x1062d
>     1164:	00 00 00 ac 	.long 0xac
>     1168:	01 01 6d 00 	.long 0x1016d00
>     116c:	00 01 06 00 	.long 0x10600
>     1170:	00 1e 00 00 	.long 0x1e0000
>     1174:	02 ca 01 2a 	.long 0x2ca012a
>     1178:	00 00 09 92 	.long 0x992
>     117c:	09 03 00 00 	tdgti   r3,0
>     1180:	00 00 00 00 	.long 0x0
>     1184:	50 18 1e 00 	rlwimi  r24,r0,3,24,0
>     1188:	00 04 01 01 	.long 0x40101
>     118c:	2a 00 00 00 	cmplwi  cr4,r0,0
>     1190:	ee 09 03 00 	.long 0xee090300
>     1194:	00 00 00 00 	.long 0x0
>     1198:	00 54 28 0b 	.long 0x54280b
>     119c:	00 00 00 f4 	.long 0xf4
>     11a0:	00 00 11 ac 	.long 0x11ac
>     11a4:	23 00 00 00 	subfic  r24,r0,0
>     11a8:	bd 3f ff 00 	stmw    r9,-256(r31)
>     11ac:	1e 00 00 00 	mulli   r16,r0,0
>     11b0:	d0 01 2b 00 	stfs    f0,11008(r1)
>     11b4:	00 11 9b 09 	.long 0x119b09
>     11b8:	03 00 00 00 	.long 0x3000000
>     11bc:	00 00 00 10 	.long 0x10
>     11c0:	18 0b 00 00 	.long 0x180b0000
>     11c4:	00 3b 00 00 	.long 0x3b0000
>     11c8:	11 d2 23 00 	vaddsbs v14,v18,v4
>     11cc:	00 00 bd ff 	.long 0xbdff
>     11d0:	ff 00 1e 00 	.long 0xff001e00
>     11d4:	00 04 47 01 	.long 0x44701
>     11d8:	2c 00 00 11 	cmpwi   r0,17
>     11dc:	c1 09 03 00 	lfs     f8,768(r9)
>     11e0:	00 00 00 00 	.long 0x0
>     11e4:	00 54 30 1f 	.long 0x54301f
>     11e8:	64 74 00 01 	oris    r20,r3,1
>     11ec:	2c 00 00 08 	cmpwi   r0,8
>     11f0:	62 09 03 00 	ori     r9,r16,768
>     11f4:	00 00 00 00 	.long 0x0
>     11f8:	00 54 18 0b 	.long 0x54180b
>     11fc:	00 00 01 3a 	.long 0x13a
>     1200:	00 00 12 0c 	.long 0x120c
>     1204:	23 00 00 00 	subfic  r24,r0,0
>     1208:	bd 01 ff 00 	stmw    r8,-256(r1)
>     120c:	1e 00 00 06 	mulli   r16,r0,6
>     1210:	97 01 2d 00 	stwu    r24,11520(r1)
>     1214:	00 11 fb 09 	.long 0x11fb09
>     1218:	03 00 00 00 	.long 0x3000000
>     121c:	00 00 00 00 	.long 0x0
>     1220:	00 1e 00 00 	.long 0x1e0000
>     1224:	02 f1 01 2f 	.long 0x2f1012f
>     1228:	00 00 00 57 	.long 0x57
>     122c:	09 03 00 00 	tdgti   r3,0
>     1230:	00 00 00 00 	.long 0x0
>     1234:	54 20 0b 00 	rlwinm  r0,r1,1,12,0
>     1238:	00 00 f4 00 	.long 0xf400
>     123c:	00 12 47 23 	.long 0x124723
>     1240:	00 00 00 bd 	.long 0xbd
>     1244:	01 ff 00 1e 	.long 0x1ff001e
>     1248:	00 00 02 b7 	.long 0x2b7
>     124c:	01 30 00 00 	.long 0x1300000
>     1250:	12 36 09 03 	.long 0x12360903
> 	...
>     125c:	0b 00 00 05 	tdnei   r0,5
>     1260:	5b 00 00 12 	rlmi    r0,r24,r0,0,9
>     1264:	6c 0c 00 00 	xoris   r12,r0,0
>     1268:	00 bd 00 00 	.long 0xbd0000
>     126c:	1f 62 62 00 	mulli   r27,r2,25088
>     1270:	01 32 00 00 	.long 0x1320000
>     1274:	12 5c 09 03 	.long 0x125c0903
>     1278:	00 00 00 00 	.long 0x0
>     127c:	00 04 54 30 	.long 0x45430
>     1280:	33 00 00 02 	addic   r24,r0,2
>     1284:	11 0a 91 00 	.long 0x110a9100
>     1288:	00 04 d6 01 	.long 0x4d601
>     128c:	01 33 00 00 	.long 0x1330000
>     1290:	03 23 0a 92 	.long 0x3230a92
>     1294:	00 00 04 d6 	.long 0x4d6
>     1298:	01 01 33 00 	.long 0x1013300
>     129c:	00 05 e8 0a 	.long 0x5e80a
>     12a0:	93 00 00 04 	stw     r24,4(0)
>     12a4:	d6 01 01 33 	stfsu   f16,307(r1)
>     12a8:	00 00 03 17 	.long 0x317
>     12ac:	0e 14 00 00 	twlti   r20,0
>     12b0:	05 02 01 01 	.long 0x5020101
>     12b4:	33 00 00 03 	addic   r24,r0,3
>     12b8:	4a 0e 14 00 	b       fffffffffe0e26b8 <bb+0xfffffffffe09d288>
>     12bc:	00 05 02 01 	.long 0x50201
>     12c0:	01 33 00 00 	.long 0x1330000
>     12c4:	01 a9 0e 16 	.long 0x1a90e16
>     12c8:	00 00 00 2d 	.long 0x2d
>     12cc:	01 01 33 00 	.long 0x1013300
>     12d0:	00 05 92 01 	.long 0x59201
>     12d4:	31 00 00 06 	addic   r8,r0,6
>     12d8:	01 01 01 34 	.long 0x1010134
>     12dc:	00 00 06 07 	.long 0x607
>     12e0:	0f 21 00 00 	twi     25,r1,0
>     12e4:	05 02 01 09 	.long 0x5020109
>     12e8:	03 00 00 00 	.long 0x3000000
>     12ec:	00 00 00 00 	.long 0x0
>     12f0:	00 34 00 00 	.long 0x340000
>     12f4:	04 c3 0f 22 	.long 0x4c30f22
>     12f8:	00 00 00 3b 	.long 0x3b
>     12fc:	01 09 03 00 	.long 0x1090300
> 	...
> 
> Disassembly of section .debug_line:
> 
> 0000000000000000 <.debug_line>:
>    0:	00 00 04 95 	.long 0x495
>    4:	00 02 00 00 	.long 0x20000
>    8:	01 50 04 01 	.long 0x1500401
>    c:	fb 0e 0d 00 	std     r24,3328(r14)
>   10:	01 01 01 01 	.long 0x1010101
>   14:	00 00 00 01 	.long 0x1
>   18:	00 00 01 6b 	.long 0x16b
>   1c:	65 78 65 63 	oris    r24,r11,25955
>   20:	2f 61 72 63 	cmpdi   cr6,r1,29283
>   24:	68 2f 70 70 	xori    r15,r1,28784
>   28:	63 36 34 00 	ori     r22,r25,13312
>   2c:	2f 75 73 72 	cmpdi   cr6,r21,29554
>   30:	2f 69 6e 63 	cmpdi   cr6,r9,28259
>   34:	6c 75 64 65 	xoris   r21,r3,25701
>   38:	2f 73 79 73 	cmpdi   cr6,r19,31091
>   3c:	00 2f 75 73 	.long 0x2f7573
>   40:	72 2f 69 6e 	andi.   r15,r17,26990
>   44:	63 6c 75 64 	ori     r12,r27,30052
>   48:	65 2f 62 69 	oris    r15,r9,25193
>   4c:	74 73 00 2f 	andis.  r19,r3,47
>   50:	75 73 72 2f 	andis.  r19,r11,29231
>   54:	6c 69 62 36 	xoris   r9,r3,25142
>   58:	34 2f 67 63 	addic.  r1,r15,26467
>   5c:	63 2f 70 6f 	ori     r15,r25,28783
>   60:	77 65 72 70 	andis.  r5,r27,29296
>   64:	63 36 34 2d 	ori     r22,r25,13357
>   68:	73 75 73 65 	andi.   r21,r27,29541
>   6c:	2d 6c 69 6e 	cmpdi   cr2,r12,26990
>   70:	75 78 2f 34 	andis.  r24,r11,12084
>   74:	2e 33 2f 69 	cmpdi   cr4,r19,12137
>   78:	6e 63 6c 75 	xoris   r3,r19,27765
>   7c:	64 65 00 2f 	oris    r5,r3,47
>   80:	75 73 72 2f 	andis.  r19,r11,29231
>   84:	69 6e 63 6c 	xori    r14,r11,25452
>   88:	75 64 65 00 	andis.  r4,r11,25856
>   8c:	6b 65 78 65 	xori    r5,r27,30821
>   90:	63 2f 61 72 	ori     r15,r25,24946
>   94:	63 68 2f 70 	ori     r8,r27,12144
>   98:	70 63 36 34 	andi.   r3,r3,13876
>   9c:	2f 2e 2e 2f 	cmpdi   cr6,r14,11823
>   a0:	2e 2e 00 00 	cmpdi   cr4,r14,0
>   a4:	66 73 32 64 	oris    r19,r19,12900
>   a8:	74 2e 63 00 	andis.  r14,r1,25344
>   ac:	01 00 00 73 	.long 0x1000073
>   b0:	74 61 74 2e 	andis.  r1,r3,29742
>   b4:	68 00 02 00 	xori    r0,r0,512
>   b8:	00 73 74 64 	.long 0x737464
>   bc:	69 6f 2e 68 	xori    r15,r11,11880
>   c0:	00 03 00 00 	.long 0x30000
>   c4:	74 79 70 65 	andis.  r25,r3,28773
>   c8:	73 2e 68 00 	andi.   r14,r25,26624
>   cc:	03 00 00 74 	.long 0x3000074
>   d0:	79 70 65 73 	rldcr.  r16,r11,r12,53
>   d4:	2e 68 00 02 	cmpdi   cr4,r8,2
>   d8:	00 00 73 74 	.long 0x7374
>   dc:	64 64 65 66 	oris    r4,r3,25958
>   e0:	2e 68 00 04 	cmpdi   cr4,r8,4
>   e4:	00 00 74 69 	.long 0x7469
>   e8:	6d 65 2e 68 	xoris   r5,r11,11880
>   ec:	00 05 00 00 	.long 0x50000
>   f0:	73 74 61 74 	andi.   r20,r27,24948
>   f4:	2e 68 00 03 	cmpdi   cr4,r8,3
>   f8:	00 00 64 69 	.long 0x6469
>   fc:	72 65 6e 74 	andi.   r5,r19,28276
>  100:	2e 68 00 03 	cmpdi   cr4,r8,3
>  104:	00 00 73 74 	.long 0x7374
>  108:	64 69 6f 2e 	oris    r9,r3,28462
>  10c:	68 00 05 00 	xori    r0,r0,1280
>  110:	00 6c 69 62 	.long 0x6c6962
>  114:	69 6f 2e 68 	xori    r15,r11,11880
>  118:	00 05 00 00 	.long 0x50000
>  11c:	73 74 64 69 	andi.   r20,r27,25705
>  120:	6e 74 2e 68 	xoris   r20,r19,11880
>  124:	00 05 00 00 	.long 0x50000
>  128:	6b 65 78 65 	xori    r5,r27,30821
>  12c:	63 2e 68 00 	ori     r14,r25,26624
>  130:	06 00 00 6b 	.long 0x600006b
>  134:	65 78 65 63 	oris    r24,r11,25955
>  138:	2d 70 70 63 	cmpdi   cr2,r16,28771
>  13c:	36 34 2e 68 	addic.  r17,r20,11880
>  140:	00 01 00 00 	.long 0x10000
>  144:	63 72 61 73 	ori     r18,r27,24947
>  148:	68 64 75 6d 	xori    r4,r3,30061
>  14c:	70 2d 70 70 	andi.   r13,r1,28784
>  150:	63 36 34 2e 	ori     r22,r25,13358
>  154:	68 00 01 00 	xori    r0,r0,256
>  158:	00 00 00 09 	.long 0x9
>  15c:	02 00 00 00 	.long 0x2000000
>  160:	00 00 00 00 	.long 0x0
>  164:	00 03 34 01 	.long 0x33401
>  168:	69 1d 2e 31 	xori    r29,r8,11825
>  16c:	af 4b 4c 21 	lhau    r26,19489(r11)
>  170:	21 21 1d 22 	subfic  r9,r1,7458
>  174:	1f 21 21 03 	mulli   r25,r1,8451
>  178:	77 82 03 0d 	andis.  r2,r28,781
>  17c:	9e 31 1d 66 	stbu    r17,7526(r17)
>  180:	23 30 03 0b 	subfic  r25,r16,779
>  184:	66 32 68 6a 	oris    r18,r17,26730
>  188:	40 03 65 90 	bdnzf-  so,6718 <dtstruct+0x12e8>
>  18c:	9f 69 6d 6d 	stbu    r27,28013(r9)
>  190:	4c 2f 26 03 	.long 0x4c2f2603
>  194:	7a 20 34 9b 	.long 0x7a20349b
>  198:	2f 30 03 6b 	cmpdi   cr6,r16,875
>  19c:	82 68 65 49 	lwz     r19,25929(r8)
>  1a0:	31 9f 40 67 	addic   r12,r31,16487
>  1a4:	03 13 74 69 	.long 0x3137469
>  1a8:	1d 2e 23 3d 	mulli   r9,r14,9021
>  1ac:	1f 68 56 59 	mulli   r27,r8,22105
>  1b0:	67 1f 03 0b 	oris    r31,r24,779
>  1b4:	20 03 74 9e 	subfic  r0,r3,29854
>  1b8:	26 85 4d a7 	dozi    r20,r5,19879
>  1bc:	03 79 58 03 	.long 0x3795803
>  1c0:	d3 00 74 6d 	stfs    f24,29805(0)
>  1c4:	03 79 20 2e 	.long 0x379202e
>  1c8:	35 67 4b 21 	addic.  r11,r7,19233
>  1cc:	1e 22 1f 21 	mulli   r17,r2,7969
>  1d0:	2f 69 32 77 	cmpdi   cr6,r9,12919
>  1d4:	83 a1 5d 1e 	lwz     r29,23838(r1)
>  1d8:	22 bd 2f 2f 	subfic  r21,r29,12079
>  1dc:	1f 2f 1f 21 	mulli   r25,r15,7969
>  1e0:	51 03 74 20 	rlwimi  r3,r8,14,16,16
>  1e4:	2f 30 1f 21 	cmpdi   cr6,r16,7969
>  1e8:	23 87 21 1f 	subfic  r28,r7,8479
>  1ec:	3d 1f 21 03 	addis   r8,r31,8451
>  1f0:	74 74 03 0c 	andis.  r20,r3,780
>  1f4:	20 03 74 2e 	subfic  r0,r3,29742
>  1f8:	03 10 2e 03 	.long 0x3102e03
>  1fc:	0e 2e 03 72 	twi     17,r14,882
>  200:	20 03 10 20 	subfic  r0,r3,4128
>  204:	03 70 20 03 	.long 0x3702003
>  208:	0e 20 21 1f 	twi     17,r0,8479
>  20c:	03 72 2e 03 	.long 0x3722e03
>  210:	0f 20 03 71 	twi     25,r0,881
>  214:	20 03 0f 2e 	subfic  r0,r3,3886
>  218:	03 71 20 03 	.long 0x3712003
>  21c:	10 20 03 70 	.long 0x10200370
>  220:	20 03 10 20 	subfic  r0,r3,4128
>  224:	21 1f 2f 22 	subfic  r8,r31,12066
>  228:	59 3d 03 79 	rlmi.   r29,r9,r0,13,28
>  22c:	90 03 78 20 	stw     r0,30752(r3)
>  230:	03 09 20 21 	.long 0x3092021
>  234:	03 77 3c 1f 	.long 0x3773c1f
>  238:	28 21 1f 2f 	cmpldi  r1,7983
>  23c:	2f 4b 2f 21 	cmpwi   cr6,r11,12065
>  240:	2d 21 3d 03 	cmpdi   cr2,r1,15619
>  244:	58 58 5c 1e 	rlmi    r24,r2,r11,16,15
>  248:	22 03 71 58 	subfic  r16,r3,29016
>  24c:	3f 75 03 a9 	addis   r27,r21,937
>  250:	7f d6 ec 03 	.long 0x7fd6ec03
>  254:	78 20 28 67 	rldicr. r0,r1,37,33
>  258:	4b 21 1e 22 	ba      ff211e20 <bb+0xff1cc9f0>
>  25c:	1f 21 2f 03 	mulli   r25,r1,12035
>  260:	35 58 03 4e 	addic.  r10,r24,846
>  264:	f2 79 59 49 	.long 0xf2795949
>  268:	21 1f 21 03 	subfic  r8,r31,8451
>  26c:	0c 2e 03 74 	twlgti  r14,884
>  270:	20 40 21 21 	subfic  r2,r0,8481
>  274:	1f 21 34 1d 	mulli   r25,r1,13341
>  278:	23 1d 23 a1 	subfic  r24,r29,9121
>  27c:	2f 2f 21 1e 	cmpdi   cr6,r15,8478
>  280:	30 1f 1f 21 	addic   r0,r31,7969
>  284:	03 09 4a 03 	.long 0x3094a03
>  288:	72 20 2f 30 	andi.   r0,r17,12080
>  28c:	1f 21 24 79 	mulli   r25,r1,9337
>  290:	21 1f 3d 1f 	subfic  r8,r31,15647
>  294:	21 4b 1f 2f 	subfic  r10,r11,7983
>  298:	03 72 20 03 	.long 0x3722003
>  29c:	0d 20 21 1f 	twi     9,r0,8479
>  2a0:	03 73 20 03 	.long 0x3732003
>  2a4:	73 4a 03 1f 	andi.   r10,r26,799
>  2a8:	2e 03 61 20 	cmpwi   cr4,r3,24864
>  2ac:	03 1f 20 03 	.long 0x31f2003
>  2b0:	61 20 03 1f 	ori     r0,r9,799
>  2b4:	20 03 61 20 	subfic  r0,r3,24864
>  2b8:	21 3b 21 4b 	subfic  r9,r27,8523
>  2bc:	a1 21 21 1f 	lhz     r9,8479(r1)
>  2c0:	21 59 03 1e 	subfic  r10,r25,798
>  2c4:	4a 03 5a 20 	b       fffffffffe035ce4 <bb+0xfffffffffdff08b4>
>  2c8:	03 28 20 03 	.long 0x3282003
>  2cc:	58 20 03 26 	rlmi    r0,r1,r0,12,19
>  2d0:	20 21 1f 03 	subfic  r1,r1,7939
>  2d4:	5a 2e 03 27 	rlmi.   r14,r17,r0,12,19
>  2d8:	20 03 59 20 	subfic  r0,r3,22816
>  2dc:	03 27 2e 03 	.long 0x3272e03
>  2e0:	59 20 03 28 	rlmi    r0,r9,r0,12,20
>  2e4:	20 03 58 20 	subfic  r0,r3,22560
>  2e8:	03 28 20 21 	.long 0x3282021
>  2ec:	1f 2f 3d 2f 	mulli   r25,r15,15663
>  2f0:	59 21 1f 2f 	rlmi.   r1,r9,r3,28,23
>  2f4:	03 4f e4 03 	.long 0x34fe403
>  2f8:	2a ac 22 3b 	cmpldi  cr5,r12,8763
>  2fc:	1f 3d 2f 03 	mulli   r25,r29,12035
>  300:	cf 00 9e 25 	lfdu    f24,-25051(0)
>  304:	1b 08 20 33 	.long 0x1b082033
>  308:	03 29 2e 03 	.long 0x3292e03
>  30c:	57 20 04 02 	rlwinm  r0,r25,0,16,1
>  310:	03 c0 01 2e 	.long 0x3c0012e
>  314:	04 01 03 e9 	.long 0x40103e9
>  318:	7e 20 25 04 	.long 0x7e202504
>  31c:	02 03 92 01 	.long 0x2039201
>  320:	3c 04 01 03 	addis   r0,r4,259
>  324:	c7 7e 90 32 	lfsu    f27,-28622(r30)
>  328:	03 0a 3c 03 	.long 0x30a3c03
>  32c:	6b 66 59 21 	xori    r6,r27,22817
>  330:	5a a8 03 ca 	rlmi    r8,r21,r0,15,5
>  334:	00 66 21 3b 	.long 0x66213b
>  338:	21 21 03 bc 	subfic  r9,r1,956
>  33c:	7f 08 58 a1 	.long 0x7f0858a1
>  340:	93 6d 67 49 	stw     r27,26441(r13)
>  344:	30 48 31 47 	addic   r2,r8,12615
>  348:	03 09 2e a6 	.long 0x3092ea6
>  34c:	69 4d 22 22 	xori    r13,r10,8738
>  350:	1e 21 1f 21 	mulli   r17,r1,7969
>  354:	2f 30 1e 30 	cmpdi   cr6,r16,7728
>  358:	3d 30 4b 1f 	addis   r9,r16,19231
>  35c:	21 21 a1 75 	subfic  r9,r1,-24203
>  360:	a1 4c 83 f3 	lhz     r10,-31757(r12)
>  364:	3d a0 30 03 	lis     r13,12291
>  368:	58 66 49 03 	rlmi.   r6,r3,r9,4,1
>  36c:	cb 00 66 6e 	lfd     f24,26222(0)
>  370:	03 78 20 98 	.long 0x3782098
>  374:	59 75 4b 2d 	rlmi.   r21,r11,r9,12,22
>  378:	3e 3d 30 75 	addis   r17,r29,12405
>  37c:	1f 21 23 32 	mulli   r25,r1,9010
>  380:	5a 59 3e 2c 	rlmi    r25,r18,r7,24,22
>  384:	22 31 03 1e 	subfic  r17,r17,798
>  388:	58 03 36 66 	rlmi    r3,r0,r6,25,19
>  38c:	04 02 03 64 	.long 0x4020364
>  390:	20 04 01 03 	subfic  r0,r4,259
>  394:	1c 20 04 02 	mulli   r1,r0,1026
>  398:	03 64 2e 04 	.long 0x3642e04
>  39c:	01 03 24 74 	.long 0x1032474
>  3a0:	32 03 74 4a 	addic   r16,r3,29770
>  3a4:	4c 67 2b 23 	.long 0x4c672b23
>  3a8:	30 04 02 03 	addic   r0,r4,515
>  3ac:	5f 20 04 01 	rlwnm.  r0,r25,r0,16,0
>  3b0:	03 21 3c 99 	.long 0x3213c99
>  3b4:	03 10 74 4b 	.long 0x310744b
>  3b8:	1f 21 21 3d 	mulli   r25,r1,8509
>  3bc:	03 b8 7f 08 	.long 0x3b87f08
>  3c0:	20 23 4b 1f 	subfic  r1,r3,19231
>  3c4:	21 03 0f 20 	subfic  r8,r3,3872
>  3c8:	1d 23 2b 23 	mulli   r9,r3,11043
>  3cc:	2f 4b 1f 2f 	cmpwi   cr6,r11,7983
>  3d0:	1f 67 2f 04 	mulli   r27,r7,12036
>  3d4:	03 03 ad 7d 	.long 0x303ad7d
>  3d8:	2e 04 01 03 	cmpwi   cr4,r4,259
>  3dc:	d4 02 66 31 	stfsu   f0,26161(r2)
>  3e0:	59 2f 3d 1f 	rlmi.   r15,r9,r7,20,15
>  3e4:	21 30 5b 2f 	subfic  r9,r16,23343
>  3e8:	03 1b 66 a1 	.long 0x31b66a1
>  3ec:	4b 03 9f 7f 	bla     ff039f7c <bb+0xfeff4b4c>
>  3f0:	2e 77 21 1f 	cmpdi   cr4,r23,8479
>  3f4:	22 1f 1f 2f 	subfic  r16,r31,7983
>  3f8:	2f 30 1e 30 	cmpdi   cr6,r16,7728
>  3fc:	21 30 34 03 	subfic  r9,r16,13315
>  400:	7a 20 24 21 	rldicl. r0,r17,4,48
>  404:	1c 23 21 3d 	mulli   r1,r3,8509
>  408:	22 1e 31 1d 	subfic  r16,r30,12573
>  40c:	22 4b 21 30 	subfic  r18,r11,8496
>  410:	3d 22 2c 30 	addis   r9,r2,11312
>  414:	03 5c 4a 7f 	.long 0x35c4a7f
>  418:	03 32 ac 4b 	.long 0x332ac4b
>  41c:	2f 30 4e 03 	cmpdi   cr6,r16,19971
>  420:	18 3c 59 40 	.long 0x183c5940
>  424:	2b 33 1e 2f 	cmpldi  cr6,r19,7727
>  428:	4b 4b 59 2f 	bla     ff4b592c <bb+0xff4704fc>
>  42c:	4b 30 3a 22 	ba      ff303a20 <bb+0xff2be5f0>
>  430:	1e 3e 03 6c 	mulli   r17,r30,876
>  434:	3c 03 7a 66 	addis   r0,r3,31334
>  438:	03 33 90 a6 	.long 0x33390a6
>  43c:	03 78 2e 44 	.long 0x3782e44
>  440:	23 1f 1e 84 	subfic  r24,r31,7812
>  444:	31 1e 1f 31 	addic   r8,r30,7985
>  448:	21 4c 21 33 	subfic  r10,r12,8499
>  44c:	22 03 79 20 	subfic  r16,r3,31008
>  450:	25 1b 27 1e 	dozi    r8,r27,10014
>  454:	1b 27 c1 1e 	.long 0x1b27c11e
>  458:	26 1e 3e 22 	dozi    r16,r30,15906
>  45c:	22 21 1c 23 	subfic  r17,r1,7203
>  460:	22 1f 1d 22 	subfic  r16,r31,7458
>  464:	1e 26 03 7a 	mulli   r17,r6,890
>  468:	20 34 30 3e 	subfic  r1,r20,12350
>  46c:	1f 1f 22 3d 	mulli   r24,r31,8765
>  470:	21 75 2f 2d 	subfic  r11,r21,12077
>  474:	21 1f 21 1f 	subfic  r8,r31,8479
>  478:	21 3d 2f 2d 	subfic  r9,r29,12077
>  47c:	21 1f 21 1f 	subfic  r8,r31,8479
>  480:	21 3e 30 2c 	subfic  r9,r30,12332
>  484:	3e 03 a8 7e 	addis   r16,r3,-22402
>  488:	d6 67 21 28 	stfsu   f19,8488(r7)
>  48c:	03 77 20 21 	.long 0x3772021
>  490:	28 08 4e 59 	cmplwi  r8,20057
>  494:	02 0b 00 01 	.long 0x20b0001
>  498:	Address 0x0000000000000498 is out of bounds.
> 
> 
> Disassembly of section .opd:
> 
> 0000000000000000 <reserve>:
> 	...
> 
> 0000000000000018 <checkprop>:
>   18:	00 00 00 00 	.long 0x0
>   1c:	00 00 00 e0 	.long 0xe0
> 	...
> 
> 0000000000000030 <propnum>:
>   30:	00 00 00 00 	.long 0x0
>   34:	00 00 03 30 	.long 0x330
> 	...
> 
> 0000000000000048 <add_usable_mem_property>:
>   48:	00 00 00 00 	.long 0x0
>   4c:	00 00 04 80 	.long 0x480
> 	...
> 
> 0000000000000060 <add_dyn_reconf_usable_mem_property>:
>   60:	00 00 00 00 	.long 0x0
>   64:	00 00 08 30 	.long 0x830
> 	...
> 
> 0000000000000078 <putprops>:
>   78:	00 00 00 00 	.long 0x0
>   7c:	00 00 0c 70 	.long 0xc70
> 	...
> 
> 0000000000000090 <putnode>:
>   90:	00 00 00 00 	.long 0x0
>   94:	00 00 10 f0 	.long 0x10f0
> 	...
> 
> 00000000000000a8 <create_flatten_tree>:
>   a8:	00 00 00 00 	.long 0x0
>   ac:	00 00 17 40 	.long 0x1740
> 	...
> 
> 00000000000000c0 <comparefunc>:
>   c0:	00 00 00 00 	.long 0x0
>   c4:	00 00 19 80 	.long 0x1980
> 	...
> 
> Disassembly of section .rodata.str1.8:
> 
> 0000000000000000 <.rodata.str1.8>:
>    0:	75 6e 72 65 	andis.  r14,r11,29285
>    4:	63 6f 76 65 	ori     r15,r27,30309
>    8:	72 61 62 6c 	andi.   r1,r19,25196
>    c:	65 20 65 72 	oris    r0,r9,25970
>   10:	72 6f 72 3a 	andi.   r15,r19,29242
>   14:	20 65 78 68 	subfic  r3,r5,30824
>   18:	61 73 75 74 	ori     r19,r11,30068
>   1c:	65 64 20 72 	oris    r4,r11,8306
>   20:	65 73 65 72 	oris    r19,r11,25970
>   24:	76 61 74 69 	andis.  r1,r19,29801
>   28:	6f 6e 20 6d 	xoris   r14,r27,8301
>   2c:	65 74 61 20 	oris    r20,r11,24864
>   30:	64 61 74 61 	oris    r1,r3,29793
>   34:	0a 00 00 00 	tdlti   r0,0
>   38:	75 6e 72 65 	andis.  r14,r11,29285
>   3c:	63 6f 76 65 	ori     r15,r27,30309
>   40:	72 61 62 6c 	andi.   r1,r19,25196
>   44:	65 20 65 72 	oris    r0,r9,25970
>   48:	72 6f 72 3a 	andi.   r15,r19,29242
>   4c:	20 6e 6f 20 	subfic  r3,r14,28448
>   50:	70 72 6f 70 	andi.   r18,r3,28528
>   54:	65 72 74 79 	oris    r18,r11,29817
>   58:	20 64 61 74 	subfic  r3,r4,24948
>   5c:	61 00 00 00 	ori     r0,r8,0
>   60:	6c 69 6e 75 	xoris   r9,r3,28277
>   64:	78 2c 72 74 	.long 0x782c7274
>   68:	61 73 2d 62 	ori     r19,r11,11618
>   6c:	61 73 65 00 	ori     r19,r11,25856
>   70:	6c 69 6e 75 	xoris   r9,r3,28277
>   74:	78 2c 74 63 	rldicl. r12,r1,46,49
>   78:	65 2d 62 61 	oris    r13,r9,25185
>   7c:	73 65 00 00 	andi.   r5,r27,0
>   80:	72 74 61 73 	andi.   r20,r19,24947
>   84:	2d 73 69 7a 	cmpdi   cr2,r19,27002
>   88:	65 00 00 00 	oris    r0,r8,0
>   8c:	00 00 00 00 	.long 0x0
>   90:	6c 69 6e 75 	xoris   r9,r3,28277
>   94:	78 2c 74 63 	rldicl. r12,r1,46,49
>   98:	65 2d 73 69 	oris    r13,r9,29545
>   9c:	7a 65 00 00 	rotldi  r5,r19,0
>   a0:	6c 69 6e 75 	xoris   r9,r3,28277
>   a4:	78 2c 69 6e 	rldimi  r12,r1,45,37
>   a8:	69 74 72 64 	xori    r20,r11,29284
>   ac:	2d 73 74 61 	cmpdi   cr2,r19,29793
>   b0:	72 74 00 00 	andi.   r20,r19,0
>   b4:	00 00 00 00 	.long 0x0
>   b8:	6c 69 6e 75 	xoris   r9,r3,28277
>   bc:	78 2c 69 6e 	rldimi  r12,r1,45,37
>   c0:	69 74 72 64 	xori    r20,r11,29284
>   c4:	2d 65 6e 64 	cmpdi   cr2,r5,28260
> 	...
>   d0:	75 6e 72 65 	andis.  r14,r11,29285
>   d4:	63 6f 76 65 	ori     r15,r27,30309
>   d8:	72 61 62 6c 	andi.   r1,r19,25196
>   dc:	65 20 65 72 	oris    r0,r9,25970
>   e0:	72 6f 72 3a 	andi.   r15,r19,29242
>   e4:	20 73 69 7a 	subfic  r3,r19,27002
>   e8:	65 20 61 6e 	oris    r0,r9,24942
>   ec:	64 20 65 6e 	oris    r0,r1,25966
>   f0:	64 20 73 65 	oris    r0,r1,29541
>   f4:	74 20 61 74 	andis.  r0,r1,24948
>   f8:	20 73 61 6d 	subfic  r3,r19,24941
>   fc:	65 20 74 69 	oris    r0,r9,29801
>  100:	6d 65 0a 00 	xoris   r5,r11,2560
>  104:	00 00 00 00 	.long 0x0
>  108:	75 6e 72 65 	andis.  r14,r11,29285
>  10c:	63 6f 76 65 	ori     r15,r27,30309
>  110:	72 61 62 6c 	andi.   r1,r19,25196
>  114:	65 20 65 72 	oris    r0,r9,25970
>  118:	72 6f 72 3a 	andi.   r15,r19,29242
>  11c:	20 70 72 6f 	subfic  r3,r16,29295
>  120:	70 6e 61 6d 	andi.   r14,r3,24941
>  124:	65 73 20 6f 	oris    r19,r11,8303
>  128:	76 65 72 72 	andis.  r5,r19,29298
>  12c:	75 6e 0a 00 	andis.  r14,r11,2560
>  130:	2f 6d 65 6d 	cmpdi   cr6,r13,25965
>  134:	6f 72 79 40 	xoris   r18,r27,31040
> 	...
>  140:	75 6e 72 65 	andis.  r14,r11,29285
>  144:	63 6f 76 65 	ori     r15,r27,30309
>  148:	72 61 62 6c 	andi.   r1,r19,25196
>  14c:	65 20 65 72 	oris    r0,r9,25970
>  150:	72 6f 72 3a 	andi.   r15,r19,29242
>  154:	20 6e 6f 74 	subfic  r3,r14,28532
>  158:	20 65 6e 6f 	subfic  r3,r5,28271
>  15c:	75 67 68 20 	andis.  r7,r11,26656
>  160:	64 61 74 61 	oris    r1,r3,29793
>  164:	20 66 6f 72 	subfic  r3,r6,28530
>  168:	20 6d 65 6d 	subfic  r3,r13,25965
>  16c:	20 70 72 6f 	subfic  r3,r16,29295
>  170:	70 65 72 74 	andi.   r5,r3,29300
>  174:	79 0a 00 00 	rotldi  r10,r8,0
>  178:	75 6e 72 65 	andis.  r14,r11,29285
>  17c:	63 6f 76 65 	ori     r15,r27,30309
>  180:	72 61 62 6c 	andi.   r1,r19,25196
>  184:	65 20 65 72 	oris    r0,r9,25970
>  188:	72 6f 72 3a 	andi.   r15,r19,29242
>  18c:	20 65 72 72 	subfic  r3,r5,29298
>  190:	6f 72 20 73 	xoris   r18,r27,8307
>  194:	65 65 6b 69 	oris    r5,r11,27497
>  198:	6e 67 20 69 	xoris   r7,r19,8297
>  19c:	6e 20 22 25 	xoris   r0,r17,8741
>  1a0:	73 22 3a 20 	andi.   r2,r25,14880
>  1a4:	25 73 0a 00 	dozi    r11,r19,2560
>  1a8:	75 6e 72 65 	andis.  r14,r11,29285
>  1ac:	63 6f 76 65 	ori     r15,r27,30309
>  1b0:	72 61 62 6c 	andi.   r1,r19,25196
>  1b4:	65 20 65 72 	oris    r0,r9,25970
>  1b8:	72 6f 72 3a 	andi.   r15,r19,29242
>  1bc:	20 65 72 72 	subfic  r3,r5,29298
>  1c0:	6f 72 20 72 	xoris   r18,r27,8306
>  1c4:	65 61 64 69 	oris    r1,r11,25705
>  1c8:	6e 67 20 22 	xoris   r7,r19,8226
>  1cc:	25 73 22 3a 	dozi    r11,r19,8762
>  1d0:	20 25 73 0a 	subfic  r1,r5,29450
>  1d4:	00 00 00 00 	.long 0x0
>  1d8:	75 6e 72 65 	andis.  r14,r11,29285
>  1dc:	63 6f 76 65 	ori     r15,r27,30309
>  1e0:	72 61 62 6c 	andi.   r1,r19,25196
>  1e4:	65 20 65 72 	oris    r0,r9,25970
>  1e8:	72 6f 72 3a 	andi.   r15,r19,29242
>  1ec:	20 6d 65 6d 	subfic  r3,r13,25965
>  1f0:	20 70 72 6f 	subfic  r3,r16,29295
>  1f4:	70 65 72 74 	andi.   r5,r3,29300
>  1f8:	79 20 6f 76 	.long 0x79206f76
>  1fc:	65 72 66 6c 	oris    r18,r11,26220
>  200:	6f 77 0a 00 	xoris   r23,r27,2560
>  204:	00 00 00 00 	.long 0x0
>  208:	6c 69 6e 75 	xoris   r9,r3,28277
>  20c:	78 2c 75 73 	rldcr.  r12,r1,r14,53
>  210:	61 62 6c 65 	ori     r2,r11,27749
>  214:	2d 6d 65 6d 	cmpdi   cr2,r13,25965
>  218:	6f 72 79 00 	xoris   r18,r27,30976
>  21c:	00 00 00 00 	.long 0x0
>  220:	2f 69 62 6d 	cmpdi   cr6,r9,25197
>  224:	2c 64 79 6e 	cmpdi   r4,31086
>  228:	61 6d 69 63 	ori     r13,r11,26979
>  22c:	2d 72 65 63 	cmpdi   cr2,r18,25955
>  230:	6f 6e 66 69 	xoris   r14,r27,26217
>  234:	67 75 72 61 	oris    r21,r27,29281
>  238:	74 69 6f 6e 	andis.  r9,r3,28526
>  23c:	2d 6d 65 6d 	cmpdi   cr2,r13,25965
>  240:	6f 72 79 00 	xoris   r18,r27,30976
>  244:	00 00 00 00 	.long 0x0
>  248:	6c 69 6e 75 	xoris   r9,r3,28277
>  24c:	78 2c 64 72 	rldcr   r12,r1,r12,49
>  250:	63 6f 6e 66 	ori     r15,r27,28262
>  254:	2d 75 73 61 	cmpdi   cr2,r21,29537
>  258:	62 6c 65 2d 	ori     r12,r19,25901
>  25c:	6d 65 6d 6f 	xoris   r5,r11,28015
>  260:	72 79 00 00 	andi.   r25,r19,0
>  264:	00 00 00 00 	.long 0x0
>  268:	75 6e 72 65 	andis.  r14,r11,29285
>  26c:	63 6f 76 65 	ori     r15,r27,30309
>  270:	72 61 62 6c 	andi.   r1,r19,25196
>  274:	65 20 65 72 	oris    r0,r9,25970
>  278:	72 6f 72 3a 	andi.   r15,r19,29242
>  27c:	20 63 6f 75 	subfic  r3,r3,28533
>  280:	6c 64 20 6e 	xoris   r4,r3,8302
>  284:	6f 74 20 73 	xoris   r20,r27,8307
>  288:	74 61 74 20 	andis.  r1,r3,29728
>  28c:	22 25 73 22 	subfic  r17,r5,29474
>  290:	3a 20 25 73 	li      r17,9587
>  294:	0a 00 00 00 	tdlti   r0,0
>  298:	6c 69 6e 75 	xoris   r9,r3,28277
>  29c:	78 2c 63 72 	rldcr   r12,r1,r12,45
>  2a0:	61 73 68 6b 	ori     r19,r11,26731
>  2a4:	65 72 6e 65 	oris    r18,r11,28261
>  2a8:	6c 2d 62 61 	xoris   r13,r1,25185
>  2ac:	73 65 00 00 	andi.   r5,r27,0
>  2b0:	6c 69 6e 75 	xoris   r9,r3,28277
>  2b4:	78 2c 63 72 	rldcr   r12,r1,r12,45
>  2b8:	61 73 68 6b 	ori     r19,r11,26731
>  2bc:	65 72 6e 65 	oris    r18,r11,28261
>  2c0:	6c 2d 73 69 	xoris   r13,r1,29545
>  2c4:	7a 65 00 00 	rotldi  r5,r19,0
>  2c8:	6c 69 6e 75 	xoris   r9,r3,28277
>  2cc:	78 2c 70 63 	rldicl. r12,r1,46,33
>  2d0:	69 2d 64 6f 	xori    r13,r9,25711
>  2d4:	6d 61 69 6e 	xoris   r1,r11,26990
> 	...
>  2e0:	6c 69 6e 75 	xoris   r9,r3,28277
>  2e4:	78 2c 68 74 	.long 0x782c6874
>  2e8:	61 62 2d 62 	ori     r2,r11,11618
>  2ec:	61 73 65 00 	ori     r19,r11,25856
>  2f0:	6c 69 6e 75 	xoris   r9,r3,28277
>  2f4:	78 2c 68 74 	.long 0x782c6874
>  2f8:	61 62 2d 73 	ori     r2,r11,11635
>  2fc:	69 7a 65 00 	xori    r26,r11,25856
>  300:	6c 69 6e 75 	xoris   r9,r3,28277
>  304:	78 2c 6b 65 	rldicr. r12,r1,13,45
>  308:	72 6e 65 6c 	andi.   r14,r19,25964
>  30c:	2d 65 6e 64 	cmpdi   cr2,r5,28260
> 	...
>  318:	62 6f 6f 74 	ori     r15,r19,28532
>  31c:	61 72 67 73 	ori     r18,r11,26483
> 	...
>  328:	75 6e 72 65 	andis.  r14,r11,29285
>  32c:	63 6f 76 65 	ori     r15,r27,30309
>  330:	72 61 62 6c 	andi.   r1,r19,25196
>  334:	65 20 65 72 	oris    r0,r9,25970
>  338:	72 6f 72 3a 	andi.   r15,r19,29242
>  33c:	20 63 6f 75 	subfic  r3,r3,28533
>  340:	6c 64 20 6e 	xoris   r4,r3,8302
>  344:	6f 74 20 6f 	xoris   r20,r27,8303
>  348:	70 65 6e 20 	andi.   r5,r3,28192
>  34c:	22 25 73 22 	subfic  r17,r5,29474
>  350:	3a 20 25 73 	li      r17,9587
>  354:	0a 00 00 00 	tdlti   r0,0
>  358:	75 6e 72 65 	andis.  r14,r11,29285
>  35c:	63 6f 76 65 	ori     r15,r27,30309
>  360:	72 61 62 6c 	andi.   r1,r19,25196
>  364:	65 20 65 72 	oris    r0,r9,25970
>  368:	72 6f 72 3a 	andi.   r15,r19,29242
>  36c:	20 63 6f 75 	subfic  r3,r3,28533
>  370:	6c 64 20 6e 	xoris   r4,r3,8302
>  374:	6f 74 20 72 	xoris   r20,r27,8306
>  378:	65 61 64 20 	oris    r1,r11,25632
>  37c:	22 25 73 22 	subfic  r17,r5,29474
>  380:	3a 20 25 73 	li      r17,9587
>  384:	0a 00 00 00 	tdlti   r0,0
>  388:	69 62 6d 2c 	xori    r2,r11,27948
>  38c:	64 79 6e 61 	oris    r25,r3,28257
>  390:	6d 69 63 2d 	xoris   r9,r11,25389
>  394:	6d 65 6d 6f 	xoris   r5,r11,28015
>  398:	72 79 00 00 	andi.   r25,r19,0
>  39c:	00 00 00 00 	.long 0x0
>  3a0:	2f 00 00 00 	cmpwi   cr6,r0,0
>  3a4:	00 00 00 00 	.long 0x0
>  3a8:	75 6e 72 65 	andis.  r14,r11,29285
>  3ac:	63 6f 76 65 	ori     r15,r27,30309
>  3b0:	72 61 62 6c 	andi.   r1,r19,25196
>  3b4:	65 20 65 72 	oris    r0,r9,25970
>  3b8:	72 6f 72 3a 	andi.   r15,r19,29242
>  3bc:	20 63 6f 75 	subfic  r3,r3,28533
>  3c0:	6c 64 20 6e 	xoris   r4,r3,8302
>  3c4:	6f 74 20 73 	xoris   r20,r27,8307
>  3c8:	63 61 6e 20 	ori     r1,r27,28192
>  3cc:	22 25 73 22 	subfic  r17,r5,29474
>  3d0:	3a 20 25 73 	li      r17,9587
>  3d4:	0a 00 00 00 	tdlti   r0,0
>  3d8:	75 6e 72 65 	andis.  r14,r11,29285
>  3dc:	63 6f 76 65 	ori     r15,r27,30309
>  3e0:	72 61 62 6c 	andi.   r1,r19,25196
>  3e4:	65 20 65 72 	oris    r0,r9,25970
>  3e8:	72 6f 72 3a 	andi.   r15,r19,29242
>  3ec:	20 6e 6f 20 	subfic  r3,r14,28448
>  3f0:	64 69 72 65 	oris    r9,r3,29285
>  3f4:	63 74 6f 72 	ori     r20,r27,28530
>  3f8:	79 20 65 6e 	rldimi  r0,r9,44,53
>  3fc:	74 72 69 65 	andis.  r18,r3,26981
>  400:	73 20 69 6e 	andi.   r0,r25,26990
>  404:	20 22 25 73 	subfic  r1,r2,9587
>  408:	22 00 00 00 	subfic  r16,r0,0
>  40c:	00 00 00 00 	.long 0x0
>  410:	2f 63 68 6f 	cmpdi   cr6,r3,26735
>  414:	73 65 6e 2f 	andi.   r5,r27,28207
> 	...
>  420:	63 72 61 73 	ori     r18,r27,24947
>  424:	68 6b 65 72 	xori    r11,r3,25970
>  428:	6e 65 6c 3d 	xoris   r5,r19,27709
>  42c:	00 00 00 00 	.long 0x0
>  430:	72 6f 6f 74 	andi.   r15,r19,28532
>  434:	3d 00 00 00 	lis     r8,0
>  438:	72 00 00 00 	andi.   r0,r16,0
>  43c:	00 00 00 00 	.long 0x0
>  440:	75 6e 61 62 	andis.  r14,r11,24930
>  444:	6c 65 20 74 	xoris   r5,r3,8308
>  448:	6f 20 72 65 	xoris   r0,r25,29285
>  44c:	61 64 20 25 	ori     r4,r11,8229
>  450:	73 0a 00 00 	andi.   r10,r24,0
>  454:	00 00 00 00 	.long 0x0
>  458:	20 00 00 00 	subfic  r0,r0,0
>  45c:	00 00 00 00 	.long 0x0
>  460:	4d 6f 64 69 	.long 0x4d6f6469
>  464:	66 69 65 64 	oris    r9,r19,25956
>  468:	20 63 6d 64 	subfic  r3,r3,28004
>  46c:	6c 69 6e 65 	xoris   r9,r3,28261
>  470:	3a 25 73 0a 	addi    r17,r5,29450
>  474:	00 00 00 00 	.long 0x0
>  478:	2f 70 72 6f 	cmpdi   cr6,r16,29295
>  47c:	63 2f 64 65 	ori     r15,r25,25701
>  480:	76 69 63 65 	andis.  r9,r19,25445
>  484:	2d 74 72 65 	cmpdi   cr2,r20,29285
>  488:	65 2f 00 00 	oris    r15,r9,0
>  48c:	00 00 00 00 	.long 0x0
> 	...
> 
> Disassembly of section .debug_frame:
> 
> 0000000000000000 <.debug_frame>:
>    0:	00 00 00 0c 	.long 0xc
>    4:	ff ff ff ff 	fnmadd. f31,f31,f31,f31
>    8:	01 00 01 78 	.long 0x1000178
>    c:	41 0c 01 00 	bdnzt-  4*cr3+lt,10c <.debug_frame+0x10c>
>   10:	00 00 00 2c 	.long 0x2c
> 	...
>   24:	00 00 00 d4 	.long 0xd4
>   28:	58 9f 01 9e 	rlmi    r31,r4,r0,6,15
>   2c:	02 9d 03 9c 	.long 0x29d039c
>   30:	04 9b 05 09 	.long 0x49b0509
>   34:	41 00 4c 0e 	bdnzta- lt,4c0c <.comparefunc+0x328c>
>   38:	a0 01 11 41 	lhz     r0,4417(r1)
>   3c:	7e 00 00 00 	cmpw    cr4,r0,r0
>   40:	00 00 00 2c 	.long 0x2c
> 	...
>   4c:	00 00 00 e0 	.long 0xe0
>   50:	00 00 00 00 	.long 0x0
>   54:	00 00 02 4c 	.long 0x24c
>   58:	48 9e 02 09 	bl      9e0260 <bb+0x99ae30>
>   5c:	41 00 54 11 	bdnztl- lt,546c <dtstruct+0x3c>
>   60:	41 7e 9f 01 	bdztl-  4*cr7+eq,ffffffffffff9f60 <bb+0xfffffffffffb4b30>
>   64:	9d 03 9c 04 	stbu    r8,-25596(r3)
>   68:	48 0e 90 01 	bl      e9068 <bb+0xa3c38>
>   6c:	00 00 00 00 	.long 0x0
>   70:	00 00 00 2c 	.long 0x2c
> 	...
>   7c:	00 00 03 30 	.long 0x330
>   80:	00 00 00 00 	.long 0x0
>   84:	00 00 01 4c 	.long 0x14c
>   88:	58 9f 01 9e 	rlmi    r31,r4,r0,6,15
>   8c:	02 9b 05 9d 	.long 0x29b059d
>   90:	03 9c 04 09 	.long 0x39c0409
>   94:	41 00 4c 0e 	bdnzta- lt,4c0c <.comparefunc+0x328c>
>   98:	a0 01 11 41 	lhz     r0,4417(r1)
>   9c:	7e 00 00 00 	cmpw    cr4,r0,r0
>   a0:	00 00 00 2c 	.long 0x2c
> 	...
>   ac:	00 00 04 80 	.long 0x480
>   b0:	00 00 00 00 	.long 0x0
>   b4:	00 00 03 b0 	.long 0x3b0
>   b8:	58 9f 01 9e 	rlmi    r31,r4,r0,6,15
>   bc:	02 9d 03 9c 	.long 0x29d039c
>   c0:	04 9b 05 09 	.long 0x49b0509
>   c4:	41 00 4c 0e 	bdnzta- lt,4c0c <.comparefunc+0x328c>
>   c8:	b0 89 01 11 	sth     r4,273(r9)
>   cc:	41 7e 00 00 	bdzt+   4*cr7+eq,cc <.debug_frame+0xcc>
>   d0:	00 00 00 34 	.long 0x34
> 	...
>   dc:	00 00 08 30 	.long 0x830
>   e0:	00 00 00 00 	.long 0x0
>   e4:	00 00 04 38 	.long 0x438
>   e8:	7c 0e d0 8b 	.long 0x7c0ed08b
>   ec:	01 9f 01 9e 	.long 0x19f019e
>   f0:	02 9c 04 9b 	.long 0x29c049b
>   f4:	05 97 09 96 	.long 0x5970996
>   f8:	0a 95 0b 94 	tdlei   r21,2964
>   fc:	0c 9d 03 9a 	tweqi   r29,922
>  100:	06 99 07 98 	.long 0x6990798
>  104:	08 11 41 7e 	tdi     0,r17,16766
>  108:	00 00 00 3c 	.long 0x3c
> 	...
>  114:	00 00 0c 70 	.long 0xc70
>  118:	00 00 00 00 	.long 0x0
>  11c:	00 00 04 80 	.long 0x480
>  120:	02 50 0e 80 	.long 0x2500e80
>  124:	03 9f 01 9e 	.long 0x39f019e
>  128:	02 9d 03 9c 	.long 0x29d039c
>  12c:	04 9b 05 9a 	.long 0x49b059a
>  130:	06 98 08 96 	.long 0x6980896
>  134:	0a 95 0b 94 	tdlei   r21,2964
>  138:	0c 93 0d 92 	tweqi   r19,3474
>  13c:	0e 91 0f 90 	twlei   r17,3984
>  140:	10 99 07 97 	.long 0x10990797
>  144:	09 11 41 7e 	tdgti   r17,16766
>  148:	00 00 00 34 	.long 0x34
> 	...
>  154:	00 00 10 f0 	.long 0x10f0
>  158:	00 00 00 00 	.long 0x0
>  15c:	00 00 06 4c 	.long 0x64c
>  160:	02 40 0e f0 	.long 0x2400ef0
>  164:	0a 9f 01 9e 	tdlei   r31,414
>  168:	02 9d 03 9c 	.long 0x29d039c
>  16c:	04 9b 05 99 	.long 0x49b0599
>  170:	07 98 08 97 	.long 0x7980897
>  174:	09 11 40 7f 	tdgti   r17,16511
>  178:	96 0a 9a 06 	stwu    r16,-26106(r10)
>  17c:	11 41 7e 00 	vsububs v10,v1,v15
>  180:	00 00 00 2c 	.long 0x2c
> 	...
>  18c:	00 00 17 40 	.long 0x1740
>  190:	00 00 00 00 	.long 0x0
>  194:	00 00 02 3c 	.long 0x23c
>  198:	68 0e b0 01 	xori    r14,r0,45057
>  19c:	9b 05 9f 01 	stb     r24,-24831(r5)
>  1a0:	9e 02 9d 03 	stbu    r16,-25341(r2)
>  1a4:	9c 04 9a 06 	stbu    r0,-26106(r4)
>  1a8:	99 07 11 41 	stb     r8,4417(r7)
>  1ac:	7e 00 00 00 	cmpw    cr4,r0,r0
>  1b0:	00 00 00 24 	.long 0x24
> 	...
>  1bc:	00 00 19 80 	.long 0x1980
>  1c0:	00 00 00 00 	.long 0x0
>  1c4:	00 00 00 c0 	.long 0xc0
>  1c8:	58 0e 90 01 	rlmi.   r14,r0,r18,0,0
>  1cc:	9d 03 9f 01 	stbu    r8,-24831(r3)
>  1d0:	9e 02 11 41 	stbu    r16,4417(r2)
>  1d4:	7e 00 00 00 	cmpw    cr4,r0,r0
> 
> Disassembly of section .debug_loc:
> 
> 0000000000000000 <.debug_loc>:
> 	...
>        c:	00 00 00 24 	.long 0x24
>       10:	00 01 51 00 	.long 0x15100
>       14:	00 00 00 00 	.long 0x0
>       18:	00 00 24 00 	.long 0x2400
>       1c:	00 00 00 00 	.long 0x0
>       20:	00 00 d4 00 	.long 0xd400
>       24:	03 71 a0 01 	.long 0x371a001
> 	...
>       44:	00 00 00 38 	.long 0x38
>       48:	00 01 53 00 	.long 0x15300
>       4c:	00 00 00 00 	.long 0x0
>       50:	00 00 38 00 	.long 0x3800
>       54:	00 00 00 00 	.long 0x0
>       58:	00 00 a4 00 	.long 0xa400
>       5c:	01 6c 00 00 	.long 0x16c0000
>       60:	00 00 00 00 	.long 0x0
>       64:	00 a4 00 00 	.long 0xa40000
>       68:	00 00 00 00 	.long 0x0
>       6c:	00 b8 00 01 	.long 0xb80001
>       70:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>       74:	00 00 00 00 	.long 0x0
>       78:	b8 00 00 00 	lmw     r0,0(0)
>       7c:	00 00 00 00 	.long 0x0
>       80:	d4 00 01 6c 	stfsu   f0,364(0)
> 	...
>       a0:	00 00 00 38 	.long 0x38
>       a4:	00 01 54 00 	.long 0x15400
>       a8:	00 00 00 00 	.long 0x0
>       ac:	00 00 38 00 	.long 0x3800
>       b0:	00 00 00 00 	.long 0x0
>       b4:	00 00 a0 00 	.long 0xa000
>       b8:	01 6b 00 00 	.long 0x16b0000
>       bc:	00 00 00 00 	.long 0x0
>       c0:	00 a0 00 00 	.long 0xa00000
>       c4:	00 00 00 00 	.long 0x0
>       c8:	00 b8 00 01 	.long 0xb80001
>       cc:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>       d0:	00 00 00 00 	.long 0x0
>       d4:	b8 00 00 00 	lmw     r0,0(0)
>       d8:	00 00 00 00 	.long 0x0
>       dc:	d4 00 01 6b 	stfsu   f0,363(0)
> 	...
>       f4:	00 00 00 40 	.long 0x40
>       f8:	00 00 00 00 	.long 0x0
>       fc:	00 00 00 b0 	.long 0xb0
>      100:	00 01 6f 00 	.long 0x16f00
>      104:	00 00 00 00 	.long 0x0
>      108:	00 00 bc 00 	.long 0xbc00
>      10c:	00 00 00 00 	.long 0x0
>      110:	00 00 d4 00 	.long 0xd400
>      114:	01 6f 00 00 	.long 0x16f0000
> 	...
>      12c:	00 e0 00 00 	.long 0xe00000
>      130:	00 00 00 00 	.long 0x0
>      134:	01 04 00 01 	.long 0x1040001
>      138:	51 00 00 00 	rlwimi  r0,r8,0,0,0
>      13c:	00 00 00 01 	.long 0x1
>      140:	04 00 00 00 	.long 0x4000000
>      144:	00 00 00 03 	.long 0x3
>      148:	2c 00 03 71 	cmpwi   r0,881
>      14c:	90 01 00 00 	stw     r0,0(r1)
> 	...
>      164:	00 e0 00 00 	.long 0xe00000
>      168:	00 00 00 00 	.long 0x0
>      16c:	01 0c 00 01 	.long 0x10c0001
>      170:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>      174:	00 00 00 01 	.long 0x1
>      178:	0c 00 00 00 	twi     0,r0,0
>      17c:	00 00 00 01 	.long 0x1
>      180:	7c 00 01 6d 	.long 0x7c00016d
>      184:	00 00 00 00 	.long 0x0
>      188:	00 00 01 8c 	.long 0x18c
>      18c:	00 00 00 00 	.long 0x0
>      190:	00 00 02 34 	.long 0x234
>      194:	00 01 6d 00 	.long 0x16d00
>      198:	00 00 00 00 	.long 0x0
>      19c:	00 02 44 00 	.long 0x24400
>      1a0:	00 00 00 00 	.long 0x0
>      1a4:	00 02 70 00 	.long 0x27000
>      1a8:	01 6d 00 00 	.long 0x16d0000
>      1ac:	00 00 00 00 	.long 0x0
>      1b0:	02 80 00 00 	.long 0x2800000
>      1b4:	00 00 00 00 	.long 0x0
>      1b8:	03 2c 00 01 	.long 0x32c0001
>      1bc:	6d 00 00 00 	xoris   r0,r8,0
> 	...
>      1d4:	e0 00 00 00 	.long 0xe0000000
>      1d8:	00 00 00 01 	.long 0x1
>      1dc:	0c 00 01 54 	twi     0,r0,340
>      1e0:	00 00 00 00 	.long 0x0
>      1e4:	00 00 01 0c 	.long 0x10c
>      1e8:	00 00 00 00 	.long 0x0
>      1ec:	00 00 01 58 	.long 0x158
>      1f0:	00 01 6e 00 	.long 0x16e00
>      1f4:	00 00 00 00 	.long 0x0
>      1f8:	00 01 6c 00 	.long 0x16c00
>      1fc:	00 00 00 00 	.long 0x0
>      200:	00 01 80 00 	.long 0x18000
>      204:	01 6e 00 00 	.long 0x16e0000
>      208:	00 00 00 00 	.long 0x0
>      20c:	01 8c 00 00 	.long 0x18c0000
>      210:	00 00 00 00 	.long 0x0
>      214:	02 10 00 01 	.long 0x2100001
>      218:	6e 00 00 00 	xoris   r0,r16,0
>      21c:	00 00 00 02 	.long 0x2
>      220:	80 00 00 00 	lwz     r0,0(0)
>      224:	00 00 00 03 	.long 0x3
>      228:	2c 00 01 6e 	cmpwi   r0,366
> 	...
>      240:	00 00 00 e0 	.long 0xe0
>      244:	00 00 00 00 	.long 0x0
>      248:	00 00 01 0c 	.long 0x10c
>      24c:	00 01 55 00 	.long 0x15500
>      250:	00 00 00 00 	.long 0x0
>      254:	00 01 0c 00 	.long 0x10c00
>      258:	00 00 00 00 	.long 0x0
>      25c:	00 01 78 00 	.long 0x17800
>      260:	01 6c 00 00 	.long 0x16c0000
>      264:	00 00 00 00 	.long 0x0
>      268:	01 8c 00 00 	.long 0x18c0000
>      26c:	00 00 00 00 	.long 0x0
>      270:	02 30 00 01 	.long 0x2300001
>      274:	6c 00 00 00 	xoris   r0,r0,0
>      278:	00 00 00 02 	.long 0x2
>      27c:	44 00 00 00 	.long 0x44000000
>      280:	00 00 00 02 	.long 0x2
>      284:	6c 00 01 6c 	xoris   r0,r0,364
>      288:	00 00 00 00 	.long 0x0
>      28c:	00 00 02 80 	.long 0x280
>      290:	00 00 00 00 	.long 0x0
>      294:	00 00 03 2c 	.long 0x32c
>      298:	00 01 6c 00 	.long 0x16c00
> 	...
>      2b0:	00 03 30 00 	.long 0x33000
>      2b4:	00 00 00 00 	.long 0x0
>      2b8:	00 03 54 00 	.long 0x35400
>      2bc:	01 51 00 00 	.long 0x1510000
>      2c0:	00 00 00 00 	.long 0x0
>      2c4:	03 54 00 00 	.long 0x3540000
>      2c8:	00 00 00 00 	.long 0x0
>      2cc:	04 7c 00 03 	.long 0x47c0003
>      2d0:	71 a0 01 00 	andi.   r0,r13,256
> 	...
>      2e8:	00 03 30 00 	.long 0x33000
>      2ec:	00 00 00 00 	.long 0x0
>      2f0:	00 03 64 00 	.long 0x36400
>      2f4:	01 53 00 00 	.long 0x1530000
>      2f8:	00 00 00 00 	.long 0x0
>      2fc:	03 64 00 00 	.long 0x3640000
>      300:	00 00 00 00 	.long 0x0
>      304:	03 dc 00 01 	.long 0x3dc0001
>      308:	6c 00 00 00 	xoris   r0,r0,0
>      30c:	00 00 00 03 	.long 0x3
>      310:	f0 00 00 00 	.long 0xf0000000
>      314:	00 00 00 04 	.long 0x4
>      318:	38 00 01 6c 	li      r0,364
>      31c:	00 00 00 00 	.long 0x0
>      320:	00 00 04 4c 	.long 0x44c
>      324:	00 00 00 00 	.long 0x0
>      328:	00 00 04 7c 	.long 0x47c
>      32c:	00 01 6c 00 	.long 0x16c00
> 	...
>      344:	00 03 6c 00 	.long 0x36c00
>      348:	00 00 00 00 	.long 0x0
>      34c:	00 03 94 00 	.long 0x39400
>      350:	01 6f 00 00 	.long 0x16f0000
>      354:	00 00 00 00 	.long 0x0
>      358:	03 94 00 00 	.long 0x3940000
>      35c:	00 00 00 00 	.long 0x0
>      360:	03 a8 00 01 	.long 0x3a80001
>      364:	6d 00 00 00 	xoris   r0,r8,0
>      368:	00 00 00 03 	.long 0x3
>      36c:	a8 00 00 00 	lha     r0,0(0)
>      370:	00 00 00 03 	.long 0x3
>      374:	e8 00 01 6f 	.long 0xe800016f
>      378:	00 00 00 00 	.long 0x0
>      37c:	00 00 03 f0 	.long 0x3f0
>      380:	00 00 00 00 	.long 0x0
>      384:	00 00 04 14 	.long 0x414
>      388:	00 01 6f 00 	.long 0x16f00
>      38c:	00 00 00 00 	.long 0x0
>      390:	00 04 14 00 	.long 0x41400
>      394:	00 00 00 00 	.long 0x0
>      398:	00 04 3c 00 	.long 0x43c00
>      39c:	01 6d 00 00 	.long 0x16d0000
>      3a0:	00 00 00 00 	.long 0x0
>      3a4:	04 3c 00 00 	.long 0x43c0000
>      3a8:	00 00 00 00 	.long 0x0
>      3ac:	04 44 00 01 	.long 0x4440001
>      3b0:	6f 00 00 00 	xoris   r0,r24,0
>      3b4:	00 00 00 04 	.long 0x4
>      3b8:	4c 00 00 00 	mcrf    cr0,cr0
>      3bc:	00 00 00 04 	.long 0x4
>      3c0:	60 00 01 6d 	ori     r0,r0,365
>      3c4:	00 00 00 00 	.long 0x0
>      3c8:	00 00 04 68 	.long 0x468
>      3cc:	00 00 00 00 	.long 0x0
>      3d0:	00 00 04 6c 	.long 0x46c
>      3d4:	00 01 6d 00 	.long 0x16d00
>      3d8:	00 00 00 00 	.long 0x0
>      3dc:	00 04 6c 00 	.long 0x46c00
>      3e0:	00 00 00 00 	.long 0x0
>      3e4:	00 04 7c 00 	.long 0x47c00
>      3e8:	01 6f 00 00 	.long 0x16f0000
> 	...
>      400:	04 80 00 00 	.long 0x4800000
>      404:	00 00 00 00 	.long 0x0
>      408:	04 a4 00 01 	.long 0x4a40001
>      40c:	51 00 00 00 	rlwimi  r0,r8,0,0,0
>      410:	00 00 00 04 	.long 0x4
>      414:	a4 00 00 00 	lhzu    r0,0(0)
>      418:	00 00 00 08 	.long 0x8
>      41c:	30 00 04 71 	addic   r0,r0,1137
>      420:	b0 89 01 00 	sth     r4,256(r9)
> 	...
>      438:	00 04 80 00 	.long 0x48000
>      43c:	00 00 00 00 	.long 0x0
>      440:	00 04 bc 00 	.long 0x4bc00
>      444:	01 53 00 00 	.long 0x1530000
>      448:	00 00 00 00 	.long 0x0
>      44c:	04 bc 00 00 	.long 0x4bc0000
>      450:	00 00 00 00 	.long 0x0
>      454:	06 c8 00 01 	.long 0x6c80001
>      458:	6b 00 00 00 	xori    r0,r24,0
>      45c:	00 00 00 06 	.long 0x6
>      460:	fc 00 00 00 	fcmpu   cr0,f0,f0
>      464:	00 00 00 07 	.long 0x7
>      468:	08 00 01 6b 	tdi     0,r0,363
>      46c:	00 00 00 00 	.long 0x0
>      470:	00 00 07 20 	.long 0x720
>      474:	00 00 00 00 	.long 0x0
>      478:	00 00 07 38 	.long 0x738
>      47c:	00 01 6b 00 	.long 0x16b00
>      480:	00 00 00 00 	.long 0x0
>      484:	00 07 9c 00 	.long 0x79c00
>      488:	00 00 00 00 	.long 0x0
>      48c:	00 08 30 00 	.long 0x83000
>      490:	01 6b 00 00 	.long 0x16b0000
> 	...
>      4a8:	04 80 00 00 	.long 0x4800000
>      4ac:	00 00 00 00 	.long 0x0
>      4b0:	04 b4 00 01 	.long 0x4b40001
>      4b4:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      4b8:	00 00 00 04 	.long 0x4
>      4bc:	b4 00 00 00 	sthu    r0,0(0)
>      4c0:	00 00 00 05 	.long 0x5
>      4c4:	30 00 01 6f 	addic   r0,r0,367
>      4c8:	00 00 00 00 	.long 0x0
>      4cc:	00 00 06 fc 	.long 0x6fc
>      4d0:	00 00 00 00 	.long 0x0
>      4d4:	00 00 07 18 	.long 0x718
>      4d8:	00 01 6f 00 	.long 0x16f00
>      4dc:	00 00 00 00 	.long 0x0
>      4e0:	00 07 cc 00 	.long 0x7cc00
>      4e4:	00 00 00 00 	.long 0x0
>      4e8:	00 08 30 00 	.long 0x83000
>      4ec:	01 6f 00 00 	.long 0x16f0000
> 	...
>      504:	05 90 00 00 	.long 0x5900000
>      508:	00 00 00 00 	.long 0x0
>      50c:	06 5c 00 01 	.long 0x65c0001
>      510:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      514:	00 00 00 06 	.long 0x6
>      518:	5c 00 00 00 	rlwnm   r0,r0,r0,0,0
>      51c:	00 00 00 06 	.long 0x6
>      520:	68 00 01 50 	xori    r0,r0,336
>      524:	00 00 00 00 	.long 0x0
>      528:	00 00 06 68 	.long 0x668
>      52c:	00 00 00 00 	.long 0x0
>      530:	00 00 06 cc 	.long 0x6cc
>      534:	00 01 54 00 	.long 0x15400
>      538:	00 00 00 00 	.long 0x0
>      53c:	00 07 20 00 	.long 0x72000
>      540:	00 00 00 00 	.long 0x0
>      544:	00 07 60 00 	.long 0x76000
>      548:	01 54 00 00 	.long 0x1540000
>      54c:	00 00 00 00 	.long 0x0
>      550:	07 bc 00 00 	.long 0x7bc0000
>      554:	00 00 00 00 	.long 0x0
>      558:	07 cc 00 01 	.long 0x7cc0001
>      55c:	54 00 00 00 	rlwinm  r0,r0,0,0,0
> 	...
>      570:	00 00 00 05 	.long 0x5
>      574:	bc 00 00 00 	stmw    r0,0(0)
>      578:	00 00 00 06 	.long 0x6
>      57c:	2c 00 01 58 	cmpwi   r0,344
>      580:	00 00 00 00 	.long 0x0
>      584:	00 00 06 2c 	.long 0x62c
>      588:	00 00 00 00 	.long 0x0
>      58c:	00 00 06 7c 	.long 0x67c
>      590:	00 01 5b 00 	.long 0x15b00
>      594:	00 00 00 00 	.long 0x0
>      598:	00 06 7c 00 	.long 0x67c00
>      59c:	00 00 00 00 	.long 0x0
>      5a0:	00 06 cc 00 	.long 0x6cc00
>      5a4:	01 58 00 00 	.long 0x1580000
>      5a8:	00 00 00 00 	.long 0x0
>      5ac:	07 20 00 00 	.long 0x7200000
>      5b0:	00 00 00 00 	.long 0x0
>      5b4:	07 60 00 01 	.long 0x7600001
>      5b8:	58 00 00 00 	rlmi    r0,r0,r0,0,0
> 	...
>      5cc:	00 00 00 05 	.long 0x5
>      5d0:	bc 00 00 00 	stmw    r0,0(0)
>      5d4:	00 00 00 06 	.long 0x6
>      5d8:	cc 00 01 57 	lfdu    f0,343(0)
>      5dc:	00 00 00 00 	.long 0x0
>      5e0:	00 00 07 20 	.long 0x720
>      5e4:	00 00 00 00 	.long 0x0
>      5e8:	00 00 07 60 	.long 0x760
>      5ec:	00 01 57 00 	.long 0x15700
> 	...
>      604:	00 05 a8 00 	.long 0x5a800
>      608:	00 00 00 00 	.long 0x0
>      60c:	00 05 d0 00 	.long 0x5d000
>      610:	01 5a 00 00 	.long 0x15a0000
>      614:	00 00 00 00 	.long 0x0
>      618:	05 d8 00 00 	.long 0x5d80000
>      61c:	00 00 00 00 	.long 0x0
>      620:	05 e8 00 01 	.long 0x5e80001
>      624:	5b 00 00 00 	rlmi    r0,r24,r0,0,0
>      628:	00 00 00 05 	.long 0x5
>      62c:	f0 00 00 00 	.long 0xf0000000
>      630:	00 00 00 06 	.long 0x6
>      634:	44 00 01 5a 	sc      10
>      638:	00 00 00 00 	.long 0x0
>      63c:	00 00 06 44 	.long 0x644
>      640:	00 00 00 00 	.long 0x0
>      644:	00 00 06 78 	.long 0x678
>      648:	00 01 58 00 	.long 0x15800
>      64c:	00 00 00 00 	.long 0x0
>      650:	00 06 78 00 	.long 0x67800
>      654:	00 00 00 00 	.long 0x0
>      658:	00 06 cc 00 	.long 0x6cc00
>      65c:	01 5a 00 00 	.long 0x15a0000
>      660:	00 00 00 00 	.long 0x0
>      664:	07 20 00 00 	.long 0x7200000
>      668:	00 00 00 00 	.long 0x0
>      66c:	07 60 00 01 	.long 0x7600001
>      670:	5a 00 00 00 	rlmi    r0,r16,r0,0,0
> 	...
>      684:	00 00 00 08 	.long 0x8
>      688:	30 00 00 00 	addic   r0,r0,0
>      68c:	00 00 00 08 	.long 0x8
>      690:	6c 00 01 51 	xoris   r0,r0,337
>      694:	00 00 00 00 	.long 0x0
>      698:	00 00 08 6c 	.long 0x86c
>      69c:	00 00 00 00 	.long 0x0
>      6a0:	00 00 0c 68 	.long 0xc68
>      6a4:	00 04 71 d0 	.long 0x471d0
>      6a8:	8b 01 00 00 	lbz     r24,0(r1)
> 	...
>      6c0:	08 30 00 00 	tdlgti  r16,0
>      6c4:	00 00 00 00 	.long 0x0
>      6c8:	08 84 00 01 	tdeqi   r4,1
>      6cc:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>      6d0:	00 00 00 08 	.long 0x8
>      6d4:	84 00 00 00 	lwzu    r0,0(0)
>      6d8:	00 00 00 08 	.long 0x8
>      6dc:	ec 00 01 69 	.long 0xec000169
>      6e0:	00 00 00 00 	.long 0x0
>      6e4:	00 00 09 0c 	.long 0x90c
>      6e8:	00 00 00 00 	.long 0x0
>      6ec:	00 00 0b d4 	.long 0xbd4
>      6f0:	00 01 69 00 	.long 0x16900
>      6f4:	00 00 00 00 	.long 0x0
>      6f8:	00 0b f4 00 	.long 0xbf400
>      6fc:	00 00 00 00 	.long 0x0
>      700:	00 0c 68 00 	.long 0xc6800
>      704:	01 69 00 00 	.long 0x1690000
> 	...
>      71c:	09 6c 00 00 	tdi     11,r12,0
>      720:	00 00 00 00 	.long 0x0
>      724:	0b 34 00 01 	tdi     25,r20,1
>      728:	6d 00 00 00 	xoris   r0,r8,0
> 	...
>      73c:	00 00 00 09 	.long 0x9
>      740:	6c 00 00 00 	xoris   r0,r0,0
>      744:	00 00 00 0a 	.long 0xa
>      748:	60 00 01 6c 	ori     r0,r0,364
>      74c:	00 00 00 00 	.long 0x0
>      750:	00 00 0a 60 	.long 0xa60
>      754:	00 00 00 00 	.long 0x0
>      758:	00 00 0a 6c 	.long 0xa6c
>      75c:	00 01 50 00 	.long 0x15000
>      760:	00 00 00 00 	.long 0x0
>      764:	00 0a 6c 00 	.long 0xa6c00
>      768:	00 00 00 00 	.long 0x0
>      76c:	00 0b 58 00 	.long 0xb5800
>      770:	01 6c 00 00 	.long 0x16c0000
> 	...
>      788:	09 c0 00 00 	tdi     14,r0,0
>      78c:	00 00 00 00 	.long 0x0
>      790:	0a cc 00 01 	tdi     22,r12,1
>      794:	57 00 00 00 	rlwinm  r0,r24,0,0,0
>      798:	00 00 00 0b 	.long 0xb
>      79c:	30 00 00 00 	addic   r0,r0,0
>      7a0:	00 00 00 0b 	.long 0xb
>      7a4:	74 00 01 57 	andis.  r0,r0,343
> 	...
>      7bc:	00 00 09 c0 	.long 0x9c0
>      7c0:	00 00 00 00 	.long 0x0
>      7c4:	00 00 09 d4 	.long 0x9d4
>      7c8:	00 01 58 00 	.long 0x15800
>      7cc:	00 00 00 00 	.long 0x0
>      7d0:	00 09 fc 00 	.long 0x9fc00
>      7d4:	00 00 00 00 	.long 0x0
>      7d8:	00 0a 94 00 	.long 0xa9400
>      7dc:	01 58 00 00 	.long 0x1580000
> 	...
>      7f4:	09 50 00 00 	tdi     10,r16,0
>      7f8:	00 00 00 00 	.long 0x0
>      7fc:	09 98 00 01 	tdgei   r24,1
>      800:	6e 00 00 00 	xoris   r0,r16,0
>      804:	00 00 00 09 	.long 0x9
>      808:	98 00 00 00 	stb     r0,0(0)
>      80c:	00 00 00 09 	.long 0x9
>      810:	d0 00 01 5a 	stfs    f0,346(0)
>      814:	00 00 00 00 	.long 0x0
>      818:	00 00 09 dc 	.long 0x9dc
>      81c:	00 00 00 00 	.long 0x0
>      820:	00 00 09 f0 	.long 0x9f0
>      824:	00 01 5b 00 	.long 0x15b00
>      828:	00 00 00 00 	.long 0x0
>      82c:	00 09 f8 00 	.long 0x9f800
>      830:	00 00 00 00 	.long 0x0
>      834:	00 0a 48 00 	.long 0xa4800
>      838:	01 5a 00 00 	.long 0x15a0000
>      83c:	00 00 00 00 	.long 0x0
>      840:	0a 48 00 00 	tdi     18,r8,0
>      844:	00 00 00 00 	.long 0x0
>      848:	0a 70 00 01 	tdi     19,r16,1
>      84c:	5b 00 00 00 	rlmi    r0,r24,r0,0,0
>      850:	00 00 00 0a 	.long 0xa
>      854:	84 00 00 00 	lwzu    r0,0(0)
>      858:	00 00 00 0a 	.long 0xa
>      85c:	b4 00 01 5a 	sthu    r0,346(0)
>      860:	00 00 00 00 	.long 0x0
>      864:	00 00 0a b4 	.long 0xab4
>      868:	00 00 00 00 	.long 0x0
>      86c:	00 00 0b 70 	.long 0xb70
>      870:	00 01 6e 00 	.long 0x16e00
>      874:	00 00 00 00 	.long 0x0
>      878:	00 0b 70 00 	.long 0xb7000
>      87c:	00 00 00 00 	.long 0x0
>      880:	00 0b 74 00 	.long 0xb7400
>      884:	01 5a 00 00 	.long 0x15a0000
> 	...
>      89c:	09 58 00 00 	tdi     10,r24,0
>      8a0:	00 00 00 00 	.long 0x0
>      8a4:	0b e0 00 01 	tdi     31,r0,1
>      8a8:	6b 00 00 00 	xori    r0,r24,0
> 	...
>      8bc:	00 00 00 09 	.long 0x9
>      8c0:	ac 00 00 00 	lhau    r0,0(0)
>      8c4:	00 00 00 0a 	.long 0xa
>      8c8:	c0 00 01 55 	lfs     f0,341(0)
>      8cc:	00 00 00 00 	.long 0x0
>      8d0:	00 00 0b 30 	.long 0xb30
>      8d4:	00 00 00 00 	.long 0x0
>      8d8:	00 00 0b 74 	.long 0xb74
>      8dc:	00 01 55 00 	.long 0x15500
> 	...
>      8f4:	00 0c 70 00 	.long 0xc7000
>      8f8:	00 00 00 00 	.long 0x0
>      8fc:	00 0c c0 00 	.long 0xcc000
>      900:	01 51 00 00 	.long 0x1510000
>      904:	00 00 00 00 	.long 0x0
>      908:	0c c0 00 00 	twllei  r0,0
>      90c:	00 00 00 00 	.long 0x0
>      910:	10 f0 00 03 	.long 0x10f00003
>      914:	71 80 03 00 	andi.   r0,r12,768
> 	...
>      92c:	00 0c 70 00 	.long 0xc7000
>      930:	00 00 00 00 	.long 0x0
>      934:	00 0c cc 00 	.long 0xccc00
>      938:	01 53 00 00 	.long 0x1530000
>      93c:	00 00 00 00 	.long 0x0
>      940:	0c cc 00 00 	twllei  r12,0
>      944:	00 00 00 00 	.long 0x0
>      948:	0d fc 00 01 	twi     15,r28,1
>      94c:	69 00 00 00 	xori    r0,r8,0
>      950:	00 00 00 0e 	.long 0xe
>      954:	18 00 00 00 	.long 0x18000000
>      958:	00 00 00 10 	.long 0x10
>      95c:	f0 00 01 69 	.long 0xf0000169
> 	...
>      974:	00 00 0c 70 	.long 0xc70
>      978:	00 00 00 00 	.long 0x0
>      97c:	00 00 0c f8 	.long 0xcf8
>      980:	00 01 54 00 	.long 0x15400
>      984:	00 00 00 00 	.long 0x0
>      988:	00 0d 54 00 	.long 0xd5400
>      98c:	00 00 00 00 	.long 0x0
>      990:	00 0d 64 00 	.long 0xd6400
>      994:	01 54 00 00 	.long 0x1540000
>      998:	00 00 00 00 	.long 0x0
>      99c:	0d ac 00 00 	twi     13,r12,0
>      9a0:	00 00 00 00 	.long 0x0
>      9a4:	0d bc 00 01 	twi     13,r28,1
>      9a8:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      9ac:	00 00 00 10 	.long 0x10
>      9b0:	c0 00 00 00 	lfs     f0,0(0)
>      9b4:	00 00 00 10 	.long 0x10
>      9b8:	c8 00 01 54 	lfd     f0,340(0)
> 	...
>      9d0:	00 00 0c 70 	.long 0xc70
>      9d4:	00 00 00 00 	.long 0x0
>      9d8:	00 00 0c cc 	.long 0xccc
>      9dc:	00 01 55 00 	.long 0x15500
>      9e0:	00 00 00 00 	.long 0x0
>      9e4:	00 0c cc 00 	.long 0xccc00
>      9e8:	00 00 00 00 	.long 0x0
>      9ec:	00 0d f4 00 	.long 0xdf400
>      9f0:	01 67 00 00 	.long 0x1670000
>      9f4:	00 00 00 00 	.long 0x0
>      9f8:	0e 18 00 00 	twlti   r24,0
>      9fc:	00 00 00 00 	.long 0x0
>      a00:	10 f0 00 01 	.long 0x10f00001
>      a04:	67 00 00 00 	oris    r0,r24,0
> 	...
>      a18:	00 00 00 0c 	.long 0xc
>      a1c:	f8 00 00 00 	std     r0,0(0)
>      a20:	00 00 00 0e 	.long 0xe
>      a24:	14 00 01 6f 	.long 0x1400016f
>      a28:	00 00 00 00 	.long 0x0
>      a2c:	00 00 0e 18 	.long 0xe18
>      a30:	00 00 00 00 	.long 0x0
>      a34:	00 00 10 c0 	.long 0x10c0
>      a38:	00 01 6f 00 	.long 0x16f00
>      a3c:	00 00 00 00 	.long 0x0
>      a40:	00 10 c8 00 	.long 0x10c800
>      a44:	00 00 00 00 	.long 0x0
>      a48:	00 10 f0 00 	.long 0x10f000
>      a4c:	01 6f 00 00 	.long 0x16f0000
> 	...
>      a64:	0c dc 00 00 	twllei  r28,0
>      a68:	00 00 00 00 	.long 0x0
>      a6c:	0e 04 00 01 	twlti   r4,1
>      a70:	6b 00 00 00 	xori    r0,r24,0
>      a74:	00 00 00 0e 	.long 0xe
>      a78:	18 00 00 00 	.long 0x18000000
>      a7c:	00 00 00 10 	.long 0x10
>      a80:	c0 00 01 6b 	lfs     f0,363(0)
>      a84:	00 00 00 00 	.long 0x0
>      a88:	00 00 10 c8 	.long 0x10c8
>      a8c:	00 00 00 00 	.long 0x0
>      a90:	00 00 10 f0 	.long 0x10f0
>      a94:	00 01 6b 00 	.long 0x16b00
> 	...
>      aac:	00 0c f8 00 	.long 0xcf800
>      ab0:	00 00 00 00 	.long 0x0
>      ab4:	00 0e 0c 00 	.long 0xe0c00
>      ab8:	01 6d 00 00 	.long 0x16d0000
>      abc:	00 00 00 00 	.long 0x0
>      ac0:	0e 18 00 00 	twlti   r24,0
>      ac4:	00 00 00 00 	.long 0x0
>      ac8:	0f 3c 00 01 	twi     25,r28,1
>      acc:	6d 00 00 00 	xoris   r0,r8,0
>      ad0:	00 00 00 0f 	.long 0xf
>      ad4:	90 00 00 00 	stw     r0,0(0)
>      ad8:	00 00 00 0f 	.long 0xf
>      adc:	94 00 01 53 	stwu    r0,339(0)
>      ae0:	00 00 00 00 	.long 0x0
>      ae4:	00 00 10 c8 	.long 0x10c8
>      ae8:	00 00 00 00 	.long 0x0
>      aec:	00 00 10 f0 	.long 0x10f0
>      af0:	00 01 6d 00 	.long 0x16d00
> 	...
>      b08:	00 0c f8 00 	.long 0xcf800
>      b0c:	00 00 00 00 	.long 0x0
>      b10:	00 0d e0 00 	.long 0xde000
>      b14:	01 63 00 00 	.long 0x1630000
>      b18:	00 00 00 00 	.long 0x0
>      b1c:	0e 18 00 00 	twlti   r24,0
>      b20:	00 00 00 00 	.long 0x0
>      b24:	10 c0 00 01 	.long 0x10c00001
>      b28:	63 00 00 00 	ori     r0,r24,0
>      b2c:	00 00 00 10 	.long 0x10
>      b30:	c8 00 00 00 	lfd     f0,0(0)
>      b34:	00 00 00 10 	.long 0x10
>      b38:	f0 00 01 63 	.long 0xf0000163
> 	...
>      b50:	00 00 10 f0 	.long 0x10f0
>      b54:	00 00 00 00 	.long 0x0
>      b58:	00 00 11 30 	.long 0x1130
>      b5c:	00 01 51 00 	.long 0x15100
>      b60:	00 00 00 00 	.long 0x0
>      b64:	00 11 30 00 	.long 0x113000
>      b68:	00 00 00 00 	.long 0x0
>      b6c:	00 17 3c 00 	.long 0x173c00
>      b70:	03 71 f0 0a 	.long 0x371f00a
> 	...
>      b88:	00 00 12 08 	.long 0x1208
>      b8c:	00 00 00 00 	.long 0x0
>      b90:	00 00 13 74 	.long 0x1374
>      b94:	00 01 6f 00 	.long 0x16f00
>      b98:	00 00 00 00 	.long 0x0
>      b9c:	00 13 78 00 	.long 0x137800
>      ba0:	00 00 00 00 	.long 0x0
>      ba4:	00 15 b8 00 	.long 0x15b800
>      ba8:	01 6f 00 00 	.long 0x16f0000
>      bac:	00 00 00 00 	.long 0x0
>      bb0:	16 0c 00 00 	.long 0x160c0000
>      bb4:	00 00 00 00 	.long 0x0
>      bb8:	17 3c 00 01 	.long 0x173c0001
>      bbc:	6f 00 00 00 	xoris   r0,r24,0
> 	...
>      bd0:	00 00 00 11 	.long 0x11
>      bd4:	dc 00 00 00 	stfdu   f0,0(0)
>      bd8:	00 00 00 13 	.long 0x13
>      bdc:	48 00 01 66 	ba      164 <.debug_loc+0x164>
>      be0:	00 00 00 00 	.long 0x0
>      be4:	00 00 13 78 	.long 0x1378
>      be8:	00 00 00 00 	.long 0x0
>      bec:	00 00 15 b8 	.long 0x15b8
>      bf0:	00 01 66 00 	.long 0x16600
>      bf4:	00 00 00 00 	.long 0x0
>      bf8:	00 16 0c 00 	.long 0x160c00
>      bfc:	00 00 00 00 	.long 0x0
>      c00:	00 17 3c 00 	.long 0x173c00
>      c04:	01 66 00 00 	.long 0x1660000
> 	...
>      c1c:	12 00 00 00 	vaddubm v16,v0,v0
>      c20:	00 00 00 00 	.long 0x0
>      c24:	15 b8 00 03 	.long 0x15b80003
>      c28:	91 80 76 00 	stw     r12,30208(0)
>      c2c:	00 00 00 00 	.long 0x0
>      c30:	00 16 0c 00 	.long 0x160c00
>      c34:	00 00 00 00 	.long 0x0
>      c38:	00 17 3c 00 	.long 0x173c00
>      c3c:	03 91 80 76 	.long 0x3918076
> 	...
>      c54:	00 00 11 b8 	.long 0x11b8
>      c58:	00 00 00 00 	.long 0x0
>      c5c:	00 00 11 bc 	.long 0x11bc
>      c60:	00 01 53 00 	.long 0x15300
>      c64:	00 00 00 00 	.long 0x0
>      c68:	00 13 78 00 	.long 0x137800
>      c6c:	00 00 00 00 	.long 0x0
>      c70:	00 17 3c 00 	.long 0x173c00
>      c74:	01 69 00 00 	.long 0x1690000
> 	...
>      c8c:	12 48 00 00 	vaddubm v18,v8,v0
>      c90:	00 00 00 00 	.long 0x0
>      c94:	13 64 00 01 	.long 0x13640001
>      c98:	6c 00 00 00 	xoris   r0,r0,0
>      c9c:	00 00 00 14 	.long 0x14
>      ca0:	88 00 00 00 	lbz     r0,0(0)
>      ca4:	00 00 00 14 	.long 0x14
>      ca8:	d0 00 01 6c 	stfs    f0,364(0)
> 	...
>      cc0:	00 00 12 3c 	.long 0x123c
>      cc4:	00 00 00 00 	.long 0x0
>      cc8:	00 00 13 78 	.long 0x1378
>      ccc:	00 03 91 88 	.long 0x39188
>      cd0:	76 00 00 00 	andis.  r0,r16,0
>      cd4:	00 00 00 13 	.long 0x13
>      cd8:	84 00 00 00 	lwzu    r0,0(0)
>      cdc:	00 00 00 14 	.long 0x14
>      ce0:	5c 00 03 71 	rlwnm.  r0,r0,r0,13,24
>      ce4:	f8 00 00 00 	std     r0,0(0)
>      ce8:	00 00 00 00 	.long 0x0
>      cec:	14 5c 00 00 	.long 0x145c0000
>      cf0:	00 00 00 00 	.long 0x0
>      cf4:	14 6c 00 03 	.long 0x146c0003
>      cf8:	91 88 76 00 	stw     r12,30208(r8)
>      cfc:	00 00 00 00 	.long 0x0
>      d00:	00 14 6c 00 	.long 0x146c00
>      d04:	00 00 00 00 	.long 0x0
>      d08:	00 14 88 00 	.long 0x148800
>      d0c:	03 71 f8 00 	.long 0x371f800
>      d10:	00 00 00 00 	.long 0x0
>      d14:	00 00 14 88 	.long 0x1488
>      d18:	00 00 00 00 	.long 0x0
>      d1c:	00 00 14 d0 	.long 0x14d0
>      d20:	00 03 91 88 	.long 0x39188
>      d24:	76 00 00 00 	andis.  r0,r16,0
>      d28:	00 00 00 16 	.long 0x16
>      d2c:	0c 00 00 00 	twi     0,r0,0
>      d30:	00 00 00 16 	.long 0x16
>      d34:	90 00 03 71 	stw     r0,881(0)
>      d38:	f8 00 00 00 	std     r0,0(0)
>      d3c:	00 00 00 00 	.long 0x0
>      d40:	16 90 00 00 	.long 0x16900000
>      d44:	00 00 00 00 	.long 0x0
>      d48:	16 9c 00 01 	.long 0x169c0001
>      d4c:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>      d50:	00 00 00 16 	.long 0x16
>      d54:	9c 00 00 00 	stbu    r0,0(0)
>      d58:	00 00 00 17 	.long 0x17
>      d5c:	04 00 03 91 	.long 0x4000391
>      d60:	88 76 00 00 	lbz     r3,0(r22)
>      d64:	00 00 00 00 	.long 0x0
>      d68:	17 04 00 00 	.long 0x17040000
>      d6c:	00 00 00 00 	.long 0x0
>      d70:	17 10 00 01 	.long 0x17100001
>      d74:	50 00 00 00 	rlwimi  r0,r0,0,0,0
>      d78:	00 00 00 17 	.long 0x17
>      d7c:	10 00 00 00 	vaddubm v0,v0,v0
>      d80:	00 00 00 17 	.long 0x17
>      d84:	1c 00 03 91 	mulli   r0,r0,913
>      d88:	88 76 00 00 	lbz     r3,0(r22)
>      d8c:	00 00 00 00 	.long 0x0
>      d90:	17 1c 00 00 	.long 0x171c0000
>      d94:	00 00 00 00 	.long 0x0
>      d98:	17 3c 00 03 	.long 0x173c0003
>      d9c:	71 f8 00 00 	andi.   r24,r15,0
> 	...
>      db4:	00 14 00 00 	.long 0x140000
>      db8:	00 00 00 00 	.long 0x0
>      dbc:	00 14 10 00 	.long 0x141000
>      dc0:	01 53 00 00 	.long 0x1530000
>      dc4:	00 00 00 00 	.long 0x0
>      dc8:	14 6c 00 00 	.long 0x146c0000
>      dcc:	00 00 00 00 	.long 0x0
>      dd0:	14 7c 00 01 	.long 0x147c0001
>      dd4:	53 00 00 00 	rlwimi  r0,r24,0,0,0
>      dd8:	00 00 00 16 	.long 0x16
>      ddc:	48 00 00 00 	b       ddc <.debug_loc+0xddc>
>      de0:	00 00 00 16 	.long 0x16
>      de4:	4c 00 01 53 	.long 0x4c000153
> 	...
>      dfc:	00 00 12 3c 	.long 0x123c
>      e00:	00 00 00 00 	.long 0x0
>      e04:	00 00 13 78 	.long 0x1378
>      e08:	00 03 91 90 	.long 0x39190
>      e0c:	76 00 00 00 	andis.  r0,r16,0
>      e10:	00 00 00 13 	.long 0x13
>      e14:	b4 00 00 00 	sthu    r0,0(0)
>      e18:	00 00 00 14 	.long 0x14
>      e1c:	40 00 03 71 	bdnzfl- lt,118c <.putnode+0x9c>
>      e20:	80 01 00 00 	lwz     r0,0(r1)
>      e24:	00 00 00 00 	.long 0x0
>      e28:	14 40 00 00 	.long 0x14400000
>      e2c:	00 00 00 00 	.long 0x0
>      e30:	14 6c 00 03 	.long 0x146c0003
>      e34:	91 90 76 00 	stw     r12,30208(r16)
>      e38:	00 00 00 00 	.long 0x0
>      e3c:	00 14 6c 00 	.long 0x146c00
>      e40:	00 00 00 00 	.long 0x0
>      e44:	00 14 70 00 	.long 0x147000
>      e48:	03 71 80 01 	.long 0x3718001
>      e4c:	00 00 00 00 	.long 0x0
>      e50:	00 00 14 70 	.long 0x1470
>      e54:	00 00 00 00 	.long 0x0
>      e58:	00 00 14 d0 	.long 0x14d0
>      e5c:	00 03 91 90 	.long 0x39190
>      e60:	76 00 00 00 	andis.  r0,r16,0
>      e64:	00 00 00 16 	.long 0x16
>      e68:	48 00 00 00 	b       e68 <.debug_loc+0xe68>
>      e6c:	00 00 00 17 	.long 0x17
>      e70:	1c 00 03 91 	mulli   r0,r0,913
>      e74:	90 76 00 00 	stw     r3,0(r22)
>      e78:	00 00 00 00 	.long 0x0
>      e7c:	17 1c 00 00 	.long 0x171c0000
>      e80:	00 00 00 00 	.long 0x0
>      e84:	17 3c 00 03 	.long 0x173c0003
>      e88:	71 80 01 00 	andi.   r0,r12,256
> 	...
>      ea0:	00 14 54 00 	.long 0x145400
>      ea4:	00 00 00 00 	.long 0x0
>      ea8:	00 14 70 00 	.long 0x147000
>      eac:	01 6c 00 00 	.long 0x16c0000
>      eb0:	00 00 00 00 	.long 0x0
>      eb4:	17 04 00 00 	.long 0x17040000
>      eb8:	00 00 00 00 	.long 0x0
>      ebc:	17 1c 00 01 	.long 0x171c0001
>      ec0:	6c 00 00 00 	xoris   r0,r0,0
> 	...
>      ed4:	00 00 00 12 	.long 0x12
>      ed8:	24 00 00 00 	dozi    r0,r0,0
>      edc:	00 00 00 14 	.long 0x14
>      ee0:	d0 00 03 91 	stfs    f0,913(0)
>      ee4:	88 76 00 00 	lbz     r3,0(r22)
>      ee8:	00 00 00 00 	.long 0x0
>      eec:	15 84 00 00 	.long 0x15840000
>      ef0:	00 00 00 00 	.long 0x0
>      ef4:	15 b8 00 03 	.long 0x15b80003
>      ef8:	71 f8 00 00 	andi.   r24,r15,0
>      efc:	00 00 00 00 	.long 0x0
>      f00:	00 16 0c 00 	.long 0x160c00
>      f04:	00 00 00 00 	.long 0x0
>      f08:	00 17 3c 00 	.long 0x173c00
>      f0c:	03 91 88 76 	.long 0x3918876
> 	...
>      f24:	00 00 17 40 	.long 0x1740
>      f28:	00 00 00 00 	.long 0x0
>      f2c:	00 00 17 68 	.long 0x1768
>      f30:	00 01 51 00 	.long 0x15100
>      f34:	00 00 00 00 	.long 0x0
>      f38:	00 17 68 00 	.long 0x176800
>      f3c:	00 00 00 00 	.long 0x0
>      f40:	00 19 7c 00 	.long 0x197c00
>      f44:	03 71 b0 01 	.long 0x371b001
> 	...
>      f5c:	00 00 17 40 	.long 0x1740
>      f60:	00 00 00 00 	.long 0x0
>      f64:	00 00 17 88 	.long 0x1788
>      f68:	00 01 53 00 	.long 0x15300
>      f6c:	00 00 00 00 	.long 0x0
>      f70:	00 17 88 00 	.long 0x178800
>      f74:	00 00 00 00 	.long 0x0
>      f78:	00 18 b0 00 	.long 0x18b000
>      f7c:	01 6c 00 00 	.long 0x16c0000
> 	...
>      f94:	17 40 00 00 	.long 0x17400000
>      f98:	00 00 00 00 	.long 0x0
>      f9c:	17 b0 00 01 	.long 0x17b00001
>      fa0:	54 00 00 00 	rlwinm  r0,r0,0,0,0
>      fa4:	00 00 00 17 	.long 0x17
>      fa8:	b0 00 00 00 	sth     r0,0(0)
>      fac:	00 00 00 19 	.long 0x19
>      fb0:	50 00 01 69 	rlwimi. r0,r0,0,5,20
> 	...
>      fc8:	00 00 17 40 	.long 0x1740
>      fcc:	00 00 00 00 	.long 0x0
>      fd0:	00 00 17 b0 	.long 0x17b0
>      fd4:	00 01 55 00 	.long 0x15500
>      fd8:	00 00 00 00 	.long 0x0
>      fdc:	00 17 b0 00 	.long 0x17b000
>      fe0:	00 00 00 00 	.long 0x0
>      fe4:	00 17 e4 00 	.long 0x17e400
>      fe8:	01 6e 00 00 	.long 0x16e0000
> 	...
>     1000:	17 e8 00 00 	.long 0x17e80000
>     1004:	00 00 00 00 	.long 0x0
>     1008:	18 4c 00 01 	.long 0x184c0001
>     100c:	5b 00 00 00 	rlmi    r0,r24,r0,0,0
>     1010:	00 00 00 18 	.long 0x18
>     1014:	5c 00 00 00 	rlwnm   r0,r0,r0,0,0
>     1018:	00 00 00 18 	.long 0x18
>     101c:	6c 00 01 53 	xoris   r0,r0,339
> 	...
>     1034:	00 00 18 f0 	.long 0x18f0
>     1038:	00 00 00 00 	.long 0x0
>     103c:	00 00 19 60 	.long 0x1960
>     1040:	00 01 6d 00 	.long 0x16d00
> 	...
>     1058:	00 19 80 00 	.long 0x198000
>     105c:	00 00 00 00 	.long 0x0
>     1060:	00 19 98 00 	.long 0x199800
>     1064:	01 51 00 00 	.long 0x1510000
>     1068:	00 00 00 00 	.long 0x0
>     106c:	19 98 00 00 	.long 0x19980000
>     1070:	00 00 00 00 	.long 0x0
>     1074:	1a 40 00 03 	.long 0x1a400003
>     1078:	71 90 01 00 	andi.   r16,r12,256
> 	...
>     1090:	00 19 80 00 	.long 0x198000
>     1094:	00 00 00 00 	.long 0x0
>     1098:	00 19 b0 00 	.long 0x19b000
>     109c:	01 53 00 00 	.long 0x1530000
> 	...
>     10b4:	19 80 00 00 	.long 0x19800000
>     10b8:	00 00 00 00 	.long 0x0
>     10bc:	19 a4 00 01 	.long 0x19a40001
>     10c0:	54 00 00 00 	rlwinm  r0,r0,0,0,0
> 	...
>     10d4:	00 00 00 19 	.long 0x19
>     10d8:	a8 00 00 00 	lha     r0,0(0)
>     10dc:	00 00 00 1a 	.long 0x1a
>     10e0:	2c 00 01 6f 	cmpwi   r0,367
> 	...
>     10f8:	00 00 19 ac 	.long 0x19ac
>     10fc:	00 00 00 00 	.long 0x0
>     1100:	00 00 1a 28 	.long 0x1a28
>     1104:	00 01 6e 00 	.long 0x16e00
> 	...
> 
> Disassembly of section .debug_pubnames:
> 
> 0000000000000000 <.debug_pubnames>:
>    0:	00 00 00 4f 	.long 0x4f
>    4:	00 02 00 00 	.long 0x20000
>    8:	00 00 00 00 	.long 0x0
>    c:	13 08 00 00 	vaddubm v24,v8,v0
>   10:	06 7e 72 65 	.long 0x67e7265
>   14:	73 65 72 76 	andi.   r5,r27,29302
>   18:	65 00 00 00 	oris    r0,r8,0
>   1c:	10 4d 63 72 	.long 0x104d6372
>   20:	65 61 74 65 	oris    r1,r11,29797
>   24:	5f 66 6c 61 	rlwnm.  r6,r27,r13,17,16
>   28:	74 74 65 6e 	andis.  r20,r3,25966
>   2c:	5f 74 72 65 	rlwnm.  r20,r27,r14,9,18
>   30:	65 00 00 00 	oris    r0,r8,0
>   34:	12 db 6c 6d 	.long 0x12db6c6d
>   38:	62 5f 73 69 	ori     r31,r18,29545
>   3c:	7a 65 00 00 	rotldi  r5,r19,0
>   40:	00 12 f1 6e 	.long 0x12f16e
>   44:	75 6d 5f 6f 	andis.  r13,r11,24431
>   48:	66 5f 6c 6d 	oris    r31,r18,27757
>   4c:	62 73 00 00 	ori     r19,r19,0
>   50:	Address 0x0000000000000050 is out of bounds.
> 
> 
> Disassembly of section .debug_aranges:
> 
> 0000000000000000 <.debug_aranges>:
>    0:	00 00 00 2c 	.long 0x2c
>    4:	00 02 00 00 	.long 0x20000
>    8:	00 00 08 00 	.long 0x800
> 	...
>   1c:	00 00 1a 40 	.long 0x1a40
> 	...
> 
> Disassembly of section .debug_ranges:
> 
> 0000000000000000 <.debug_ranges>:
>    0:	00 00 00 00 	.long 0x0
>    4:	00 00 03 64 	.long 0x364
>    8:	00 00 00 00 	.long 0x0
>    c:	00 00 03 68 	.long 0x368
>   10:	00 00 00 00 	.long 0x0
>   14:	00 00 03 a8 	.long 0x3a8
>   18:	00 00 00 00 	.long 0x0
>   1c:	00 00 03 bc 	.long 0x3bc
> 	...
>   34:	00 00 0c dc 	.long 0xcdc
>   38:	00 00 00 00 	.long 0x0
>   3c:	00 00 0c e0 	.long 0xce0
>   40:	00 00 00 00 	.long 0x0
>   44:	00 00 0c f0 	.long 0xcf0
>   48:	00 00 00 00 	.long 0x0
>   4c:	00 00 0d 14 	.long 0xd14
> 	...
>   64:	00 00 0d 28 	.long 0xd28
>   68:	00 00 00 00 	.long 0x0
>   6c:	00 00 0d 38 	.long 0xd38
>   70:	00 00 00 00 	.long 0x0
>   74:	00 00 0e 84 	.long 0xe84
>   78:	00 00 00 00 	.long 0x0
>   7c:	00 00 0e 94 	.long 0xe94
> 	...
>   94:	00 00 12 40 	.long 0x1240
>   98:	00 00 00 00 	.long 0x0
>   9c:	00 00 12 44 	.long 0x1244
>   a0:	00 00 00 00 	.long 0x0
>   a4:	00 00 12 c0 	.long 0x12c0
>   a8:	00 00 00 00 	.long 0x0
>   ac:	00 00 12 cc 	.long 0x12cc
>   b0:	00 00 00 00 	.long 0x0
>   b4:	00 00 12 4c 	.long 0x124c
>   b8:	00 00 00 00 	.long 0x0
>   bc:	00 00 12 68 	.long 0x1268
> 	...
>   d4:	00 00 12 bc 	.long 0x12bc
>   d8:	00 00 00 00 	.long 0x0
>   dc:	00 00 12 c0 	.long 0x12c0
>   e0:	00 00 00 00 	.long 0x0
>   e4:	00 00 12 cc 	.long 0x12cc
>   e8:	00 00 00 00 	.long 0x0
>   ec:	00 00 12 d8 	.long 0x12d8
> 	...
>  104:	00 00 12 bc 	.long 0x12bc
>  108:	00 00 00 00 	.long 0x0
>  10c:	00 00 12 c0 	.long 0x12c0
>  110:	00 00 00 00 	.long 0x0
>  114:	00 00 12 cc 	.long 0x12cc
>  118:	00 00 00 00 	.long 0x0
>  11c:	00 00 12 d8 	.long 0x12d8
> 	...
>  134:	00 00 13 80 	.long 0x1380
>  138:	00 00 00 00 	.long 0x0
>  13c:	00 00 14 90 	.long 0x1490
>  140:	00 00 00 00 	.long 0x0
>  144:	00 00 16 0c 	.long 0x160c
>  148:	00 00 00 00 	.long 0x0
>  14c:	00 00 17 30 	.long 0x1730
> 	...
>  164:	00 00 13 a0 	.long 0x13a0
>  168:	00 00 00 00 	.long 0x0
>  16c:	00 00 14 90 	.long 0x1490
>  170:	00 00 00 00 	.long 0x0
>  174:	00 00 17 04 	.long 0x1704
>  178:	00 00 00 00 	.long 0x0
>  17c:	00 00 17 30 	.long 0x1730
> 	...
> 
> Disassembly of section .debug_str:
> 
> 0000000000000000 <.debug_str>:
>    0:	5f 5f 6f 66 	rlwnm   r31,r26,r13,29,19
>    4:	66 5f 74 00 	oris    r31,r18,29696
>    8:	5f 5f 67 69 	rlwnm.  r31,r26,r12,29,20
>    c:	64 5f 74 00 	oris    r31,r2,29696
>   10:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>   14:	72 65 61 64 	andi.   r5,r19,24932
>   18:	5f 70 74 72 	rlwnm   r16,r27,r14,17,25
>   1c:	00 5f 63 68 	.long 0x5f6368
>   20:	61 69 6e 00 	ori     r9,r11,28160
>   24:	73 74 5f 63 	andi.   r20,r27,24419
>   28:	74 69 6d 00 	andis.  r9,r3,27904
>   2c:	63 6f 6d 70 	ori     r15,r27,28016
>   30:	61 72 65 66 	ori     r18,r11,25958
>   34:	75 6e 63 00 	andis.  r14,r11,25344
>   38:	73 69 7a 65 	andi.   r9,r27,31333
>   3c:	5f 74 00 77 	rlwnm.  r20,r27,r0,1,27
>   40:	68 65 72 65 	xori    r5,r3,29285
>   44:	00 5f 73 68 	.long 0x5f7368
>   48:	6f 72 74 62 	xoris   r18,r27,29794
>   4c:	75 66 00 5f 	andis.  r6,r11,95
>   50:	5f 70 61 74 	rlwnm   r16,r27,r12,5,26
>   54:	68 00 74 79 	xori    r0,r0,29817
>   58:	70 65 00 61 	andi.   r5,r3,97
>   5c:	64 64 5f 64 	oris    r4,r3,24420
>   60:	79 6e 5f 72 	rldcr   r14,r11,r11,61
>   64:	65 63 6f 6e 	oris    r3,r11,28526
>   68:	66 5f 75 73 	oris    r31,r18,30067
>   6c:	61 62 6c 65 	ori     r2,r11,27749
>   70:	5f 6d 65 6d 	rlwnm.  r13,r27,r12,21,22
>   74:	5f 70 72 6f 	rlwnm.  r16,r27,r14,9,23
>   78:	70 65 72 74 	andi.   r5,r3,29300
>   7c:	79 00 74 6f 	rldimi. r0,r8,46,49
>   80:	74 61 6c 73 	andis.  r1,r3,27763
>   84:	69 7a 65 00 	xori    r26,r11,25856
>   88:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>   8c:	62 75 66 5f 	ori     r21,r19,26207
>   90:	62 61 73 65 	ori     r1,r19,29541
>   94:	00 6c 6f 6e 	.long 0x6c6f6e
>   98:	67 20 6c 6f 	oris    r0,r25,27759
>   9c:	6e 67 20 75 	xoris   r7,r19,8309
>   a0:	6e 73 69 67 	xoris   r19,r19,26983
>   a4:	6e 65 64 20 	xoris   r5,r19,25632
>   a8:	69 6e 74 00 	xori    r14,r11,29696
>   ac:	5f 5f 73 32 	rlwnm   r31,r26,r14,12,25
>   b0:	5f 6c 65 6e 	rlwnm   r12,r27,r12,21,23
>   b4:	00 72 6e 67 	.long 0x726e67
>   b8:	73 5f 63 6e 	andi.   r31,r26,25454
>   bc:	74 00 6c 61 	andis.  r0,r0,27745
>   c0:	73 74 5f 63 	andi.   r20,r27,24419
>   c4:	6f 6d 70 5f 	xoris   r13,r27,28767
>   c8:	76 65 72 73 	andis.  r5,r19,29299
>   cc:	69 6f 6e 00 	xori    r15,r11,28160
>   d0:	70 72 6f 70 	andi.   r18,r3,28528
>   d4:	6e 61 6d 65 	xoris   r1,r19,28005
>   d8:	73 00 70 75 	andi.   r0,r24,28789
>   dc:	74 6e 6f 64 	andis.  r14,r3,28516
>   e0:	65 00 73 74 	oris    r0,r8,29556
>   e4:	61 74 00 6c 	ori     r20,r11,108
>   e8:	6f 6e 67 20 	xoris   r14,r27,26400
>   ec:	6c 6f 6e 67 	xoris   r15,r3,28263
>   f0:	20 69 6e 74 	subfic  r3,r9,28276
>   f4:	00 73 69 67 	.long 0x736967
>   f8:	6e 65 64 20 	xoris   r5,r19,25632
>   fc:	63 68 61 72 	ori     r8,r27,24946
>  100:	00 73 74 5f 	.long 0x73745f
>  104:	69 6e 6f 00 	xori    r14,r11,28416
>  108:	5f 5f 6d 6f 	rlwnm.  r31,r26,r13,21,23
>  10c:	64 65 5f 74 	oris    r5,r3,24436
>  110:	00 69 6e 69 	.long 0x696e69
>  114:	74 72 64 5f 	andis.  r18,r3,25695
>  118:	65 6e 64 00 	oris    r14,r11,25600
>  11c:	5f 76 74 61 	rlwnm.  r22,r27,r14,17,16
>  120:	62 6c 65 5f 	ori     r12,r19,25951
>  124:	6f 66 66 73 	xoris   r6,r27,26227
>  128:	65 74 00 5f 	oris    r20,r11,95
>  12c:	66 69 6c 65 	oris    r9,r19,27749
>  130:	6e 6f 00 62 	xoris   r15,r19,98
>  134:	75 66 70 00 	andis.  r6,r11,28672
>  138:	5f 5f 75 6e 	rlwnm   r31,r26,r14,21,23
>  13c:	75 73 65 64 	andis.  r19,r11,25956
>  140:	34 00 5f 5f 	addic.  r0,r0,24415
>  144:	75 6e 75 73 	andis.  r14,r11,30067
>  148:	65 64 35 00 	oris    r4,r11,13568
>  14c:	5f 5f 75 6e 	rlwnm   r31,r26,r14,21,23
>  150:	75 73 65 64 	andis.  r19,r11,25956
>  154:	36 00 5f 5f 	addic.  r16,r0,24415
>  158:	62 6c 6b 63 	ori     r12,r19,27491
>  15c:	6e 74 5f 74 	xoris   r20,r19,24436
>  160:	00 6c 6f 6e 	.long 0x6c6f6e
>  164:	67 20 69 6e 	oris    r0,r25,26990
>  168:	74 00 64 5f 	andis.  r0,r0,25695
>  16c:	72 65 63 6c 	andi.   r5,r19,25452
>  170:	65 6e 00 5f 	oris    r14,r11,95
>  174:	66 6c 61 67 	oris    r12,r19,24935
>  178:	73 00 72 6c 	andi.   r0,r24,29292
>  17c:	65 6e 00 5f 	oris    r14,r11,95
>  180:	5f 73 73 69 	rlwnm.  r19,r27,r14,13,20
>  184:	7a 65 5f 74 	.long 0x7a655f74
>  188:	00 5f 49 4f 	.long 0x5f494f
>  18c:	5f 62 75 66 	rlwnm   r2,r27,r14,21,19
>  190:	5f 65 6e 64 	rlwnm   r5,r27,r13,25,18
>  194:	00 5f 63 75 	.long 0x5f6375
>  198:	72 5f 63 6f 	andi.   r31,r18,25455
>  19c:	6c 75 6d 6e 	xoris   r21,r3,28014
>  1a0:	00 73 74 61 	.long 0x737461
>  1a4:	74 62 75 66 	andis.  r2,r3,30054
>  1a8:	00 72 65 75 	.long 0x726575
>  1ac:	73 65 5f 69 	andi.   r5,r27,24425
>  1b0:	6e 69 74 72 	xoris   r9,r19,29810
>  1b4:	64 00 73 74 	oris    r0,r0,29556
>  1b8:	5f 61 74 69 	rlwnm.  r1,r27,r14,17,20
>  1bc:	6d 00 5f 6f 	xoris   r0,r8,24431
>  1c0:	66 66 73 65 	oris    r6,r19,29541
>  1c4:	74 00 73 74 	andis.  r0,r0,29556
>  1c8:	72 31 00 64 	andi.   r17,r17,100
>  1cc:	5f 6e 61 6d 	rlwnm.  r14,r27,r12,5,22
>  1d0:	65 00 6d 65 	oris    r0,r8,28005
>  1d4:	6d 5f 72 67 	xoris   r31,r10,29287
>  1d8:	6e 73 5f 74 	xoris   r19,r19,24436
>  1dc:	00 73 74 72 	.long 0x737472
>  1e0:	32 00 6f 66 	addic   r16,r0,28518
>  1e4:	66 5f 74 00 	oris    r31,r18,29696
>  1e8:	6d 65 6d 6f 	xoris   r5,r11,28015
>  1ec:	72 79 5f 72 	andi.   r25,r19,24434
>  1f0:	61 6e 67 65 	ori     r14,r11,26469
>  1f4:	00 73 74 5f 	.long 0x73745f
>  1f8:	62 6c 6f 63 	ori     r12,r19,28515
>  1fc:	6b 73 00 73 	xori    r19,r27,115
>  200:	74 5f 75 69 	andis.  r31,r2,30057
>  204:	64 00 5f 49 	oris    r0,r0,24393
>  208:	4f 5f 6d 61 	.long 0x4f5f6d61
>  20c:	72 6b 65 72 	andi.   r11,r19,25970
>  210:	00 73 74 64 	.long 0x737464
>  214:	69 6e 00 75 	xori    r14,r11,117
>  218:	6e 73 69 67 	xoris   r19,r19,26983
>  21c:	6e 65 64 20 	xoris   r5,r19,25632
>  220:	69 6e 74 00 	xori    r14,r11,29696
>  224:	62 6f 6f 74 	ori     r15,r19,28532
>  228:	62 6c 6f 63 	ori     r12,r19,28515
>  22c:	6b 00 74 6d 	xori    r0,r24,29805
>  230:	70 5f 69 6e 	andi.   r31,r2,26990
>  234:	64 78 00 67 	oris    r24,r3,103
>  238:	65 74 6c 69 	oris    r20,r11,27753
>  23c:	6e 65 00 5f 	xoris   r5,r19,95
>  240:	5f 73 74 72 	rlwnm   r19,r27,r14,17,25
>  244:	65 61 6d 00 	oris    r1,r11,27904
>  248:	74 69 6d 65 	andis.  r9,r3,28005
>  24c:	73 70 65 63 	andi.   r16,r27,25955
>  250:	00 6c 6f 6e 	.long 0x6c6f6e
>  254:	67 20 75 6e 	oris    r0,r25,30062
>  258:	73 69 67 6e 	andi.   r9,r27,26478
>  25c:	65 64 20 69 	oris    r4,r11,8297
>  260:	6e 74 00 63 	xoris   r20,r19,99
>  264:	72 65 61 74 	andi.   r5,r19,24948
>  268:	65 5f 66 6c 	oris    r31,r10,26220
>  26c:	61 74 74 65 	ori     r20,r11,29797
>  270:	6e 5f 74 72 	xoris   r31,r18,29810
>  274:	65 65 00 6f 	oris    r5,r11,111
>  278:	66 66 5f 64 	oris    r6,r19,24420
>  27c:	74 5f 73 74 	andis.  r31,r2,29556
>  280:	72 69 6e 67 	andi.   r9,r19,28263
>  284:	73 00 5f 49 	andi.   r0,r24,24393
>  288:	4f 5f 77 72 	.long 0x4f5f7772
>  28c:	69 74 65 5f 	xori    r20,r11,25951
>  290:	70 74 72 00 	andi.   r20,r3,29184
>  294:	6e 61 6d 65 	xoris   r1,r19,28005
>  298:	00 5f 5f 73 	.long 0x5f5f73
>  29c:	74 61 74 62 	andis.  r1,r3,29794
>  2a0:	75 66 00 5f 	andis.  r6,r11,95
>  2a4:	73 62 75 66 	andi.   r2,r27,30054
>  2a8:	00 5f 5f 72 	.long 0x5f5f72
>  2ac:	65 73 75 6c 	oris    r19,r11,30060
>  2b0:	74 00 64 61 	andis.  r0,r0,25697
>  2b4:	74 61 00 6c 	andis.  r1,r3,108
>  2b8:	6f 63 61 6c 	xoris   r3,r27,24940
>  2bc:	5f 63 6d 64 	rlwnm   r3,r27,r13,21,18
>  2c0:	6c 69 6e 65 	xoris   r9,r3,28261
>  2c4:	00 73 69 7a 	.long 0x73697a
>  2c8:	65 00 70 61 	oris    r0,r8,28769
>  2cc:	74 68 6e 61 	andis.  r8,r3,28257
>  2d0:	6d 65 00 64 	xoris   r5,r11,100
>  2d4:	5f 6f 66 66 	rlwnm   r15,r27,r12,25,19
>  2d8:	00 5f 49 4f 	.long 0x5f494f
>  2dc:	5f 73 61 76 	rlwnm   r19,r27,r12,5,27
>  2e0:	65 5f 62 61 	oris    r31,r10,25185
>  2e4:	73 65 00 5f 	andi.   r5,r27,95
>  2e8:	5f 6e 6c 69 	rlwnm.  r14,r27,r13,17,20
>  2ec:	6e 6b 5f 74 	xoris   r11,r19,24436
>  2f0:	00 63 72 61 	.long 0x637261
>  2f4:	73 68 5f 70 	andi.   r8,r27,24432
>  2f8:	61 72 61 6d 	ori     r18,r11,24941
>  2fc:	00 5f 5f 73 	.long 0x5f5f73
>  300:	31 00 6c 6f 	addic   r8,r0,27759
>  304:	63 5f 62 61 	ori     r31,r26,25185
>  308:	73 65 00 5f 	andi.   r5,r27,95
>  30c:	6c 6f 63 6b 	xoris   r15,r3,25451
>  310:	00 5f 6d 6f 	.long 0x5f6d6f
>  314:	64 65 00 69 	oris    r5,r3,105
>  318:	6e 69 74 72 	xoris   r9,r19,29810
>  31c:	64 5f 62 61 	oris    r31,r2,25185
>  320:	73 65 00 73 	andi.   r5,r27,115
>  324:	74 64 6f 75 	andis.  r4,r3,28533
>  328:	74 00 73 74 	andis.  r0,r0,29556
>  32c:	5f 73 69 7a 	rlwnm   r19,r27,r13,5,29
>  330:	65 00 63 6d 	oris    r0,r8,25453
>  334:	64 5f 6c 65 	oris    r31,r2,27749
>  338:	6e 00 73 74 	xoris   r0,r16,29556
>  33c:	5f 6d 6f 64 	rlwnm   r13,r27,r13,29,18
>  340:	65 00 76 65 	oris    r0,r8,30309
>  344:	72 73 69 6f 	andi.   r19,r19,26991
>  348:	6e 00 69 6e 	xoris   r0,r16,26990
>  34c:	69 74 72 64 	xori    r20,r11,29284
>  350:	5f 73 69 7a 	rlwnm   r19,r27,r13,5,29
>  354:	65 00 5f 49 	oris    r0,r8,24393
>  358:	4f 5f 72 65 	.long 0x4f5f7265
>  35c:	61 64 5f 65 	ori     r4,r11,24421
>  360:	6e 64 00 61 	xoris   r4,r19,97
>  364:	64 64 5f 75 	oris    r4,r3,24437
>  368:	73 61 62 6c 	andi.   r1,r27,25196
>  36c:	65 5f 6d 65 	oris    r31,r10,28005
>  370:	6d 5f 70 72 	xoris   r31,r10,28786
>  374:	6f 70 65 72 	xoris   r16,r27,25970
>  378:	74 79 00 74 	andis.  r25,r3,116
>  37c:	76 5f 6e 73 	andis.  r31,r18,28275
>  380:	65 63 00 6c 	oris    r3,r11,108
>  384:	6f 63 5f 65 	xoris   r3,r27,24421
>  388:	6e 64 00 5f 	xoris   r4,r19,95
>  38c:	5f 64 65 76 	rlwnm   r4,r27,r12,21,27
>  390:	5f 74 00 66 	rlwnm   r20,r27,r0,1,19
>  394:	69 6c 65 6e 	xori    r12,r11,25966
>  398:	61 6d 65 00 	ori     r13,r11,25856
>  39c:	70 72 6f 70 	andi.   r18,r3,28528
>  3a0:	6e 75 6d 00 	xoris   r21,r19,27904
>  3a4:	63 68 65 63 	ori     r8,r27,25955
>  3a8:	6b 70 72 6f 	xori    r16,r27,29295
>  3ac:	70 00 6f 66 	andi.   r0,r0,28518
>  3b0:	66 5f 64 74 	oris    r31,r18,25716
>  3b4:	5f 73 74 72 	rlwnm   r19,r27,r14,17,25
>  3b8:	75 63 74 00 	andis.  r3,r11,29696
>  3bc:	70 61 72 61 	andi.   r1,r3,29281
>  3c0:	6d 00 75 69 	xoris   r0,r8,30057
>  3c4:	6e 74 36 34 	xoris   r20,r19,13876
>  3c8:	5f 74 00 64 	rlwnm   r20,r27,r0,1,18
>  3cc:	69 72 65 6e 	xori    r18,r11,25966
>  3d0:	74 00 64 5f 	andis.  r0,r0,25695
>  3d4:	69 6e 6f 00 	xori    r14,r11,28416
>  3d8:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>  3dc:	6c 6f 63 6b 	xoris   r15,r3,25451
>  3e0:	5f 74 00 5f 	rlwnm.  r20,r27,r0,1,15
>  3e4:	49 4f 5f 46 	ba      14f5f44 <bb+0x14b0b14>
>  3e8:	49 4c 45 00 	b       14c48e8 <bb+0x147f4b8>
>  3ec:	5f 5f 62 6c 	rlwnm   r31,r26,r12,9,22
>  3f0:	6b 73 69 7a 	xori    r19,r27,27002
>  3f4:	65 5f 74 00 	oris    r31,r10,29696
>  3f8:	5f 5f 73 31 	rlwnm.  r31,r26,r14,12,24
>  3fc:	5f 6c 65 6e 	rlwnm   r12,r27,r12,21,23
>  400:	00 70 61 74 	.long 0x706174
>  404:	68 73 74 61 	xori    r19,r3,29793
>  408:	72 74 00 72 	andi.   r20,r19,114
>  40c:	61 6e 67 65 	ori     r14,r11,26469
>  410:	00 5f 70 6f 	.long 0x5f706f
>  414:	73 00 5f 6f 	andi.   r0,r24,24431
>  418:	6c 64 5f 6f 	xoris   r4,r3,24431
>  41c:	66 66 73 65 	oris    r6,r19,29541
>  420:	74 00 74 76 	andis.  r0,r0,29814
>  424:	5f 73 65 63 	rlwnm.  r19,r27,r12,21,17
>  428:	00 5f 6d 61 	.long 0x5f6d61
>  42c:	72 6b 65 72 	andi.   r11,r19,25970
>  430:	73 00 72 61 	andi.   r0,r24,29281
>  434:	6e 67 65 73 	xoris   r7,r19,25971
>  438:	00 6d 65 6d 	.long 0x6d656d
>  43c:	5f 72 67 6e 	rlwnm   r18,r27,r12,29,23
>  440:	73 00 62 61 	andi.   r0,r24,25185
>  444:	73 65 00 64 	andi.   r5,r27,100
>  448:	74 73 74 72 	andis.  r19,r3,29810
>  44c:	75 63 74 00 	andis.  r3,r11,29696
>  450:	6b 65 78 65 	xori    r5,r27,30821
>  454:	63 2f 61 72 	ori     r15,r25,24946
>  458:	63 68 2f 70 	ori     r8,r27,12144
>  45c:	70 63 36 34 	andi.   r3,r3,13876
>  460:	2f 66 73 32 	cmpdi   cr6,r6,29490
>  464:	64 74 2e 63 	oris    r20,r3,11875
>  468:	00 75 6e 73 	.long 0x756e73
>  46c:	69 67 6e 65 	xori    r7,r11,28261
>  470:	64 20 63 68 	oris    r0,r1,25448
>  474:	61 72 00 64 	ori     r18,r11,100
>  478:	5f 74 79 70 	rlwnm   r20,r27,r15,5,24
>  47c:	65 00 6f 66 	oris    r0,r8,28518
>  480:	66 5f 6d 65 	oris    r31,r18,28005
>  484:	6d 5f 72 73 	xoris   r31,r10,29299
>  488:	76 6d 61 70 	andis.  r13,r19,24944
>  48c:	00 73 68 6f 	.long 0x73686f
>  490:	72 74 20 69 	andi.   r20,r19,8297
>  494:	6e 74 00 6d 	xoris   r20,r19,109
>  498:	61 67 69 63 	ori     r7,r11,26979
>  49c:	00 73 74 5f 	.long 0x73745f
>  4a0:	62 6c 6b 73 	ori     r12,r19,27507
>  4a4:	69 7a 65 00 	xori    r26,r11,25856
>  4a8:	6c 73 74 61 	xoris   r19,r3,29793
>  4ac:	74 00 46 49 	andis.  r0,r0,17993
>  4b0:	4c 45 00 5f 	.long 0x4c45005f
>  4b4:	5f 6c 69 6e 	rlwnm   r12,r27,r13,5,23
>  4b8:	65 70 74 72 	oris    r16,r11,29810
>  4bc:	00 6e 6c 69 	.long 0x6e6c69
>  4c0:	73 74 00 6e 	andi.   r20,r27,110
>  4c4:	75 6d 5f 6f 	andis.  r13,r11,24431
>  4c8:	66 5f 6c 6d 	oris    r31,r18,27757
>  4cc:	62 73 00 5f 	ori     r19,r19,95
>  4d0:	5f 69 6e 6f 	rlwnm.  r9,r27,r13,25,23
>  4d4:	5f 74 00 73 	rlwnm.  r20,r27,r0,1,25
>  4d8:	74 5f 6e 6c 	andis.  r31,r2,28268
>  4dc:	69 6e 6b 00 	xori    r14,r11,27392
>  4e0:	6f 6c 64 5f 	xoris   r12,r27,25695
>  4e4:	70 61 72 61 	andi.   r1,r3,29281
>  4e8:	6d 00 73 74 	xoris   r0,r8,29556
>  4ec:	5f 72 64 65 	rlwnm.  r18,r27,r12,17,18
>  4f0:	76 00 6c 65 	andis.  r0,r16,27749
>  4f4:	6e 67 74 68 	xoris   r7,r19,29800
>  4f8:	00 63 68 61 	.long 0x636861
>  4fc:	72 00 62 61 	andi.   r0,r16,25185
>  500:	73 65 6e 61 	andi.   r5,r27,28257
>  504:	6d 65 00 5f 	xoris   r5,r11,95
>  508:	5f 74 69 6d 	rlwnm.  r20,r27,r13,5,22
>  50c:	65 5f 74 00 	oris    r31,r10,29696
>  510:	47 4e 55 20 	.long 0x474e5520
>  514:	43 20 34 2e 	bdnza+  342c <.comparefunc+0x1aac>
>  518:	33 2e 32 20 	addic   r25,r14,12832
>  51c:	5b 67 63 63 	rlmi.   r7,r27,r12,13,17
>  520:	2d 34 5f 33 	cmpdi   cr2,r20,24371
>  524:	2d 62 72 61 	cmpdi   cr2,r2,29281
>  528:	6e 63 68 20 	xoris   r3,r19,26656
>  52c:	72 65 76 69 	andi.   r5,r19,30313
>  530:	73 69 6f 6e 	andi.   r9,r27,28526
>  534:	20 31 34 31 	subfic  r1,r17,13361
>  538:	32 39 31 5d 	addic   r17,r25,12637
>  53c:	00 63 6d 64 	.long 0x636d64
>  540:	6c 69 6e 65 	xoris   r9,r3,28261
>  544:	00 5f 5f 75 	.long 0x5f5f75
>  548:	69 64 5f 74 	xori    r4,r11,24436
>  54c:	00 5f 6e 65 	.long 0x5f6e65
>  550:	78 74 00 5f 	.long 0x7874005f
>  554:	5f 6f 66 66 	rlwnm   r15,r27,r12,25,19
>  558:	36 34 5f 74 	addic.  r17,r20,24436
>  55c:	00 6f 66 66 	.long 0x6f6666
>  560:	73 65 74 00 	andi.   r5,r27,29696
>  564:	5f 49 4f 5f 	rlwnm.  r9,r26,r9,29,15
>  568:	72 65 61 64 	andi.   r5,r19,24932
>  56c:	5f 62 61 73 	rlwnm.  r2,r27,r12,5,25
>  570:	65 00 5f 49 	oris    r0,r8,24393
>  574:	4f 5f 73 61 	.long 0x4f5f7361
>  578:	76 65 5f 65 	andis.  r5,r19,24421
>  57c:	6e 64 00 73 	xoris   r4,r19,115
>  580:	68 6f 72 74 	xori    r15,r3,29300
>  584:	20 75 6e 73 	subfic  r3,r21,28275
>  588:	69 67 6e 65 	xori    r7,r11,28261
>  58c:	64 20 69 6e 	oris    r0,r1,26990
>  590:	74 00 75 73 	andis.  r0,r0,30067
>  594:	61 62 6c 65 	ori     r2,r11,27749
>  598:	6d 65 6d 5f 	xoris   r5,r11,27999
>  59c:	72 67 6e 73 	andi.   r7,r19,28275
>  5a0:	00 73 74 5f 	.long 0x73745f
>  5a4:	67 69 64 00 	oris    r9,r27,25600
>  5a8:	5f 5f 70 61 	rlwnm.  r31,r26,r14,1,16
>  5ac:	64 31 00 5f 	oris    r17,r1,95
>  5b0:	5f 70 61 64 	rlwnm   r16,r27,r12,5,18
>  5b4:	32 00 5f 5f 	addic   r16,r0,24415
>  5b8:	70 61 64 33 	andi.   r1,r3,25651
>  5bc:	00 5f 5f 70 	.long 0x5f5f70
>  5c0:	61 64 34 00 	ori     r4,r11,13312
>  5c4:	5f 5f 70 61 	rlwnm.  r31,r26,r14,1,16
>  5c8:	64 35 00 5f 	oris    r21,r1,95
>  5cc:	49 4f 5f 77 	bla     14f5f74 <bb+0x14b0b44>
>  5d0:	72 69 74 65 	andi.   r9,r19,29797
>  5d4:	5f 65 6e 64 	rlwnm   r5,r27,r13,25,18
>  5d8:	00 66 6e 61 	.long 0x666e61
>  5dc:	6d 65 00 5f 	xoris   r5,r11,95
>  5e0:	75 6e 75 73 	andis.  r14,r11,30067
>  5e4:	65 64 32 00 	oris    r4,r11,12800
>  5e8:	73 74 64 65 	andi.   r20,r27,25701
>  5ec:	72 72 00 64 	andi.   r18,r19,100
>  5f0:	65 6e 74 72 	oris    r14,r11,29810
>  5f4:	79 31 00 64 	rldicr  r17,r9,0,33
>  5f8:	65 6e 74 72 	oris    r14,r11,29810
>  5fc:	79 32 00 72 	rldcr   r18,r9,r0,33
>  600:	65 73 65 72 	oris    r19,r11,25970
>  604:	76 65 00 6c 	andis.  r5,r19,108
>  608:	6d 62 5f 73 	xoris   r2,r11,24435
>  60c:	69 7a 65 00 	xori    r26,r11,25856
>  610:	70 75 74 70 	andi.   r21,r3,29808
>  614:	72 6f 70 73 	andi.   r15,r19,28787
>  618:	00 62 6f 6f 	.long 0x626f6f
>  61c:	74 5f 70 68 	andis.  r31,r2,28776
>  620:	79 73 69 64 	rldicr  r19,r11,13,37
>  624:	00 73 74 5f 	.long 0x73745f
>  628:	64 65 76 00 	oris    r5,r3,30208
>  62c:	6c 61 73 74 	xoris   r1,r3,29556
>  630:	5f 63 6d 64 	rlwnm   r3,r27,r13,21,18
>  634:	6c 69 6e 65 	xoris   r9,r3,28261
>  638:	00 5f 66 6c 	.long 0x5f666c
>  63c:	61 67 73 32 	ori     r7,r11,29490
>  640:	00 5f 49 4f 	.long 0x5f494f
>  644:	5f 62 61 63 	rlwnm.  r2,r27,r12,5,17
>  648:	6b 75 70 5f 	xori    r21,r27,28767
>  64c:	62 61 73 65 	ori     r1,r19,29541
>  650:	00 73 74 5f 	.long 0x73745f
>  654:	6d 74 69 6d 	xoris   r20,r11,26989
>  658:	00 73 69 7a 	.long 0x73697a
>  65c:	65 70 00 62 	oris    r16,r11,98
>  660:	6e 61 6d 65 	xoris   r1,r19,28005
>  664:	00 2f 68 6f 	.long 0x2f686f
>  668:	6d 65 2f 6d 	xoris   r5,r11,12141
>  66c:	6f 68 61 6e 	xoris   r8,r27,24942
>  670:	2f 6b 65 78 	cmpdi   cr6,r11,25976
>  674:	65 63 2d 74 	oris    r3,r11,11636
>  678:	6f 6f 6c 73 	xoris   r15,r27,27763
>  67c:	00 73 74 61 	.long 0x737461
>  680:	72 74 00 5f 	andi.   r20,r19,95
>  684:	49 4f 5f 77 	bla     14f5f74 <bb+0x14b0b44>
>  688:	72 69 74 65 	andi.   r9,r19,29797
>  68c:	5f 62 61 73 	rlwnm.  r2,r27,r12,5,25
>  690:	65 00 74 6c 	oris    r0,r8,29804
>  694:	65 6e 00 6d 	oris    r14,r11,109
>  698:	65 6d 5f 72 	oris    r13,r11,24434
>  69c:	73 72 76 00 	andi.   r18,r27,30208
>  6a0:	6e 75 6d 6c 	xoris   r21,r19,28012
>  6a4:	69 73 74 00 	xori    r19,r11,29696
>  6a8:	6e 61 6d 65 	xoris   r1,r19,28005
>  6ac:	6c 69 73 74 	xoris   r9,r3,29556
> 	...
> 
> Disassembly of section .comment:
> 
> 0000000000000000 <.comment>:
>    0:	00 47 43 43 	.long 0x474343
>    4:	3a 20 28 53 	li      r17,10323
>    8:	55 53 45 20 	rlwinm  r19,r10,8,20,16
>    c:	4c 69 6e 75 	.long 0x4c696e75
>   10:	78 29 20 34 	.long 0x78292034
>   14:	2e 33 2e 32 	cmpdi   cr4,r19,11826
>   18:	20 5b 67 63 	subfic  r2,r27,26467
>   1c:	63 2d 34 5f 	ori     r13,r25,13407
>   20:	33 2d 62 72 	addic   r25,r13,25202
>   24:	61 6e 63 68 	ori     r14,r11,25448
>   28:	20 72 65 76 	subfic  r3,r18,25974
>   2c:	69 73 69 6f 	xori    r19,r11,26991
>   30:	6e 20 31 34 	xoris   r0,r17,12596
>   34:	31 32 39 31 	addic   r9,r18,14641
>   38:	Address 0x0000000000000038 is out of bounds.
> 
> 
> Disassembly of section .comment.SUSE.OPTs:
> 
> 0000000000000000 <.comment.SUSE.OPTs>:
>    0:	4f 73 70 57 	.long 0x4f737057
>    4:	Address 0x0000000000000004 is out of bounds.
> 
