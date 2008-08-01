Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311935n1f81f18dw135372d97d3dcb45@mail.gmail.com>
Date: Thu, 31 Jul 2008 22:35:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <20080801020303.GA30947@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4891F4D8.9090905@grandegger.com> <4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca> <48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<20080801020303.GA30947@secretlab.ca>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> Your mixing up device tree layout with implementation details.  Device
>  tree layout must come first.  mpc52xx_find_ipb_freq() is just a
>  convenience function that walks up the device tree looking for a
>  bus-frequency property.
>
>  So, instead of making arguments based on available helper functions,
>  make your arguments based on how data should be laid out in the device
>  tree.  Currently mpc5200 bindings simply depend on finding a
>  bus-frequency property in the parent node for determining the input
>  clock and I don't see any pressing reason to change that (though it
>  probably needs to be documented better).
>
>  However, for the complex cases that Trent and Timur are talking about,
>  it makes perfect sense to have an optional property in the i2c node
>  itself that defines a different clock.  Once that decision has been made
>  and documented, then the driver can be modified and the appropriate
>  helper functions added to adapt the device tree data into something
>  useful.

I've having trouble with whether these clocks are a system resource or
something that belongs to i2c. If they are a system resource then we
should make nodes in the root and use a phandle in the i2c node to
link to them.

The phandle in the mpc5200 case could be implicit since it is fixed in silicon.

Is this register in a system register bank or an i2c one?
gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG

>
>  Remember (and chant this to yourself).  The device tree describes
>  *hardware*.  It does not describe Linux internal implementation details.
>
>
>  g.
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
