Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id DCB1ADE1C0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:25:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1147734anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 10:25:45 -0800 (PST)
Message-ID: <fa686aa40801031025r10c31ce6x203755fe532f0c88@mail.gmail.com>
Date: Thu, 3 Jan 2008 11:25:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477D25F4.6020700@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<477D25F4.6020700@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > Does that mean with ASoC V2 you can instantiate it with the board
> > specific platform code instead?
>
> I don't know.  I haven't really looked at V2 yet.  You'll have to ask Liam
> Girdwood.
>
> > This is one of the examples of where the compatible properties are
> > trying to be far to generic about what they are.  How do you define
> > what "fsl,ssi" is?
>
> The SSI is a specific Freescale device, so I think it's pretty well defined.
>
> > What happens when Freescale produces another
> > peripheral that can do ssi but isn't register level compatible?
>
> It won't be called the SSI.  It will be called something else.

Heh, I've seen enough to know that it's virtually impossible for a
company to maintain a consistent naming scheme all the time.  Better
to be specific now and add generic names sometime in the future rather
than the other way around.

> > In my opinion, it is far better to be specific in the device tree and
> > teach the driver about what versions it is able to bind against.  In
> > this case, I would use "fsl,mpc8610-ssi" or maybe better yet:
> > "fsl,mpc8610-ssi,i2s" (MPC8610 SSI device in I2S mode).
>
> I can work with that, but the SSI could be placed into any future 83xx, 85xx,
> or 86xx SOC, and the driver will still work with it as-is.

The have the device trees claim compatibility with the older
fsl,mpc8610-ssi device specifically.  ie: compatible =
"fsl,mpc83<whatever>-ssi,ac97", "fsl,mpc8610-ssi,ac97";

>
> > I don't like the idea of a separate fsl,mode property to describe the
> > behaviour of multifunction peripherals.  It makes probing more
> > difficult when there is a different driver for each mode.
>
> Can you propose an alternative?  The driver needs to know what mode to use
> when communicating with its codec.  How am I supposed to know if I have an I2S
> codec or an AC97 codec?

Make the compatible property tell you!  :-)  If it's connected to an
I2S codec, then it could be compatible = "fsl,mpc8610-ssi,i2s".  Or
for AC7, compatible = "fsl,mpc8610-ssi,ac97"

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
