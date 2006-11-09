Return-Path: <lagrange@fr.oleane.com>
Received: from smtp23.msg.oleane.net (smtp23.msg.oleane.net [62.161.4.23])
	by ozlabs.org (Postfix) with ESMTP id 7B9A767C72
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 02:27:59 +1100 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp23.msg.oleane.net (MTA) with ESMTP id kA9F7q50025996
	for <linuxppc-embedded@ozlabs.org>; Thu, 9 Nov 2006 16:07:53 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Laurent Lagrange'" <lagrange@fr.oleane.com>
Subject: MPC82xx  : ECC and PCI problem
Date: Thu, 9 Nov 2006 16:11:31 +0100
Message-ID: <000001c70411$5c36d140$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I work on a custom monarch PMC MPC82xx board.
This board embeds an ECC device which can be enabled or disabled.
When ECC is disabled all PCI accesses work fine.
When ECC is enabled and PCI disabled, all work fine.

But when ECC and PCI are enabled, the first PCI accesses give the following
:

>>>
Linux/PPC load: devfs=mount rootfstype=tmpfs root=/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.9-xxx (version gcc 3.2.3) #1 Thu Feb 16 12:02:39 CET 2006
Built 1 zonelists
Kernel command line: devfs=mount rootfstype=tmpfs root=/dev/ram rw
PID hash table entries: 1024 (order: 10, 16384 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 123904k available (1072k kernel code, 368k data, 72k init, 0k
highmem)
Calibrating delay loop... 177.15 BogoMIPS (lpj=88576)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Machine check in kernel mode.
Caused by (from SRR1=81032): Machine check signal
Oops: machine check, sig: 7 [#1]
NIP: C00137DC LR: C0013820 SP: C0491E40 REGS: c0491d90 TRAP: 0200    Not
tainted
MSR: 00081032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c08fcba0[1] 'swapper' THREAD: c0490000Last syscall: 120
GPR00: C008ECE8 C0491E40 C08FCBA0 00000000 00000000 FF010906 00000001
C0491E78
GPR08: 2F9DEB58 00000002 00000800 FF010904 C02B21DC 00015710 FDFFFFFF
FF010000
GPR16: FFFF7FFF EFFFDFFF 00200000 FFF7FFFF 00000000 BFFFEDBF 00000000
80000000
GPR24: 00000000 FFFFFF7E 00000000 00000001 C0491E98 00009032 C04A3280
C04A3280
NIP [c00137dc] indirect_read_config+0xc8/0x11c
LR [c0013820] indirect_read_config+0x10c/0x11c
Call trace:
 [c008ece8] pci_bus_read_config_byte+0x40/0x60
 [c01648a4] pci_scan_device+0x24/0x198
 [c0164a30] pci_scan_single_device+0x18/0x70
 [c0164ab8] pci_scan_slot+0x30/0x98
 [c0164b4c] pci_scan_child_bus+0x2c/0xd0
 [c0164db0] pci_scan_bus_parented+0x184/0x198
 [c015e488] pcibios_init+0x64/0x134
 [c015a87c] do_initcalls+0x5c/0xfc
 [c015a93c] do_basic_setup+0x20/0x30
 [c0003a08] init+0x2c/0xf0
 [c000aae4] kernel_thread+0x44/0x60
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..
>>>

Has anyone encountered same problems ?
Relationships between ECC, PCI, cache ?

Any idea would be welcome
Thanks all
Laurent
