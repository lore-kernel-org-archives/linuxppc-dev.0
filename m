Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 84FA4474D3
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:16:48 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1089265ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 08:16:47 -0800 (PST)
Message-ID: <4919AFED.50903@genesi-usa.com>
Date: Tue, 11 Nov 2008 10:16:45 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
Subject: Re: AW: [PATCH]: [MPC5200] Add ATA DMA support
References: <20080813061135.GH17587@secretlab.ca>	<792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
	<633A55242A59C7488FAAF5A6850929984B8133@SRVEXC01.sts.saurer.vpn>
	<49199847.5090505@genesi-usa.com>
	<633A55242A59C7488FAAF5A6850929984B8136@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <633A55242A59C7488FAAF5A6850929984B8136@SRVEXC01.sts.saurer.vpn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hmm even with DMA built in my disk (Seagate 5400.8) still "configured" for
PIO4.

This is probably my fault. Tim, could you respin the patch anyway since
it doesn't apply cleanly to the 2.6.27 kernel? :)

This did work for me once but we were still using a SUSE kernel (from
11.0) to patch it onto and another interrupt controller patch crippled
performance so it wasn't a really good test..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Lehmann, Hans (Ritter Elektronik) wrote:
> We take a vanilla kernel with rt11 patches from Ingo Mollnar.
> 
> Here are the section of my boot messages
> 
> ata: MPC52xx IDE/ATA libata driver
> scsi0 : mpc52xx_ata
> ata1: PATA max UDMA/33 ata_regs 0xf0003a00 irq 135
> ata1.00: ATA-0: ELITE PRO CF CARD 1GB, 20070131, max MWDMA2
> ata1.00: 2031120 sectors, multi 0: LBA
> ata1.00: configured for MWDMA2
> ata1.00: configured for MWDMA2
> ata1: EH complete
> scsi 0:0:0:0: Direct-Access     ATA      ELITE PRO CF CAR 2007 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 2031120 512-byte hardware sectors (1040 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 2031120 512-byte hardware sectors (1040 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 
> 
> Greetings
> 
> Mit freundlichen Grüßen
> 
> Hans Lehmann
> Softwareentwicklung
> 
> Telefon	+49 (0)2191-67-2520
> Fax 	+49 (0)2191-67-703408
> e-mail 	hans.lehmann@ritter-elektronik.de
> 
> 
> 
> Ritter Elektronik GmbH
> Leverkuser Straße 65
> D-42897 Remscheid
> www.ritter-elektronik.de
> 
> Geschäftsführer: Manfred A. Wagner, Dr. Uwe Baader
> Sitz der Gesellschaft: Oberhausen
> HRB 17168 Duisburg  /  USt-ID DE 814009849
> 
> 
> -----Ursprüngliche Nachricht-----
> Von: Matt Sealey [mailto:neko@genesi-usa.com] Im Auftrag von Matt Sealey
> Gesendet: Dienstag, 11. November 2008 15:36
> An: Lehmann, Hans (Ritter Elektronik)
> Cc: Tim Yamin; Grant Likely; linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH]: [MPC5200] Add ATA DMA support
> 
> Oddly I built 2.6.27.2 with the patch and the Efika "waited" for a disk to appear and didn't get anywhere. If I set libata.dma=0 then it complained about missing symbols (but not with it enabled!).
> 
> This was a clean SUSE kernel from Factory, with only the ATA patch applied with a few hand-merges (pata_mpc52xx.c has had a line of whitespace removed at some point, but otherwise identical).
> 
> Lehmann, Hans (Ritter Elektronik) wrote:
>> Tim, Grant,
>>
>> I have tested the patch on our MPC5200B based board with Kingston Elite Pro CF-card and it worked fine with DMA2. I have port the patch back to 2.6.24.7 Kernel and I can't detect problems our errors, even with big files (40 mB) over FEC wich I save to card . We get performance up to 10,5mB/s which is near to the max. speed.
>>
>> Greetings
>>
>>
>>
>>
>> Mit freundlichen Grüßen
>>
>> Hans Lehmann
>> Softwareentwicklung
>>
>> Telefon	+49 (0)2191-67-2520
>> Fax 	+49 (0)2191-67-703408
>> e-mail 	hans.lehmann@ritter-elektronik.de
>>
>>
>>
>> Ritter Elektronik GmbH
>> Leverkuser Straße 65
>> D-42897 Remscheid
>> www.ritter-elektronik.de
>>
>> Geschäftsführer: Manfred A. Wagner, Dr. Uwe Baader Sitz der 
>> Gesellschaft: Oberhausen HRB 17168 Duisburg  /  USt-ID DE 814009849
>>
>>
>> -----Ursprüngliche Nachricht-----
>> Von: linuxppc-dev-bounces+hans.lehmann=ritter-elektronik.de@ozlabs.org 
>> [mailto:linuxppc-dev-bounces+hans.lehmann=ritter-elektronik.de@ozlabs.
>> org] Im Auftrag von Tim Yamin
>> Gesendet: Mittwoch, 13. August 2008 11:07
>> An: Grant Likely
>> Cc: linuxppc-dev@ozlabs.org
>> Betreff: [WW Spam: medium] Re: [PATCH]: [MPC5200] Add ATA DMA support
>>
>> On Wed, Aug 13, 2008 at 7:11 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> Sounds good to me.  You will get more testers that way.  I can pick 
>>> it up for -next if everything else looks good.
>> Here are the new patches; tested against 2.6.27-rc3.
>>
>> Thanks,
>>
>> Tim
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
> 
