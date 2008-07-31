Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311343h3a1b21dbub15754090a67fac6@mail.gmail.com>
Date: Thu, 31 Jul 2008 16:43:40 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <48922218.9020503@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com>
	<20080731182810.GB29097@secretlab.ca> <48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
	<48922218.9020503@freescale.com>
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
> Jon Smirl wrote:
>
>  > For mpc5200 it is easy, mpc52xx_find_ipb_freq()  already exists to get
>  > the source clock for the i2c devices. Each i2c node in the device tree
>  > can then specify "clock-frequency = 400000;" or let it default. You
>
>
> 400KHz is the *speed* of the I2C bus, so let's be sure to use "speed" in the
>  property name.  Reserve the word "bus" for the input clock to the I2C device.
>
>
>  > #if defined(CONFIG_MPC8540) || defined(CONFIG_MPC8541) || \
>  >        defined(CONFIG_MPC8560) || defined(CONFIG_MPC8555)
>  >        gd->i2c1_clk = sys_info.freqSystemBus;
>  > #elif defined(CONFIG_MPC8544)
>  >        /*
>  >         * On the 8544, the I2C clock is the same as the SEC clock.  This can be
>  >         * either CCB/2 or CCB/3, depending on the value of cfg_sec_freq. See
>  >         * 4.4.3.3 of the 8544 RM.  Note that this might actually work for all
>  >         * 85xx, but only the 8544 has cfg_sec_freq, so it's unknown if the
>  >         * PORDEVSR2_SEC_CFG bit is 0 on all 85xx boards that are not an 8544.
>  >         */
>  >        if (gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG)
>  >                gd->i2c1_clk = sys_info.freqSystemBus / 3;
>  >        else
>  >                gd->i2c1_clk = sys_info.freqSystemBus / 2;
>  > #else
>  >        /* Most 85xx SOCs use CCB/2, so this is the default behavior. */
>  >        gd->i2c1_clk = sys_info.freqSystemBus / 2;
>  > #endif
>  >        gd->i2c2_clk = gd->i2c1_clk;
>
>
> I think the whole point is to eliminate duplicating this code in the Linux
>  driver.  It's hideously ugly, so it should be limited as much as possible.

It wouldn't go into the i2c driver, it would go into the mpc8xxx
platform driver. Why is it bad to put it into the mpc8xxx platform
driver? It is an accurate description of the mpc8xxx platform isn't
it?


-- 
Jon Smirl
jonsmirl@gmail.com
