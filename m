Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61B99DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 20:33:53 +1100 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1JJQN4-0001eb-Bg
	for linuxppc-embedded@ozlabs.org; Mon, 28 Jan 2008 10:33:46 +0100
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 28 Jan 2008 10:33:40 +0100
References: <918EB199DDDFFA42BEA2EB3A1C6021F3020BEB4D@CORREO>
In-Reply-To: <918EB199DDDFFA42BEA2EB3A1C6021F3020BEB4D@CORREO>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801281033.40952.jbe@pengutronix.de>
Subject: Re: MPC5200B SPI codec error when there is a heavy ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 28 January 2008 09:37, TXEMA LOPEZ wrote:
> The engineers of Freescale have recognized a problem in the PSC SPI Slave
> Select signal when there is a heavy ethernet loading. Textually they say:
>
> " I have tested the MPC5200B FEC and PSC6 SPI.
> You are right. If there is heavy Ethernet loading, the PSC SPI can stop
> during transmission with SS goes high. Use a general-purpose output as SPI
> slave select signal instead PSC SPI SS signal. Factory is informed about
> similar incorrect behaviour of the PSC SPI slave select."
>
> We have repeated the error in three scenarios:
> 	In our MPC5200B custom board with a Denx 2.4.25 kernel.
> 	In a Lite5200B with a Denx 2.4.25 kernel.
> 	In a Lite5200B with the freescale bsp:
> mpc5200_lite5200b_20070203_ltib-rc4. It's a 2.6.16 kernel version.
>
> We have checked the PSC3 and PSC6 and the behaviour is the same.
>
> So, it seems is a chip's bug and we must avoid to use the SS signal with
> the PSC SPI if we want to communicate by ethernet. I think it's a
> probabilistic error and in case there is some traffic in ethernet and a
> transmission by SPI at the same time it could happen.

There seems also another bug: If the PSC based SPI unit runs as SPI slave, =
and=20
some data in the send FIFO waits for transmission, the MISO line is active=
=20
even if SS input is high and blocks the bus. It does not happen, of the sen=
d=20
=46IFO is empty.

JB
=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
