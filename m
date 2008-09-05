Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 86DB2DDDE1
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 04:29:11 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Kbg3Q-00036c-F1
	for linuxppc-dev@ozlabs.org; Fri, 05 Sep 2008 11:29:08 -0700
Message-ID: <19336474.post@talk.nabble.com>
Date: Fri, 5 Sep 2008 11:29:08 -0700 (PDT)
From: WITTROCK <jwittrock@maginst.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
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



Tim Yamin-2 wrote:
> 
> On Wed, Aug 13, 2008 at 7:11 AM, Grant Likely <grant.likely@secretlab.ca>
> wrote:
>> Sounds good to me.  You will get more testers that way.  I can pick it
>> up for -next if everything else looks good.
> 
> Here are the new patches; tested against 2.6.27-rc3.
> 
> Thanks,
> 
> Tim
> 



I have been trying this patch against 2.6.26.3 on our own MPC5200B based
board.  I am using a seagate  ST980815A.  The drive mounts O.K, and I can
transfer small files, but during large transfers there is the following
problem.

.....

## Booting kernel from Legacy Image at 00500000 ...
   Image Name:   Linux-2.6.26.3
   Created:      2008-09-05  17:01:31 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1409558 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 00400000
   Booting using the fdt blob at 0x400000
[    0.000000] Using m9000 machine description
[    0.000000] Linux version 2.6.26.3 (developer@usi-dev-linux) (gcc version
4.1.2) #2 Fri Sep 5 13:01:26 EDT 2008
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    32767
[    0.000000]   Normal      32767 ->    32767

........

[    0.796907] Driver 'sd' needs updating - please use bus_type methods
[    0.803944] ata: MPC52xx IDE/ATA libata driver
[    0.809300] scsi0 : mpc52xx_ata
[    0.813246] ata1: PATA max UDMA/33 ata_regs 0xf0003a00 irq 135
[    0.980196] ata1.00: ATA-6: ST980815A, 3.ALC, max UDMA/100
[    0.985864] ata1.00: 156301488 sectors, multi 0: LBA48 
[    1.004074] ata1.00: configured for UDMA/33
[    1.009047] scsi 0:0:0:0: Direct-Access     ATA      ST980815A       
3.AL PQ: 0 ANSI: 5
[    1.018652] sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026
MB)
[    1.026104] sd 0:0:0:0: [sda] Write Protect is off
[    1.031419] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    1.041235] sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026
MB)
[    1.048681] sd 0:0:0:0: [sda] Write Protect is off
[    1.053994] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    1.063308]  sda: unknown partition table
[    1.077092] sd 0:0:0:0: [sda] Attached SCSI disk

.......

-sh-2.05b# 
-sh-2.05b# cp test.txt > /mnt/hd/writetest
-sh-2.05b# cp test2.txt > /mnt/hd/writetest
-sh-2.05b# cp -R  /test /mnt/hd/writetest
[  170.239726] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[  170.247020] ata1.00: cmd ca/00:18:30:00:00/00:00:00:00:00/e0 tag 0 dma
12288 out
[  170.247033]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
[  170.262180] ata1.00: status: { DRDY }
[  170.265995] ata1: soft resetting link
[  170.423867] ata1.00: revalidation failed (errno=-2)
[  170.428902] ata1: failed to recover some devices, retrying in 5 secs
[  175.435694] ata1: soft resetting link
[  175.591873] ata1.00: revalidation failed (errno=-2)
[  175.596909] ata1: failed to recover some devices, retrying in 5 secs
[  180.603697] ata1: soft resetting link
[  180.759873] ata1.00: revalidation failed (errno=-2)
[  180.764907] ata1.00: disabled
[  181.271725] ata1: soft resetting link
[  181.427741] ata1: EH complete
[  181.430856] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.437358] end_request: I/O error, dev sda, sector 48
[  181.442652] Buffer I/O error on device sda, logical block 6
[  181.448386] lost page write due to I/O error on sda
[  181.453429] Buffer I/O error on device sda, logical block 7
[  181.459165] lost page write due to I/O error on sda
[  181.464205] Buffer I/O error on device sda, logical block 8
[  181.469939] lost page write due to I/O error on sda
[  181.475076] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.481580] end_request: I/O error, dev sda, sector 8
[  181.486782] Buffer I/O error on device sda, logical block 1
[  181.492515] lost page write due to I/O error on sda
[  181.497653] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.504158] end_request: I/O error, dev sda, sector 0
[  181.509361] Buffer I/O error on device sda, logical block 0
[  181.515091] lost page write due to I/O error on sda
[  181.520252] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.526762] end_request: I/O error, dev sda, sector 180232
[  181.532441] Buffer I/O error on device sda, logical block 22540
[  181.538534] lost page write due to I/O error on sda
[  181.543784] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.550259] end_request: I/O error, dev sda, sector 180328
[  181.556223] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.562707] end_request: I/O error, dev sda, sector 181352
[  181.568659] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.575144] end_request: I/O error, dev sda, sector 182376
[  181.581094] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.587579] end_request: I/O error, dev sda, sector 183400
[  181.593483] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  181.599997] end_request: I/O error, dev sda, sector 184424
[  185.268091] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  185.274573] end_request: I/O error, dev sda, sector 180224
[  185.280329] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  185.286803] end_request: I/O error, dev sda, sector 64
[  185.292100] Buffer I/O error on device sda, logical block 8
[  185.297830] lost page write due to I/O error on sda
[  185.302957] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  185.309462] end_request: I/O error, dev sda, sector 48
[  185.314756] Buffer I/O error on device sda, logical block 6
[  185.320493] lost page write due to I/O error on sda
[  185.325593] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  185.332095] end_request: I/O error, dev sda, sector 0
[  185.337299] Buffer I/O error on device sda, logical block 0
[  185.343028] lost page write due to I/O error on sda
[  185.348067] Buffer I/O error on device sda, logical block 1
[  185.353805] lost page write due to I/O error on sda

With PATA_MPC52xx_DMA not set, it works fine.  To help eliminate our
hardware, I also tried this on a lite5200b development board, and had the
same results.  I also tried this with a compact flash card, and then the
problem occurs, but it happens during bootup.  I can't be certain my cf card
works with DMA though, as I don't have anything else handy to test it with.

I do have a driver which communicates with an FPGA using the LocalPlus bus,
but for the purpose of testing I don't have it installed, and the FPGA I/O
is tristated.

I recall reading somewhere that the lite5200B board had some problem with
IDE signal integrity when using a regular IDE cable, so I used an ultra-IDE
cable with the same results.  On our own hardware, there is no cable as the
drive mounts directly to a connector on our board within ~3" of the
processor.

Any thoughts.....

Thanks,
-Jeff
-- 
View this message in context: http://www.nabble.com/-PATCH-%3A--MPC5200--Add-ATA-DMA-support-tp17880454p19336474.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
