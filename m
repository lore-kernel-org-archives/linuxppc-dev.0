Message-ID: <39929A9C.C17E22D7@dgt-lab.com.pl>
Date: Thu, 10 Aug 2000 14:05:48 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: too few RAM?
References: <00Jun4.144038est.115228@border.alcanet.com.au>
	 <393BBE5D.49B17E9C@embeddededge.com> <00Jun6.135659est.115272@border.alcanet.com.au>
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i'm trying to run  mpc8xx-2.2.13 (with all patches I found)
 - with 8xxrom (0.3.0)
 - on MPC8XXFADS
    .MPC823e
    .4MB RAM
    .2MB FLASH

this is is my boot time output:
==================

entry 0x100000, phoff 0x34, shoff 0x75a60
phnum 0x1, shnum 0x9
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x530c, p_memsz 0xb1cc
Loading at 0x10c000
Size 486060
475 blocks
Starting 0x11c000
loaded at:     0011C000 001271CC
relocated to:  00100000 0010B1CC
board data at: 003F0000 003F001C
relocated to:  0010C100 0010C11C
zimage at:     00122000 00181A24
avail ram:     00182000 00400000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

and here is what
====================
exception: Implementation Specific Instruction TLB miss
0xc00d95bc  can't read memory address

f823Bug> md 0d95b0 :i
0x000d95b0:             bb010010 lmw    r24, 0x10(r1)
0x000d95b4:             38210030 addi   r1,r1, 0x30
0x000d95b8:             4e800020 bclr   0x14,0
0x000d95bc:             9421ffd0 stwu   r1,-0x30(r1)
0x000d95c0:             7c0802a6 mfspr  r0,LR
0x000d95c4:             bf810020 stmw   r28, 0x20(r1)
0x000d95c8:             90010034 stw    r0, 0x34(r1)
0x000d95cc:             3d20c00d addis  r9,r0,0xc00d
0x000d95d0:             80697420 lwz    r3, 0x7420(r9)
0x000d95d4:             3fa0c00d addis  r29,r0,0xc00d
0x000d95d8:             4bf36f79 bl     0x00010550
0x000d95dc:             3f80c00d addis  r28,r0,0xc00d
0x000d95e0:             38610008 addi   r3,r1, 0x8
0x000d95e4:             38bc7408 addi   r5,r28, 0x7408
0x000d95e8:             389d7404 addi   r4,r29, 0x7404
0x000d95ec:             480004d9 bl     0x000d9ac4

====================
Q1: is it not enough RAM to run this stuff ?

Q2: does anyone have ALL pathched files to run with my board?
  (HHL nos not support FADS!)


PS please answer to my priv too (krom@dgt-lab.com.pl)

* * * * * * * * * * * * *
* per pedes ad astra !  *
* * * * * * * * * * * * *    mailto:krom@softomat.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
