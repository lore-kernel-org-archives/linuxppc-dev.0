Return-Path: <xyzzy@speakeasy.org>
Date: Thu, 31 Jul 2008 18:36:33 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0807311828580.10341@shell4.speakeasy.net>
References: <4889EFFE.2070201@grandegger.com> <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com> <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2008, Jon Smirl wrote:
> >  Here's my idea:
> >
> >         i2c@0 {
> >                 compatible = "fsl-i2c";
> >                 bus-frequency = <100000>;
> >
> >                 /* Either */
> >                 source-clock-frequency = <0>;
> >                 /* OR */
> >                 source-clock = <&ccb>;
> >         };
>
> Can't we hide a lot of this on platforms where the source clock is not
> messed up? For example the mpc5200 doesn't need any of this, the
> needed frequency is already available in mpc52xx_find_ipb_freq().
> mpc5200 doesn't need any uboot change.
>
> Next would be normal mpc8xxx platforms where i2c is driven by a single
> clock, add a uboot filled in parameter in the root node (or I think it
> can be computed off of the ones uboot is already filling in). make a
> mpc8xxx_find_i2c_freq() function. May not need to change device tree
> and uboot.
>
> Finally use this for those days when the tea leaves were especially
> bad. Both a device tree and uboot change.

If you have to support clock speed in the i2c node anyway, what's the point
of the other options?

> > Except the i2c clock isn't always a based on an integer divider of the CCB
> >  frequency.  What's more, it's not always the same for both i2c controllers.
> >  Suppose i2c #1 uses CCB times 2/3 and i2c #2 uses CCB/2, how would
> >  fsl_get_i2c_freq() figure that out from bus-frequency and
> >  i2c-clock-divider?
>
> If you get the CCB frequency from uboot and know the chip model, can't
> you compute these in the platform code? Then make a
> mpc8xxx_find_i2c_freq(cell_index).

You need a bunch of random other device registers (SEC, ethernet, sdhc,
etc.) too.

> I don't see why we want to go through the trouble of having uboot tell
> us things about a chip that are fixed in stone. Obviously something
> like the frequency of the external crystal needs to be passed up, but
> why pass up stuff that can be computed (or recovered by reading a
> register)?

One could also say that if U-boot has to have the code and already
calculated the value, why duplicate the code and the calculation in Linux?
