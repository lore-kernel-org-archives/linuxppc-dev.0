Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 3959BDDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 01:14:39 +1000 (EST)
Date: Wed, 23 Jul 2008 16:14:32 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/2] Allow a custom ASOC machine driver with
	soc-of-simple
Message-ID: <20080723151431.GA22926@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
	<9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 10:09:01AM -0400, Jon Smirl wrote:
> On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > ...this doesn't just allow a custom machine driver, it requires that
> >  something configures at least the machine name.  That's not a problem
> >  from the ASoC point of view but possibly from the PowerPC side?

> You have to configure at least the name. Otherwise if the machine
> driver is the last to register, how do you know to hold off the final
> registration and wait for the machine driver to appear?

I understand why you have made this change but it's a substantial change
which should at least be documented in the changelog (I'd expect to see
some mention of how this is supposed to be configured, for example).
I'd also expect something to handle the existing user.

Like I said, I'm not entirely sure that you're supposed to be using this
driver if you want a machine driver: this is a machine driver and I'm
not sure if it's supposed to cover all cases or not.  Grant?

> Or is it ok for me to change these after the platform device has been created?
> 		of_soc->dai_link.ops = machine_ops;
> 		of_soc->machine.name = machine_name;

No.
