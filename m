From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "jinoung kim" <jinoung@mail.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: omitted kernel sections
Date: Mon, 26 Jun 2000 15:43:35 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <384039193.961980819731.JavaMail.root@web538-mc.mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Nowadays, I'm trying load the kernel on my custom board. (which has MPC860)

when I was following the procedure : initialize console on SMC2, memory allocation for kernel and ramdisk...
there was a problem. The compressed kernel image wasn't loaded. So the procedure stopped on gunzip process.

I use AMC BDM port, and I speculate the messages.

It's the message when kernel is loaded.

---------------------------------------
> LOAD 'c:\860source\zvmlinux.initrd'
  Warning: symbols deleted - check use in macros etc.
 Loading section '.text' located at 0x00400000..0x004046E4
 Loading section '.rodata' located at 0x004046F0..0x00404B90
 Loading section '.data' located at 0x00405000..0x0040530C
 Loading section '.bss' located at 0x00406000..0x0040B1F0
  Warning:
  'main' function not found in file: c:\860source\zvmlinux.initrd
  Note: in startup routine. Enter STEP to go to High-level module.


This is the section map through the command 'objdump -h zvmlinux.initrd'

--------------------
zvmlinux.initrd:     file format elf32-big

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         000046e4  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       000004a0  004046f0  004046f0  000146f0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000030c  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .bss          000051f0  00406000  00406000  00016000  2**2
                  ALLOC
  4 .image        00064605  00000000  00000000  00016000  2**0
                  CONTENTS, READONLY
  5 .initrd       00201d19  00000000  00000000  0007a605  2**0
                  CONTENTS, READONLY

Why weren't .image, .initrd section loaded? Because they aren't elf format file?

But I tried. I changed the zipped files into elf data file as

.byte 0x00 0x00 blah blah blah...

And there was the same message, only four sections were loaded.

What can I do? I haven't any idea.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
