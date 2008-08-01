Return-Path: <xyzzy@speakeasy.org>
Date: Thu, 31 Jul 2008 17:46:42 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers	configurable
	via FDT
In-Reply-To: <20080731195911.GA29610@secretlab.ca>
Message-ID: <Pine.LNX.4.58.0807311742230.10341@shell4.speakeasy.net>
References: <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com> <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com> <48921888.3020900@grandegger.com>
	<20080731195911.GA29610@secretlab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2008, Grant Likely wrote:
> On Thu, Jul 31, 2008 at 09:54:48PM +0200, Wolfgang Grandegger wrote:
> > Thinking more about it, it would be best to add the property
> > "i2c-clock-divider" to the soc node and implement fsl_get_i2c_freq() in
> > a similar way:
> >
> >         soc8541@e0000000 {
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 device_type = "soc";
> >                 ranges = <0x0 0xe0000000 0x100000>;
> >                 reg = <0xe0000000 0x1000>;      // CCSRBAR 1M
> >                 bus-frequency = <0>;
> >                 i2c-clock-divider = <2>;
> >
> > U-Boot could then fixup that value like bus-frequency() and the i2c-mpc
> > driver simply calls fsl_get_i2c_freq().

Except the i2c clock isn't always a based on an interger divider of the CCB
frequency.  What's more, it's not always the same for both i2c controllers.
Suppose i2c #1 uses CCB times 2/3 and i2c #2 uses CCB/2, how would
fsl_get_i2c_freq() figure that out from bus-frequency and
i2c-clock-divider?

> Ugh.  This is specifically related to the i2c device, so please place
> the property in the i2c device.  Remember, device tree design is not
> about what will make the implementation simplest, but rather about what
> describes the hardware in the best way.

> Now, if you can argue that i2c-clock-frequency is actually a separate
> clock domain defined at the SoC level, not the i2c device level, then I
> will change my opinion.

The i2c controller just uses some system clock that was handy.  For each
chip, the designers consult tea leaves to choose a system clock at random
to connect to the i2c controller.
