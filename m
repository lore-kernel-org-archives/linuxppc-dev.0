Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 3AC0EDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:27:08 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ko8ef-0002EG-En
	for linuxppc-dev@ozlabs.org; Thu, 09 Oct 2008 20:27:05 -0700
Message-ID: <19911261.post@talk.nabble.com>
Date: Thu, 9 Oct 2008 20:27:05 -0700 (PDT)
From: Jeff Borlin <jborlin@aclaratech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Compact Flash on 8349mITX
In-Reply-To: <20081009172338.GA4292@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <6011A7C9CD0EE74792C3ED2A83556086342189@mail.twacs.com>
	<6011A7C9CD0EE74792C3ED2A8355608634218F@mail.twacs.com>
	<19900326.post@talk.nabble.com>
	<20081009172338.GA4292@oksana.dev.rtsoft.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Anton Vorontsov-2 wrote:
> 
> This happens just before the PATA information is printed. I'm not
> libata expert; and from the brief look I don't see where libata
> clears any pending "unexpected" irqs. Just a guesswork,
> could you try this patch?
> 
This patch did not appear to change anything.  


Anton Vorontsov-2 wrote:
> 
> Can you check if the CF will work w/o IRQs? To try it:
> 
Your directions did result in progress:
[...]
scsi4 : pata_platform
ata5: PATA max PIO6 no IRQ, using PIO polling mmio cmd 0xf0000000 ctl
0xf000020c
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
 sda: sda1 sda2
sd 4:0:0:0: [sda] Attached SCSI removable disk
sd 4:0:0:0: Attached scsi generic sg0 type 0
physmap platform flash device: 01000000 at fe000000
[...]
/ # dd if=/dev/sda of=/dev/null count=20000
20000+0 records in
20000+0 records out
/ # mount -t vfat /dev/sda /mnt/cf
mount: Mounting /dev/sda on /mnt/cf failed: Invalid argument
/ # mount -t vfat /dev/sda2 /mnt/cf
mount: Mounting /dev/sda2 on /mnt/cf failed: Invalid argument

I still need to figure out what I may be doing wrong here, but wanted to
post the results I have so far in case they are useful.  
-- 
View this message in context: http://www.nabble.com/Compact-Flash-on-8349mITX-tp18754330p19911261.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
