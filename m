Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D3EACDE69B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 04:23:40 +1100 (EST)
Date: Thu, 9 Oct 2008 21:23:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Borlin <jborlin@aclaratech.com>
Subject: Re: Compact Flash on 8349mITX
Message-ID: <20081009172338.GA4292@oksana.dev.rtsoft.ru>
References: <19900326.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <19900326.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 08:52:09AM -0700, Jeff Borlin wrote:
> 
> I have taken over this effort to get Compact Flash working on the 8349mITX
> board and am running into these same issues.  I can get uBoot to list the
> contents of a CF card,

U-Boot doesn't use interrupts.

> but am running into a couple problems through the
> kernel.  There appears to be an IRQ problem and a general communication
> problem with the CF card, possibly related.  Note that I am very new to
> Linux so please don't assume obvious things are correct
> 
> I am using the latest from /linux/kernel/git/benh/powerpc.git, and created
> my dtb from:  arch/powerpc/dts/mpc8349emitx.dts.  
> 
> Any ideas on what I could try or look into next with either issue?  
> 
> boot info:  
> [...]
[...]

This happens just before the PATA information is printed. I'm not
libata expert; and from the brief look I don't see where libata
clears any pending "unexpected" irqs. Just a guesswork,
could you try this patch?

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 8f65ad6..3b7c79d 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
+#include <linux/io.h>
 #include <scsi/scsi_host.h>
 #include <linux/ata.h>
 #include <linux/libata.h>
@@ -171,6 +172,8 @@ int __devinit __pata_platform_probe(struct device *dev,
 
 	pata_platform_setup_port(&ap->ioaddr, ioport_shift);
 
+	ioread8(ap->ioaddr.status_addr);
+
 	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
 		      (unsigned long long)io_res->start,
 		      (unsigned long long)ctl_res->start);


> irq 23: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [cec29a30] [c00089a4] 0xc00089a4 (unreliable)
> [cec29a60] [c00467d8] 0xc00467d8
> [...]
> Disabling IRQ #23
> scsi4 : pata_platform
> ata5: PATA max PIO6 mmio cmd 0xf0000000 ctl 0xf000020c irq 23
> ata5.00: CFA: SanDisk SDCFJ-512, HDX 3.13, max MWDMA2
> ata5.00: 1000944 sectors, multi 0: LBA
> ata5.00: configured for PIO

Can you check if the CF will work w/o IRQs? To try it:

1. open the arch/powerpc/dts/mpc8349emitx.dts file, find the pata node:

                pata@3,0 {
                        compatible = "fsl,mpc8349emitx-pata", "ata-generic";
                        reg = <0x3 0x0 0x10 0x3 0x20c 0x4>;
                        reg-shift = <1>;
                        pio-mode = <6>;
                        interrupts = <23 0x8>;
                        interrupt-parent = <&ipic>;
                };

2. delete interrupts = <>; and interrupt-parent = <>; lines.

3. recompile the dts to dtb.

4. Apply this patch to the kernel http://lkml.org/lkml/2008/10/6/176

5. And try to boot the patched kernel using the re-compiled dtb file.

> scsi 4:0:0:0: Direct-Access     ATA      SanDisk SDCFJ-51 HDX  PQ: 0 ANSI: 5
> sd 4:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
> sd 4:0:0:0: [sda] Write Protect is off
> sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 4:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
> sd 4:0:0:0: [sda] Write Protect is off
> sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
>  sda:<3>ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata5.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata5.00: status: { DRDY }
> ata5: soft resetting link
> ata5.00: configured for PIO
> ata5: EH complete
> ata5.00: limiting speed to UDMA7:PIO5
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata5.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata5.00: status: { DRDY }
> ata5: soft resetting link
> ata5.00: configured for PIO
> ata5: EH complete
> ata5.00: limiting speed to PIO0
> [...]


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
