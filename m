Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3smV046Q6lzDrZQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 23:44:03 +1000 (AEST)
Received: by mail-wm0-x22c.google.com with SMTP id p138so72110659wmb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Oct 2016 06:44:02 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 1 Oct 2016 15:43:37 +0200
Message-ID: <CA+7wUszQjtBHWkGSAUKtbv8yFrHLAQ-9aZZSOM-vmgJZw4VOww@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in
 /home/mathieu/tmp/linux-4.6.4/drivers/scsi/scsi_devinfo.c:458:21
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Anyone seen this before (PowerMac G4/MacMini):

[    1.397164] ata1.00: ATA-8: WDC WD800BEVE-00A0HT0, 11.01A11, max UDMA/100
[    1.401313] ata1.00: 156301488 sectors, multi 16: LBA48
[    1.405525] ata1.01: ATAPI: MATSHITADVD-R   UJ-845C, DPP9, max UDMA/66
[    1.414606] ata1.00: configured for UDMA/100
[    1.423655] ata1.01: configured for UDMA/66
[    1.431116] scsi 0:0:0:0: Direct-Access     ATA      WDC
WD800BEVE-00 1A11 PQ: 0 ANSI: 5
[    1.435987] device: 'target0:0:0': device_add
[    1.436030] bus: 'scsi': add device target0:0:0
[    1.436133] PM: Adding info for scsi:target0:0:0
[    1.436184] device: '0:0:0:0': device_add
[    1.436410] bus: 'scsi': add device 0:0:0:0
[    1.436501] PM: Adding info for scsi:0:0:0:0
[    1.436526] device: '0:0:0:0': device_add
[    1.436654] PM: Adding info for No Bus:0:0:0:0
[    1.436695] device: '0:0:0:0': device_add
[    1.436819] PM: Adding info for No Bus:0:0:0:0
[    1.438276] ================================================================================
[    1.443124] UBSAN: Undefined behaviour in
/home/mathieu/tmp/linux-4.6.4/drivers/scsi/scsi_devinfo.c:458:21
[    1.453129] index 8 is out of range for type 'char [8]'
[    1.458352] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 4.6.0-1-powerpc #5
[    1.463771] Workqueue: events_unbound async_run_entry_fn
[    1.469284] Call Trace:
[    1.474816] [df54bb80] [c071a9f4] ubsan_epilogue+0x18/0x4c (unreliable)
[    1.480614] [df54bb90] [c071b114] __ubsan_handle_out_of_bounds+0x7c/0x90
[    1.486313] [df54bbd0] [c09fe084] scsi_dev_info_list_find+0x2e0/0x3a4
[    1.491880] [df54bc20] [c09fe6a0] scsi_get_device_flags_keyed+0x40/0x11c
[    1.497397] [df54bc40] [c09f4ec8] scsi_probe_and_add_lun+0x458/0x1ce4
[    1.502836] [df54bd00] [c09f6b04] __scsi_add_device+0x170/0x1cc
[    1.508207] [df54bd40] [c0a30064] ata_scsi_scan_host+0x214/0x3f8
[    1.513578] [df54bda0] [c00d78b4] async_run_entry_fn+0x90/0x3c4
[    1.518944] [df54be00] [c00c20a0] process_one_work+0x2dc/0xd44
[    1.524270] [df54be70] [c00c2dc0] worker_thread+0x2b8/0xbf4
[    1.529596] [df54bee0] [c00d1618] kthread+0x124/0x1b0
[    1.534914] [df54bf40] [c00244b0] ret_from_kernel_thread+0x5c/0x64
[    1.540229] ================================================================================
[    1.546530] scsi 0:0:1:0: CD-ROM            MATSHITA DVD-R
UJ-845C  DPP9 PQ: 0 ANSI: 5
[    1.559176] device: 'target0:0:1': device_add
[    1.559217] bus: 'scsi': add device target0:0:1
[    1.559307] PM: Adding info for scsi:target0:0:1
[    1.559356] device: '0:0:1:0': device_add
[    1.559566] bus: 'scsi': add device 0:0:1:0
