Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 31449DDF5C
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 09:18:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: dcr stuff.
Date: Mon, 24 Mar 2008 15:18:11 -0700
In-Reply-To: <1206395973.7197.50.camel@pasglop>
References: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
	<20080321201704.032999c3@zod.rchland.ibm.com>
	<20080324043416.3634316E007A@mail15-dub.bigfish.com>
	<1206395973.7197.50.camel@pasglop>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <benh@kernel.crashing.org>
Message-Id: <20080324221812.6833E168004A@mail108-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Monday, March 24, 2008 3:00 PM
> To: Stephen Neuendorffer
> Cc: Josh Boyer; linuxppc-dev@ozlabs.org; git-dev
> Subject: RE: dcr stuff.
>=20
>=20
> On Sun, 2008-03-23 at 21:34 -0700, Stephen Neuendorffer wrote:
> >
> > Certainly, if it ain't broke don't fix it.  What I'm really trying
to
> > do is figure out how to clean up alot of non-mainline drivers.
> > At the moment, several cores use DCR, but the drivers for those
cores
> > have internal code for DCR, their own ifdefs, etc.  This *is*
broken.
> > I'm looking at the available documentation to figure out the best
way
> > of approaching the problem.
> >
> > It might be nice if there was an extra layer of indirection which
was
> > only enabled if DCR_NATIVE and DCR_MMIO, and which was no cost
> > otherwise,
> > but the bigger problem I see in the short term is that we'll likely
> > have to support ARCH ppc for at least some time into the future, and
> > it would be
> > nice if we used the same driver code to do it: it doesn't seem
obvious
> > how to achieve this.
>=20
> It's not too hard to have the DCR code be common, it's harder to deal
> with the lack of device-tree in arch/ppc tho.

My thoughts at the moment are to punt on map and unmap and at least
provide support for dcr_host_t and dcr_read and dcr_write.  Any driver
code that wants to use this without a device tree will just have to do
the work itself.  This will at least support the use cases we have
today: If people want something better, then they should switch to ARCH
powerpc.. :)
=20
> As for enabling support for both native and MMIO, that's certainly
> possible, patches welcome :-) You could make the dcr host structure
> contain the type or even function pointers, as you see fit. But make
is
> so that when only native is enabled, it turns back into the inlines we
> have now.

Working on it.. :)

Steve
