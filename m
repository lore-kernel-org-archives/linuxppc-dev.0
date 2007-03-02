Return-Path: <ed.swarthout@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9CB55DDF63
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 06:28:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l22JSEO3007613
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Mar 2007 12:28:15 -0700 (MST)
Received: from az33exm20.fsl.freescale.net (az33exm20.am.freescale.net
	[10.64.32.6])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l22JSEFs018693
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Mar 2007 13:28:14 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: To DMA or not to DMA
Date: Fri, 2 Mar 2007 12:28:09 -0700
Message-ID: <B52955765C54604CB1A62A9967F22C7301EAE573@az33exm20.fsl.freescale.net>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
From: "Swarthout Edward L-SWARTHOU" <ed.swarthout@freescale.com>
To: "Charles Krinke" <ckrinke@istor.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It could be a lot of other things, but I see two things wrong:

> From: Charles Krinke
...=20
> origPotar =3D readl(POTAR2) //save outbound address translation=20
> writel(0x00040000, SATR0) //source attribute for normal read/write
> writel(0x00040000, DATR0) //dest attribute for normal read/write
> writel(destHigh32bits >> 8, POTAR2) //put address into window conside
> writel(destLow32bits, DAR0) //setup the destination address register
> writel(sourceLow32bits, SAR0) //setup the source address register
> writel(size, BCR0) //setup the number of words to transfer

Add a sync here to ensure the previous stores are out of the cpu.

> writel(1, MRx[CS]) //trigger the DMA to go
> writel(origPotar, POTAR2) //restor outbound address translation

Don't destroy the outbound window brefore the dma is complete!

> And I would expect the DMA to work, but it doesn't. Can someone help
me
> get my mind around how the DMA in the 8541 is supposed to work?

-EdS
