Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 87A94DE1BE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 01:05:35 +1000 (EST)
Date: Mon, 14 Jul 2008 16:05:28 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Message-ID: <20080714150527.GD25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 10:13:14AM -0400, Jon Smirl wrote:
> On 7/14/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Ideally someone from the PowerPC community would sign off on this -
> >  given the nature and volume of discussion people obviously have very

> Grant is one of the core PowerPC developers. There's no big

OK, fair enough...

> Hopefully we can get the driver model sorted out in v2. If the ASoC
> driver model is fixed all of this glue code disappears.

> The PowerPC side isn't without fault too. PowerPC still doesn't have a
> good way to load the fabric/machine driver.

I'm finding it difficult to square these two statements - from an ASoC
point of view the main thing this patch is doing is adding a machine
driver and that's not something that's going to go away.  With version 2
you will get the wait for all components to come on-line logic that's
implemented here from the ASoC core but that doesn't remove the need for
a machine driver to tell the core what to wait for and arrange any
machine specific things like clocking.  It's this debate about machine
drivers that makes me nervous here.

Like I say, from an ASoC point of view it's not an issue and the current
approach is fine.

> Which are we going to call it, fabric or machine? I had been working
> on the Apple code in sound/aoa. It is called fabric in that code. The
> equivalent driver is called machine in ASoC v1.

ASoC has always called it a machine driver.

> >  > This is most likely temporary glue code to work around limitations in
> >  > the ASoC v1 framework.  I expect ASoC v2 won't need this.
> >
> >
> > It will need some way of providing a machine driver, generic (like this
> >  one) or otherwise.

[BTW, it'd be helpful if you could delete unreferenced quotes when you
reply - it makes things much easier to read, especially when reviewing
lengthy patches.  Unfortunately the GMail UI encourages doing this :(]
