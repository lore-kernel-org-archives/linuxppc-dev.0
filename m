Message-Id: <200106252029.WAA00806@piglet.grunz.lu>
Date: Mon, 25 Jun 2001 22:29:13 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Crash on BenH's latest rsync (2.4.6-pre3)
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

While booting BanH's latest rsync tree, I get the following crash:
(from memory, with what I noted down as xmon's printout)

Transfer Error Ack,
vector 200 at pc c00067b8 lr=c0005d58 msr 41000 sp c01e1420

Here's where pc and lr point to:

c00067a8 <__sti_end>:
c00067a8:       7c 00 00 a6     mfmsr   r0
c00067ac:       7c 00 18 78     andc    r0,r0,r3
c00067b0:       7c 00 23 78     or      r0,r0,r4
c00067b4:       7c 00 01 24     mtmsr   r0
c00067b8:       4c 00 01 2c     isync
c00067bc:       4e 80 00 20     blr

c0005cf8 <power_save>:
c0005cf8:       94 21 ff f0     stwu    r1,-16(r1)
c0005cfc:       7c 08 02 a6     mflr    r0
c0005d00:       90 01 00 14     stw     r0,20(r1)
c0005d04:       38 60 00 00     li      r3,0
c0005d08:       60 63 80 00     ori     r3,r3,32768
c0005d0c:       38 80 00 00     li      r4,0
c0005d10:       48 00 0a 99     bl      c00067a8 <__sti_end>
c0005d14:       80 02 00 14     lwz     r0,20(r2)
c0005d18:       2c 00 00 00     cmpwi   r0,0
c0005d1c:       40 82 00 3c     bne     c0005d58 <power_save+0x60>
c0005d20:       3d 20 c0 20     lis     r9,-16352
c0005d24:       7d 70 fa a6     mfdbsr  r11
c0005d28:       80 09 a1 f4     lwz     r0,-24076(r9)
c0005d2c:       55 6b 02 ce     rlwinm  r11,r11,0,11,7
c0005d30:       2c 00 00 00     cmpwi   r0,0
c0005d34:       41 82 00 0c     beq     c0005d40 <power_save+0x48>
c0005d38:       65 6b 00 50     oris    r11,r11,80
c0005d3c:       48 00 00 08     b       c0005d44 <power_save+0x4c>
c0005d40:       65 6b 00 90     oris    r11,r11,144
c0005d44:       7d 70 fb a6     mtdbsr  r11
c0005d48:       3c 80 00 04     lis     r4,4
c0005d4c:       38 60 00 00     li      r3,0
c0005d50:       60 84 80 00     ori     r4,r4,32768
c0005d54:       48 00 0a 55     bl      c00067a8 <__sti_end>
c0005d58:       38 80 00 00     li      r4,0
c0005d5c:       38 60 00 00     li      r3,0
c0005d60:       60 84 80 00     ori     r4,r4,32768
c0005d64:       48 00 0a 45     bl      c00067a8 <__sti_end>
c0005d68:       80 01 00 14     lwz     r0,20(r1)
c0005d6c:       7c 08 03 a6     mtlr    r0
c0005d70:       38 21 00 10     addi    r1,r1,16
c0005d74:       4e 80 00 20     blr

The strange part is that it crashes at varying points shortly after
bootup (when starting daemons; later when X is up, ...).

I was running 2.4.5-pre3 before (and now to compose this ;-); which is
rock solid for me.

Anyone seen this? Anyone want me to look further into debugging this?

Ah yes, I forget, this is on a TiBook (running Debian testing; but I
don't think that the distribution makes any difference...)

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
