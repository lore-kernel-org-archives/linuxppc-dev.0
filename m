Return-Path: <thisismevinay@yahoo.co.in>
Received: from web8409.mail.in.yahoo.com (web8409.mail.in.yahoo.com
	[202.43.219.157]) by ozlabs.org (Postfix) with SMTP id 26BA4679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 21:44:23 +1000 (EST)
Message-ID: <20060505113741.97194.qmail@web8409.mail.in.yahoo.com>
Date: Fri, 5 May 2006 12:37:41 +0100 (BST)
From: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Some issues while booting the 2.6.13.4 kernel on PPC440GR with CMD649
	IDE
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am porting the 2.6.13.4 kernel to PPC440GR board.
When I try to boot the kernel with CMD649 IDE support
enabled, I get kernel panic. Without CMD649, the
kernel boots just fine.

I read the PCI config space from the driver (inside
do_ide_setup_pci_device function) and verified that
DEVICE id,VENDOR id and interrupt lines are correct.
However, bar address does not seem to be correct
(actual phy and virtual set while PCI bridge config is
0xa0000000). Below is the kernel boot log for
reference:

>>>>>>>>>>>>>>>>>
..........
..........
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
CMD649: IDE controller at PCI slot 0000:00:0c.0
CMD649: chipset revision 1
CMD649: 100% native mode on irq 25
Data machine check in kernel mode.
PLB0: BEAR=0x0000000000000000 ACR=  0x00000000 BESR=
0x360eff98
POB0: BEAR=0xc27e3194fefcfc9f BESR0=0x00000000
BESR1=0x00000000
OPB0: BEAR=0x0000000000000151 BSTAT=0x00000000
Oops: machine check, sig: 7 [#1]
NIP: 00000000 LR: C0106024 SP: C1981EC0 REGS: c026af50
TRAP: 0202    Not tainted
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
TASK = c1134b10[1] 'swapper' THREAD: c1980000
Last syscall: 120
GPR00: FDFFEFD2 C1981EC0 C1134B10 00000000 00000060
FDFEE004 00000002 C1981EA8
GPR08: 00000000 C0270000 00000008 FDFEE004 00000000
30000000 C0277CB0 C0277CB0
GPR16: C0277CB0 00000019 00000000 C0277CB0 C0277CB0
C1130000 C1981F58 C1130000
GPR24: C0265A2A C1130000 00000000 0000FFD0 C0265A08
40000000 C0277CB0 C0277CB0
NIP [00000000] 0x0
LR [c0106024] ide_pci_setup_ports+0x61c/0x71c
Call trace:
 [c010633c] do_ide_setup_pci_device+0x218/0x464
 [c01065a8] ide_setup_pci_device+0x20/0x9c
 [c02298d0] cmd64x_init_one+0x24/0x34
 [c022a2f0] ide_scan_pcidev+0x80/0xc4
 [c022a360] ide_scan_pcibus+0x2c/0xf8
 [c022a24c] ide_init+0x58/0x7c
 [c0001868] init+0x7c/0x2cc
 [c0004b90] kernel_thread+0x48/0x64
Data machine check in kernel mode.
PLB0: BEAR=0x0000000000000000 ACR=  0x00000000 BESR=
0x360eff98
POB0: BEAR=0xc27e3194fefcfc9f BESR0=0x00000000
BESR1=0x00000000
OPB0: BEAR=0x0000000000000151 BSTAT=0x00000000
Oops: machine check, sig: 7 [#2]
NIP: 00000000 LR: C00028DC SP: C026AE70 REGS: c026af50
TRAP: 0202    Not tainted
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
TASK = c1134b10[1] 'swapper' THREAD: c1980000
Last syscall: 120
GPR00: 08000000 C026AE70 C1134B10 C026AE80 00000C1B
FFFFFFFF C0270000 C01E511C
GPR08: C01E0000 C00028DC 00021002 C0003CDC C1134CD8
30000000 C0277CB0 C0277CB0
GPR16: C0277CB0 00000019 00000000 C0277CB0 C0277CB0
C1130000 C1981F58 C1130000
GPR24: C0265A2A C1130000 00000000 0000FFD0 C0265A08
40000000 C026AF50 00000007
NIP [00000000] 0x0
LR [c00028dc] ret_from_except+0x0/0x18
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..
<<<<<<<<<<<<<<<<<

This is what I get when I print some PCI config space
parameters:

>>>>>>>>>>>>>
VENDOR ID: 0x1095
DEVICE ID: 0x0649
INTERRUPT LINE: 0x1C
REVISION: 0x01
BASE REG 0 is: 0x0000FFF0
BASE REG 1 is: 0x0000FFF0
BASE REG 2 is: 0x0000FFE0
BASE REG 3 is: 0x0000FFE0
<<<<<<<<<<<<

The "pci" command from u-Boot shows the following:
>>>>>>>>>>
=> pci
Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class      
Sub-Class
______________________________________________________00.00.00
  0x1014     0x027f     Bridge device           0x80
00.0c.00   0x1095     0x0649     Mass storage
controller 0x04
=>
<<<<<<<<<<

I enabled the following for CMD649 in kernel
configuration:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_IDEDMA=y


Please let me know if - anybody has seen this error
before/knows the fix for this issue.

Thanks for the help.
-Vinay.


		
____________________________________________________ 
Yahoo! India Answers: Share what you know. Learn something new. http://in.answers.yahoo.com
