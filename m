Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Linux 2_4_devel kernel hangs after control transferred from u-boot
Date: Thu, 2 Oct 2003 14:29:18 +0100
Message-ID: <A4EB77D93A60F347A518AC05291647D9032E5E@domosvr1.domo.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
From: "Stuart Vivian" <stuartvivian@domo.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am trying to get a linux kernel to build and run on a Cogent CSB272
(IBM PPC 405GP processor) running a U-boot 0.4.0 bootloader. I can tftp
a uImage into ram and it passes check, but when I run bootm it
uncompresses the kernel and hangs after it starts executing the kernel
at address 0x00000000.

I was given a hardhat vmlinux elf file that I can package to a uImage
and run (although it stops at the Calibrating Delay loop... Stage, but
that's another issue). I need to be able to recompile a kernel for the
board and downloaded linuxppc_2_4_devel from mvista. This compiles fine
and produces a new vmlinux. I've started off by using the walnut 405
config file to build the kernel, since they're pretty similar.

Any ideas where to start debugging this? I'm relatively new in embedded
stuff and linux in general, so it might be something simple, but don't
know where to start. Have a BDI2000 but no gdb driver yet, so can't put
in breakpoints etc.

The output I get from u-boot before it hangs up is shown below. There's
no ram disk image built in at the moment or initrd, but I just wan't to
get it off the ground and printing to the console to start.

Many thanks

Stuart

--------------------------------------------
U-Boot 0.4.0 (Oct  2 2003 - 09:46:35)

CPU:   IBM PowerPC 405GP Rev. E at 199.980 MHz (PLB=66, OPB=16, EBC=33
MHz)
           PCI sync clock at 33 MHz, internal PCI arbiter enabled
           16 kB I-Cache 8 kB D-Cache
Board: ### No HW ID - assuming CSB272
I2C:   ready
DRAM:  64 MB
Top of RAM usable for U-Boot at: 04000000
Reserving 221k for U-Boot at: 03fc8000
Reserving 384k for malloc() at: 03f68000
Reserving 112 Bytes for Board Info at: 03f67f90
Reserving 44 Bytes for Global Data at: 03f67f64
Stack Pointer at: 03f67f48
New Stack Pointer is: 03f67f48
Now running in RAM - U-Boot at: 03fc8000
FLASH: 32 MB
PCI Scan: Found Bus 0, Device 0, Function 0
In:    serial
Out:   serial
Err:   serial
setting up fs6377!
Reset Ethernet PHY
KGDB:  kgdb ready
ready
U-Boot relocated to 03fc8000
Net:   ppc_4xx_eth0
BEDBUG:ready
=> tftp 1000000 uImage
Trying ppc_4xx_eth0
using 100bT
using full duplex
ENET Speed is 100 Mbps - FULL duplex connection
TFTP from server 192.168.2.2; our IP address is 192.168.2.117
Filename 'uImage'.
Load address: 0x1000000
Loading:
#################################################################
         ###################################################
done
Bytes transferred = 591772 (9079c hex)
=> imi 1000000

## Checking Image at 01000000 ...
   Image Name:   Linux Kernel Image
   Created:      2003-10-02  12:57:10 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    591708 Bytes = 577.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
=> printenv
bootargs=root=/dev/ram console=ttyS0,9600 console=tty0
baudrate=9600
loads_echo=1
ethaddr=2A:EE:71:4C:11:9D
autoload=n
stdin=serial
stdout=serial
stderr=serial
filesize=9079c
gatewayip=192.168.2.1
netmask=255.255.255.0
ipaddr=192.168.2.117
serverip=192.168.2.2

Environment size: 261/262140 bytes
=> bootm 1000000
## Booting image at 01000000 ...
   Image Name:   Linux Kernel Image
   Created:      2003-10-02  12:57:10 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    591708 Bytes = 577.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x03F675E0 => set upper limit to 0x00800000
## cmdline at 0x007FFC00 ... 0x007FFC2D
bd address  = 0x03F67F90
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFE000000
flashsize   = 0x02000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0xFFFFFFFF
procfreq    = 199.980 MHz
plb_busfreq = 66.660 MHz
pci_busfreq = 33.330 MHz
ethaddr     = 2A:EE:71:4C:11:9D
IP addr     = 192.168.2.117
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
--------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
