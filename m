Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 491A2B7CF9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 21:01:01 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 4543BB6D0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 12:00:55 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5200B, many FEC_IEVENT_RFIFO_ERRORs until link down
MIME-Version: 1.0
Message-ID: <201003301200.54609.roman.fietze@telemotive.de>
Date: Tue, 30 Mar 2010 12:00:54 +0200
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

Hello,

I think this is a never ending story. This error still happens under
higher load every few seconds, until I get a "PHY: f0003000:00 - Link
is Down", on my box easiliy reproducable after maybe 15 to 30 seconds.
I can recover using "ip link set down/up dev eth0".

I double checked that I'm using the most recent version of this driver
(checked with DENX, benh master/next, using Wolfgang Denk's version of
the 2.6.33), this includes the locking patches from Asier Llano, the
hard setting of mii_speed in the PHY mdio transfer routine of course.
I tried all 8 combinations of PLDIS, BSDIS and SE, with and without
CONFIG_NOT_COHERENT_CACHE.

As some of you probably remember, I'm running this controller under
high load on FEC, ATA and LPC. As soon as "the" load is going above a
certain level I get those FEC RFIFO errors, sometimes ATA errors
(MWDMA2) and sometimes even lost SDMA interrupts using BestComm with
the SCLPC (now switched back to simple PIO). I quite sure almost all
of this is the BestComm's fault.

Did somebody already try the latest NAPI patches, which might give me
a slight chance to have a workaround? Any idea or upcoming patch to
address this problem once more, and if it's just by recovering e.g.
within mpc52xx_fec_mdio_transfer's timeout using some other dirty
workaround?


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
