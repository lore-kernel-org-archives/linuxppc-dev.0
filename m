Message-ID: <B895EFF5AF34724880036BDB5B5B8148135698@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Scott Anderson'" <sanders@mvista.com>,
	??? <nari_dhy@nari-china.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: bootstrap of virtex-ii pro eval board ML300
Date: Mon, 2 Jun 2003 13:41:31 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are two details here, one of them important.

(1) The System ACE is one configuration option; you can also
download a new bit file via the JTAG cable.

(2) Whether the bit file is obtained via System ACE or JTAG,
the FPGA is initialized.  This includes populating the
block RAM.

Note that your block RAM will almost certainly not be
big enough to contain your Linux kernel.  Sizes vary but
in my experience they are measured in kilobytes -- e.g.
4KB to 64KB.  For this reason, it is preferable to have
the ELF file that is contained in your bitstream be a *small*
executable that can fit in the block RAM.  This small
executable can *find* a larger executable (e.g. the Linux
kernel image), from a flash device, compact flash, TFTP,
etc., then load and run it.


-----Original Message-----
From: Scott Anderson [mailto:sanders@mvista.com]
Sent: Monday, June 02, 2003 1:36 PM
To: ???
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootstrap of virtex-ii pro eval board ML300



On Saturday, May 31, 2003, at 06:14  PM, 丁厚永 wrote:
\We have subscribe the ML300 demo board from xilinx,but it needs several
> months to arrive. I remember someone has done some work in virtex II
> pro demo boards.Will someone tell me some details about the bootstrap's
> procedure of such systems.

A quick high level description from my understanding:
There is a piece of Xilinx hardware called System ACE which reads
a rotary switch to determine which of eight possible files it
should load from the first partition (which must be a FAT partition)
of the IBM MicroDrive.  System ACE initializes the FPGA, processor
and memory by using the contents of this file to manipulate the
JTAG chain.  Xilinx provides tools so that you can combine an
ELF image (e.g. a Linux kernel) with an FPGA bitstream so that
when the processor comes out of reset, your image is already
loaded into memory ready to go.  For your development, I would
suggest using a JTAG debugger (specifically, the Abatron BDI2000)
to load your kernel into memory so that you don't have to keep
mucking with the MicroDrive.  Having the BDI2000 also gives you
a good tool for debugging the kernel and drivers.

    Scott


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
