Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4528EB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Oct 2010 22:17:53 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[10.96.97.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 34EC3E7264
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Oct 2010 13:17:48 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5200B MWDMA2 with recent 2.6.36 kernels
MIME-Version: 1.0
Message-ID: <201010251317.47857.roman.fietze@telemotive.de>
Date: Mon, 25 Oct 2010 13:17:47 +0200
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I recently tried to switch to 2.6.36 (torvalds/master) using a
Lite5200B compatible board.

Using 2.6.34 we were running ATA in MWDMA 2 to avoid MPC5200B HW
problems with UDMA.

But with 2.6.36 I get only ATA errors (PIO4 is working fine):

...
ata: MPC52xx IDE/ATA libata driver
scsi0 : mpc52xx_ata
ata1: PATA max MWDMA2 ata_regs 0xf0003a00 irq 135
...
ata1.00: ATA-6: Hitachi HEJ421010G9AT00, F5DJA40B, max UDMA/100
ata1.00: 195371568 sectors, multi 0: LBA48 
ata1.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HEJ42101 F5DJ PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 195371568 512-byte logical blocks: (100 GB/93.1 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO749060] ------------[ cut here ]------------
WARNING: at /home/fietze/src/linux-2.6-telemotive/drivers/ata/libata-sff.c:1468
Modules linked in:
NIP: c01b1680 LR: c01b1654 CTR: c01b06d0
REGS: c7843ad0 TRAP: 0700   Not tainted  (2.6.36.00.02-obelix)
MSR: 00021032 <ME,CE,IR,DR>  CR: 24008084  XER: 00000000
TASK = c7829b20[8] 'kworker/u:1' THREAD: c7842000
GPR00: 00000001 c7843b80 c7829b20 00000050 c9088a78 00000001 00000000 00000000 
GPR08: 00000000 c03432d8 00000003 00000000 44008082 1001a7f0 c02adb28 c0269df8 
GPR16: c02adb20 c02adbc4 c02adbec c6f2bc60 c6f48000 c02647a0 c74081a0 c000f060 
GPR24: c780baa0 00000002 c6f21430 c6f21430 00000003 00000000 c6f20000 c6f200a4 
NIP [c01b1680] ata_sff_qc_issue+0x78/0x24c
LR [c01b1654] ata_sff_qc_issue+0x4c/0x24c
Call Trace:
[c7843b80] [c01b1654] ata_sff_qc_issue+0x4c/0x24c (unreliable)
[c7843ba0] [c01a087c] ata_qc_issue+0x208/0x330
[c7843bd0] [c01a5ca4] ata_scsi_translate+0x104/0x1b0
[c7843bf0] [c018d208] scsi_dispatch_cmd+0xf4/0x208
[c7843c10] [c0193b64] scsi_request_fn+0x270/0x404
[c7843c40] [c01405b0] __generic_unplug_device+0x48/0x5c
[c7843c50] [c0140ee4] generic_unplug_device+0x28/0x44
[c7843c60] [c013e480] blk_unplug+0x20/0x30
[c7843c70] [c00b14b4] block_sync_page+0x54/0x70
[c7843c80] [c005b37c] sync_page+0x50/0x74
[c7843c90] [c0259b50] __wait_on_bit_lock+0x94/0x124
[c7843cb0] [c005b2f8] __lock_page+0x50/0x60
[c7843ce0] [c005baac] do_read_cache_page+0x18c/0x190
[c7843d10] [c005bb08] read_cache_page+0x14/0x28
[c7843d20] [c00d7ca8] read_dev_sector+0x40/0xb0
[c7843d40] [c00d8c24] msdos_partition+0xb4/0x98c
[c7843e20] [c00d885c] rescan_partitions+0x1c0/0x4bc
[c7843e80] [c00b960c] __blkdev_get+0x1a0/0x368
[c7843ec0] [c00d85ec] register_disk+0x17c/0x194
[c7843ef0] [c0147e04] add_disk+0xf4/0x144
[c7843f20] [c019b658] sd_probe_async+0xf4/0x1bc
[c7843f40] [c004339c] async_run_entry_fn+0x84/0x1cc
[c7843f60] [c0035c1c] process_one_work+0x10c/0x330
[c7843f90] [c003730c] worker_thread+0x1ec/0x32c
[c7843fb0] [c003ba60] kthread+0x7c/0x80
[c7843ff0] [c000f5c4] kernel_thread+0x4c/0x68
Instruction dump:
4bfff65d 8b9f0014 2f9c0002 419e00e8 2b9c0002 419d0040 2f9c0001 419e0158 
3d20c034 392932d8 89690005 69600001 <0f000000> 2f8b0000 38600040 419e01bc 
---[ end trace 69c43b02b90e3750 ]---
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: failed command: READ DMA
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 50/00:00:2f:22:a5/00:00:00:00:00/a0 Emask 0x40 (internal error)
ata1.00: status: { DRDY }
ata1.00: configured for MWDMA2
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: failed command: READ DMA
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 50/00:00:2f:22:a5/00:00:00:00:00/a0 Emask 0x40 (internal error)
ata1.00: status: { DRDY }
ata1.00: configured for MWDMA2
...
... and so on


Any ideas? Same behavious on some of your boxes? Too bad my current
know how when it comes to ATA is not too much above zero.


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
