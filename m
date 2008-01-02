Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 15945DDE11
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 03:28:13 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1046756anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 08:28:12 -0800 (PST)
Message-ID: <fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
Date: Wed, 2 Jan 2008 09:28:12 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477BADF5.9060003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> That's the best plan I came up with.  This is apparently fixed in ASoC
> V2.  From ASoC V1's perspective, the fabric driver must be the master.
> However, it doesn't make sense to have a node in the device tree for the
> fabric driver, because there is no such "device".  The fabric driver is
> an abstraction.  So I need to chose some other node to probe the fabric
> driver with.  I chose the SSI, since each SSI can have only one codec.

Does that mean with ASoC V2 you can instantiate it with the board
specific platform code instead?  I think that is the consensus we were
leaning towards in the last discussion about this issue.

> > But that doesn't work in my environment. My generic channel is
> > "fsl,i2s". I have four different systems booting off from a shared
> > network drive. Each of these systems needs the common "fsl,i2s" driver
> > but they all four need different fabric drivers.
>
> That, I don't understand.  fsl,ssi is pretty much the same thing as
> fsl,i2s, since the SSI *is* an I2S device.  It's also an AC97 device,
> which is why I added the fsl,mode property.

This is one of the examples of where the compatible properties are
trying to be far to generic about what they are.  How do you define
what "fsl,ssi" is?  What happens when Freescale produces another
peripheral that can do ssi but isn't register level compatible?

In my opinion, it is far better to be specific in the device tree and
teach the driver about what versions it is able to bind against.  In
this case, I would use "fsl,mpc8610-ssi" or maybe better yet:
"fsl,mpc8610-ssi,i2s" (MPC8610 SSI device in I2S mode).

I don't like the idea of a separate fsl,mode property to describe the
behaviour of multifunction peripherals.  It makes probing more
difficult when there is a different driver for each mode.

>
> The fabric driver is specific to the board.  So you should be using
> Kconfig to select the fabric driver.  There is no node in the device
> tree for fabric drivers.  I thought that was the consensus.

No, the desire is to go multiplatform in ppc.  That means you cannot
use Kconfig to select the correct fabric driver.

> Are you saying that you want to use the same kernel on four different
> systems?  If so, then you need to find a way to compile all fabric
> drivers together, and at boot time each fabric driver will decide
> whether it will do anything.

Yes!  That is exactly what we want to support in arch/powerpc.  Use
platform code to select the correct fabric driver.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
