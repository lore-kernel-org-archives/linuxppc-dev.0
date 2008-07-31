Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
Date: Thu, 31 Jul 2008 16:32:01 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <48921DED.6010403@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com>
	<20080731180959.GA29057@secretlab.ca> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca> <48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com>
Cc: Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Timur Tabi wrote:
>
> > Wolfgang Grandegger wrote:
> >
> >
> > > But clock-frequency, aka bus-frequency, is already used by
> fsl_get_sys_freq():
> > >
> > >
> http://lxr.linux.no/linux+v2.6.26/arch/powerpc/sysdev/fsl_soc.c#L80
> > >
> >
> > So?  clock-frequency is a per-node property.  I use it in the codec node
> on the
> > 8610 (mpc8610_hpcd.dts).  It does not mean "platform clock frequency".
> >
> >
> > > U-Boot could then fixup that value like bus-frequency() and the i2c-mpc
> driver simply calls fsl_get_i2c_freq().
> > >
> >
> > This is just more complicated than it needs to be.  Why should the I2C
> driver
> > fetch the platform clock and the divider from the parent node, and then do
> > additional math, when it could just get the value it needs right from the
> node
> > it's probing?
> >
>
>  I'm a bit confused. The frequency of the I2C source clock and the real I2C
> clock frequency are two different things. The first one is common for all
> I2C devices, the second can be different. What properties would you like to
> use for defining both?

For mpc5200 it is easy, mpc52xx_find_ipb_freq()  already exists to get
the source clock for the i2c devices. Each i2c node in the device tree
can then specify "clock-frequency = 400000;" or let it default. You
have the input clock and the desired clock, do some math and you can
set FDR.

For the 8xxx chips there is no simple solution for obtain the input
clock for the i2c section. Maybe create something like i2c-frequency
and set it from uboot. The make another accessor function like
mpc8xxx_find_i2c_freq().

		PowerPC,8xxx@0 {
			timebase-frequency = <0>;	/* From Bootloader  */
			bus-frequency = <0>;		/* From Bootloader  */
			clock-frequency = <0>;		/* From Bootloader  */
			i2c-frequency = <0>;		/* From Bootloader  */
		};

Instead of creating i2c-frequency in the device tree, you could put
this piece of code in the the mpc8xxx platform driver and use it to
implement mpc8xxx_find_i2c_freq(). Read the PORDEVSR2_SEC_CFG bit back
from whatever uboot set it too.

#if defined(CONFIG_MPC8540) || defined(CONFIG_MPC8541) || \
       defined(CONFIG_MPC8560) || defined(CONFIG_MPC8555)
       gd->i2c1_clk = sys_info.freqSystemBus;
#elif defined(CONFIG_MPC8544)
       /*
        * On the 8544, the I2C clock is the same as the SEC clock.  This can be
        * either CCB/2 or CCB/3, depending on the value of cfg_sec_freq. See
        * 4.4.3.3 of the 8544 RM.  Note that this might actually work for all
        * 85xx, but only the 8544 has cfg_sec_freq, so it's unknown if the
        * PORDEVSR2_SEC_CFG bit is 0 on all 85xx boards that are not an 8544.
        */
       if (gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG)
               gd->i2c1_clk = sys_info.freqSystemBus / 3;
       else
               gd->i2c1_clk = sys_info.freqSystemBus / 2;
#else
       /* Most 85xx SOCs use CCB/2, so this is the default behavior. */
       gd->i2c1_clk = sys_info.freqSystemBus / 2;
#endif
       gd->i2c2_clk = gd->i2c1_clk;


-- 
Jon Smirl
jonsmirl@gmail.com
