Message-Id: <4.3.2.20000821065652.00b573b0@falcon.si.com>
Date: Mon, 21 Aug 2000 07:24:18 -0400
To: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: PPCBoot memory mapping problems
In-Reply-To: <1.5.4.32.20000819004501.006984e4@pop.esteem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:45 PM 8/18/00 -0700, clark@esteem.com wrote:

>         Okay here is the situation,
>
>         I have hacked & slashed the PPCBoot code to work with our custom
>board (all except the flash portion). I have mapped the memory as show
>below.
>
>   address       size            name            BR#/OR#         buswidth
>0x00000000      8meg            Bank0           1               32
>0x00800000      8meg            Bank1           2               32
>0x40000000      2meg            Flash0          0               16
>0x60000000*     2meg            Flash1          3               16
>0xFFF00000      whatever        IMMR            N/A             N/A
>
>(* Note will be remapped to the end of flash0 to form contigious flash
>block
>when I get around to hacking the flash code)

One thing that leaps out at me which could be a problem, depending on
conditions and code, is the IMMR address.  We found it much easier to
just set the IMMR to 0xF0000000 rather than fight the code to put it
elsewhere.  Theoretically, it can be anywhere above the virtual address
of RAM (0xC0000000).  You also have to be _very_ careful in your IMMR
remap code that it only is executed _once_.  If you execute it a second
time or try to remap it but don't have the correct current IMMR address
(you need the current IMMR address in order to set it to the new
address), you will (probably) cause a bus fault and Bad Things Will Happen.

It shouldn't be a problem, but I would strongly urge you to _not_ set
the IMMR to 0xFFF00000 because that is the magic boot address.  It will
be very confusing for everybody who follows in your footsteps as to why
you appear to be overwriting your boot code when you do IMMR I/O.  I
would recommend you use one of the power up selectable IMMR addresses
(0xF0000000 is the only one that is above 0xC0000000) and it is easier
if you set your boot configuration to set the IMMR to 0xF0000000 on
bootup to make it match the linux expectations.

Another possibility is your flash addresses.  The kernel makes
assumptions that the addresses of I/O is higher than the end of virtual
RAM: if your kernel is using the flash[01], it may be getting confused.

This is what Jon Diekema and I came up with for Linux memory mapping
rules, applied to mapping the resource on the EST SBC8260 board.

         * EST SBC8260 Linux memory mapping rules:

         Initial conditions:
         -------------------

         Tasks that need to be perform by the boot ROM before control is
         transferred to zImage (compressed Linux kernel):

         - Define the IMMR to 0xf0000000

         - Initialize the memory controller so that RAM is available at
           physical address 0x00000000.  On the SBC8260 is this 16M (64M)
           SDRAM.

         - Build the board information structure (see
           include/asm-ppc/est8260.h for its definition)

         - The compressed Linux kernel (zImage) contains a bootstrap
loader
           that is position independent; you can load it into any RAM,
           ROM or FLASH memory address >= 0x00200000 (above 2 MB).

           Note: If zImage is loaded at its link address of 0x00400000
(4 MB),
                 then zImage will skip the step of moving itself to
                 its link address.

         - Load R3 with the address of the board information structure

         - Transfer control to zImage

         - The Linux console port is SMC1, and the baud rate is controlled
           from the bi_baudrate field of the board information structure.
           On thing to keep in mind when picking the baud rate, is that
           there is no flow control on the SMC ports.  I would stick
           with something safe and standard like 19200.

           On the EST SBC8260, the SMC1 port is on the COM1 connector of
           the board.


         EST SBC8260 defaults:
         ---------------------

         0x00000000-0x00FFFFFF   16M (64M) SDRAM
         0xFE000000-0xFFFFFFFF    4M flash (SIMM)
         0xFC000000-0xFCFFFFFF    2M flash (8 bits wide, soldered to
the board)
         0x22000000-0x2200FFFF    8K EEPROM
         0x04000000-0x04FFFFFF    4M local bus SDRAM (soldered to the
board)
         0x21000000-0x21000000   Flash present detect (from the flash SIMM)
         0x21000001-0x21000001   Switches (read) and LEDs (write)

         - BATs can map 128K-256Mbytes each.  There are four data BATs and
           four instruction BATs.  Generally the data and instruction BATs
           are mapped the same.

         - The chip selects can map 32K blocks and up (powers of 2)

         - The SDRAM machine can handled up to 128Mbytes per chip select

         - The IMMR must be set above the kernel virtual memory addresses,
           which start at 0xC0000000.  Otherwise, the kernel may crash as
           soon as you start any threads or processes.

         - Linux uses the 60x bus memory (the SDRAM DIMM) for the
           communications buffers.

         - RAM is at physical address 0x00000000, and gets mapped to
0xC0000000
           for the kernel.


         Physical addresses used by the Linux kernel:
         --------------------------------------------

         0x00000000-0x3FFFFFFF   1GB reserved for RAM
         0xF0000000-0xF001FFFF   128K IMMR  64K used for dual port memory,
                                  64K for 8260 registers


         Logical addresses used by the Linux kernel:
         -------------------------------------------

         0xF0000000-0xFFFFFFFF   256M BAT0 (IMMR: dual port RAM, registers)
         0xE0000000-0xEFFFFFFF   256M BAT1 (I/O space for custom boards)
         0xC0000000-0xCFFFFFFF   256M BAT2 (RAM)
         0xD0000000-0xDFFFFFFF   256M BAT3 (if RAM > 256MByte)


         EST SBC8260 Linux mapping:
         --------------------------

         DBAT0, IBAT0, cache inhibited:

                                 Chip
         Memory                  Sel Use
         ---------------------   --- ---------------------------------
         0xFE000000-0xFFFFFFFF   CS0 4M/16M flash (SIMM)
         0xFD000000-0xFDFFFFFF   CS1 0M/16M Reserved for expanded SIMM
flash
         0xFC000000-0xFCFFFFFF   CS6 2M/16M flash (onboard)
         0xFA000000-0xFABFFFFF   CS4 4M/16M local bus SDRAM
         0xF8010000-0xF801FFFF   CS5 8K/64K EEPROM
         0xF8000000-0xF800FFFF   CS7 2B/64K LED, switches, flash
present detect
         0xF0000000-0xF001FFFF   n/a IMMR: dual port RAM, registers

         DBAT1, IBAT1, cache inhibited:


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
