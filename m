Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64AD0DDF6A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 06:52:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: DMA take 3
Date: Fri, 2 Mar 2007 11:52:27 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B02@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
	<B52955765C54604CB1A62A9967F22C7301EAE573@az33exm20.fsl.freescale.net>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Swarthout Edward L-SWARTHOU" <ed.swarthout@freescale.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ed:
Thank you for the two hints. Please bear with me for another question or =
two as I try to converge this today.
=20
I have incorporated your two ideas and still have something else going =
awry. First of all, I do not have to be changing a POTAR at this point =
in the program for a while. So I am trying to simplify it until it =
works. Here is the current state.
=20
write(0, SR0)  //clear anything and everything
write(0x00040000, SATR0)  //READTTYPE=3DRead, do not snoop=20
write(0x00040000, DATR0)  //READTTYPE=3DWrite, do not snoop=20
write(sourceLow32bits, SAR0)  //usually 0x07xxxxxx near the top of =
128Mbyte physical memory=20
write(size, BCR0) =20
printk(various things including some of the registers recently written
//I am assuming this is benign in a Linux driver at this point
asm("sync") //got this in here now
write(destLow32bits, DAR0)  //This should now trigger the DMA
//potar already has the destHi32Bits and it is always 0x1_0000_0000 in =
64bit memory space in
//At this point, I would expect the DMA engine to DMA through the window =
previously setup in potar
=20
Charles
=20
________________________________

From: Swarthout Edward L-SWARTHOU [mailto:ed.swarthout@freescale.com]
Sent: Fri 3/2/2007 11:28 AM
To: Charles Krinke; linuxppc-embedded@ozlabs.org
Subject: RE: To DMA or not to DMA



It could be a lot of other things, but I see two things wrong:

> From: Charles Krinke
...
> origPotar =3D readl(POTAR2) //save outbound address translation
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
