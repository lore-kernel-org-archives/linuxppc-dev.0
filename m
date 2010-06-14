Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id DA0A6B6EFF
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 00:59:21 +1000 (EST)
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_JnHxsmfpZvAWppjMQY5gmQ)"
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0L40001HUEYWON30@VL-MO-MR002.ip.videotron.ca> for
	linuxppc-dev@ozlabs.org; Mon, 14 Jun 2010 10:59:20 -0400 (EDT)
Date: Mon, 14 Jun 2010 10:59:20 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Request review of device tree documentation
In-reply-to: <20100614124438.GF9323@yookeroo>
Message-id: <alpine.LFD.2.00.1006141044510.13427@xanadu.home>
References: <33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_JnHxsmfpZvAWppjMQY5gmQ)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Mon, 14 Jun 2010, David Gibson wrote:

> On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
> [sni]
> > > That's sort of a self-fulfilling prophecy.  If the OS doesn't trust the
> > > firmware, there is no pressure for the firmware to "get it right".
> > 
> > Firmware will not get it right.  Period.  There will always be
> > something wrong.  It is never right on PCs.  It will never be right on
> > the other architectures.
> 
> Yes, yes, yes.  And there is a great deal of empirical evidence to
> back that assertion.
> 
> >  That goes for OSes too, but upgrading an OS
> > isn't as risky as upgrading firmware.  That isn't to say that it can't
> > be close, but every firmware feature that the OS depends on is a
> > feature that could force a risky firmware upgrade when the bug in it
> > is discovered.
> 
> Indeed.  In fact, the general rule of thumb is really "put as much as
> possible into the most easily replaced layer of the stack".  This is,
> incidentally, why I've always been dubious about simple firmwares
> supplying a flattened device tree rather than including the device
> tree template in the kernel, cuboot style.

The biggest advantage, IMHO, for adding DT to ARM, is actually to 
decouple the hardware config information and the kernel.  If in the end 
the DT has to be shipped in the kernel then we're losing all this 
advantage over the current state of things on ARM which still works 
pretty well otherwise.

In the best case, the simple firmware simply has to retrieve the 
flattened device tree from flash, and pass it to the kernel just like 
some anonymous blob.  And the simple firmware only needs to provide a 
way for that DT blob to be updatable, like through an upload of a 
replacement blob that was prepared offline.  Just like a ramdisk image 
or the like.

That doesn't need to be fancier than that, and the goal of having the DT 
data tied to the hardware instead of the kernel is achieved.

> > I'm also convinced that the economics are all wrong for "getting it
> > right" when talking about firmware.  Manufactures don't care about
> > firmware; they care about selling boxes.  Customers don't care about
> > firmware, they care about the operating system (well, that's not true
> > either, they care about applications).  For manufactures, once it can
> > boot the real operating system, there is little to no incentive to
> > spend any more money on firmware when the money can be better spent on
> > either the next product or the adding features to the operating system
> > of the existing product.  In fact, spending money on firmware is
> > actually *more risky* one a product ships, because if a firmware
> > upgrade goes bad, then that means product returned for repair at the
> > factory.
> 
> A good analysis.  The other side of this, is that for an OS, if you
> rely on the firmware to do X, it will work when the firmware gets it
> right.  If you do X yourself, it will work whether or not the firmware
> gets it right.  This means that if there's even one firmware you have
> to deal with out there that gets X wrong, you have to do it yourself
> and then there is little to no incentive to rely on firmware even in
> the cases where it does get it right.  In fact there's a disincentive,
> because then you have two different code paths to test and maintain.

Amen.


Nicolas

--Boundary_(ID_JnHxsmfpZvAWppjMQY5gmQ)--
