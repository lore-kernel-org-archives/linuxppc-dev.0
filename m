Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6388DB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 00:52:36 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Tejun Heo <tj@kernel.org>
Subject: PowerPC MPC5200B ATA MWDMA regression
MIME-Version: 1.0
Message-ID: <201101031445.47922.roman.fietze@telemotive.de>
Date: Mon, 3 Jan 2011 14:45:47 +0100
Content-Type: Text/Plain;
  charset="us-ascii"
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

When merging more recent kernel versions, tried that using v2.6.35 and
v2.6.36, into our tree (branched at v2.6.34), I detected, that MWDMA2
on the HW listed in the subject does no longer work.

So I bisected that using the original, standard kernel tree using a
minimum config using

   git bisect start v2.6.35 v2.6.34

The final result is:

360ff7833098e944e5003618b03894251e937802 is the first bad commit
commit 360ff7833098e944e5003618b03894251e937802
Author: Tejun Heo <tj@kernel.org>
Date:   Mon May 10 21:41:42 2010 +0200

    libata-sff: separate out BMDMA qc_issue

...


I double checked the failure with the latest torvalds/master as well
(b518a64983cbf2ff31), still the same issue.

The HW is an own board very close to the original Freescale
Lite5200/Lite5200B. The relevant part of the device tree source file
contains "mwdma-mode = <2>;" inside the ata section.

