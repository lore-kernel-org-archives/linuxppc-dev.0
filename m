Return-Path: <timur@freescale.com>
Message-ID: <48920C16.4010203@freescale.com>
Date: Thu, 31 Jul 2008 14:01:42 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <4889EFFE.2070201@grandegger.com>
	<4891A744.6060005@grandegger.com>	
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>	
	<4891F4D8.9090905@grandegger.com>	
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>	
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>	
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>	
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
In-Reply-To: <9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Jon Smirl wrote:

> The existence of the dfsrr and fsl,mpc5200-i2c attributes imply to me
> that the compatible strings were not done correctly. If these devices
> really were compatible we wouldn't need extra attributes to tell them
> apart.

I agree with that.

> So I'm with Grant on adding compatible strings sufficient to remove
> the need for dfsrr and fsl,mpc5200-i2c.

Let's just make sure we don't break backwards compatibility.

> Something like...
> static const struct of_device_id mpc_i2c_of_match[] = {
>        {.compatible = "fsl,mpc5200b-i2c", .data = fsl_i2c_mpc5200, },
>        {.compatible = "fsl,mpc5200-i2c", .data = fsl_i2c_mpc5200, },
>        {.compatible = "fsl,mpc8xxx-i2c", .data = fsl_i2c_dfsrr, },

That seems ok.

> As for the source clock, how about creating a new global like
> ppc_proc_freq called ppc_ipb_freq. The platform code can then set the
> right clock value into the variable. For mpc8xxxx get it from uboot.
> mpc5200 can easily compute it from ppc_proc_freq and checking how the
> ipb divider is set. That will move the clock problem out of the i2c
> driver.

I don't want to differentiate between 52xx and 8xxx any more than we have to.
If 8xxx has the clock frequency in the device tree, then 52xx should have it
there, too.

For backwards compatibility purposes, we can have the driver provide a
hard-coded value of some kind if the property does not exist.

> I'd like to move towards a more generic uboot that gets the processor
> minimally running and then use the device tree to customize as many
> things as possible. But that's just my opinion.

U-Boot needs to configure the I2C bus speed because U-Boot uses the I2C.  We
should capitalize on that by taking the information that U-Boot has calculated
and re-use it.

-- 
Timur Tabi
Linux kernel developer at Freescale
