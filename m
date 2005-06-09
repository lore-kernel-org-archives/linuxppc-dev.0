Return-Path: <tnt@246tNt.com>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.3.3]) by ozlabs.org (Postfix) with ESMTP id A317A679F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 21:28:24 +1000 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j59BSIJ4008853
	for <linuxppc-embedded@ozlabs.org>; Thu, 9 Jun 2005 13:28:18 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42A827DC.8000803@246tNt.com>
Date: Thu, 09 Jun 2005 13:28:28 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <glikely@gmail.com>
References: <528646bc05060816514c2d5860@mail.gmail.com>
In-Reply-To: <528646bc05060816514c2d5860@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> I'm working on an MPC52xx SPI device driver using one of the PSC. 
> However, when I call driver_register() I get a failure (-17, EEXISTS)
> with a traceback (posted below).
> 
> I've tracked it down to failing when trying to create a sysfs entry
> for the driver.  It fails because sysfs tries to create a directory
> that already exists (mpc52xx_psc).  The directory was already created
> when the psc serial port device driver was registered.
> 
>>From what I can tell, I should be able to register more than one
> driver for a particular device name (mpc52xx_psc).

I always assumed that yes.
But now looking more closely, I'm not sure what I based that assumption 
on ... And if not the case that's indeed a problem because that's what's 
used to support the different function supported by the PSCs.

> Otherwise I would
> need to change arch/ppc/syslib/mpc52xx_devices.c to have a different
> name for each psc.

No you shouldn't have to touch that. The
mpc52xx_match_psc_function(idx, "spi") is there to know which driver 
should be used for what PSC and you're using it correctly so it _should_ 
work.

> If I change the sysfs code to ignore the failure
> to create a directory then the driver seems to register fine.

A "better" quick-fix would be to change the platform_match 
(drivers/platform.c) to support "sub-fonctions". For example when using
mpc52xx_psc.spi it only matches what's before the dot (if any) with the 
device name.

That changes the semantic of the driver names for the platform bus 
however, making the dot a "special" char.




	Sylvain
