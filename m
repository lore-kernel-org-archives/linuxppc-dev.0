Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09CAADDFA4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:32:42 +1000 (EST)
Message-ID: <4713BE5E.3030406@freescale.com>
Date: Mon, 15 Oct 2007 14:24:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
References: <200710151529.11485.sr@denx.de>	
	<20071015163216.GA8127@gate.ebshome.net>	
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>	
	<20071015185340.GB4474@loki.buserror.net>
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
In-Reply-To: <fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Grant Likely wrote:
> On 10/15/07, Scott Wood <scottwood@freescale.com> wrote:
>> On Mon, Oct 15, 2007 at 10:57:48AM -0600, Grant Likely wrote:
>>> Segher is recommending that we use an aliases node as per the open
>>> firmware example for this.  I think in this case it would look
>>> something like this (but I'm not the expert):
>>>
>>> aliases {
>>>      IIC0 = "/path/to/bus/iic@0x2000";
>>>      IIC1 = "/path/to/bus/iic@0x2000";
>>> };
>> I think this is overly complicated; something like linux,i2c-index in the
>> i2c adapter node would be simpler.
> 
> But not perhaps better.  Enumeration is a system-wide thing.  It does
> make sense to group all the device enumerations in one place.

For purposes of generating a Linux bus number, having to scan all 
aliases for a matching path and turn IIC0/IIC1 into a number is a bit silly.

For associating a device node with a human readable label, I'd prefer a 
"label" property in the device node, rather than doing it backwards with 
aliases.

> As per your point below; if all the i2c devices are children of the
> adapter, then yes you are right that the bus number doesn't matter to
> the user.  But it *does* matter for things like serial and ethernet
> ports.

And a label property would be great for that. :-)

>> Though, I don't see what the problem with the original approach is, as long
>> as the numbers are chosen in the same way when registering i2c clients based
>> on the children of the adapter node.  There's no concept in the hardware
>> itself of a bus number.
> 
> Even if you take this approach, the driver still need to know what bus
> number to use (as per the i2c infrastructure).  It is not sane for an
> i2c bus driver to attempt to assign the bus number itself because it
> could conflict with another arbitrarily chosen bus number from another
> driver.

Hence why global bus numbers suck. :-)

However, statically chosen numbers should only be done for platform 
devices, not dynamic things such as PCI, so in practice I don't think 
it'd be a problem.

-Scott
