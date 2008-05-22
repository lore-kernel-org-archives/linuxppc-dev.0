Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5E1B7DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 00:12:18 +1000 (EST)
Date: Thu, 22 May 2008 09:28:34 -0500
From: Olof Johansson <olof@lixom.net>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH 2/2] USB: isp1760: Support board-specific hardware
	configurations
Message-ID: <20080522142834.GA14072@lixom.net>
References: <1211405331.13845.628.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1211405331.13845.628.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 04:28:51PM -0500, Nate Case wrote:
> This adds support for hardware configurations that don't match the
> chip default register settings (e.g., 16-bit data bus, DACK and
> DREQ pulled down instead of up, analog overcurrent mode).
> 
> These settings are passed in via the OF device tree.  The PCI
> interface still assumes the same default values.

Nice! I'll give this a spin on Electra as well, it should make it work
there.

A couple of comments on the OF interface:

> @@ -55,8 +57,34 @@ static int of_isp1760_probe(struct of_device *dev,
>  	virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
>  			oirq.size);
>  
> +	prop = of_get_property(dp, "port1-disable", NULL);
> +	if (prop && *prop != 0)
> +		devflags |= ISP1760_FLAG_PORT1_DIS;

It should be sufficient to add the property without a value, and just
check for the presence of it. The cpu nodes have properties like this if
you want something to compare with.

> +
> +	/* Some systems wire up only 16 of the 32 data lines */
> +	prop = of_get_property(dp, "bus-width", NULL);
> +	if (prop && *prop == 16)
> +		devflags |= ISP1760_FLAG_BUS_WIDTH_16;

This is the obvious exception, here you'll have to check the value.

I'm not sure if the DT police will complain of the overloaded bus-width
property name and would prefer a custom one.


-Olof
