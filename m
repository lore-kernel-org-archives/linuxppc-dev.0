Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <19122-27221@sneakemail.com>
Date: Mon, 01 Mar 2004 22:41:34 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel hangs in early_init
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a PPC405GPr based board w/ 128Meg SDRAM, and I'm building
kernel 2.4.24 (devel CVS) for it. I also have U-Boot ported to
it, and I'm using U-Boot as the bootstrap loader.

I am able to compile a uImage, load the uImage via SystemACE,
and bootm seems happy with it. (See bootm log below.) I'm able
to show that head_4xx.S gets as far as calling early_init in
setup.c, and I can show that it starts executing in setup.c,
but calls to reloc_offset never execute. It appears that the
reloc_offset function never even starts.

I believe the SDRAM is configured OK, as u-boot is running out
of it quite happily. So I'm left wondering what can possibly
be wrong.

=> bootm 400000
## Booting image at 00400000 ...
    Image Name:   Linux-2.4.24-pre2
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    604749 Bytes = 590.6 kB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
## Current stack ends at 0x07F7FC28 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF30
bd address  = 0x07F7FE84
memstart    = 0x00000000
memsize     = 0x08000000
flashstart  = 0xFFF80000
flashsize   = 0x00080000
flashoffset = 0x0002A800
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0xF4000000
procfreq    = 266.500 MHz
plb_busfreq = 133.250 MHz
pci_busfreq = 33.312 MHz
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
