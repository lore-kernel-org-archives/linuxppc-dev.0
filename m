Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <402AC1A4.7070304@246tNt.com>
Date: Thu, 12 Feb 2004 00:58:28 +0100
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL
References: <20040211200900.8CAD6C108D@atlas.denx.de>
In-Reply-To: <20040211200900.8CAD6C108D@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello



>>I've managed to compile U-Boot in a lowboot configuration :
>>
>># make MPC5200LITE_LOWBOOT_config
>># <edit the config.mk of the board to set TEXTADDR>
>>
>>
>
>No such edit is necessary!!!!
>
>
Oh, ok. I've changed it back, and recompiled / reinstalled U-boot just
to be sure ( I don't think it can be of any influence but ... )

>> From there I download the freshly downloaded/compiled kernel image (
>>from denx cvs linux_2_4_devel, configured with icecube_5200_config ) and
>>try to boot it :
>>
>>
>...
>
>
>>zone(1): 0 pages.
>>zone(2): 0 pages.
>>Kernel command line:
>>
>>
>
>You don't pass any "bootargs" here? Where is your root filesystem?
>
>See http://www.denx.de/twiki/bin/view/DULG/LinuxKernelArgs
>
>
>
I had none. I just planned to do it as soon as I got an unable to mount
root error. To be sure it was not the problem, I took
the pRamdisk file from
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ppc_82xx/ as I seen
from another post.

To launch it I use :
tftp 100000 mpc5200/uImage; tftp 200000 mpc5200/pRamdisk; bootm 100000
200000

The environment variable bootargs is set to "root=/dev/ram rw"

The "new" output is included at the end , quite similar.

One other weird things is that I was forced to setenv bootargs, then
saveenv it, then reset to try to boot. If i just set the bootargs before
the bootm, it decompressed the two images, but the kernel was not
(apparently) starting ...

>>POSIX conformance testing by UNIFIX
>>PCI: Probing PCI hardware
>>PCI: Cannot allocate resource region 0 of device 00:1a.0
>>
>>
>
>This looks fishy. Is there a PCI card installed? Remove it!!
>
>
Huh, no. The only things connected to the board are the alim, the serial
cable, and a crossed RJ45 cable ( direct connection to my PC ). Jumper
setting are all default execpt for the low boot settings.

U-Boot seems to 'see' a device too :

U-Boot 1.0.2 (Feb 12 2004 - 00:17:05)


CPU:   MPC5200 (JTAG ID 0001101d) at 396 MHz
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
Board: Motorola MPC5200 (IceCube)
I2C:   85 kHz, ready
DRAM:  64 MB
FLASH: 16 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5803  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET

Maybe I'm mistaken, but isn't this the motorola itself ?


>>But as you can see, it doesn't exactly do what I hoped ;) I was waiting
>>for an "Unable to mount root" since I didn't put a rootfs yet but it
>>crashes before that ( i think )
>>
>>
>
>Did you modify the kernel configuration? Did you try  passing  useful
>kernel boot arguments?
>
>
At first, I tried with a kernel I compiled some time ago, when I ordered
the board but didn't yet have it. ( 27 january ), and I had changed some
stuff. When I saw it didn't work, I took a new fresh copy from cvs and
make the default config and compiled it.


Is a default, precompiled kernel image available somewhere ?
Maybe my toolchain is producing weird binaries ....
I'll try to install the toolchain from denx.


Thanks for your help,

    Sylvain Munaut


[ New output ]

Bytes transferred = 1400262 (155dc6 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.24-pre2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    635420 Bytes = 620.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00200000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1400198 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03e4b000, end 03fa0d86 ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.24-pre2 (tnt@246tNt-main) (gcc version 3.4.0 20040127
(prerelease)) #4 Wed Feb 11 19:55:20 CET 2004
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Calibrating delay loop... 263.78 BogoMIPS
Memory: 61372k available (1096k kernel code, 356k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:1a.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
floating point used in kernel (task=c3e44000, pc=ffbad4c4)
Oops: kernel access of bad area, sig: 11
NIP: FFF02448 XER: 20000000 LR: FFF00024 SP: C3E45FD0 REGS: c3e45f20
TRAP: 0300    Not tainted
MSR: 0000b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 00016F88, DSISR: 22000000
TASK = c3e44000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: FFBAD4C7 C3E45FD0 C3E44000 00000000 00001032 C3FDBF48 00000016
C3E4403C
GPR08: C3E44000 C0150000 C3FDA03C C0150000 00000000 FFE7FFFF 03FFA000
00000000
GPR16: 00000001 FFFFFFFF 00000000 03FF432C C0130000 C014BC00 C0130000
00000001
GPR24: C0110000 00000002 C014BC00 00000000 00352B46 00000000 C014BC00
00016F88
Call backtrace:
C00039B0 C0007498
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

[ End of output ]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
