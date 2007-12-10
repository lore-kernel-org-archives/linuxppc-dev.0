Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AB29DE0EF
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 05:44:44 +1100 (EST)
Message-ID: <475D8756.2000906@freescale.com>
Date: Mon, 10 Dec 2007 12:37:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
References: <20071203212032.23543.3453.stgit@terra.home>	
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>	
	<1197233208.6563.14.camel@pasglop>	
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>	
	<1197234799.6563.19.camel@pasglop>	
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>	
	<1197236326.6563.22.camel@pasglop>	
	<20071210164255.GA4497@loki.buserror.net>
	<9e4733910712101006s37829df4w676eea54a98b282d@mail.gmail.com>
In-Reply-To: <9e4733910712101006s37829df4w676eea54a98b282d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> I can't see an easy way to do this. The basic problem is that the i2c
>  drivers are assumed to be cross platform.

It'd be a small binding-specific portion, similar to an of_platform stub
on a generic driver.  It could probably wait until an actual need
arises, though.

> I would need to add a path through the i2c core for getting a void
> pointer from the bus to the device But then when the device code gets
> this pointer it has no way of knowing what it was.

It'd need to know which binding/name combination it matched against
(similar to how of_platform does it).

> Another way that would work cross platform would be for the module to
>  have module parameters for the extra attributes.

Ick.  Module parameters are a PITA, and have to be duplicated with 
command line parameters if you want to support non-modular builds.

-Scott
