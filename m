Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D82F2DDE20
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:00:45 +1100 (EST)
Date: Thu, 3 Jan 2008 23:00:38 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080103230004.GA18709@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<477BA974.8010308@freescale.com>
	<20080102172340.GA2007@sirena.org.uk>
	<477D280C.4000800@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477D280C.4000800@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 12:23:08PM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > To cover everything you'd need to be able to specify all the clocking
> > parameters, especially a PLL configuration, and also specify more than
> > one of each item.  Even then you'd still have problems like...

> The ASoC V1 API for communicating clock data from the fabric driver to the 
> codec driver only allows for three parameters.

Each individual call to set_sysclk() only takes three parameters but it
can be called repeatedly and some configurations are going to require
this.  There's also the set_pll() call which will be required by some
things too (and again that can support multiple PLLs).  

For example, something like this isn't unknown:

 - Set PLL input to pin A.
 - Configure PLL input/output frequencies.
 - Set codec system clock source to be the PLL

and of course the ordering matters.  You can also have other dividers
and clock sources within the codec which need configuring and other
components outside the codec which need configuring to supply the clocks
to the codec.

> > According to the documentation in your patch the bus frequency should
> > already be optional 

> My code does not currently support that configuration, and I don't have any 
> hardware that works that way, so I don't know what it would look like.  I'm 
> just trying to make the driver as flexible as possible, given ASoC V1 constraints.

Indeed.  Providing the device tree stuff doesn't get set in stone I'm
not sure we need to nail this down perfectly for ASoC v1 when we're
running into trouble working around it.
