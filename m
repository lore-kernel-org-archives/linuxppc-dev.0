Return-Path: <tlopez@aotek.es>
Received: from smtp-out1b.sarenet.es (smtp-out1b.sarenet.es [194.30.18.11])
	by ozlabs.org (Postfix) with ESMTP id B4C5DDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 20:07:29 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp-out1b.sarenet.es (Postfix) with ESMTP id 66E716D483
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 09:37:59 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: RE: MPC5200B SPI codec error when there is a heavy ethernet
Date: Mon, 28 Jan 2008 09:37:54 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F3020BEB4D@CORREO>
From: "TXEMA LOPEZ" <tlopez@aotek.es>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,=20

The engineers of Freescale have recognized a problem in the PSC SPI =
Slave Select signal when there is a heavy ethernet loading. Textually =
they say:

" I have tested the MPC5200B FEC and PSC6 SPI.=20
You are right. If there is heavy Ethernet loading, the PSC SPI can stop =
during transmission with SS goes high.
Use a general-purpose output as SPI slave select signal instead PSC SPI =
SS signal.
Factory is informed about similar incorrect behaviour of the PSC SPI =
slave select."

We have repeated the error in three scenarios:
	In our MPC5200B custom board with a Denx 2.4.25 kernel.
	In a Lite5200B with a Denx 2.4.25 kernel.
	In a Lite5200B with the freescale bsp: =
mpc5200_lite5200b_20070203_ltib-rc4. It's a 2.6.16 kernel version.

We have checked the PSC3 and PSC6 and the behaviour is the same.

So, it seems is a chip's bug and we must avoid to use the SS signal with =
the PSC SPI if we want to communicate by ethernet. I think it's a =
probabilistic error and in case there is some traffic in ethernet and a =
transmission by SPI at the same time it could happen.


Best regards,
Txema L=F3pez.

=09
=09
=09
