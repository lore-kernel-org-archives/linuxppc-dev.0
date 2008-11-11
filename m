Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail5.oerlikon.com (mail5.oerlikon.com [193.158.88.212])
	by ozlabs.org (Postfix) with ESMTP id 73908474C1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 02:04:49 +1100 (EST)
Received: from anetcsgv210.dom03.net (localhost.localdomain [127.0.0.1])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 4306C2E97BA
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 16:04:45 +0100 (CET)
Received: from anetcsgv202.dom03.net (anetcsgv202.dom03.net [193.158.88.254])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 137792E97B1
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 16:04:45 +0100 (CET)
Received: from SRVWWP01.sts.saurer.vpn (unknown [10.33.20.167])
	by anetcsgv202.dom03.net (postfix-1) with ESMTP id D414192
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 16:04:44 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: [PATCH]: [MPC5200] Add ATA DMA support
Date: Tue, 11 Nov 2008 16:04:44 +0100
Message-ID: <633A55242A59C7488FAAF5A6850929984B8136@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <49199847.5090505@genesi-usa.com>
References: <20080813061135.GH17587@secretlab.ca>	<792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
	<633A55242A59C7488FAAF5A6850929984B8133@SRVEXC01.sts.saurer.vpn>
	<49199847.5090505@genesi-usa.com>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: "Matt Sealey" <matt@genesi-usa.com>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We take a vanilla kernel with rt11 patches from Ingo Mollnar.

Here are the section of my boot messages

ata: MPC52xx IDE/ATA libata driver
scsi0 : mpc52xx_ata
ata1: PATA max UDMA/33 ata_regs 0xf0003a00 irq 135
ata1.00: ATA-0: ELITE PRO CF CARD 1GB, 20070131, max MWDMA2
ata1.00: 2031120 sectors, multi 0: LBA
ata1.00: configured for MWDMA2
ata1.00: configured for MWDMA2
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      ELITE PRO CF CAR 2007 PQ: 0 =
ANSI: 5
sd 0:0:0:0: [sda] 2031120 512-byte hardware sectors (1040 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't =
support DPO or FUA
sd 0:0:0:0: [sda] 2031120 512-byte hardware sectors (1040 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't =
support DPO or FUA
 sda: sda1=20

Greetings

Mit freundlichen Gr=FC=DFen

Hans Lehmann
Softwareentwicklung

Telefon	+49 (0)2191-67-2520
Fax 	+49 (0)2191-67-703408
e-mail 	hans.lehmann@ritter-elektronik.de



Ritter Elektronik GmbH
Leverkuser Stra=DFe 65
D-42897 Remscheid
www.ritter-elektronik.de

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader
Sitz der Gesellschaft: Oberhausen
HRB 17168 Duisburg  /  USt-ID DE 814009849


-----Urspr=FCngliche Nachricht-----
Von: Matt Sealey [mailto:neko@genesi-usa.com] Im Auftrag von Matt Sealey
Gesendet: Dienstag, 11. November 2008 15:36
An: Lehmann, Hans (Ritter Elektronik)
Cc: Tim Yamin; Grant Likely; linuxppc-dev@ozlabs.org
Betreff: Re: [PATCH]: [MPC5200] Add ATA DMA support

Oddly I built 2.6.27.2 with the patch and the Efika "waited" for a disk =
to appear and didn't get anywhere. If I set libata.dma=3D0 then it =
complained about missing symbols (but not with it enabled!).

This was a clean SUSE kernel from Factory, with only the ATA patch =
applied with a few hand-merges (pata_mpc52xx.c has had a line of =
whitespace removed at some point, but otherwise identical).

Lehmann, Hans (Ritter Elektronik) wrote:
> Tim, Grant,
>=20
> I have tested the patch on our MPC5200B based board with Kingston =
Elite Pro CF-card and it worked fine with DMA2. I have port the patch =
back to 2.6.24.7 Kernel and I can't detect problems our errors, even =
with big files (40 mB) over FEC wich I save to card . We get performance =
up to 10,5mB/s which is near to the max. speed.
>=20
> Greetings
>=20
>=20
>=20
>=20
> Mit freundlichen Gr=FC=DFen
>=20
> Hans Lehmann
> Softwareentwicklung
>=20
> Telefon	+49 (0)2191-67-2520
> Fax 	+49 (0)2191-67-703408
> e-mail 	hans.lehmann@ritter-elektronik.de
>=20
>=20
>=20
> Ritter Elektronik GmbH
> Leverkuser Stra=DFe 65
> D-42897 Remscheid
> www.ritter-elektronik.de
>=20
> Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader Sitz der=20
> Gesellschaft: Oberhausen HRB 17168 Duisburg  /  USt-ID DE 814009849
>=20
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: =
linuxppc-dev-bounces+hans.lehmann=3Dritter-elektronik.de@ozlabs.org=20
> =
[mailto:linuxppc-dev-bounces+hans.lehmann=3Dritter-elektronik.de@ozlabs.
> org] Im Auftrag von Tim Yamin
> Gesendet: Mittwoch, 13. August 2008 11:07
> An: Grant Likely
> Cc: linuxppc-dev@ozlabs.org
> Betreff: [WW Spam: medium] Re: [PATCH]: [MPC5200] Add ATA DMA support
>=20
> On Wed, Aug 13, 2008 at 7:11 AM, Grant Likely =
<grant.likely@secretlab.ca> wrote:
>> Sounds good to me.  You will get more testers that way.  I can pick=20
>> it up for -next if everything else looks good.
>=20
> Here are the new patches; tested against 2.6.27-rc3.
>=20
> Thanks,
>=20
> Tim
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
