Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C9B5DDFBF
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 01:52:03 +1100 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1JN86S-0003gI-QC
	for linuxppc-dev@ozlabs.org; Thu, 07 Feb 2008 15:51:57 +0100
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Thu, 7 Feb 2008 15:51:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200802071551.51901.jbe@pengutronix.de>
Subject: MPC5200B AC97 support for recent kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm using a 2.6.23 kernel and trying to get the AC97 running on my MPC5200B=
=20
based CPU card. I'm using a patch stack posted here last year. FEC and ATA=
=20
seems running correctly. Also the AC97 seems to run, but I can hear some=20
noise only. But ALSA does detect the external Wolfson codec and its=20
capabilities correctly, so I think the AC97 link works as expected.

Some things I noticed:

 - I can control the volume of the noise with alsamixer
 - the external codes outputs the correct clock (~12 MHz)
 - the MPC5200B AC97 driver receives interrupts from the bestcomm unit (to
   report progress to the pcm framework)
 - everything seems ways too fast. A four minutes mp3 song is ready after
   40 seconds
 - I'm not sure: What type of data wants the AC97 PCS unit? AC97
   data slots are 20 bits wide. int32_t or 24 bits per sample? Big endian?
 - does it use interleave? Left, right, left, right, ... to be fed into AC97
   data slot 3 and 4?

Any ideas?

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
