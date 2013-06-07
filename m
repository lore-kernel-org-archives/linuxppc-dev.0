Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 750E52C029B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 08:34:45 +1000 (EST)
Date: Fri, 7 Jun 2013 17:34:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: FSL 64-bit DMA window question
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1370642994.3766.421.camel@pasglop> (from
 benh@kernel.crashing.org on Fri Jun  7 17:09:54 2013)
Message-ID: <1370644475.6813.17@snotra>
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

On 06/07/2013 05:09:54 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-06-07 at 17:02 -0500, Scott Wood wrote:
> > O
> > > I thought the device tree was for describing the hardware, rather
> > > than configuration? :-)
>=20
> A bit of both really. See things like /chosen etc...
>=20
> Also to what extent a MAC address is HW vs. configuration ? :-)

Normally I'd consider that hardware, unless you're overriding it for =20
some reason.

> The HW configuration for a given boards (ie, internal address map,
> location of the various bridge windows etc...) is a fairly common =20
> thing
> to put in a device-tree.

Sure, there's some stuff that is technically software config, but which =20
is easier to treat as a fixed property of the hardware once U-Boot is =20
done setting it up.  But U-Boot doesn't have anything to do with this =20
DMA window...

> If the PCI outbound windows are there (and they are), why not the
> inbound ones ? IE, it's not far fetched.

PCI outbound windows (and the LAWs that back them up) are set up by =20
U-Boot.  With the current FSL kernel code, if you set it to something =20
that isn't covered by a PCIe LAW from U-Boot, it won't work.

> > > A kernel command line option might be more appropriate, unless you
> > > just mean describing the difference between e6500 (which supports =20
> 40
> > > bit addresses) and previous chips (which support 36 bits), rather
> > > than an ability to move it earlier even on e6500.
>=20
> Well, so we could indeed locate it at 36 on e5500 and that would clear
> the current use case and break again on e6500... or we can make it
> depend on the overall address map of the board, which is described
> in the device-tree. IE, if you don't "locate" anything above 39-bit
> in our address map, then using 39 for the window is ok. IE. It's a
> choice. A server board setup that doesn't need gfx but want address
> space for some other things wouldn't care.

I suppose we could put in the device tree the highest address that has =20
been configured for anything...  though for that to be useful we'd need =20
to get out of the habit of putting CCSR near the top of the physical =20
address space.

> > > Maybe we could by default use the size of actual RAM, rather than =20
> the
> > > physical address space.  Then only odd scenarios such as DMA to
> > > non-kernel-owned RAM would need manual adjustment (MSIs would =20
> still
> > > go through the special window below 4G).
>=20
> You also need to account for other on-chip MMIOs no ? Or do you never
> intend to let PCI devices hit them ?

I don't think we normally need that (other than MSIs, which have a =20
special window under 4G)...  The question is whether it's better to let =20
odd use cases work without having to manually move the DMA window, at =20
the cost of decreased out-of-the-box performance with common PCIe cards.

-Scott=
