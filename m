Message-ID: <39D8A52D.22F2F7B8@agelectronics.co.uk>
Date: Mon, 02 Oct 2000 16:09:33 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Tim Montgomery <tjmontgo@home.com>
CC: Linux PPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: flying blind with BATs
References: <39D89C8F.4F328DAF@home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Montgomery wrote:

> I have the BATs configure (by the bootloader) such that 0xc0000000
> (virtual) is mapped to 0x00000000 (phys SDRAM base), but after
> the image is decompressed (to the virtual addr), I get garbage when
> I do a dump at 0xc0000000 (i.e. the kernel isn't there.)

My trick is just to load the ELF file to physical address 0. The elf
file format is easy enough to decode (mine is about 60 lines of C, and
I'll post it if there's interest). Then, I load r3 with a value to
indicate machine type ('TPE3' or 'TPE4'), and jump to the start of the
kernel turning off the cache and MMU.

Important things to note are:
1) Flush the caches over the region you've just loaded before fiddling
with MMU and cache settings.

Here's the section of my bootloader - r3 is the kernel entry point
(physical address) and r4 is 'TPE3':
ppc_run_executable:
        mtspr   SRR0, r3
        mr      3, 4
        mfspr   9, HID0
        li      10, HID0_DCE
        andc    9, 9, 10
        mtspr   HID0, 9
        sync
        mfmsr   9
        li      10, MSR_DR | MSR_IR
        andc    9, 9, 10
        mtspr   SRR1, 9
        sync
        rfi

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
