Return-Path: <xyzzy@speakeasy.org>
Date: Thu, 31 Jul 2008 17:22:28 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers	configurable
	via FDT
In-Reply-To: <9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
References: <4889EFFE.2070201@grandegger.com> <4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com> <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
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
> As for the source clock, how about creating a new global like
> ppc_proc_freq called ppc_ipb_freq. The platform code can then set the
> right clock value into the variable. For mpc8xxxx get it from uboot.
> mpc5200 can easily compute it from ppc_proc_freq and checking how the
> ipb divider is set. That will move the clock problem out of the i2c
> driver.

There is a huge variation in where the I2C source clock comes from.
Sometimes it's the system bus, sometimes ethernet, sometimes SEC, etc.  If
I look at u-boot (which might not be entirely correct or complete), I see:

83xx:  5 different clock sources
85xx:  3 different clock sources
86xx:  2 different clock sources

But there's more.  Sometimes the two I2C controllers don't use the same
clock!  So even if you add 10 globals with different clocks, and then add
code to the mpc i2c driver so if can figure out which one to use given the
platform, it's still not enough because you need to know which controller
the device node is for.

IMHO, what Timur suggested of having u-boot put the source clock into the
i2c node makes the most sense.  U-boot has to figure this out, so why
duplicate the work?

Here's my idea:

	i2c@0 {
		compatible = "fsl-i2c";
		bus-frequency = <100000>;

		/* Either */
		source-clock-frequency = <0>;
		/* OR */
		source-clock = <&ccb>;
	};

bus-frequency is the desired frequency of the i2c bus, i.e. 100 kHz or 400
kHz usually.  source-clock-frequency is the the source clock to this i2c
controller.  U-Boot can fill this in since it already knows it anyway.  Or,
instead of source-clock-frequency, source-clock can be specified as a
phandle to a device which has the clock to use.  This could be useful if
Linux can change the clock frequency.
