Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
Date: Thu, 31 Jul 2008 14:57:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <48920607.5040606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com> <4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com> <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>  > No it doesn't, it depends on the register interface to decide
>  > compatibility.  Clock interface is part of that.
>
>
> I don't think so.  The interface for programming the clock registers is
>  identical on all 8[356]xx parts.  The only thing that matters is what specific
>  values to put in the FDR and DFSR registers to get a desired I2C bus speed.
>  That answer is dependent on the actual clock input to the device, which is
>  external to the device.  I wouldn't call the input frequency a property of the
>  I2C device.
>
>
>  > I suggested encoding
>  > the clock divider directly in compatible (implicit in the SoC version),
>  > but it doesn't have to be that way.  If clock freq is obtained from
>  > another property or some other method then that is okay too.
>
>
> I think we agree on that.
>
>
>  > There is nothing wrong with it (as long as we agree and it gets
>  > documented).  I certainly don't have a problem with doing it this way.
>
>
> I propose the property "clock-frequency", like this:
>
>                 i2c@3000 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         cell-index = <0>;
>                         compatible = "fsl-i2c";
>                         reg = <0x3000 0x100>;
>                         interrupts = <14 0x8>;
>                         interrupt-parent = <&ipic>;
>                         dfsrr;

The existence of the dfsrr and fsl,mpc5200-i2c attributes imply to me
that the compatible strings were not done correctly. If these devices
really were compatible we wouldn't need extra attributes to tell them
apart.

So I'm with Grant on adding compatible strings sufficient to remove
the need for dfsrr and fsl,mpc5200-i2c.

Something like...
static const struct of_device_id mpc_i2c_of_match[] = {
       {.compatible = "fsl,mpc5200b-i2c", .data = fsl_i2c_mpc5200, },
       {.compatible = "fsl,mpc5200-i2c", .data = fsl_i2c_mpc5200, },
       {.compatible = "fsl,mpc8xxx-i2c", .data = fsl_i2c_dfsrr, },


As for the source clock, how about creating a new global like
ppc_proc_freq called ppc_ipb_freq. The platform code can then set the
right clock value into the variable. For mpc8xxxx get it from uboot.
mpc5200 can easily compute it from ppc_proc_freq and checking how the
ipb divider is set. That will move the clock problem out of the i2c
driver.

I'd like to move towards a more generic uboot that gets the processor
minimally running and then use the device tree to customize as many
things as possible. But that's just my opinion.


-- 
Jon Smirl
jonsmirl@gmail.com
