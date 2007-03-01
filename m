Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D5A7DDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 07:49:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: To DMA or not to DMA
Date: Thu, 1 Mar 2007 12:49:47 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
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

I am in the midst of "trying" to get DMA working in a driver on a new
8541 board using Linux-2.6.17.11. I am starting with a functional driver
on an 8241.

One of the issues seems to be the difference between the DMA engines in
the 8241 vs the 8541. Our PCI device uses DAC (Dual Address Cycles) to
write to a 64bit memory space using a 32bit PCI interface and this works
just fine on both the 8241 and the 8541. On both processors, the
outbound address translation windows are used to create the DAC. On the
8241, its DMA engine can create DAC's to 64bit PCI address space on a
32bit PCI interface with no problem. The problem occurs in that the DMA
engine in the new 8541 will not produce DAC's. Rather it looks like one
must DMA to an outbound window and let the address translation logic do
the DAC.

With this in mind, I am using POTAR2 and its cousins for access to
memory on our PCI device. In the DMA logic, I do (in pseudocode)

origPotar =3D readl(POTAR2) //save outbound address translation=20
writel(0x00040000, SATR0) //source attribute for normal read/write
writel(0x00040000, DATR0) //dest attribute for normal read/write
writel(destHigh32bits >> 8, POTAR2) //put address into window
considering the bit shifting required
writel(destLow32bits, DAR0) //setup the destination address register
writel(sourceLow32bits, SAR0) //setup the source address register
writel(size, BCR0) //setup the number of words to transfer
writel(1, MRx[CS]) //trigger the DMA to go
writel(origPotar, POTAR2) //restor outbound address translation

And I would expect the DMA to work, but it doesn't. Can someone help me
get my mind around how the DMA in the 8541 is supposed to work?

Charles
