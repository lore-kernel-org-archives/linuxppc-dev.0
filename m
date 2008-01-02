Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CF97DE048
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:54:00 +1100 (EST)
Date: Wed, 2 Jan 2008 17:23:40 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080102172340.GA2007@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<477BA974.8010308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477BA974.8010308@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 09:10:44AM -0600, Timur Tabi wrote:
> Jon Smirl wrote:

> > Does this need to be bus-frequency? It's always called MCLK in all of
> > the literature.

> I'm trying to make this node as generic as possible.  The fabric driver 
> is the one that will parse this node and pass the data to the codec 
> driver, so I can't use any codec-specific terms.

> The API from the fabric driver for passing clock information includes a 
> clock ID, a direction, and a frequency.  I can do something like this:

> clock1 = <0, bb8000>

> Would that be better?

To cover everything you'd need to be able to specify all the clocking
parameters, especially a PLL configuration, and also specify more than
one of each item.  Even then you'd still have problems like...

> > In my case the MCLK comes from a chip on the i2c bus that is
> > programmable How would that be encoded?.

> I'm going under the assumption that MCLK does not change once the board 
> is up and running.  In your case, you'd need to do something quite 
> different, because you're not reading the clock info from the device 
> tree and passing it to the codec at initialization once.  If you want to 
> define an extension to the 'codec' child node that handles that, I'll 
> add it to the documentation.

According to the documentation in your patch the bus frequency should
already be optional (though I don't immediately see that in the code,
but then I'm entirely unfamiliar with OpenFirmware device trees).
Boards that reconfigure the clocking at run time can then provide
code to set the clocking up at the appropriate times, which is probably
what they want anyway.
