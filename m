Return-Path: <timur.tabi@gmail.com>
Message-ID: <ed82fe3e0808010625q53680d42l83f28a6df835f959@mail.gmail.com>
Date: Fri, 1 Aug 2008 08:25:59 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <9e4733910807311935n1f81f18dw135372d97d3dcb45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4891F4D8.9090905@grandegger.com>
	<20080731180959.GA29057@secretlab.ca> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca> <48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<20080801020303.GA30947@secretlab.ca>
	<9e4733910807311935n1f81f18dw135372d97d3dcb45@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 9:35 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> I've having trouble with whether these clocks are a system resource or
> something that belongs to i2c. If they are a system resource then we
> should make nodes in the root and use a phandle in the i2c node to
> link to them.

I can't speak for 52xx, but for 8[356]xx, I would say the clocks
belong to the I2C devices.  The screwball determination of whether to
divide by 1, 2, or 3 only applies to the I2C device only.  The divider
itself is not used to drive a clock for any other device.  If you
disable I2C support, then you don't need to care about the divider (or
its output clock) at all.  That's why I think have the I2C clock in
the parent node is wrong, because it would only be used if you had I2C
child nodes.  If you didn't have any I2C nodes, then you would need to
delete the property from the parent node as well.

> The phandle in the mpc5200 case could be implicit since it is fixed in silicon.

If we want to use the same I2C driver for 52xx and 83xx, it shouldn't
be implicit.  Otherwise, the driver will have to check the platform to
determine where to look.

> Is this register in a system register bank or an i2c one?
> gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG

That should be "guts->" I think.  The global utilities is a block of
miscellaneous registers, one per SOC.  It's not part of the I2C block.

-- 
Timur Tabi
Linux kernel developer at Freescale
