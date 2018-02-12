Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500:20f:1fff:fe04:1bbb])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgJMb0VVdzF0pR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 08:14:34 +1100 (AEDT)
Date: Mon, 12 Feb 2018 22:52:46 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Christoph Hellwig <hch@lst.de>
cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Message-ID: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I tested 4.16-rc1 on my PowerMac G4 and got the following warning from 
macio pata driver. Since pata-macio has no recent changes, dma-mapping.h 
changes seem to be related.

[    0.228408] MacIO PCI driver attached to Keylargo chipset
[    1.283931] pata-macio 0.0001f000:ata-4: Activating pata-macio chipset KeyLargo ATA-4, Apple bus ID 2
[    1.284398] WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 dmam_alloc_coherent+0xec/0x110
[    1.284689] Modules linked in:
[    1.284797] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc1 #60
[    1.284991] NIP:  c03259ec LR: c0325948 CTR: 00000000
[    1.285150] REGS: ef047c10 TRAP: 0700   Not tainted  (4.16.0-rc1)
[    1.285337] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24fff228  XER: 20000000
[    1.285559] 
               GPR00: c0325948 ef047cc0 ef048000 ef1321b0 00000000 00000000 ef1321bc 00000000 
               GPR08: 00000000 00000000 c04f1bd0 00000000 22fff884 00000000 c0004c80 00000000 
               GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0660000 c05f0960 
               GPR24: 00000007 c063d7a8 00000000 ef1e59ac 00001020 ef1321b0 ef135c18 014000c0 
[    1.303085] NIP [c03259ec] dmam_alloc_coherent+0xec/0x110
[    1.308751] LR [c0325948] dmam_alloc_coherent+0x48/0x110
[    1.314511] Call Trace:
[    1.320187] [ef047cc0] [c0325948] dmam_alloc_coherent+0x48/0x110 (unreliable)
[    1.326133] [ef047ce0] [c0370a90] pata_macio_port_start+0x44/0xb8
[    1.332110] [ef047d00] [c0355ed4] ata_host_start.part.5+0x138/0x254
[    1.338100] [ef047d30] [c035c1e8] ata_host_activate+0x84/0x1a0
[    1.344007] [ef047d50] [c0371214] pata_macio_common_init+0x3b0/0x608
[    1.349890] [ef047db0] [c0336f9c] macio_device_probe+0x60/0x120
[    1.355761] [ef047dd0] [c031868c] driver_probe_device+0x25c/0x35c
[    1.361576] [ef047e00] [c031887c] __driver_attach+0xf0/0xf4
[    1.367320] [ef047e20] [c0316340] bus_for_each_dev+0x80/0xc0
[    1.373051] [ef047e50] [c031782c] bus_add_driver+0x144/0x258
[    1.378805] [ef047e70] [c03190dc] driver_register+0x8c/0x140
[    1.384580] [ef047e80] [c060ce14] pata_macio_init+0x5c/0x8c
[    1.390303] [ef047ea0] [c0004aa0] do_one_initcall+0x48/0x18c
[    1.396000] [ef047f00] [c05f1214] kernel_init_freeable+0x12c/0x1ec
[    1.401615] [ef047f30] [c0004c98] kernel_init+0x18/0x128
[    1.407208] [ef047f40] [c00122e4] ret_from_kernel_thread+0x5c/0x64
[    1.412829] Instruction dump:
[    1.418409] 939d0000 4bff6329 80010024 7fe3fb78 8361000c 83810010 7c0803a6 83a10014
[    1.424201] 83c10018 83e1001c 38210020 4e800020 <0fe00000> 4bffff84 7fa3eb78 3be00000 
[    1.430020] ---[ end trace 89c0f4a91a110769 ]---


-- 
Meelis Roos (mroos@linux.ee)
