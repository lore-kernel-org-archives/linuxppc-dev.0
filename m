Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 5682FB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 02:14:00 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so773264rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 09:13:58 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Fri, 26 Jun 2009 11:13:38 -0500
Message-ID: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
Subject: Trouble "Transferring control to Linux (at address 00000000)"
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm trying to load Linux from U-Boot. I am using ELDK 4.2 with U-Boot
2009.03 on an EP88xC rev1.1 board (MPC885 cpu, 64MB RAM, 32MB FLASH).
The linux kernel sources were obtained from instructions at
"http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.1."
and the FDT blob (dtb) was generated from
"linux-2.6-denx/arch/powerpc/boot/dts/ep88xc.dts". Below is my output
from boot to hang:

U-Boot 2009.03-svn8591 (Jun 25 2009 - 11:08:09)

CPU:   MPC885ZPnn at 100 MHz [40.0...133.0 MHz]
       8 kB I-Cache 8 kB D-Cache FEC present
clock 100000000Hz != 300000Hz
Board: EP88xC 1.1  CPLD revision 2
DRAM:  64 MB
Top of RAM usable for U-Boot at: 04000000
Reserving 208k for U-Boot at: 03fcb000
Reserving 384k for malloc() at: 03f6b000
Reserving 60 Bytes for Board Info at: 03f6afc4
Reserving 56 Bytes for Global Data at: 03f6af8c
Stack Pointer at: 03f6af68
New Stack Pointer is: 03f6af68
Now running in RAM - U-Boot at: 03fcb000
FLASH: flash detect cfi
fwc addr fc000000 cmd f0 f0 8bit x 8 bit
...
... <some output skipped> ...
...
is= cmd 59(Y) addr fc000048 is= 00590059 00590059
device interface is 2
found port 4 chip 2 port 32 bits chip 16 bits
00 : 51 52 59 02 00 40 00 00 00 00 00 27 36 00 00 07  QRY..@.....'6...
...
... <some output skipped> ...
...
fwc addr fc000154 cmd 98 00980098 32bit x 16 bit
manufacturer is 2
manufacturer id is 0x1
device id is 0x227e
device id2 is 0x0
cfi version is 0x3133
size_ratio 2 port 32 bits chip 16 bits
found 1 erase regions
erase region 0: 0x0200007f
erase_region_count = 128 erase_region_size = 131072
fwc addr fc000000 cmd f0 00f000f0 32bit x 16 bit
flash_protect ON: from 0xFC000000 to 0xFC02DFFF
protect on 0
flash_protect ON: from 0xFC040000 to 0xFC07FFFF
protect on 1
32 MB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
U-Boot relocated to 03fcb000
Net:   FEC ETHERNET, FEC2 ETHERNET
### main_loop entered: bootdelay=2

### main_loop: bootcmd="bootm fc080000"
Hit any key to stop autoboot:  0
## Current stack ends at 0x03f6ad50
*  kernel: cmdline image address = 0xfc080000
Wrong Image Format for bootm command
ERROR: can't get kernel image!
=> setenv ipaddr 10.0.54.150
=> setenv serverip 10.0.54.129
=> setenv bootargs root=/dev/ram0 rw
=> setenv ethaddr 00-e0-86-0c-84-fd
eth_set_enetaddr(num=0, addr=00-e0-86-0c-84-fd)
Setting new HW address on FEC ETHERNET
New Address is             00:E0:86:0C:84:FD
eth_set_enetaddr(num=0, addr=00-e0-86-0c-84-fd)
Setting new HW address on FEC ETHERNET
New Address is             00:E0:86:0C:84:FD
=> tftp 400000 ep88x_uimage2
Trying FEC ETHERNET
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_uimage2'.
Load address: 0x400000
Loading: #################################################################
         ########
done
Bytes transferred = 1061544 (1032a8 hex)
=> tftp 550000 ep88x_ramdisk3
Trying FEC ETHERNET
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_ramdisk3'.
Load address: 0x550000
Loading: #################################################################
         #############################################################
done
Bytes transferred = 1846099 (1c2b53 hex)
=> tftp 750000 ep88x_dtb
Trying FEC ETHERNET
Using FEC ETHERNET device
TFTP from server 10.0.54.129; our IP address is 10.0.54.150
Filename 'ep88x_dtb'.
Load address: 0x750000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
=> bootm 400000 550000 750000
## Current stack ends at 0x03f6ad60
*  kernel: cmdline image address = 0x00400000
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.30-rc2-01402-gd4e2f68-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1061480 Bytes =  1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Entry Point:  00000000
   kernel data at 0x00400040, len = 0x00103268 (1061480)
*  ramdisk: cmdline image address = 0x00550000
## Loading init Ramdisk from Legacy Image at 00550000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1846035 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   ramdisk start = 0x00550040, ramdisk end = 0x00712b53
*  fdt: cmdline image address = 0x00750000
## Checking for 'FDT'/'FDT Image' at 00750000
*  fdt: raw FDT blob
## Flattened Device Tree blob at 00750000
   Booting using the fdt blob at 0x750000
   of_flat_tree at 0x00750000 size 0x00003000
   Uncompressing Kernel Image ... OK
   kernel loaded at 0x00000000, end = 0x00226224
## initrd_high = 0xffffffff, copy_to_ram = 1
   Loading Ramdisk to 03da7000, end 03f69b13 ... OK
   ramdisk load start = 0x03da7000, ramdisk load end = 0x03f69b13
## Transferring control to Linux (at address 00000000) ...
   Booting using OF flat tree...

I did a post-mortem analysis
(http://www.denx.de/wiki/view/DULG/LinuxPostMortemAnalysis) and came
up with the following message:
<6>Using Embedded Planet EP88xC machine description.
<0>Kernel panic - not syncing: Error: Failed to allocate 0x1
................0x800000..
<0>.
<4>Call Trace:.
<4>................69e0]
show_stack...............................21f00] [c001bcb4]
panic+0x8c/0x1................ [c01fac70] lmb_alloc+0x0/0xc.
<4>[c0221f70] [c01................_page+0x60/0x74.
<4>[c0221f80] [c01a4484] pte_alloc_one_kernel+0x

I'm not quite sure where to go from here to get linux working. Anybody
have any suggestions?

Thank you,
Mikhail Zaturenskiy
