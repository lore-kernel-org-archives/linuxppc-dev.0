Date: Thu, 28 Mar 2002 09:44:34 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: crash on sleep with 2.4.19-pre4-ben0
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16qVWR-0000Ez-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Recently I have a hard time sending my TiBook to sleep. It started
crashing often a few weeks ago, and now, with 2.4.19-pre4-ben0, it
crashes reliably all the time.

Here's what xmon tells me:

vector: 300 at pc=c001ef74 (T sys_capset + 0x8c), lr=c001ef58 (T
sys_capset + 0x70)
msr=1032, sp=c3fafdc0 [c3fafd10]
dar=496e7665, dsisr=42000000
current=c3fae000, pid=374, comm=pmud

Here's the code around pc and lr (in other words, forget the symbol info
from xmon):

c001ef38 <del_timer>:
c001ef38:       94 21 ff e0     stwu    r1,-32(r1)
c001ef3c:       7c 08 02 a6     mflr    r0
c001ef40:       bf c1 00 18     stmw    r30,24(r1)
c001ef44:       90 01 00 24     stw     r0,36(r1)
c001ef48:       7c 7f 1b 78     mr      r31,r3
c001ef4c:       38 61 00 08     addi    r3,r1,8
c001ef50:       4b fe 77 a5     bl      c00066f4 <__save_flags_ptr>
c001ef54:       4b fe 78 55     bl      c00067a8 <__cli>
c001ef58:       81 7f 00 00     lwz     r11,0(r31)
c001ef5c:       2c 0b 00 00     cmpwi   r11,0
c001ef60:       40 82 00 0c     bne-    c001ef6c <del_timer+0x34>
c001ef64:       3b c0 00 00     li      r30,0
c001ef68:       48 00 00 14     b       c001ef7c <del_timer+0x44>
c001ef6c:       81 3f 00 04     lwz     r9,4(r31)
c001ef70:       3b c0 00 01     li      r30,1
c001ef74:       91 2b 00 04     stw     r9,4(r11)
c001ef78:       91 69 00 00     stw     r11,0(r9)
c001ef7c:       38 00 00 00     li      r0,0
c001ef80:       90 1f 00 00     stw     r0,0(r31)
c001ef84:       90 1f 00 04     stw     r0,4(r31)
c001ef88:       80 61 00 08     lwz     r3,8(r1)
c001ef8c:       4b fe 77 b9     bl      c0006744 <__restore_flags>
c001ef90:       7f c3 f3 78     mr      r3,r30
c001ef94:       80 01 00 24     lwz     r0,36(r1)
c001ef98:       7c 08 03 a6     mtlr    r0
c001ef9c:       bb c1 00 18     lmw     r30,24(r1)
c001efa0:       38 21 00 20     addi    r1,r1,32
c001efa4:       4e 80 00 20     blr

Per System.map, I was able to verify that at least one previous crash
(with 2.4.18-rc4-benh) was in the same place.

When these crashes started, I had changed, modulo kernel version of
course, these things:

- started to use unmasq_irq on the hd,
- installed pbbuttonsd & gtkpbbuttons

Removing both doesn't help. Also, it seems I need to power-off after a
crash to get airport back to life.

Anybody with more insight?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
