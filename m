Message-Id: <200110071920.VAA00680@piglet.grunz.lu>
Date: Sun, 7 Oct 2001 21:20:20 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Crash with BenH's 2.4.10/2.4.11-pre on 7600
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Recent 2.4 kernels refuse to boot my old faithful 7600 (OldWorld). Ben's
current 2.4.11-pre4-ben0 crashes inside kmalloc(), called from
__request_region():

vector: 300 at pc = c002e150, lr = c0019a08
msr = 9032, sp = c01d91f0 [c01d9140]
dar = 2c, dsisr = 40000000
current = c01d7460, pid = 0, comm = swapper
mon>

pc is here:

c002e0c4 <kmalloc>:
c002e0c4:       94 21 ff d0     stwu    r1,-48(r1)
c002e0c8:       7c 08 02 a6     mflr    r0
c002e0cc:       bf 81 00 20     stmw    r28,32(r1)
c002e0d0:       90 01 00 34     stw     r0,52(r1)
c002e0d4:       3d 20 c0 1e     lis     r9,-16354
c002e0d8:       80 09 ab 80     lwz     r0,-21632(r9)
c002e0dc:       7c 6b 1b 78     mr      r11,r3
c002e0e0:       2c 00 00 00     cmpwi   r0,0
c002e0e4:       7c 9c 23 78     mr      r28,r4
c002e0e8:       38 69 ab 80     addi    r3,r9,-21632
c002e0ec:       41 82 01 78     beq     c002e264 <kmalloc+0x1a0>
c002e0f0:       73 80 00 01     andi.   r0,r28,1
c002e0f4:       3d 20 c0 18     lis     r9,-16360
c002e0f8:       3c 80 c0 18     lis     r4,-16360
c002e0fc:       4f 80 00 00     mcrf    cr7,cr0
c002e100:       80 03 00 00     lwz     r0,0(r3)
c002e104:       7c 0b 00 40     cmplw   r11,r0
c002e108:       41 81 01 50     bgt     c002e258 <kmalloc+0x194>
c002e10c:       41 9e 00 0c     beq     cr7,c002e118 <kmalloc+0x54>
c002e110:       83 e3 00 08     lwz     r31,8(r3)
c002e114:       48 00 00 08     b       c002e11c <kmalloc+0x58>
c002e118:       83 e3 00 04     lwz     r31,4(r3)
c002e11c:       41 9e 00 34     beq     cr7,c002e150 <kmalloc+0x8c>
c002e120:       80 1f 00 2c     lwz     r0,44(r31)
c002e124:       3b c1 00 08     addi    r30,r1,8
c002e128:       70 0b 00 01     andi.   r11,r0,1
c002e12c:       3b bf 00 08     addi    r29,r31,8
c002e130:       40 82 00 4c     bne     c002e17c <kmalloc+0xb8>
c002e134:       38 84 f0 5c     addi    r4,r4,-4004
c002e138:       38 69 ef 70     addi    r3,r9,-4240
c002e13c:       38 a0 04 bd     li      r5,1213
c002e140:       4b fe 5d 5d     bl      c0013e9c <printk>
c002e144:       38 60 00 00     li      r3,0
c002e148:       48 05 ed 35     bl      c008ce7c <xmon>
c002e14c:       48 00 00 30     b       c002e17c <kmalloc+0xb8>
c002e150:       80 1f 00 2c     lwz     r0,44(r31)
^^^^^^^^
c002e154:       3b c1 00 08     addi    r30,r1,8
c002e158:       70 0b 00 01     andi.   r11,r0,1
c002e15c:       3b bf 00 08     addi    r29,r31,8
c002e160:       41 82 00 1c     beq     c002e17c <kmalloc+0xb8>

and lr points here:

c00199dc <__request_region>:
c00199dc:       94 21 ff e0     stwu    r1,-32(r1)
c00199e0:       7c 08 02 a6     mflr    r0
c00199e4:       bf 61 00 0c     stmw    r27,12(r1)
c00199e8:       90 01 00 24     stw     r0,36(r1)
c00199ec:       7c 7e 1b 78     mr      r30,r3
c00199f0:       7c 9c 23 78     mr      r28,r4
c00199f4:       7c bd 2b 78     mr      r29,r5
c00199f8:       7c db 33 78     mr      r27,r6
c00199fc:       38 60 00 1c     li      r3,28
c0019a00:       38 80 03 f0     li      r4,1008
c0019a04:       48 01 46 c1     bl      c002e0c4 <kmalloc>
c0019a08:       7c 7f 1b 79     mr.     r31,r3
^^^^^^^^
c0019a0c:       41 82 00 68     beq     c0019a74 <__request_region+0x98>
c0019a10:       7f e3 fb 78     mr      r3,r31
c0019a14:       38 80 00 00     li      r4,0
c0019a18:       38 a0 00 1c     li      r5,28
c0019a1c:       4b ff 5f 59     bl      c000f974 <memset>

I've tried to follow the code in kmalloc(), but I've not found a lot....
if I understand xmon's crashinfo right, it would seem that r31 points
into nowhereland, but I'm not sure where it gets loaded with what
address... that would be (r3+8), right? And r3 would point at
0xc01eab80, right? Well, that is in kernel space, and System.map says
this:

c01e9fd8 D font_sun_12x22
c01e9ff0 d fontdata_8x16
c01eaff0 D font_vga_8x16
c01eb008 d fb_fops
c01eb050 d red2

I'm confused....

Anybody who can help here?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
