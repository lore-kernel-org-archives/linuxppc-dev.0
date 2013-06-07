Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 52A6C2C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 09:29:41 +1000 (EST)
Date: Fri, 7 Jun 2013 18:29:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: FSL 64-bit DMA window question
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1370644793.3766.423.camel@pasglop> (from
 benh@kernel.crashing.org on Fri Jun  7 17:39:53 2013)
Message-ID: <1370647771.6813.19@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/07/2013 05:39:53 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-06-07 at 17:34 -0500, Scott Wood wrote:
> > > You also need to account for other on-chip MMIOs no ? Or do you =20
> never
> > > intend to let PCI devices hit them ?
> >
> > I don't think we normally need that (other than MSIs, which have a
> > special window under 4G)...  The question is whether it's better to =20
> let
> > odd use cases work without having to manually move the DMA window, =20
> at
> > the cost of decreased out-of-the-box performance with common PCIe =20
> cards.
>=20
> Sorry, I didn't parse what the tradeoff is here...

I just meant that a PCIe device targeting something other than RAM, =20
CCSR (it's not just MSIs that are mapped through the special window), =20
or another PCIe is a rather unusual case -- not something that you'd =20
see by just plugging in an ordinary PCIe card.  The tradeoff is that if =20
we accommodate this strange use case, boards like the radeon would need =20
to use swiotlb (once we fix the > versus >=3D bug) unless the user tweaks =20
the DMA window.

It may be best to stick with the default that makes everything work, =20
even if a broken PCIe card ends up being a bit slower out of the box, =20
even if the PCIe-to-MMIO use case is weird and would require custom =20
setup anyway.  OTOH, did we ever care about 32-bit DMA being able to =20
access MMIO?

> Putting the inbound window above memory seems like a reasonable =20
> option then
> (at least as a default that the board can override).
>=20
> I sincerely hope those radeons are the only remaining things with =20
> that sort of
> limitation but you never know ... it's all x86 fault of course for =20
> never having
> used high DMA windows :-)

Hmm... Why are we using this special window at all?  Can't we just have =20
one large identity mapping starting at zero, with the MSI window =20
presumably taking precedence?  The manual is a bit vague on whether =20
inbound windows can overlap with priority... in EP mode it says it =20
does, and the RC section is silent.  Do we currently ever overlap =20
PCICSRBAR with a real window?

-Scott=
