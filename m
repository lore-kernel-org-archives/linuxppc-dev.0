Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <402A7561.7020105@246tNt.com>
Date: Wed, 11 Feb 2004 19:33:05 +0100
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL
References: <20040210220007.54753C1215@atlas.denx.de>
In-Reply-To: <20040210220007.54753C1215@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

Thanks for your advices.

I've managed to compile U-Boot in a lowboot configuration :

# make MPC5200LITE_LOWBOOT_config
# <edit the config.mk of the board to set TEXTADDR>
# make

Then flash it with the dBUG ( the defaut motorola stuff on the flash ) :

 > dn -i -o 0x100000 /mpc5200/u-boot.bin
 > fe 0xff000000 0xff050000
 > fp 0xff000000 0xff040000 0x100000

Then, changing the jumpers setting on the board to low-boot, it boots
fine on U-Boot.
 From there I download the freshly downloaded/compiled kernel image (
from denx cvs linux_2_4_devel, configured with icecube_5200_config ) and
try to boot it :

[... Cut ...]

=> tftpboot 200000 mpc5200/uImage
Using FEC ETHERNET device
TFTP from server 192.168.1.1; our IP address is 192.168.1.3
Filename 'mpc5200/uImage'.
Load address: 0x200000
Loading: #################################################################
         ############################################################
done
Bytes transferred = 635394 (9b202 hex)
=> bootm 200000
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.24-pre2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    635330 Bytes = 620.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.24-pre2 (tnt@246tNt-main) (gcc version 3.4.0 20040127
(prerel4On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Calibrating delay loop... 263.78 BogoMIPS
Memory: 62740k available (1096k kernel code, 356k data, 60k init, 0k
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
Oops: kernel access of bad area, sig: 11
NIP: DFFEFDEC XER: 20000000 LR: C0003998 SP: C02CBFD0 REGS: c02cbf20
TRAP: 0400dMSR: 20009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c02ca000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: DFFEFDED C02CBFD0 C02CA000 00000000 00001032 C03F1F48 00000016
C02CA03C
GPR08: C02CA000 C0150000 C03F003C C0150000 00000000 FFFFEFFF 03FFA000
00000000
GPR16: 00000001 FFFFFFFF 00000000 03FF432C 003FF000 03FA1D80 03FFF1B0
00000002
GPR24: 00000000 007FFEB0 40000000 C012B000 007FFF00 00000000 C014BC00
C014BC04
Call backtrace:
C0003978 C00073F8
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

[... End of cut ...]

But as you can see, it doesn't exactly do what I hoped ;) I was waiting
for an "Unable to mount root" since I didn't put a rootfs yet but it
crashes before that ( i think )
 From what I can see in the System.map, the call backtrace are :

c0003918 t run_init_process
c00073cc T arch_kernel_thread

Any comments ?


    Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
