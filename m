Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D84CCDDF4A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:47:02 +1100 (EST)
Date: Fri, 10 Oct 2008 15:47:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Borlin <jborlin@aclaratech.com>
Subject: Re: Compact Flash on 8349mITX
Message-ID: <20081010114701.GB5481@oksana.dev.rtsoft.ru>
References: <6011A7C9CD0EE74792C3ED2A83556086342189@mail.twacs.com>
	<6011A7C9CD0EE74792C3ED2A8355608634218F@mail.twacs.com>
	<19900326.post@talk.nabble.com>
	<20081009172338.GA4292@oksana.dev.rtsoft.ru>
	<19911261.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <19911261.post@talk.nabble.com>
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

On Thu, Oct 09, 2008 at 08:27:05PM -0700, Jeff Borlin wrote:
> 
> 
> Anton Vorontsov-2 wrote:
> > 
> > This happens just before the PATA information is printed. I'm not
> > libata expert; and from the brief look I don't see where libata
> > clears any pending "unexpected" irqs. Just a guesswork,
> > could you try this patch?
> > 
> This patch did not appear to change anything.  

:-(

> Anton Vorontsov-2 wrote:
> > 
> > Can you check if the CF will work w/o IRQs? To try it:
> > 
> Your directions did result in progress:
> [...]
> scsi4 : pata_platform
> ata5: PATA max PIO6 no IRQ, using PIO polling mmio cmd 0xf0000000 ctl
> 0xf000020c
> ata5.00: CFA: SanDisk SDCFJ-512, HDX 3.13, max MWDMA2
> ata5.00: 1000944 sectors, multi 0: LBA
> ata5.00: configured for PIO
> scsi 4:0:0:0: Direct-Access     ATA      SanDisk SDCFJ-51 HDX  PQ: 0 ANSI: 5
> sd 4:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
> sd 4:0:0:0: [sda] Write Protect is off
> sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 4:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
> sd 4:0:0:0: [sda] Write Protect is off
> sd 4:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
>  sda: sda1 sda2
> sd 4:0:0:0: [sda] Attached SCSI removable disk
> sd 4:0:0:0: Attached scsi generic sg0 type 0
> physmap platform flash device: 01000000 at fe000000
> [...]
> / # dd if=/dev/sda of=/dev/null count=20000
> 20000+0 records in
> 20000+0 records out

Ok, it basically works w/o IRQs...

I'll try to find bunch of CF flashes to test, but to my knowledge
they all worked for me on the mitx (i.e. with IRQs)... :-/

If I could find the non-working CF (or non-working mITX board)
I would investigate this...

> / # mount -t vfat /dev/sda /mnt/cf
> mount: Mounting /dev/sda on /mnt/cf failed: Invalid argument
> / # mount -t vfat /dev/sda2 /mnt/cf
> mount: Mounting /dev/sda2 on /mnt/cf failed: Invalid argument

This seems unrelated, either there isn't vfat support enabled in the
kernel, or there is another filesystem on the CF).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
