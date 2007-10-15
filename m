Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED24FDDF58
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:03:15 +1000 (EST)
Message-ID: <4713C57F.7060509@freescale.com>
Date: Mon, 15 Oct 2007 14:54:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
References: <200710151529.11485.sr@denx.de>	
	<20071015163216.GA8127@gate.ebshome.net>	
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>	
	<20071015185340.GB4474@loki.buserror.net>	
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>	
	<4713BE5E.3030406@freescale.com>
	<fa686aa40710151248y5e921a4fmbb0a3e0b7c9a2ca5@mail.gmail.com>
In-Reply-To: <fa686aa40710151248y5e921a4fmbb0a3e0b7c9a2ca5@mail.gmail.com>
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
>> For associating a device node with a human readable label, I'd
>> prefer a "label" property in the device node, rather than doing it
>> backwards with aliases.
> 
> Here the corresponding problem; having to scan every device node to 
> make sure you don't assign a number already selected by another node 
> (in the case where one node is assigned a number and another is not).
> 
Don't Do That(tm).  If you use this mechanism, and an adapter node
doesn't have a bus number, then it doesn't get to pre-register devices,
but instead must use i2c_new_device.

>>> As per your point below; if all the i2c devices are children of
>>> the adapter, then yes you are right that the bus number doesn't
>>> matter to the user.  But it *does* matter for things like serial
>>> and ethernet ports.
>> And a label property would be great for that. :-)
> 
> Not really; if the user needs to renumber devices; you don't want him
>  fiddling around in the hardware description.

Why would the user renumber devices?

> Just like the chosen node; an aliases describes logical constructs,
> not physical ones.  I don't think this is any different from the
> linux,stdout-path property in chosen.

Well, it's somewhat different in that stdout describes a usage of the 
device, not the identity.

Still, I don't like linux,stdout-path. :-)
At the very least it should be a phandle.

-Scott
