Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x22f.google.com (mail-vk0-x22f.google.com
 [IPv6:2607:f8b0:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXy7J5J7dzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 00:11:56 +1100 (AEDT)
Received: by mail-vk0-x22f.google.com with SMTP id w201so13439223vkw.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 05:11:56 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 2 Feb 2018 14:11:33 +0100
Message-ID: <CA+7wUsybeT=pdkX7AkiC=JsG2ShDMZF+Z_anxryeJ=UJFHkSYQ@mail.gmail.com>
Subject: [ppc32] WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516
 dmam_alloc_coherent+0xd8/0x118
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

What is this warning all about (system is Mac Mini G4) ? Thanks

[    3.265537] pata-macio 0.00020000:ata-3: Activating pata-macio
chipset KeyLargo ATA-3, Apple bus ID 0
[    3.272686] WARNING: CPU: 0 PID: 1 at
./include/linux/dma-mapping.h:516 dmam_alloc_coherent+0xd8/0x118
[    3.280031] Modules linked in:
[    3.283660] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0+ #333
[    3.287314] NIP:  c0643f5c LR: c0643ec8 CTR: 00000000
[    3.290920] REGS: df4f1c00 TRAP: 0700   Not tainted  (4.15.0+)
[    3.294499] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 28228428  XER: 20000000
[    3.298056]
               GPR00: c0643ec8 df4f1cb0 df4ee940 de15de50 00000000
00000000 de15de5c 00000000
               GPR08: 00000000 00000000 c08e4d88 00000000 24228484
00000000 c0004cc8 00000000
               GPR16: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 c0c90000
               GPR24: c0b4fdd0 c0c3d6e0 00000000 de00beec 00001020
014000c0 de15de50 de017c18
[    3.315308] NIP [c0643f5c] dmam_alloc_coherent+0xd8/0x118
[    3.318724] LR [c0643ec8] dmam_alloc_coherent+0x44/0x118
[    3.322073] Call Trace:
[    3.325399] [df4f1cb0] [c0643ec8] dmam_alloc_coherent+0x44/0x118 (unreliable)
[    3.328858] [df4f1cd0] [c06a5f4c] pata_macio_port_start+0x48/0x98
[    3.332294] [df4f1cf0] [c068b25c] ata_host_start.part.9+0x108/0x220
[    3.335706] [df4f1d10] [c06912d8] ata_host_activate+0x70/0x15c
[    3.339084] [df4f1d30] [c06a6a8c] pata_macio_common_init+0x300/0x568
[    3.342459] [df4f1d90] [c06a6ef4] pata_macio_attach+0xe4/0x18c
[    3.345862] [df4f1db0] [c06582bc] macio_device_probe+0x64/0xf8
[    3.349218] [df4f1dd0] [c062c5e8] driver_probe_device+0x334/0x4b4
[    3.352537] [df4f1e00] [c062c884] __driver_attach+0x11c/0x120
[    3.355822] [df4f1e20] [c0629a14] bus_for_each_dev+0x70/0xc0
[    3.359074] [df4f1e50] [c062b338] bus_add_driver+0x180/0x2dc
[    3.362277] [df4f1e70] [c062d620] driver_register+0x94/0x13c
[    3.365415] [df4f1e80] [c0b937f8] pata_macio_init+0x68/0x90
[    3.368474] [df4f1ea0] [c0004af4] do_one_initcall+0x4c/0x178
[    3.371471] [df4f1f00] [c0b50774] kernel_init_freeable+0x138/0x1d0
[    3.374421] [df4f1f30] [c0004cec] kernel_init+0x24/0x118
[    3.377337] [df4f1f40] [c0018304] ret_from_kernel_thread+0x5c/0x64
[    3.380249] --- interrupt: 0 at   (null)
                   LR =   (null)
[    3.385965] Instruction dump:
[    3.388713] 7fc4f378 7fe3fb78 93be0004 913e0008 939e0000 4bfecd79
7fa3eb78 80010024
[    3.391513] bb61000c 38210020 7c0803a6 4e800020 <0fe00000> 812a0000
2f890000 409eff98
[    3.394280] ---[ end trace a4431b67b2b33261 ]---
[    3.397425] scsi host1: pata_macio
