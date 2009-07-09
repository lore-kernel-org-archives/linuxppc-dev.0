Return-Path: <roman.fietze@telemotive.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 161D8B6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 00:24:32 +1000 (EST)
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 1A405DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 00:24:30 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id E8835B8390
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 16:24:26 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
References: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
	<633A55242A59C7488FAAF5A6850929984B816F@SRVEXC01.sts.saurer.vpn>
	<fa686aa40901050731i3fb3ee2er221af3b174051aa@mail.gmail.com>
In-Reply-To: <fa686aa40901050731i3fb3ee2er221af3b174051aa@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <200907091624.26593.roman.fietze@telemotive.de>
Date: Thu, 9 Jul 2009 16:24:26 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo,

On Monday 05 January 2009 16:31:33 Grant Likely wrote:

> DMA support is now in mainline, but it is disabled by
> default ...

I had problems using ATA DMA on an own MPC5200B board, too. This board
has no problems at all using DMA33 with DENX 2.4.25, with all kinds of
automotive disks from 20 to 40GB. I definitively tested all three
listed drives below, but we are using other drives as well
(e.g. Hitachi 20 and 40 GB variants).

On exactly those boards I'm now running the 2.6.30 from DENX. The
following harddisks work well on this board, including network traffic
in parallel (which sometimes was a problem on old kernels or MPC5200's
w/o a 'B'):

=2D Toshiba MK4036GA
=2D Hitachi HEJ423020F9AT00


But an old 20GB Seagate ST940813AM shows the following problem when
booting the system:

PHY: f0003000:00 - Link is Up - 100/Half
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata1.00: BMDMA stat 0x5
ata1.00: cmd ca/00:08:1f:10:9c/00:00:00:00:00/e0 tag 0 dma 4096 out
         res 51/84:08:1f:10:9c/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY ERR }
ata1.00: error: { ICRC ABRT }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1: EH complete


I think this is similar to the errors reported after the ATA DMA patch
for the MPC5200B was introduced in this mailing list.

I even tried to use some modified timings from the 2.4.25 kernel, but
(of course) w/o success.

Are there any other patches I should try? Anything I could do to help
you to get this problem fixed?


Roman

=2D-=20
Roman Fietze  Telemotive AG  B=FCro M=FChlhausen
