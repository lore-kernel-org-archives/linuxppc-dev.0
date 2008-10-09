Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 21DC5DE19E
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 02:52:12 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Knxo9-0007gb-7I
	for linuxppc-dev@ozlabs.org; Thu, 09 Oct 2008 08:52:09 -0700
Message-ID: <19900326.post@talk.nabble.com>
Date: Thu, 9 Oct 2008 08:52:09 -0700 (PDT)
From: Jeff Borlin <jborlin@aclaratech.com>
To: linuxppc-dev@ozlabs.org
Subject: RE: Compact Flash on 8349mITX
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have taken over this effort to get Compact Flash working on the 8349mITX
board and am running into these same issues.  I can get uBoot to list the
contents of a CF card, but am running into a couple problems through the
kernel.  There appears to be an IRQ problem and a general communication
problem with the CF card, possibly related.  Note that I am very new to
Linux so please don't assume obvious things are correct

I am using the latest from /linux/kernel/git/benh/powerpc.git, and created
my dtb from:  arch/powerpc/dts/mpc8349emitx.dts.  

Any ideas on what I could try or look into next with either issue?  

boot info:  
[...]
Kernel command line: root=/dev/ram ramdisk_size=65000 rw
ip=10.100.17.83:10.100.10.74:10.100.17.1:255.255.255.0::eth0:off irqpoll
console=ttyS0,115200 mtdparts=physmap-flash.0:64k,8128k,-
Misrouted IRQ fixup and polling support enabled
[...]
Using MPC834x ITX machine description
Linux version 2.6.27-rc5-11100-g7c12d90-dirty (jborlin@sce-svr1.twacs.local)
(gcc version 3.4.5) #4 Thu Oct 9 07:56:48 CDT 2008
[...]
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
Driver 'sd' needs updating - please use bus_type methods
sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
ata1: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000080 irq 22
ata2: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900000c0 irq 22
ata3: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x90000280 irq 22
ata4: SATA max UDMA/100 mmio m1024@0x90000000 tf 0x900002c0 irq 22
ata1: SATA link down (SStatus 0 SControl 310)
ata2: SATA link down (SStatus 0 SControl 310)
ata3: SATA link down (SStatus 0 SControl 310)
ata4: SATA link down (SStatus 0 SControl 310)
irq 23: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[cec29a30] [c00089a4] 0xc00089a4 (unreliable)
[cec29a60] [c00467d8] 0xc00467d8
[...]
Disabling IRQ #23
scsi4 : pata_platform
ata5: PATA max PIO6 mmio cmd 0xf0000000 ctl 0xf000020c irq 23
ata5.00: CFA: SanDisk SDCFJ-512, HDX 3.13, max MWDMA2
ata5.00: 1000944 sectors, multi 0: LBA
ata5.00: configured for PIO
scsi 4:0:0:0: Direct-Access     ATA      SanDisk SDCFJ-51 HDX  PQ: 0 ANSI: 5
sd 4:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
sd 4:0:0:0: [sda] Write Protect is off
sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
sd 4:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
sd 4:0:0:0: [sda] Write Protect is off
sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sda:<3>ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata5.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: status: { DRDY }
ata5: soft resetting link
ata5.00: configured for PIO
ata5: EH complete
ata5.00: limiting speed to UDMA7:PIO5
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata5.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: status: { DRDY }
ata5: soft resetting link
ata5.00: configured for PIO
ata5: EH complete
ata5.00: limiting speed to PIO0
[...]
-- 
View this message in context: http://www.nabble.com/Compact-Flash-on-8349mITX-tp18754330p19900326.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
