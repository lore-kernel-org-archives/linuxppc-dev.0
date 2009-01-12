Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AC02DDFC2
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 08:36:46 +1100 (EST)
Subject: Re: mal_probe crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0901121421140.13607@vixen.sonytel.be>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
	<200901091602.05730.matthias.fuchs@esd-electronics.com>
	<Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
	<1231536613.2142.74.camel@pasglop> <aday6xknnp2.fsf@cisco.com>
	<Pine.LNX.4.64.0901121421140.13607@vixen.sonytel.be>
Content-Type: text/plain
Date: Tue, 13 Jan 2009 08:36:32 +1100
Message-Id: <1231796192.22571.30.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Roland Dreier <rdreier@cisco.com>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-12 at 14:37 +0100, Geert Uytterhoeven wrote:
> On Fri, 9 Jan 2009, Roland Dreier wrote:
> >  > Can you double check that the e1000 isn't copying the PCI resources into
> >  > a unsigned long before ioremap'ing the result, thus cropping the top
> >  > bits ?
> > 
> > as far as I can see, e1000 is using pci_ioremap_bar(), which should do
> > the right thing as long as resource_size_t is the right type (which it
> > looks like it is on PowerPC 44x).
> 
> Indeed, the full 36-bit address is passed to __ioremap() via pci_ioremap_bar(),
> as evidenced from the additional debug output below (see [1]).
> 
> As I don't have any other 3.3V PCI Ethernet cards, I plugged in a 3.3V PCI USB
> 2.0 card in the second PCI slot, and got a similar crash (see [2]).
> 
> Are the PCI slots on the Sequoia known broken under recent Linux kernels? I've
> never used them before...

Hrm, something is indeed wrong, hard to say what tho. My canyonlands
works fine (460EPx) and I can try a Taishan one of these days (440GX
iirc). What is in sequoia ? I think it's a GX no ?

Could be something in the device-tree ?

Cheers,
Ben.
