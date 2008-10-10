Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07325DDEDE
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 18:26:11 +1100 (EST)
Message-ID: <48EF0388.3070006@linux.net.cn>
Date: Fri, 10 Oct 2008 15:26:00 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: Jeff Borlin <jborlin@aclaratech.com>
Subject: Re: Compact Flash on 8349mITX
References: <6011A7C9CD0EE74792C3ED2A83556086342189@mail.twacs.com>	<6011A7C9CD0EE74792C3ED2A8355608634218F@mail.twacs.com>	<19900326.post@talk.nabble.com>	<20081009172338.GA4292@oksana.dev.rtsoft.ru>
	<19911261.post@talk.nabble.com>
In-Reply-To: <19911261.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Borlin wrote:
> 
> Anton Vorontsov-2 wrote:
>> This happens just before the PATA information is printed. I'm not
>> libata expert; and from the brief look I don't see where libata
>> clears any pending "unexpected" irqs. Just a guesswork,
>> could you try this patch?
>>
> This patch did not appear to change anything.  

Without this patch, you can't use it without irq.

> Anton Vorontsov-2 wrote:
>> Can you check if the CF will work w/o IRQs? To try it:
>>
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
> / # mount -t vfat /dev/sda /mnt/cf
> mount: Mounting /dev/sda on /mnt/cf failed: Invalid argument
> / # mount -t vfat /dev/sda2 /mnt/cf
> mount: Mounting /dev/sda2 on /mnt/cf failed: Invalid argument
> 
> I still need to figure out what I may be doing wrong here, but wanted to
> post the results I have so far in case they are useful.  

The CF card seems to work fine. See if your kernel supports vfat by

# cat /proc/filesystems

Of course, you need to mount /proc properly first. If your kernel
doesn't support vfat, make it support.

Or you can insert a blank CF card and play with it (ext2, etc)
