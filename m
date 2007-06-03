Return-Path: <root@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id D0585DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jun 2007 02:00:58 +1000 (EST)
Date: Sun, 3 Jun 2007 15:53:54 +0200 (CEST)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: linuxppc-embedded@ozlabs.org
Subject: ppc assembler problem with calling C funciton in entry.S
Message-ID: <Pine.LNX.4.60.0706031527370.1056@rtl14.hofr.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi !

  Im trying to intercept rfi in entry.S - the intercept function called
  emulate_iret is called (get the printk) but then the box hangs - so I
  guess Im messing up the stack some how - but I don't understand how
  - could someone point me to the error or to documentation that could
  help ?

  kernel is 2.6.19.2 (ELDK)
  Toolchain ELDK
  HW is AMCC 440GR


The dummy intercept function basically does a printk and messes around
on the stack a bit - sould have no sideffects.

static int g_test_int;
void emulate_iret(void)
{
         static int g[2];
         ++g_test_int;
         printk("emulate_iret!\n");

         g[0] = g_test_int;
         g[1] = g_test_int + 10;
}


The modified transfer_to_handler_cont - just calls emulate_iret and 
restors (code between #if 1 and #endif was added):

in arch/ppc/kernel/entry.S
transfer_to_handler_cont:
3:
#if 1					/* this code block was added */
         bl      emulate_iret
         lwz     r9,_LINK(r1)		/* restore the link register */
         mtlr    r9

         lwz     r10,_MSR(r1)		/* may be changed during call */
         FIX_SRR1(r10, r0)		/* this macro is empty for (440 GR) */
#endif
         mflr    r9
         lwz     r11,0(r9)               /* virtual address of handler */
         lwz     r9,4(r9)                /* where to go when done */
         mtspr   SPRN_SRR0,r11
         mtspr   SPRN_SRR1,r10
         mtlr    r9
         SYNC
         RFI                             /* jump to handler, enable MMU */

dissassembly of emulate_iret:

c000688c <emulate_iret>:
c000688c:       94 21 ff e0     stwu    r1,-32(r1)
c0006890:       bf a1 00 14     stmw    r29,20(r1)
c0006894:       3f a0 c0 2c     lis     r29,-16340
c0006898:       81 3d 41 34     lwz     r9,16692(r29)
c000689c:       7c 08 02 a6     mflr    r0
c00068a0:       3c 60 c0 20     lis     r3,-16352
c00068a4:       39 29 00 01     addi    r9,r9,1
c00068a8:       38 63 97 f8     addi    r3,r3,-26632
c00068ac:       90 01 00 24     stw     r0,36(r1)
c00068b0:       91 3d 41 34     stw     r9,16692(r29)
c00068b4:       48 01 9f cd     bl      c0020880 <printk>
c00068b8:       81 5d 41 34     lwz     r10,16692(r29)
c00068bc:       3d 60 c0 2c     lis     r11,-16340
c00068c0:       38 0a 00 0a     addi    r0,r10,10
c00068c4:       39 2b 41 24     addi    r9,r11,16676
c00068c8:       90 09 00 04     stw     r0,4(r9)
c00068cc:       80 01 00 24     lwz     r0,36(r1)
c00068d0:       bb a1 00 14     lmw     r29,20(r1)
c00068d4:       7c 08 03 a6     mtlr    r0
c00068d8:       38 21 00 20     addi    r1,r1,32
c00068dc:       91 4b 41 24     stw     r10,16676(r11)
c00068e0:       4e 80 00 20     blr

thx !
hofrat
