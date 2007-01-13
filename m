Return-Path: <boardbringup@hotmail.com>
Received: from bay0-omc2-s26.bay0.hotmail.com (bay0-omc2-s26.bay0.hotmail.com
	[65.54.246.162]) by ozlabs.org (Postfix) with ESMTP id 25AA6DDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 21:58:21 +1100 (EST)
Message-ID: <BAY112-F31BA09B0E90550602613EC0B70@phx.gbl>
From: "Suresh Chandra Mannava" <boardbringup@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: kernel problem
Date: Sat, 13 Jan 2007 16:26:55 +0530
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_372e_31bb_50ac"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_372e_31bb_50ac
Content-Type: text/plain; format=flowed

Hi,

I am working on porting Linux 2.6.19 on a custom board with MPC7410 and 
CPC700 system controller.
I am using u-boot-1.1.6 for booting Linux. I found IBM spruce is also having 
CPC700, I followed spruce related files and made modifications accordingly.
Board supports external 2MB L2 cache and 128MB SDRAM.

I am encountering kernel panic(serial console messages attached with this 
mail). I traced the code by putting printk and found that kernel is crashing 
after executing all functions in start_kernel.
Is this problem related to L2 cache?
I didn't enabled L2 cache in Linux as well as in u-boot.
I request you to provide me some pointers and suggestions for finding out 
this problem. I am going to try with L2 cache enabled.

Thanks a lot.

Suresh Chandra Mannava

_________________________________________________________________
Try Sanjeev Kapoor's culinary delights! 
http://content.msn.co.in/Lifestyle/Moreonlifestyle/LifestylePT_101106_1530.htm

------=_NextPart_000_372e_31bb_50ac
Content-Type: text/plain; name="CAPTURE.TXT"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="CAPTURE.TXT"

bootm 2000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.19
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    705067 Bytes = 688.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07FB4CF0 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF13
memstart    = 0x00000000
memsize     = 0x08000000
flashstart  = 0xFFE00000
flashsize   = 0x00200000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x00000001
intfreq     =    363 MHz
busfreq     =     66 MHz
ethaddr     = 64:36:00:00:00:01
eth1addr    = 64:36:00:00:00:02
IP addr     = 192.168.0.100
baudrate    =  57600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Total memory = 128MB; using 256kB for hash table (at c0180000)
Linux version 2.6.19 (suresh@mannava) (gcc version 4.0.0 (DENX ELDK 4.0 
4.0.0)) #18 Thu Jan 11 10:34:36 IST 2007
System Identification: Cornet CSVG4 Linux Boot
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists.  Total pages: 32512
Kernel command line: console=ttyS0,57600
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128128k available (1068k kernel code, 336k data, 92k init, 0k 
highmem)
Mount-cache hash table entries: 512
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0011ADC LR: C0011B78 CTR: 00000005
REGS: c02edfb0 TRAP: 0300   Not tainted  (2.6.19)
MSR: 00001032 <ME,IR,DR>  CR: 24028022  XER: 20000000
DAR: 0000007D, DSISR: 42000000
TASK = c02e9b38[0] '' THREAD: 02dc5915
GPR00: 00200200 C02EE060 C02E9B38 C02E9B38 C0169DB4 00000000 C02EFFFC 
00000044
GPR08: 01C09000 00000078 C02E9B60 0000007D 00000000 04008C00 08003C00 
007FFF13
GPR16: 00000001 C01684C8 C0170000 C0170000 00000000 00000000 00880381 
C0169980
GPR24: C02EE000 C0169980 C02E9BF4 C02E9C48 00000000 C02E9B38 C02E9B38 
C00CE818
NIP [C0011ADC] dequeue_task+0x20/0x84
LR [C0011B78] deactivate_task+0x38/0x54
Call Trace:
Instruction dump:
90830028 91690004 912b0000 4e800020 81240000 39430028 3c000020 3929ffff
60000200 91240000 816a0004 81230028 <912b0000> 91690004 39240018 900a0004
Oops: kernel access of bad area, sig: 11 [#2]
NIP: C0012934 LR: C00128B0 CTR: 00000000
REGS: c02edd90 TRAP: 0600   Not tainted  (2.6.19)
MSR: 00001032 <ME,IR,DR>  CR: 44028024  XER: 00000000
DAR: 02DC593D, DSISR: 00000140
TASK = c02e9b38[0] '' THREAD: 02dc5915
GPR00: 02DC593D C02EDE40 C02E9B38 00000000 19EED540 00000001 C0169540 
00000000
GPR08: 08F9C6A0 00000008 00000000 02DC5915 08F9C6A0 04008C00 08003C00 
007FFF13
GPR16: 00000001 C01684C8 C0170000 C0170000 00000000 C0170000 C01672C0 
00000000
GPR24: C0160000 C0170000 C0160000 C02EDEC0 C0170000 C0169DB4 C0169980 
C02E9B38
NIP [C0012934] scheduler_tick+0x9c/0x350
LR [C00128B0] scheduler_tick+0x18/0x350
Call Trace:
Instruction dump:
801e0024 907e0018 7f9f0000 909e001c 419e0030 83bf0030 801e002c 7f9d0000
419e0048 817f0004 39200008 380b0028 <7d400028> 7d4a4b78 7d40012d 40a2fff4
Badness in do_exit at kernel/exit.c:859
Call Trace:
Kernel panic - not syncing: Aiee, killing interrupt handler!
<0>Rebooting in 180 seconds..


------=_NextPart_000_372e_31bb_50ac--
