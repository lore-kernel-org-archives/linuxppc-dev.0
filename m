Date: Sat, 5 Aug 2000 21:15:28 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: a GCC question
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000805204429.649H-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have modified the code in arch/ppc/kernel/prom.c to add support for
various depths and it looks like this:

static void
draw_byte(unsigned char c, long locX, long locY)
{
	unsigned long offset	= reloc_offset();
	boot_infos_t* bi	= PTRRELOC(RELOC(disp_bi));
	unsigned char *base	= calc_base(bi, locX << 3, locY << 4);
	unsigned char *font	= &RELOC(vga_font)[((unsigned long)c) *
16];
	int rb			= bi->dispDeviceRowBytes;

	switch (bi->dispDeviceDepth) {
	case 32:
		draw_byte_32(font, (unsigned long *)base, rb);
		break;
	case 16:
		draw_byte_16(font, (unsigned long *)base, rb);
		break;
	case 8:
		draw_byte_8(font, (unsigned long *)base, rb);
		break;
	case 4:
		draw_byte_4(font, (unsigned long *)base, rb);
		break;
	case 2:
		draw_byte_2(font, (unsigned short *)base, rb);
		break;
	case 1:
		draw_byte_1(font, (unsigned char *)base, rb);
		break;
	}
}

At the early boot time when this function is called inside kernel, it is
not at its linked location.  When I have only top three cases (32, 16, 8),
it works just fine.  However, when there are more cases, it doesn't work.
Here is the objdump of the function:

000004e0 <draw_byte>:
     4e0:       94 21 ff d0     stwu    r1,-48(r1)
     4e4:       7c 08 02 a6     mflr    r0
     4e8:       bf 21 00 14     stmw    r25,20(r1)
     4ec:       90 01 00 34     stw     r0,52(r1)
     4f0:       7c 7c 1b 78     mr      r28,r3
     4f4:       7c 9a 23 78     mr      r26,r4
     4f8:       7c b9 2b 78     mr      r25,r5
     4fc:       48 00 00 01     bl      4fc <draw_byte+0x1c>
                        4fc: R_PPC_REL24        reloc_offset
     500:       3d 20 00 00     lis     r9,0
                        502: R_PPC_ADDR16_HA    disp_bi
     504:       7c 7b 1b 78     mr      r27,r3
     508:       39 29 00 00     addi    r9,r9,0
                        50a: R_PPC_ADDR16_LO    disp_bi
     50c:       7f bb 48 2e     lwzx    r29,r27,r9
     510:       57 44 18 38     rlwinm  r4,r26,3,0,28
     514:       7f bd da 14     add     r29,r29,r27
     518:       57 25 20 36     rlwinm  r5,r25,4,0,27
     51c:       7f a3 eb 78     mr      r3,r29
     520:       4b ff fa e1     bl      0 <calc_base>
     524:       81 7d 00 2c     lwz     r11,44(r29)
     528:       3d 20 00 00     lis     r9,0
                        52a: R_PPC_ADDR16_HA    vga_font
     52c:       38 0b ff ff     addi    r0,r11,-1
     530:       57 9c 20 36     rlwinm  r28,r28,4,0,27
     534:       39 29 00 00     addi    r9,r9,0
                        536: R_PPC_ADDR16_LO    vga_font
     538:       28 00 00 1f     cmplwi  r0,31
     53c:       7c 64 1b 78     mr      r4,r3
     540:       7f 9c 4a 14     add     r28,r28,r9
     544:       80 bd 00 34     lwz     r5,52(r29)
     548:       7c 7b e2 14     add     r3,r27,r28
     54c:       41 81 00 54     bgt     5a0 <draw_byte+0xc0>
     550:       3d 60 00 00     lis     r11,0
                        552: R_PPC_ADDR16_HA    .rodata+0x770
     554:       39 6b 07 70     addi    r11,r11,1904
                        556: R_PPC_ADDR16_LO    .rodata+0x770
     558:       54 00 10 3a     rlwinm  r0,r0,2,0,29
     55c:       7d 4b 00 2e     lwzx    r10,r11,r0
     560:       3d 20 00 00     lis     r9,0
                        562: R_PPC_ADDR16_HA    .rodata+0x770
     564:       39 29 07 70     addi    r9,r9,1904
                        566: R_PPC_ADDR16_LO    .rodata+0x770
     568:       7d 4a 4a 14     add     r10,r10,r9
     56c:       7d 49 03 a6     mtctr   r10
     570:       4e 80 04 20     bctr
     574:       48 00 00 91     bl      604 <draw_byte_32>
     578:       48 00 00 28     b       5a0 <draw_byte+0xc0>
     57c:       48 00 01 6d     bl      6e8 <draw_byte_16>
     580:       48 00 00 20     b       5a0 <draw_byte+0xc0>
     584:       48 00 02 31     bl      7b4 <draw_byte_8>
     588:       48 00 00 18     b       5a0 <draw_byte+0xc0>
     58c:       48 00 03 25     bl      8b0 <draw_byte_4>
     590:       48 00 00 10     b       5a0 <draw_byte+0xc0>
     594:       48 00 03 ad     bl      940 <draw_byte_2>
     598:       48 00 00 08     b       5a0 <draw_byte+0xc0>
     59c:       48 00 04 39     bl      9d4 <draw_byte_1>
     5a0:       80 01 00 34     lwz     r0,52(r1)
     5a4:       7c 08 03 a6     mtlr    r0
     5a8:       bb 21 00 14     lmw     r25,20(r1)
     5ac:       38 21 00 30     addi    r1,r1,48
     5b0:       4e 80 00 20     blr

As you can see, the switch statement is causing offsets fetch from
.rodata, and, since .rodata section is also not at its linked location,
the value fetched is total garbage or, in the case of my machine, it
causes a machine check.

Is there a gcc flag which will prevent generation of codes like this?  Or
any suggestion for better C codes?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
