Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: start / load addresses for kernel
Date: Fri, 21 Mar 2003 16:43:45 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNGEPGCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:  I have sent this query to the u-boot list and
did not receive a response - I am hoping that the linux/ppc
list might be a more appropriate list for this question -

I apologize for the cross posting, however I am in real need
of some direction

Kindest Regards,

Jerry Walden
-----Original Message-----
From: Jerry Walden [mailto:jwalden@digitalatlantic.com]
Sent: Friday, March 21, 2003 3:12 PM
To: U-Boot-Users@Lists. Sourceforge. Net
Subject: start / load addresses for kernel


Hello:

I received the below advice recently:

>since you are building for a non openbios kernel, you will need
>to change the make file.  The start/ load addresses and all are different

I am trying to get more detail on what needs to change,
I see 2 config options:

1) CONFIG_KERNEL_START_BOOL - is set this to yes
2) CONFIG_KERNEL_START -- what should this be set to - the default is
0xc0000000 seems fine to me

Are there any other options that I am missing?

Below is a log of my attempt to boot the kernel - displayed are the
command line that is getting passed in, and well as the startup parameters -
do these look okay - I made sure that the kernel bd_info struct is the same
as the u-boot struct

****************************************************************************
Script started on Fri Mar 21 14:43:27 2003
Welcome to minicom 1.83.1





U-Boot 0.2.0 (Mar 19 2003 - 12:09:59)
CPU:   IBM PowerPC 405GPr Rev. A at 266.666 MHz (PLB=133, OPB=66, EBC=26
MHz)
           PCI async ext clock used, internal PCI arbiter enabled
           16 kB I-Cache 16 kB D-Cache


Board: ### No HW ID - assuming WALNUT405
I2C:   ready
DRAM:  64 MB
Now running in RAM - U-Boot at: 03fcf000
FLASH: 512 kB

*** Warning - bad CRC, using default environment


PCI:   Bus Dev VenId DevId Class Int
PCI Autoconfig: Memory region: [20000000-27ffffff]
PCI Autoconfig: I/O region: [800000-3ffffff]
PCI Scan: Found Bus 0, Device 0, Function 0
PCI Scan: Found Bus 0, Device 7, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000000, address=0x20000000
PCI Autoconfig: BAR 1, I/O, size=0xffffff04, No room in resource
PCI Autoconfig: BAR 2, I/O, size=0x1000000, address=0x1000000
        00  07  1394  0978  0200  1c

In:    serial
Out:   serial
Err:   serial


U-Boot relocated to 03fcf000

IDE:   Bus 0: port = c
OK

 Device 0: Model: SanDisk SDCFB-64 Firm: Vdg 8.16. Ser#: 111913G1602X4714
            Type: Removable Hard Disk
            Capacity: 61.2 MB = 0.0 GB (125440 x 512)

=>
=> imi 0x200000

## Checking Image at 00200000 ...
   Image Name:   Linux-2.4.18_mvl30-walnut
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    298601 Bytes = 291.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

=> bootm 0x200000

## Booting image at 00200000 ...

   Image Name:   Linux-2.4.18_mvl30-walnut
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    298601 Bytes = 291.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

## Current stack ends at 0x03F9EBD8 => set upper limit to 0x00800000

## cmdline at 0x007FFF00 ... 0x007FFF20
root=/dev/ram console=ttyS0,9600

memsize     = 0x04000000
flashstart  = 0xFFF80000
flashsize   = 0x00080000
flashoffset = 0x00031000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x001E8480
procfreq    = 266.666 MHz
plb_busfreq = 133.333 MHz
pci_busfreq = 33.333 MHz
ethaddr     = 00:00:00:00:00:00
IP addr     = 0.0.0.0
baudrate    =   9600 bps
No initrd

## Transferring control to Linux (at address 00000000) ...


Thanks

Jerry Walden


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
