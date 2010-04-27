Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA98EB7D52
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 08:29:17 +1000 (EST)
Date: Tue, 27 Apr 2010 23:29:14 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
Message-ID: <20100427222913.GE15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 02:24:34PM -0600, Grant Likely wrote:

> However, as you and Mark rightly point out, it completely fails to
> represent complex sound devices with weird clocking and strange
> routes.  Something like this is probably more appropriate:

> 
> 	[...]
> 		codec1 :codec@4f {
> 			compatible = "cirrus,cs4270";
> 			reg = <0x4f>;
> 			/* MCLK source is a stand-alone oscillator */
> 			clock-frequency = <12288000>;
> 		};

You also want to be representing unused pins here.

> 	[...]
> 	ssi1: ssi@16000 {
> 		compatible = "fsl,mpc8610-ssi";
> 		[...]
> 		fsl,mode = "i2s-slave";

I'd not include the master/slave decision; it's either implied by the
fact that the CODEC has a standalone clock, a property of the link/card,
or a policy decision that the running software can change on a whim.

> 	sound {
> 		compatible = "fsl,mpc8610-hpcd-sound";
> 		/* maybe something like (totally off the top of my head) */
> 		dai-links = <&ssi1 0 &codec 0
> 		             &ssi1 1 &codec 1>;

I'm having a hard time loving this.  I'd be looking for a lot more
semantics on the links (things like information about separate clocks
for the two directions, for example) which makes me think that that
simple list format is far too simple and you want a list of more complex
objects.

There's also analogue interconnects to deal with, and jacks (including
detection and accessories).  Jacks can be particularly entertaining
here.

> Or, in other words, the device tree should *not* be used to describe
> every possible detail and permutation.  It is best used to describe
> the permutations that are common so that they don't need to be hard
> coded for each and every board.

I think the ideal is something that's purely descriptive of the hardware
and doesn't include any policy decisions.  Policy decisions covers an
awful lot of the interesting issues, though - but they're the sort of
things that can easily be changed with a new software load and therefore
don't belong in the device tree.

On the other hand from a pragmatic point of view it's just much less
hassle to just only provide the mechanism for instantiating a machine
with custom code and use that for everything.
