Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79F97DDDCA
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 08:30:23 +1000 (EST)
Date: Mon, 30 Jun 2008 17:30:08 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
Message-Id: <20080630173008.d6762380.kim.phillips@freescale.com>
In-Reply-To: <e07b0ce3c375e9418ac976256c731f03@kernel.crashing.org>
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
	<fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
	<2b97f7566925ed86b78b364ff5724644@kernel.crashing.org>
	<20080630110410.7ee097ed.kim.phillips@freescale.com>
	<e590624fb4ff66d787a2fa3c44e00cbc@kernel.crashing.org>
	<20080630131441.e9b9ac1c.kim.phillips@freescale.com>
	<e07b0ce3c375e9418ac976256c731f03@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 30 Jun 2008 23:19:05 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >>>> Also, these made-up names make you do more work: you'll need to
> >>>
> >>> who said they were made up?
> >>
> >> I did.  These names do not refer to some physical part you can buy.
> >
> > right, they refer to devices in multiple physical parts you can buy.
> > Part-you-can-buy documentation clearly indicates the SEC version in
> > that part, in the form "SEC X.Y", i.e, it's not something made up
> > that's not already in freescale documentation.
> 
> Yes.  As a side note, since there are multiple devices that contain
> e.g. a sec-1.0, it would be prudent to describe the exact incarnation
> in the device tree, like "mpc8272-sec" or something, in either "model"

but 'fsl,sec-X.Y' /does/ describe the exact incarnation, whereas
'fsl,mpc8349-sec' /does not/.  "fsl,mpc8349-sec' might mean the SEC 2.1
or the SEC 2.4, it depends on the revision of the mpc8349.

> or "compatible", just in case a problem shows up with one of them.

I thought 'model' was superseded by 'compatible'; that's why it's taken
out here, along with device_type.

> >>>> write up a binding for them, explaining exactly what a 1.0 device
> >>>> etc. is (or at least point to documentation for it).  If you use
> >>>> a name that refers to some device that people can easily google
> >>>> for documentation, you can skip this (well, you might need to
> >>>> write a binding anyway; but at least you won't have to explain
> >>>> what the device _is_).
> >>>
> >>> documentation is available in the usual places, and it specifically
> >>> points out which SEC version it references.
> >>
> >> I can't find a manual online for "freescale sec"; googling
> >> for "freescale sec-1.0" finds a manual for the PowerQUICC I;
> >> is that the right one?  I don't know, so the binding needs
> >> to explain it to me.
> >
> > the binding shouldn't be responsible for google's shortcomings
> 
> The binding needs to describe what device it is for.  I am a stupid
> user, just like most users, so if the binding doesn't tell me I turn
> to google.  Don't blame them for not finding it; the binding should
> have told me in the first place!

Again, I don't see how google's results are pertinent in this
discussion.  The fact that Freescale doesn't publish a separate SEC
manual is not what this patch is trying to address.

btw, the title for the binding is:

  g) Freescale SOC SEC Security Engines

Is that what you are looking for?  If not, what precisely?  a list of
all the parts?  There's an SEC in every mpc8[35]xxE!

> >>> Plus, as I mentioned
> >>> before, a lot of the differences between the SEC versions are 
> >>> miniscule
> >>> feature bits scattered across the programming model.
> >>
> >> I don't see how this is relevant, sorry.
> >>
> > I'm under the impression that listing the differences (assuming they're
> > easily obtainable) would lead to unnecessary b-w-of bloat.
> 
> The binding at a minimum should describe how to identify each
> unique version from the device tree, no matter how miniscule
> those differences are.  Just a specific "compatible" value will
> do.

I'm at a loss; isn't that what this patch does?

> > I don't know what google does; I'd search freescale documentation
> > directly.
> 
> Or the binding could just bloody say what it is talking about in the
> first place, heh.

Again, I'm at a loss here.  Can you give a specific example of what
you're looking for here?

> Anyway, how about we do something constructive?  If you still want to
> use "fsl,sec-N.M" names, that's fine with me.  Each specific device
> tree needs to still say which exact device it contains, so an entry
> would look like e.g.
> 
> 	compatible = "fsl,mpc8272-sec", "fsl,sec-3.0";
> 
> and the driver can just probe for "fsl,sec-3.0" if it doesn't need
> to know about the exact version; but it _can_ use it if it _does_
> need to know.

Currently the driver matches on "fsl,sec2.0", and if needs be, will
call of_device_is_compatible with the version number that introduces
the feature it wants to implement.

Kim
