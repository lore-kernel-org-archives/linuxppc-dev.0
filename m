Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
Date: Thu, 31 Jul 2008 21:19:51 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Trent Piepho" <xyzzy@speakeasy.org>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com> <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com> <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
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

On 7/31/08, Trent Piepho <xyzzy@speakeasy.org> wrote:
> On Thu, 31 Jul 2008, Jon Smirl wrote:
>  > As for the source clock, how about creating a new global like
>  > ppc_proc_freq called ppc_ipb_freq. The platform code can then set the
>  > right clock value into the variable. For mpc8xxxx get it from uboot.
>  > mpc5200 can easily compute it from ppc_proc_freq and checking how the
>  > ipb divider is set. That will move the clock problem out of the i2c
>  > driver.
>
>
> There is a huge variation in where the I2C source clock comes from.
>  Sometimes it's the system bus, sometimes ethernet, sometimes SEC, etc.  If
>  I look at u-boot (which might not be entirely correct or complete), I see:
>
>  83xx:  5 different clock sources
>  85xx:  3 different clock sources
>  86xx:  2 different clock sources
>
>  But there's more.  Sometimes the two I2C controllers don't use the same
>  clock!  So even if you add 10 globals with different clocks, and then add
>  code to the mpc i2c driver so if can figure out which one to use given the
>  platform, it's still not enough because you need to know which controller
>  the device node is for.
>
>  IMHO, what Timur suggested of having u-boot put the source clock into the
>  i2c node makes the most sense.  U-boot has to figure this out, so why
>  duplicate the work?
>
>  Here's my idea:
>
>         i2c@0 {
>                 compatible = "fsl-i2c";
>                 bus-frequency = <100000>;
>
>                 /* Either */
>                 source-clock-frequency = <0>;
>                 /* OR */
>                 source-clock = <&ccb>;
>         };

Can't we hide a lot of this on platforms where the source clock is not
messed up? For example the mpc5200 doesn't need any of this, the
needed frequency is already available in mpc52xx_find_ipb_freq().
mpc5200 doesn't need any uboot change.

Next would be normal mpc8xxx platforms where i2c is driven by a single
clock, add a uboot filled in parameter in the root node (or I think it
can be computed off of the ones uboot is already filling in). make a
mpc8xxx_find_i2c_freq() function. May not need to change device tree
and uboot.

Finally use this for those days when the tea leaves were especially
bad. Both a device tree and uboot change.

> Except the i2c clock isn't always a based on an integer divider of the CCB
>  frequency.  What's more, it's not always the same for both i2c controllers.
>  Suppose i2c #1 uses CCB times 2/3 and i2c #2 uses CCB/2, how would
>  fsl_get_i2c_freq() figure that out from bus-frequency and
>  i2c-clock-divider?

If you get the CCB frequency from uboot and know the chip model, can't
you compute these in the platform code? Then make a
mpc8xxx_find_i2c_freq(cell_index).

I don't see why we want to go through the trouble of having uboot tell
us things about a chip that are fixed in stone. Obviously something
like the frequency of the external crystal needs to be passed up, but
why pass up stuff that can be computed (or recovered by reading a
register)?

I may be using uboot differently, I just use it to boot and removed
support for everything else.

>  bus-frequency is the desired frequency of the i2c bus, i.e. 100 kHz or 400
>  kHz usually.  source-clock-frequency is the the source clock to this i2c
>  controller.  U-Boot can fill this in since it already knows it anyway.  Or,
>  instead of source-clock-frequency, source-clock can be specified as a
>  phandle to a device which has the clock to use.  This could be useful if
>  Linux can change the clock frequency.
>


-- 
Jon Smirl
jonsmirl@gmail.com
