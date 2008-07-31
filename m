Return-Path: <timur@freescale.com>
Message-ID: <48920D9B.5060406@freescale.com>
Date: Thu, 31 Jul 2008 14:08:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48920C1A.7010605@freescale.com>
In-Reply-To: <48920C1A.7010605@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Timur Tabi wrote:
>> Grant Likely wrote:
>>
>>> No it doesn't, it depends on the register interface to decide
>>> compatibility.  Clock interface is part of that. 
>> I don't think so.  The interface for programming the clock registers is
>> identical on all 8[356]xx parts.  The only thing that matters is what specific
>> values to put in the FDR and DFSR registers to get a desired I2C bus speed.
> 
> If it affects the values you need to write to the registers to achieve a 
> given result, how is it not a difference in the register interface?

I think we're splitting hairs, here.  The code for actually programming the
registers is the same, regardless of the input frequency.  It's just that the
input frequency is a value needed to calculate the right value.  But like I
said, I don't think this distinction is that relevant.

> A clock-frequency property is OK, and is in line with what we do in 
> other types of nodes.  However, in the long run it might be nice to 
> introduce some sort of clock binding where, for example, the i2c node 
> can point to a clock elsewhere in the device tree as an input clock.

The only problem with that is that the actual input clock to the I2C device is
not the same as any other device.  It's a unique clock.  Look at the code I had
to write to figure out this clock just on 85xx:

	/*
	 * The base clock for I2C depends on the actual SOC.  Unfortunately,
	 * there is no pattern that can be used to determine the frequency, so
	 * the only choice is to look up the actual SOC number and use the value
	 * for that SOC. This information is taken from application note
	 * AN2919.
	 */
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

This is just for 85xx, and it only applies to the I2C devices.

> That way, less knowledge is required by the firmware to poke values all 
> over the place, and it also allows one to describe situations where the 
> frequency of the input clock can change (such as in low-power modes).

I don't think it's possible to do what you want to do.  I2C clocking is
completely screwed up, and that's just the way the hardware was designed.

-- 
Timur Tabi
Linux kernel developer at Freescale