In the bad case the log always shows (the exact drive or drive type
doesn't matter, double checked):

[    1.553501] ata1.00: ATA-5: HEJ423020F9AT00, 00MJA0A0, max UDMA/100
[    1.560003] ata1.00: 39070080 sectors, multi 0: LBA 
[    1.581418] ata1.00: configured for MWDMA2
[    1.586644] scsi 0:0:0:0: Direct-Access     ATA      HEJ423020F9AT00  00MJ PQ: 0 ANSI: 5
[    1.597831] sd 0:0:0:0: [sda] 39070080 512-byte logical blocks: (20.0 GB/18.6 GiB)
[    1.606876] sd 0:0:0:0: [sda] Write Protect is off
[    1.611907] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.617627] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.629423]  sda:
[    1.631702] ------------[ cut here ]------------
[    1.636613] Badness at /home/fietze/src/linux-2.6-telemotive/drivers/ata/libata-sff.c:1466
[    1.645047] NIP: c01ae650 LR: c01ae624 CTR: c01accbc
[    1.650115] REGS: c7955b30 TRAP: 0700   Not tainted  (2.6.34-rc7-obelix)
[    1.656948] MSR: 00021032 <ME,CE,IR,DR>  CR: 24008084  XER: 00000000
[    1.663452] TASK = c78f2490[784] 'async/0' THREAD: c7954000
[    1.668957] GPR00: 00000001 c7955be0 c78f2490 00000050 c904aa78 00000001 00000000 00000000 
[    1.677497] GPR08: 00000000 c034ee50 00000000 00000000 44008082 1001a7f0 c7955f68 07fb2938 
[    1.686037] GPR16: c78a8000 07fb2914 07f3f64c c0340000 c031ed00 c78a8000 00000000 c0010adc 
[    1.694577] GPR24: c7842820 00000002 c7949428 c7948000 00000003 00000000 c7948000 c794809c 
[    1.703321] NIP [c01ae650] ata_sff_qc_issue+0x74/0x248
[    1.708564] LR [c01ae624] ata_sff_qc_issue+0x48/0x248
[    1.713712] Call Trace:
[    1.716211] [c7955be0] [c01ae624] ata_sff_qc_issue+0x48/0x248 (unreliable)
[    1.723243] [c7955c00] [c019dd10] ata_qc_issue+0x1ac/0x31c
[    1.728850] [c7955c30] [c01a3540] ata_scsi_translate+0x104/0x1b0
[    1.734987] [c7955c50] [c018a8e0] scsi_dispatch_cmd+0xf4/0x208
[    1.740952] [c7955c70] [c01912bc] scsi_request_fn+0x268/0x404
[    1.746827] [c7955ca0] [c013bc84] __generic_unplug_device+0x48/0x5c
[    1.753227] [c7955cb0] [c013c518] generic_unplug_device+0x28/0x44
[    1.759449] [c7955cc0] [c0139c08] blk_unplug+0x20/0x30
[    1.764697] [c7955cd0] [c00ad148] block_sync_page+0x50/0x6c
[    1.770403] [c7955ce0] [c005a6b8] sync_page+0x4c/0x70
[    1.775577] [c7955cf0] [c0252f24] __wait_on_bit_lock+0x94/0x124
[    1.781623] [c7955d10] [c005a638] __lock_page+0x50/0x60
[    1.786961] [c7955d40] [c005addc] do_read_cache_page+0x18c/0x190
[    1.793093] [c7955d70] [c005ae38] read_cache_page+0x14/0x28
[    1.798793] [c7955d80] [c00d2a44] read_dev_sector+0x40/0xb0
[    1.804488] [c7955da0] [c00d36fc] msdos_partition+0x58/0x888
[    1.810270] [c7955e20] [c00d33e8] rescan_partitions+0x18c/0x430
[    1.816326] [c7955e80] [c00b51d8] __blkdev_get+0x1a0/0x368
[    1.821929] [c7955ec0] [c00d31ec] register_disk+0x140/0x158
[    1.827620] [c7955ef0] [c0143024] add_disk+0xe4/0x144
[    1.832784] [c7955f20] [c0198aa8] sd_probe_async+0xd4/0x1d8
[    1.838478] [c7955f40] [c00429f4] async_thread+0x120/0x2a8
[    1.844079] [c7955fc0] [c003af90] kthread+0x78/0x7c
[    1.849076] [c7955ff0] [c0010fd4] kernel_thread+0x4c/0x68
[    1.854581] Instruction dump:
[    1.857606] 4bffe96d 8b9f0014 2f9c0002 419e00e8 2b9c0002 419d0040 2f9c0001 419e0158 
[    1.865525] 3d20c035 3929ee50 89690006 69600001 <0f000000> 2f8b0000 38600040 419e01bc 
[    1.873859] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[    1.880541] ata1.00: failed command: READ DMA
[    1.885101] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[    1.885116]          res 50/00:00:7f:29:54/00:00:00:00:00/a0 Emask 0x40 (internal error)
[    1.900812] ata1.00: status: { DRDY }
[    1.921430] ata1.00: configured for MWDMA2
[    1.925775] ata1: EH complete
[    1.929052] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[    1.935739] ata1.00: failed command: READ DMA
[    1.940301] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[    1.940316]          res 50/00:00:7f:29:54/00:00:00:00:00/a0 Emask 0x40 (internal error)
[    1.956013] ata1.00: status: { DRDY }
[    1.981416] ata1.00: configured for MWDMA2
[    1.985755] ata1: EH complete
[    1.989027] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[    1.995707] ata1.00: failed command: READ DMA
[    2.000262] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[    2.000275]          res 50/00:00:7f:29:54/00:00:00:00:00/a0 Emask 0x40 (internal error)
[    2.015971] ata1.00: status: { DRDY }
[    2.041420] ata1.00: configured for MWDMA2
[    2.045767] ata1: EH complete
[    2.049044] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[    2.055730] ata1.00: failed command: READ DMA
[    2.060287] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[    2.060301]          res 50/00:00:7f:29:54/00:00:00:00:00/a0 Emask 0x40 (internal error)
[    2.075997] ata1.00: status: { DRDY }
...

and then while operating the drive e.g. using dd if=/dev/sda ...:

[   81.936231] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[   81.942966] ata1.00: failed command: READ DMA
[   81.947534] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0 dma 131072 in
[   81.947550]          res 50/00:00:7f:29:54/00:00:00:00:00/a0 Emask 0x40 (internal error)
[   81.963422] ata1.00: status: { DRDY }
[   81.983316] ata1.00: configured for MWDMA2
[   81.987690] ata1: EH complete
[   81.990974] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[   81.997661] ata1.00: failed command: READ DMA
[   82.002219] ata1.00: cmd c8/00:00:00:00:00/00:00:00:00:00/e0 tag 0 dma 131072 in
[   82.002234]          res 50/00:00:7f:29:54/00:00:00:00:00/a0 Emask 0x40 (internal error)
[   82.018186] ata1.00: status: { DRDY }
[   82.047323] ata1.00: configured for MWDMA2
[   82.051695] ata1: EH complete
...

and so on.

If I would understand more of IDE/ATA/libata I would have tried own
fixes, so I'm sorry to bother you with test results instead of
patches.


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
