Return-Path: <gjkwon@idis.co.kr>
Received: from gw.idis.co.kr (unknown [211.47.237.15])
	by ozlabs.org (Postfix) with ESMTP id 6B7C667C40
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 19:23:43 +1000 (EST)
Message-ID: <44EEBEF2.1000609@idis.co.kr>
Date: Fri, 25 Aug 2006 18:12:18 +0900
From: =?EUC-KR?B?Imdqa3dvbiixx7HiwdgpIg==?= <gjkwon@idis.co.kr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: When mounting using USB-CDROM, segment fault is called and system
	hangon
Content-Type: text/plain; charset=EUC-KR
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.
I am KiJun Kwon who lives in South Korea. 
Nice to meet your group. Now, I really want to fix the bellow problem. ^^ 


Most recent kernel where this bug did not occur: 
For 2.6.15, 2.6.17, it is occurred 

Hardware Environment: bamboo board(PPC440EP Rev.B)

Software Environment: debian

Problem Description:
To read the files in the cdrom, I used USB-CDROM device(it is not specific to 
a vendor, model). When I try to mount, below dmesg is printed and system is 
hangon or segmentation fault is called. 

juno-nfs:~# mount -o ro -t iso9660 /dev/sr0 /mnt
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 7C0802A4 LR: D101CB7C CTR: 7C0802A6
REGS: cb747990 TRAP: 0400   Not tainted  (2.6.17)
MSR: 00029000 <EE,ME>  CR: 22002428  XER: 00000000
TASK = cbe2e830[377] 'mount' THREAD: cb746000
GPR00: 7C0802A6 CB747A40 CBE2E830 C062E1F8 00000000 CB747A00 00000000 C027E130
GPR08: CB646B3C 0000000C C02FA100 C04BC02C 0000825F 1002A544 10024B18 10024AE8
GPR16: 10024AC8 00000000 00000000 10024AB8 00000000 10020000 00000000 10024AF8
GPR24: C04AFC08 CB747A58 CB747CB8 D1020000 D102A144 00000000 D1020000 C062E1F8
NIP [7C0802A4] 0x7c0802a4
LR [D101CB7C] cdrom_open+0x3a0/0xad8 [cdrom]
Call Trace:
[CB747A40] [D101CB18] cdrom_open+0x33c/0xad8 [cdrom] (unreliable)
[CB747BD0] [D1029DF0] sr_block_open+0x8c/0xd8 [sr_mod]
[CB747BF0] [C0060444] do_open+0x94/0x398
[CB747C30] [C0060840] blkdev_get+0x64/0x78
[CB747D70] [C00608A4] open_bdev_excl+0x50/0xd8
[CB747D90] [C005F1F4] get_sb_bdev+0x30/0x188
[CB747DE0] [C00E4B08] isofs_get_sb+0x18/0x28
[CB747DF0] [C005E60C] do_kern_mount+0x58/0x10c
[CB747E10] [C007701C] do_mount+0x254/0x704
[CB747F10] [C007755C] sys_mount+0x90/0xe4
[CB747F40] [C0001C88] ret_from_syscall+0x0/0x3c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Segmentation fault



After this error, when I try to remount, system is freezed without any mesg.
But, for a IDE-CDROM device, it works fine. 
For x86 cpu, same kernel version, configuration, it wasn't happened. So, it 
seems that ppc32-usb cdrom combination has a bug. 


kkj-nfs:~# lsmod
Module                  Size  Used by
sg                     32768  0
sr_mod                 15684  0
cdrom                  45180  1 sr_mod
ehci_hcd               46760  0
ohci_hcd               30628  0
usb_storage            38276  0
 
kkj-nfs:~# lspci -v
0000:00:04.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 128, IRQ 25
        Memory at cffff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

0000:00:04.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 128, IRQ 25
        Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

0000:00:04.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 
[EHCI]
)
        Subsystem: NEC Corporation USB 2.0
        Flags: bus master, medium devsel, latency 128, IRQ 25
        Memory at cfffdf00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

kkj-nfs:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: CDRW9602EXT-B    Rev: 8OS4
  Type:   CD-ROM                           ANSI SCSI revision: 02


USB-CDROM model, vendor doesn't matter.
 
Board is booted with nfs.


Steps to reproduce:
1. Attach USB-CDROM(non-empty iso9660 formatted file cd exist) to usb jack of 
board.
2. Power On
3. insert some modules - sr_mod, sg, usb-storage, ohci_hcd, ehci_hcd
4. mount -o ro -t iso9660 /dev/sr0 /media
5. segmentation fault is called
