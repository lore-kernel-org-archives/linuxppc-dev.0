Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14536DDFE9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:02:15 +1000 (EST)
Date: Mon, 15 Oct 2007 13:53:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
Message-ID: <20071015185340.GB4474@loki.buserror.net>
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 10:57:48AM -0600, Grant Likely wrote:
> Segher is recommending that we use an aliases node as per the open
> firmware example for this.  I think in this case it would look
> something like this (but I'm not the expert):
> 
> aliases {
>      IIC0 = "/path/to/bus/iic@0x2000";
>      IIC1 = "/path/to/bus/iic@0x2000";
> };

I think this is overly complicated; something like linux,i2c-index in the
i2c adapter node would be simpler.

Though, I don't see what the problem with the original approach is, as long
as the numbers are chosen in the same way when registering i2c clients based
on the children of the adapter node.  There's no concept in the hardware
itself of a bus number.

-Scott
