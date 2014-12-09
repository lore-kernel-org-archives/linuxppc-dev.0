Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7284A1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 20:43:15 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3B611400DE
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 20:43:14 +1100 (AEDT)
Message-ID: <1418118183.13358.38.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Dec 2014 20:43:03 +1100
In-Reply-To: <20141209085435.GA1154@katana>
References: <20141208063039.14356.34770.stgit@localhost.localdomain>
 <1418069595.4827.43.camel@kernel.crashing.org>
 <20141208205520.GA12715@katana>
 <1418075026.13358.4.camel@kernel.crashing.org>
 <20141209085435.GA1154@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 09:54 +0100, Wolfram Sang wrote:
> > > Oh, I thought we agreed that you take it via powerpc. I still think this
> > > is the best solution.
> > 
> > I threatened to do that :-) I don't remember you replying, did I miss
> > it ?

> It is here:
> http://thread.gmane.org/gmane.linux.drivers.i2c/20762/focus=21099

Weird, it never made it to my mbox... anyway:

> I did not invent DT bindings.

No I did :) Or rather Mitch did with OF and I contributed heavily at
slapping it onto everbody's face :) Then I let Grant run with it and
deal with the carnage... but as you can imagine, I feel like whatever
rule I made for others don't apply to me :)

> I did not invent that DT is/should be a
>hardware description. 

This is the basic idea but it's flexible. It is in essence a description
of the environment, which is essentially the HW but there is no taboo
about adding various ancilliary pieces of informations that one deems
useful, especially if they are prefixed by a vendor prefix to avoid
collision with "well defined" properties.

I think we ended up being fairly strict about the rules initially to try
to rein in the crowd of ARM embedded folks who really went all over the
place but like every rule, it's meant to be broken (hear the french guy
talking ...).

>For me, it is a burden that I (as a subsystem
> maintainer for mainly drivers) have to prevent people from using DT ?>
> for software configuration (some people use it as an 1:1 mapping for
> platform data even.)

Well, yes and no... for example, it's perfectly legit to have a node
representing a UART, have the firmware slap into it the default expected
baud rate as a property (or whatever it has configured it to be) which
makes it then a reasonable default for the kernel to use.

Generally speaking there is nothing fundamentally wrong about having
configuration information in the device-tree, but it has to be clearly
identifiable as such.

The description of the HW in my world at least also implies how that HW
is meant to be configured for a given platform.

> Since there are no guidelines (probably there can't
> be), I developed a set of rules out of experience and when those don't
> match I ask for help. Having a different set of rules for
> powerpc/arm/... (or server/embedded for that matter) will increase
> this burden a lot. People will come and say "But they did it as 
> well..."

The basic rule is "does it make sense ?". Really. Apply your jugement
based on your experience as to whether something is a reasonable
comprimise or not and whether it will turn into a big mess in the long
run or, on the contrary, is a perfectly fine ad-hoc solution for a given
setup.

> It's getting quite tempting to just throw that driver into powerpc.git

Maybe this is the easiest. Just make sure that MAINTAINERS also point
this driver to you or PowerNV maintainers. And no Ack from me, please.
Then, I can always say "I dunno" if people start asking questions.

:)

Technically I need your ack if we are to follow the process for Linux
upstreaming. I doubt Linux will holler if I just put it in the tree but
I'd rather follow the process if possible.

>> And I don't give a flying crap about what random ARM SOC vendor
>> thinks of my powerpc FW interface for a powerpc unique FW interface.
>
> But you are not alone here. If you open the box for giving busses a
> configurable name, I can see other people (without FW) wanting this,
> too. So, this discussion will come anyhow IMO.

Right and I personally don't see a problem with that ... what's
fundamentally wrong with letting the platform description (ie,. the DT)
specify reasonable names for i2c busses ? It has pretty much no impact
on drivers nowadays but means things are easier to figure out/locate for
users/admin/developers and eases diagnostics.

> > If you are ok with the driver and are happy for me to take it,
> > please send an Ack.
> 
> "Happy" is not the correct word, but let's just go over with it. Maybe
> like this:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de> (I2C part, excluding the bindings)

Forget about the binding mess, Olof reminded me that the result of one
of the recent KS was that the bindings no longer needed "approval", and
are to be sent to the list purely for informational purposes, otherwise
the process is a mess. We have to provide at least some trust here, and
we can reject the driver if we think the binding is really way too
gross.

> > From a binding perspective, it's just a piece of additional info that
> > the firmware provides for convenience.
> 
> I do understand the use case. I even agree it makes sense to have
> something like this. It is just that I'd prefer a generic, widely
> acknowledged solution, with consensus where it belongs and how it should
> be named. Not a custom solution which, frankly, feels forced on me
> by time pressure I have nothing to do with. So, not happy here, but also
> not looking for drama. Let's move on...

Adding a generic binding for i2c controllers to name their respective
busses sounds like a laudable idea, and if that happens I'll be happy to
update the driver to take that into account so that a future FW version
can add it (in addition to the old property for backward compat).

Ben.
