Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 10:47:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080103234725.GD12883@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<20080102184957.GB2007@sirena.org.uk>
	<477D2673.5090203@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477D2673.5090203@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 12:16:19PM -0600, Timur Tabi wrote:
> Mark Brown wrote:
> 
> > The machine support code (fabric driver in PowerPC terms, I think?)
> > tells the core how everything is connected together by registering
> > devices representing the links (eg, I2S) between the codecs, CPU and
> > other devices.  The ASoC core is then responsible for ensuring that all
> > the required components are present before it registers with the ALSA
> > core.
> 
> I'm no expert on this, but I think from the PowerPC point-of-view,
> the *ideal* situation would be if the ASoC fabric driver were
> generic, maybe even part of ASoC itself, and everything it needed
> could be obtained from the device tree.

Nice idea in principle, and may be the way to go ultimately, but very
tricky in practice.  The whole reason the fabric driver concept exists
(from other archs) is that there are an awful lot of variants on how
to wire the sound components together.  Devising a way of expressing
those connections in the device tree that's sufficient will be very
curly.  Then we'd have to build the fabric driver that can parse and
process them all.  And then, people will no doubt produce device trees
with errors in the connection information, so we'll still need
platform-specific workarounds.

If we want sound working any time soon, we'll want to stick with the
platform based fabric drivers for the time being.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
