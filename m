Return-Path: <johns.daniel@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 36C37DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Dec 2007 02:37:45 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so158080fgg.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Dec 2007 07:37:44 -0800 (PST)
Message-ID: <ba5d9360712210737h133fd831vbfb7c9f996c6df7c@mail.gmail.com>
Date: Fri, 21 Dec 2007 09:37:43 -0600
From: "Johns Daniel" <johns.daniel@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: CONFIG_PCI interaction with pata_platform driver on MPC834x board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am observing a strange interaction between configuring PCI support
in my kernel and CompactFlash probing. Without PCI support configured,
the CF card is discovered and configured by the kernel. With PCI
support configured, there is some issue in the probing of the CF card.

There are only two things that I notice between the two kernel setups
that might be significant:
1.) The libata virq changes from 19 to 20.
2.) The isa_io_base changes from 0x0 to 0xfcfff000.
Are either of these two changes significant?

I am using the "arch/powerpc" kernel, version 2.6.20.21. The CF is
wired directly to the local bus in True IDE mode.

I have some debug info included below.

-- Johns

================      without CONFIG_PCI     =================
ata_device_add: ENTER
ata_port_add: ENTER
ata_port_start: prd alloc, virt dfe2a000, dma 1fe2a000
ata1: PATA max PIO0 cmd 0xE1062000 ctl 0xE106420C bmdma 0x0 irq 19
__ata_port_freeze: ata1 port frozen
ata_device_add: probe begin
scsi0 : pata_platform
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_mmio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_dump_id: 49==0x0200  53==0x0003  63==0x0000  64==0x0003  75==0x0000
ata_dump_id: 80==0x0400  81==0x0000  82==0x0000  83==0x0000  84==0x0000
ata_dump_id: 88==0x0000  93==0x0000
ata1.00: CFA, max PIO4, 250880 sectors: LBA
ata1.00: ata1: dev 0 multi count 0
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_device_add: host probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 30 58 df
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 30 58 df
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-12 HDB  PQ: 0 ANSI: 5
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 30 58 df
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 250880 512-byte hdwr sectors (128 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sda: Write Protect is off
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 01 00 00 00 24
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 250880 512-byte hdwr sectors (128 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sda: Write Protect is off
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
SCSI device sda: write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
ata_exec_command_mmio: ata1: cmd 0x20
ata_scsi_translate: EXIT
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_host_intr: ata1: protocol 2 task_state 1
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x50)
ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
 sda1 sda2 sda3
sd 0:0:0:0: Attached scsi removable disk sda
ata_device_add: EXIT, returning 1
================      without CONFIG_PCI     =================


==================      with CONFIG_PCI     =================
ata_device_add: ENTER
ata_port_add: ENTER
ata_port_start: prd alloc, virt dfe46000, dma 1fe46000
ata1: PATA max PIO0 cmd 0xE1062000 ctl 0xE106420C bmdma 0x0 irq 20
__ata_port_freeze: ata1 port frozen
ata_device_add: probe begin
scsi0 : pata_platform
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_eh_autopsy: ENTER
ata_eh_recover: ENTER
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_mmio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ATA: abnormal status 0x58 on port 0xE106200E
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x58)
__ata_port_freeze: ata1 port frozen
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata_eh_revalidate_and_attach: EXIT
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_mmio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ATA: abnormal status 0x58 on port 0xE106200E
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x58)
__ata_port_freeze: ata1 port frozen
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata_eh_revalidate_and_attach: EXIT
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_mmio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 1 (dev_stat 0x58)
ata_pio_sector: data read
ATA: abnormal status 0x58 on port 0xE106200E
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_hsm_move: ata1: protocol 2 task_state 3 (dev_stat 0x58)
__ata_port_freeze: ata1 port frozen
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata_eh_revalidate_and_attach: EXIT
ata_eh_prep_resume: ENTER
ata_eh_prep_resume: EXIT
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=3
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=5
ata_std_postreset: ENTER
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: EXIT
ata_eh_resume: ENTER
ata_eh_resume: EXIT
ata_eh_suspend: ENTER
ata_eh_suspend: EXIT
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_device_add: host probe begin
ata_device_add: EXIT, returning 1
==================      with CONFIG_PCI     =================
