Date: Mon, 12 Jan 2004 12:09:42 -0800
From: mutex <mutex@cryptobackpack.org>
To: ghannon@cspi.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DMA timing issues with promise controllers
Message-ID: <20040112200942.GF15119@heliosphan.futuretel.com>
Reply-To: mutex <mutex@cryptobackpack.org>
References: <85256E19.005070C8.00@pine.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <85256E19.005070C8.00@pine.cspi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 12, 2004 at 10:14:39AM -0500 or thereabouts, ghannon@cspi.com wrote:
> If it helps any I've seen exactly the same thing on a Motorola VME board
> with a Ramix (now GE Fanuc) card running over PCI.  It also uses
> a PROMIS chip.   The error seem to be just a nuisance, but does cause
> an extra delay during boot.  You're right that it does appear to be a DMA
> timing
> issue, as the system sees the drive fine and it works great after the
> reset.
>

It would be nice if my machine didn't have a 5 min booting time ;-)

> Anything I saw on lists said to check cables, etc. which was not the issue
> here.     For me, the bigger problem is to get the firmware on the board to
> talk to the controller and recognize the drive so I can boot from it.
> This was booted from flash.
>

I checked cables and what not as well.  Are you able to boot from
it ?  I haven't tried yet, so far I've just been messing with the
drives on a gentoo livecd.

I would like to test 2.6, see if it has the same problems.

>
> Snip from boot output ************
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20269: IDE controller at PCI slot 00:11.0
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0x77ef90-0x77ef97, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x77ef98-0x77ef9f, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> hde: IC25N040ATCS04-0, ATA DISK drive
> blk: queue c0224b60, I/O limit 4095Mb (mask 0xffffffff)
> Probing IDE interface ide3...
> ide2 at 0x77efb8-0x77efbf,0x77efb6 on irq 28
> hde: attached ide-disk driver.
> hde: host protected area => 1
> hde: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63,
> UDMA(100)
> Partition check:
>  hde:<4>hde: dma_timer_expiry: dma status == 0x21
> hde: error waiting for DMA
> hde: dma timeout retry: status=0x51 { DriveReady SeekComplete Error }
> hde: dma timeout retry: error=0x84 { DriveStatusError BadCRC }
>  hde1 hde2 hde3 hde4 <hde: dma_intr: status=0x51 { DriveReady SeekComplete
> Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> PDC202XX: Primary channel reset.
> ide2: reset: success
>  hde5 >
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>
> end snip ************************
>
> If you find a fix and would like me to test it on this platform, I'd be
> glad to.
> I'm running at 2.4.23-pre5 from the linuxppc_2_4_devel tree.
> The errors happen on every reset.
>

yeah sucks.  I think i'm running 2.4.22-something... I'll check when
I'm back at home in front of the box.  Benh said that it may be the
controller is expecting a PC bios to set some timing register, and OF
isn't doing that.  I'll take a look at the driver when I have a few
minutes.. see if it insipres anything, however I must admit my
experince with IDE drivers is definatly 'less-than-expert' status.

Are you using the pdc202xx_new or pdc202xx_old driver ?  It looks like
andre hedrick is the maintainer, I'll email him with a pointer to this
thread, maybe he will have something insipring to add.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
