Return-Path: <glikely@secretlab.ca>
Date: Thu, 31 Jul 2008 13:25:33 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Message-ID: <20080731192533.GD29097@secretlab.ca>
References: <4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
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

On Thu, Jul 31, 2008 at 02:57:25PM -0400, Jon Smirl wrote:
> On 7/31/08, Timur Tabi <timur@freescale.com> wrote:
> > Grant Likely wrote:
> > I propose the property "clock-frequency", like this:
> >
> >                 i2c@3000 {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         cell-index = <0>;
> >                         compatible = "fsl-i2c";
> >                         reg = <0x3000 0x100>;
> >                         interrupts = <14 0x8>;
> >                         interrupt-parent = <&ipic>;
> >                         dfsrr;
> 
> The existence of the dfsrr and fsl,mpc5200-i2c attributes imply to me
> that the compatible strings were not done correctly. If these devices
> really were compatible we wouldn't need extra attributes to tell them
> apart.

Yes, exactly right.

> So I'm with Grant on adding compatible strings sufficient to remove
> the need for dfsrr and fsl,mpc5200-i2c.
> 
> Something like...
> static const struct of_device_id mpc_i2c_of_match[] = {
>        {.compatible = "fsl,mpc5200b-i2c", .data = fsl_i2c_mpc5200, },
>        {.compatible = "fsl,mpc5200-i2c", .data = fsl_i2c_mpc5200, },
>        {.compatible = "fsl,mpc8xxx-i2c", .data = fsl_i2c_dfsrr, },

Yes, but I don't agree with the last entry in this list.
"fsl,mpc8xxx-i2c" is not a good value.  Use an actual part number
instead and have newer devices claim compatibility with the old.

The problem with 8xxx is that you don't know if/when another 8xxx
will arrive on the scene which does not conform to already made
assumptions.  If you specify an exact SoC part, then the problem goes
away without any downside.

> As for the source clock, how about creating a new global like
> ppc_proc_freq called ppc_ipb_freq. The platform code can then set the
> right clock value into the variable. For mpc8xxxx get it from uboot.
> mpc5200 can easily compute it from ppc_proc_freq and checking how the
> ipb divider is set. That will move the clock problem out of the i2c
> driver.

In general, I don't like adding additional global or machine vars to
Linux.  I just don't think it in necessary and it can quickly get out of
control.  Instead, For 5200 I've exported a mpc52xx specific function
that returns the clock frequency.  The function can be adapted over time
to handle new cases on the 52xx platform and it get compiled out if 5200
is not in use.

As an alternative, clock-frequency could be made an optional property.
If it isn't specified, then get the bus-frequency property from the
parent node instead.

g.
