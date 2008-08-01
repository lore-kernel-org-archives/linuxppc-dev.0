Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3F48CDDE41
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:51:01 +1000 (EST)
Date: Fri, 1 Aug 2008 20:50:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Sparks, Sam" <SSparks@aclaratech.com>
Subject: Re: Compact flash on mpc8349eITX
Message-ID: <20080801165059.GA7047@polina.dev.rtsoft.ru>
References: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
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

On Fri, Aug 01, 2008 at 10:58:58AM -0500, Sparks, Sam wrote:
> I'm trying to get the compact flash up and running on an mpc8349eITX,
> and am continually running into issues where the IRQ is not processed,
> and the mmio commands are not getting response. At this point, I am
> starting to suspect a HW issue, but I was hoping to verify that I am
> using a known good kernel configuration.
> 
> Has anyone successfully communicated with a compact flash device in true
> IDE mode on the MPC8349eITX? If so, do you happen to know the kernel
> configuration and/or revision?

Works like a charm here. I use quite outdated u-boot though. Which one
you use? I could try it (if it is community u-boot).

As for the backtrace you posted recently, I remeber I've noticed the
similar issue long ago on some mITX board. I believe the board had
hw issues indeed (or CF card I tested with). The problem could be in
the IRQ line itself (for some reason it always low), or it could be
IDE cmd/data lines at fault, so that IDE can't receive status read
command and does not deassert the interrupt line... quite hard to
tell.

The logs below.

(Notice that u-boot says that UPMA is configured to work with CF IDE).

U-Boot 1.2.0-g5b1313fb (Jun  9 2007 - 17:29:42) MPC83XX

CPU:   e300c1, MPC8349E, Rev: 11 at 533.333 MHz, CSB:  266 MHz
Board: Freescale MPC8349E-mITX
UPMA:  Configured for compact flash
I2C:   ready
DRAM:
   DDR DIMM: data bus width is 64 bit without ECC
   DDRC ECC mode: OFF
   DDR RAM: 256 MB
FLASH: 16 MB
PCI:   Bus Dev VenId DevId Class Int
        00  10  1095  3114  0180  00
In:    serial
Out:   serial
Err:   serial
Board revision: 1.0 (PCF8475A)
Net:   TSEC0
IDE:   Bus 0: OK
  Device 0: Model: KINGSTON Firm: 20060713 Ser#: KINGSTON CF 00003E2C
            Type: Hard Disk
            Capacity: 495.1 MB = 0.4 GB (1014048 x 512)
MPC8349E-mITX> boot
[...]
Using MPC834x ITX machine description
Linux version 2.6.27-rc1-00006-g2799599 (cbou@polina) (gcc version 4.2.0)) #35 Fri Aug 1 20:32:51 MSD 2008
[...]
scsi0 : pata_platform
ata1: PATA max PIO6 mmio cmd 0xf0000000 ctl 0xf000020c irq 23
ata1.00: ATA-0: KINGSTON, 20060713, max MWDMA2
ata1.00: 1014048 sectors, multi 0: LBA
ata1.00: configured for PIO
ata1.00: configured for PIO
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      KINGSTON         2006 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1014048 512-byte hardware sectors (519 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 1014048 512-byte hardware sectors (519 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
[...]
# dd if=/dev/sda of=/dev/null count=20000
20000+0 records in
20000+0 records out
10240000 bytes (10 MB) copied, 1.94026 seconds, 5.3 MB/s

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
