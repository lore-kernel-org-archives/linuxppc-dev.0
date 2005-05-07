Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6931B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 04:50:25 +1000 (EST)
Date: Sat, 7 May 2005 10:16:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050507131609.GA16996@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
	<20050506230523.GA15908@logos.cnet>
	<6f231f4afce0886929ca99426a86b47a@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f231f4afce0886929ca99426a86b47a@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> >So you do agree that pte's should not be created for the first
> >8MBytes if CONFIG_PIN_TLB is set? :)
> 
> NO.  Just leave that code alone.  I don't understand why you think
> doing this will have any effect on the system operation.   
>
> If you are able to run a system without creating these tables, then 
> the pinned TLBs must be working.  If pinned TLBs weren't working, 
> the kernel would crash. 

Not creating 4kb mappings for the first 8Mbytes of kernel 
virtual addresses fixed the problem for me. 

Break at first start_kernel instruction (0xc02284a4).

Dump TLB contents to "itlb-before".

[marcelo@dmt ~]$ grep SPR itlb-before | grep 816
SPR  816 : 0x10002080    268443776
SPR  816 : 0x10001080    268439680
SPR  816 : 0x0ff79080    267882624
SPR  816 : 0x0ff261c0    267542976
SPR  816 : 0x0ff521c0    267723200
SPR  816 : 0x100121c0    268509632
SPR  816 : 0x100011c0    268440000
SPR  816 : 0x0ffdd1c0    268292544
SPR  816 : 0x0ffdb1c0    268284352
SPR  816 : 0x0fef51c0    267342272
SPR  816 : 0x0fef91c0    267358656
SPR  816 : 0x0fe0b1c0    266383808
SPR  816 : 0x0fef71c0    267350464
SPR  816 : 0x0fef61c0    267346368
SPR  816 : 0x0ffee1c0    268362176
SPR  816 : 0x0ffdc1c0    268288448
SPR  816 : 0x0fef21c0    267329984
SPR  816 : 0x0fef11c0    267325888
SPR  816 : 0x0fe071c0    266367424
SPR  816 : 0x0ffc61c0    268198336
SPR  816 : 0x0fe0c1c0    266387904
SPR  816 : 0x0ffc51c0    268194240
SPR  816 : 0x0fe091c0    266375616
SPR  816 : 0x0ffea080    268345472
SPR  816 : 0x0ff20080    267518080
SPR  816 : 0x0ff81080    267915392
SPR  816 : 0x1001c080    268550272
SPR  816 : 0x10008080    268468352
SPR  816 : 0x100021e0    268444128
SPR  816 : 0x100241e0    268583392
SPR  816 : 0x100301e0    268632544
SPR  816 : 0xc0000e1f  -1073738209   <----- VALID 8MB TLB ENTRY

"go" 
BDI breaks at 

BDI>i
    Target state      : debug mode
    Debug entry cause : instruction breakpoint
    Current PC        : 0xc0228544
BDI>

0xc0228538 <start_kernel+148>:  bl      0xc023107c <pidhash_init>
0xc022853c <start_kernel+152>:  bl      0xc0230f1c <init_timers>
0xc0228540 <start_kernel+156>:  bl      0xc0230cf4 <softirq_init>
0xc0228544 <start_kernel+160>:  bl      0xc022ead0 <time_init>
0xc0228548 <start_kernel+164>:  bl      0xc02354b0 <console_init>
0xc022854c <start_kernel+168>:  lis     r9,-16348

[marcelo@dmt ~]$ grep SPR itlb-2 | grep 816
SPR  816 : 0x10001100    268439808
SPR  816 : 0x0ffdd100    268292352
SPR  816 : 0x0ffdb100    268284160
SPR  816 : 0x0fef5100    267342080
SPR  816 : 0x0fef9100    267358464
SPR  816 : 0x0fe0b100    266383616
SPR  816 : 0x0fef7100    267350272
SPR  816 : 0x0fef6100    267346176
SPR  816 : 0x0ffee100    268361984
SPR  816 : 0x0ffdc100    268288256
SPR  816 : 0xc0038110  -1073512176     <---------
SPR  816 : 0xc0063110  -1073336048     
SPR  816 : 0xc0024110  -1073594096
SPR  816 : 0xc0017110  -1073647344
SPR  816 : 0xc000e110  -1073684208
SPR  816 : 0xc0003110  -1073729264
SPR  816 : 0xc0002110  -1073733360
SPR  816 : 0xc000d110  -1073688304
SPR  816 : 0xc0004110  -1073725168	
SPR  816 : 0xc0012110  -1073667824
SPR  816 : 0xc01a1110  -1072033520	
SPR  816 : 0xc01a2110  -1072029424
SPR  816 : 0xc000a110  -1073700592	
SPR  816 : 0xc001c110  -1073626864 
SPR  816 : 0xc001b110  -1073630960      <---------
SPR  816 : 0x0ff26100    267542784
SPR  816 : 0x0ff52100    
SPR  816 : 0x10012100    268509440
SPR  816 : 0x100021e0    268444128
SPR  816 : 0x100241e0    268583392
SPR  816 : 0x100301e0    268632544
SPR  816 : 0xc0000e1f  -1073738209 

