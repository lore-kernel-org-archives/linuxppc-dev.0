Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 327A6B7D63
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 10:52:17 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur.tabi@gmail.com>
In-Reply-To: <r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
	<r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 10:52:02 +1000
Message-ID: <1272502322.24542.135.camel@pasglop>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-28 at 17:13 -0500, Timur Tabi wrote:
> On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > The sound0 node needs a compatible value,
> 
> I knew I was forgetting something
> 
> > the sound-device node should
> > probably have one too.
> 
> The aliases, cpus, and memory node don't have a compatible property,
> and I was modeling the design after the aliases node.

aliases is a bad choice, it's very very special and is neither a device
nor a virtual device, like chosen.

cpus is more of a match in your case.

In any case, I agree, you may not really need a compatible prop for the
virtual device. In fact, Grant, do we really need an enclosing node like
that ? In any case, it's no big deal and shouldn't have much impact on
the design.

Cheers,
Ben.

> > The sound0 node should have something board specific like
> > "fsl,mpc8610hpcd-sound" to make it clear that the binding really only
> > applies to this particular board.  It would also be a good idea to
> > prefix all of the property names with 'fsl,' to avoid conflicting with
> > any future common bindings or conventions.  Other boards can use the
> > same binding, but they would get a different compatible value (the
> > driver could bind on both).
> 
> The aliases node doesn't have an fsl, prefix.  I understand the need
> for the prefix, but I wonder why we don't do that for the aliases
> node.
> 
> > I'm not a huge fan of the name "sound-devices" for the parent node.
> > There are other sorts of things that we need 'virtual' device nodes to
> > describe.  It would be nice to have a single place for collecting
> > nodes for stuff like this.  Perhaps this:
> >
> > system {
> >        compatible = "system-devices";
> >        sound0 {
> >                compatible = "fsl,mpc8610hpcd-sound";
> >                fsl,ssi = &ssi0;
> >                fsl,playback-dma = &dma00;
> >                fsl,capture-dma = &dma01;
> >                fsl,codec = &cs4270;
> >        };
> > };
> 
> I like that.
> 
