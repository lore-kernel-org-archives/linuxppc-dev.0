Message-Id: <m12mgPF-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Getting the image section of the ELF file to load w/ VxWorks boot ROM
To: linuxppc-embedded@lists.linuxppc.org, bkuschak@yaoo.com,
        jim.chapman@iname.com, frank@mitre.org
Date: Tue, 2 May 2000 13:24:21 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	I am having trouble loading the image section of the elf file
	(contains the gzip compressed Linux kernel) with the VxWorks boot
	ROM or the EST VisionICE on the EST SBC8260 board.  Both of these
	options appear to ignore this section.

	This problem was discussed on the linuxppc-embedded mailing list
	on 11/2[2-3]/99.  A few approaches were put forth, but not all the
	details were included.  Does someone have a recipe on how to solve
	this problem?

	CPU: EST Corp. est8260 -- MPC8260 PowerQUICC II SBC
	Version: 5.4
        BSP version: 1.2/3

	I have managed to use ".gzimage" instead of "image" as the
	section name and have changed the section flags, but I don't
	think this is enough.

bucks 2166} powerpc-linux-objdump -h zImage

zImage:     file format elf32-powerpc

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00004494  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000470  004044a0  004044a0  000144a0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000030c  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00406000  00406000  00016000  2**0
                  CONTENTS
  4 .bss          0000526c  00406000  00406000  00016000  2**2
                  ALLOC
  5 .gzimage      0006fd80  00000000  00000000  00020000  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
