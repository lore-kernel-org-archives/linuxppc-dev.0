Message-ID: <BE1C564723B3D21191FD0000F840E39801D81549@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Questions about 8xxrom
Date: Fri, 26 May 2000 09:48:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been using 8xxrom-0.3.0 to start up my board.
Since I couldn't get the ELF reading to work,
I added a "go" command..
"go 0xff810000" is what I use to start Linux.

Now, I've gone back to try the ELF method.  My flash starts at FF800000, and
the zImage.initrd is stored at the beginning of flash.  I found three things
that had been in my way:
1) rom_bread() second parameter was edited sometime to be 0-based, but elf.c
still wants it to be 1-based.  I don't know the proper fix, but I edited
rom_bread() to be 1-based again.

2) After elf.c reads the image into RAM, it sets eh = bp; but bp was
modified during the read loop.  Better to set eh = zstart.

3) 500000 bytes is not enough for zImage.initrd.  I made it 2000000 (elf.c).

After all that, it still fails, while decompressing initrd.
I think the problem is that the board information overwrites part of initrd,
as shown in the boot text:

rom:0:/> bootz
No filesystem found

entry 0x100000, phoff 0x34, shoff 0x1e9064
phnum 0x1, shnum 0xa
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x6318, p_memsz 0xc318
Loading at 0x10d000
Starting 0x11d000
loaded at:     0011D000 00129318
relocated to:  00100000 0010C318
board data at: 00FFF000 00FFF138
relocated to:  00200100 00200238	<= oops, why here?
zimage at:     00124000 00184034
initrd at:     00184034 002F6023	<<
avail ram:     002F7000 01000000

I'm continuing to look at the code to see why the initrd gets overwritten.
I'm using the arch/ppc/mbxboot loader.

I see that 8xxrom is supposed to be on sourceforge as ppcboot, but nothing
is on the website yet, so I'm asking here.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