(gdb) disassemble start_kernel
Dump of assembler code for function start_kernel:
0xc02284a4 <start_kernel+0>:    lis     r3,-16358
0xc02284a8 <start_kernel+4>:    stwu    r1,-32(r1)
0xc02284ac <start_kernel+8>:    mflr    r0
0xc02284b0 <start_kernel+12>:   addi    r3,r3,21832
0xc02284b4 <start_kernel+16>:   stw     r0,36(r1)
0xc02284b8 <start_kernel+20>:   stmw    r29,20(r1)
0xc02284bc <start_kernel+24>:   bl      0xc0012130 <printk>
0xc02284c0 <start_kernel+28>:   addi    r3,r1,8
0xc02284c4 <start_kernel+32>:   bl      0xc022ee28 <setup_arch>
0xc02284c8 <start_kernel+36>:   bl      0xc0230548 <sched_init>
0xc02284cc <start_kernel+40>:   bl      0xc02321e8 <build_all_zonelists>
0xc02284d0 <start_kernel+44>:   bl      0xc02326f4 <page_alloc_init>
0xc02284d4 <start_kernel+48>:   lis     r4,-16348
0xc02284d8 <start_kernel+52>:   lis     r3,-16355
0xc02284dc <start_kernel+56>:   addi    r4,r4,-5804
0xc02284e0 <start_kernel+60>:   addi    r3,r3,-6768
0xc02284e4 <start_kernel+64>:   bl      0xc0012130 <printk>
0xc02284e8 <start_kernel+68>:   bl      0xc022842c <parse_early_param>
0xc02284ec <start_kernel+72>:   lis     r5,-16353
0xc02284f0 <start_kernel+76>:   lis     r6,-16353
0xc02284f4 <start_kernel+80>:   addi    r5,r5,4580
0xc02284f8 <start_kernel+84>:   addi    r6,r6,5060
---Type <return> to continue, or q <return> to quit---
0xc02284fc <start_kernel+88>:   subf    r6,r5,r6
0xc0228500 <start_kernel+92>:   lis     r0,-13108
0xc0228504 <start_kernel+96>:   ori     r0,r0,52429
0xc0228508 <start_kernel+100>:  srawi   r6,r6,2
0xc022850c <start_kernel+104>:  mullw   r6,r6,r0
0xc0228510 <start_kernel+108>:  lwz     r4,8(r1)
0xc0228514 <start_kernel+112>:  lis     r7,-16349
0xc0228518 <start_kernel+116>:  lis     r3,-16355
0xc022851c <start_kernel+120>:  addi    r7,r7,-32404
0xc0228520 <start_kernel+124>:  addi    r3,r3,-6740
0xc0228524 <start_kernel+128>:  bl      0xc0024dac <parse_args>
0xc0228528 <start_kernel+132>:  bl      0xc0231220 <sort_main_extable>
0xc022852c <start_kernel+136>:  bl      0xc022eaa0 <trap_init>
0xc0228530 <start_kernel+140>:  bl      0xc02311f0 <rcu_init>
0xc0228534 <start_kernel+144>:  bl      0xc022eaa4 <init_IRQ>
0xc0228538 <start_kernel+148>:  bl      0xc023107c <pidhash_init>
0xc022853c <start_kernel+152>:  bl      0xc0230f1c <init_timers>
0xc0228540 <start_kernel+156>:  bl      0xc0230cf4 <softirq_init>
0xc0228544 <start_kernel+160>:  bl      0xc022ead0 <time_init>
0xc0228548 <start_kernel+164>:  bl      0xc02354b0 <console_init>
0xc022854c <start_kernel+168>:  lis     r9,-16348
0xc0228550 <start_kernel+172>:  lwz     r3,-8180(r9)
0xc0228554 <start_kernel+176>:  cmpwi   r3,0
