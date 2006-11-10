Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 22:37:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Brian King <brking@us.ibm.com>
Subject: ipr SATA support is causing problems
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	James Bottomley <jejb@mulgrave.il.steeleye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian,

Today I compiled up a kernel from Linus' git tree and tried it on a
POWER6 partition.  First I found that my config no longer had the ipr
driver, because I didn't have CONFIG_ATA and ipr now depends on
CONFIG_ATA.  So I enabled CONFIG_ATA without enabling any of the ATA
chip drivers, which seems a little weird, and re-enabled ipr.

However, the kernel crashed on boot with a null pointer dereference in
the ata code called from the ipr driver (see stack trace below).
Other people have also reported such a crash.  I then reverted commit
35a39691e4, and the resulting kernel booted without crashing.

It looks like there is still some bug in the SATA support in ipr.c,
perhaps something not getting initialized that needs to be
initialized.  We may have to get Linus to revert that commit if the
bug can't be found and fixed, because otherwise 2.6.19 will be
unusable on pseries partitions with ipr SCSI adaptors.

Paul.

Unable to handle kernel paging request for data at address 0x00000010
Faulting instruction address: 0xc000000000063ca0
cpu 0x2: Vector: 300 (Data Access) at [c000000002f2ecc0]
    pc: c000000000063ca0: .flush_workqueue+0x28/0xdc
    lr: c000000000366848: .ata_port_flush_task+0x5c/0x124
    sp: c000000002f2ef40
   msr: 8000000000009032
   dar: 10
 dsisr: 40000000
  current = 0xc000000002f29800
  paca    = 0xc0000000005aa800
    pid   = 1, comm = swapper
enter ? for help
[c000000002f2efd0] c000000000366848 .ata_port_flush_task+0x5c/0x124
[c000000002f2f060] c00000000036afe4 .ata_exec_internal+0x260/0x418
[c000000002f2f170] c00000000036b2b0 .ata_dev_read_id+0x114/0x36c
[c000000002f2f250] c00000000036bfa0 .ata_bus_probe+0x180/0x34c
[c000000002f2f310] c00000000036f4d8 .ata_sas_port_init+0x50/0x70
[c000000002f2f3a0] c00000000034fca8 .ipr_slave_alloc+0x17c/0x200
[c000000002f2f430] c00000000032dc88 .scsi_alloc_sdev+0x1d0/0x248
[c000000002f2f4f0] c00000000032dee0 .scsi_probe_and_add_lun+0x118/0x918
[c000000002f2f5f0] c00000000032ee6c .__scsi_scan_target+0xf0/0x608
[c000000002f2f700] c00000000032f3d8 .scsi_scan_channel+0x54/0xd0
[c000000002f2f7a0] c00000000032f50c .scsi_scan_host_selected+0xb8/0x130
[c000000002f2f850] c00000000034f2f4 .ipr_probe+0xe98/0xf80
[c000000002f2f960] c000000000227298 .pci_device_probe+0x144/0x1e4
[c000000002f2fa20] c0000000002a35b8 .really_probe+0x80/0x19c
[c000000002f2fac0] c0000000002a397c .__driver_attach+0xa0/0x124
[c000000002f2fb50] c0000000002a2708 .bus_for_each_dev+0x7c/0xd4
[c000000002f2fc10] c0000000002a3430 .driver_attach+0x28/0x40
[c000000002f2fc90] c0000000002a2bdc .bus_add_driver+0x80/0x1ec
[c000000002f2fd30] c0000000002a3d60 .driver_register+0xa8/0xc4
[c000000002f2fdb0] c0000000002275f4 .__pci_register_driver+0x9c/0xe4
[c000000002f2fe40] c00000000056e03c .ipr_init+0x34/0x4c
[c000000002f2fec0] c0000000000093ac .init+0x1e0/0x3c0
[c000000002f2ff90] c000000000023f04 .kernel_thread+0x4c/0x68
2:mon> r
R00 = c000000000366848   R16 = 4000000002100000
R01 = c000000002f2ef40   R17 = c0000000004a7cf0
R02 = c0000000007ba890   R18 = c00000000283022c
R03 = 0000000000000000   R19 = 00000000000000a1
R04 = 8000000000009032   R20 = 0000000000000200
R05 = 0000000000000160   R21 = 00000000fafbfcfd
R06 = 0000000024002042   R22 = 0000000000000000
R07 = 0000000000000000   R23 = 0000000000000000
R08 = 0000000000000000   R24 = 0000000000000002
R09 = 0000000000000010   R25 = c000000002f2f1e0
R10 = c000000002f2f0e8   R26 = 8000000000009032
R11 = c000000002f2f0e8   R27 = c000000002830200
R12 = 8000000001310000   R28 = c000000000867fb8
R13 = c0000000005aa800   R29 = 0000000000000000
R14 = 0000000000000000   R30 = c0000000005e2d58
R15 = c0000000004a9268   R31 = c000000002830000
pc  = c000000000063ca0 .flush_workqueue+0x28/0xdc
lr  = c000000000366848 .ata_port_flush_task+0x5c/0x124
msr = 8000000000009032   cr  = 24002042
ctr = 0000000000000000   xer = 000000002000000c   trap =  300
dar = 0000000000000010   dsisr = 40000000
