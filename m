Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40AD5DED.4000608@sonartech.com.au>
Date: Fri, 21 May 2004 11:39:57 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question on the fs choice
References: <EFB813091B18D511BD3600508B644F820A617EBB@tx14exm06.ftw.mot.com>
In-Reply-To: <EFB813091B18D511BD3600508B644F820A617EBB@tx14exm06.ftw.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry for the late post thought I'd just add my experiences which seem
to reflect the general discussion, and hopefully gain some more

>Has anybody successfully implemented any of these FS systems on an embedded
>platform equipped with a compact flash card working as a main storage
>medium?
>
>
Yes, not successfully yet though,

platform: mvme5100

ide controller: promise pmc
ide 0000:03:03.0 Unknown mass storage controller: Promise Technology,
Inc. 20269 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Flags: bus master, 66MHz, slow devsel, latency 128, IRQ 28
        I/O ports at 774fb8 [size=8]
        I/O ports at 774fb4 [size=4]
        I/O ports at 774fa8 [size=8]
        I/O ports at 774fa4 [size=4]
        I/O ports at 774f90 [size=16]
        Memory at f36fc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: <available only to root>

compact flash: SanDisk SDCFB-512

dmesg:
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller at PCI slot 03:03.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x774f90-0x774f97, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x774f98-0x774f9f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: SanDisk SDCFB-512, CFA DISK drive
blk: queue c01d7d70, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide3...
ide2 at 0x774fb8-0x774fbf,0x774fb6 on irq 28
hde: attached ide-disk driver.
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 1000944 sectors (512 MB) w/1KiB Cache, CHS=993/16/63, BUG
Partition check:
 /dev/ide/host2/bus0/target0/lun0:hde: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
hde: dma_intr: error=0x04 { DriveStatusError }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x04 { DriveStatusError }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x04 { DriveStatusError }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x04 { DriveStatusError }
hde: DMA disabled
PDC202XX: Primary channel reset.
ide2: reset: success
 p1 p2


The Compact Flash works fine as long (if you can ignore the errors, like
above) as it's mounted read only through power failures, resets ....,
but if it's mounted rw a corrupted disk (a repartition "usually" fixes
this) can be the result after resets, power failures .....
I haven't had much time to spend on testing this but may have in the
near future, any suggestions on how I can get rid of the "hde:" errors
would be greatly appreciated, as it's probably obvious to some, but not
me ....

Ta,
dg

ps: Adam hope this helps


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
