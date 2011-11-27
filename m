Return-Path: <acrux_it@libero.it>
Received: from outrelay08.libero.it (outrelay08.libero.it [212.52.84.112])
 by ozlabs.org (Postfix) with ESMTP id 4DC8BB6F8E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 03:37:39 +1100 (EST)
Received: from acrux-1faad1e87 (151.77.169.2) by outrelay08.libero.it
 (8.5.133) (authenticated as acrux_it@libero.it)
 id 4EBCFB600249B67C for linuxppc-dev@lists.ozlabs.org;
 Sun, 27 Nov 2011 17:37:35 +0100
Date: Sun, 27 Nov 2011 17:37:48 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
Message-Id: <20111127173748.9f235741.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Acube Sam460ex has SM502 as onboard video.
I got this with any kernel newer than 2.6.38.x thus the framebuffer is lost too:

root@sam4x0:~# diff dmesg-2.6.38.8 dmesg-2.6.39.4
1,2c1,3
< Using PowerPC 44x Platform machine description
< Linux version 2.6.38.8-Sam460ex (root@sam4x0) (gcc version 4.5.3 (CRUX PPC) ) #1 Fri Nov 11 22:07:53 CET 2011
---
> Using Canyonlands machine description
> Initializing cgroup subsys cpu
> Linux version 2.6.39.4-Sam460ex (root@sam4x0) (gcc version 4.5.3 (CRUX PPC) ) #1 Fri Nov 11 19:06:02 CET 2011
17c18
[cut]
161,179c165,167
< sm501 0001:00:06.0: SM501 At f5480000: Version 050100c0, 64 Mb, IRQ 19
< sm501 0001:00:06.0: setting M1XCLK to 144000000
< sm501 0001:00:06.0: setting MCLK to 72000000
< sm501-usb[0] [mem 0xd84040000-0xd8405ffff]
< sm501-usb[1] [mem 0xd83fc0000-0xd83ffffff]
< sm501-usb[2] [irq 19]
< serial8250.10: ttyS2 at MMIO 0xd84030000 (irq = 19) is a ST16654
< serial8250.10: ttyS3 at MMIO 0xd84030020 (irq = 19) is a ST16654
< sm501-fb[0] [mem 0xd84080000-0xd8408ffff]
< sm501-fb[1] [mem 0xd84100000-0xd8414ffff]
< sm501-fb[2] [mem 0xd80000000-0xd83fbffff]
< sm501-fb[3] [irq 19]
< sm501-fb sm501-fb.80: fb sm501fb-crt disabled at start
< Console: switching to colour frame buffer device 100x37
< sm501-fb sm501-fb.80: fb0: sm501fb-crt frame buffer
< sm501-fb sm501-fb.80: fb sm501fb-panel enabled at start
< sm501-fb sm501-fb.80: fb1: sm501fb-panel frame buffer
< of:sata-dwc 4bffd1000.sata: id 0, controller version 1.82
< of:sata-dwc 4bffd1000.sata: DMA initialized
---
> sm501 0001:00:06.0: incorrect device id c0000105
> sata-dwc 4bffd1000.sata: id 0, controller version 1.82
> sata-dwc 4bffd1000.sata: DMA initialized
181,182c169
< ata1: SATA max UDMA/133 irq 31
< Fixed MDIO Bus: probed
---
> ata1: SATA max UDMA/133 irq 34
[...]


btw, i remember that i also receive a kernel panic if MTD support is enabled with any kernel newer than 2.6.36.x


regards,
--nico
-- 
acrux <acrux_it@libero.it>
