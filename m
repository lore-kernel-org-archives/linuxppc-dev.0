Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1052BDDDFC
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 10:59:17 +1100 (EST)
Message-ID: <47549685.8050307@freescale.com>
Date: Mon, 03 Dec 2007 17:51:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/4] Series to add device tree naming to i2c
References: <20071203212032.23543.3453.stgit@terra.home>
	<20071203233752.GA7041@lixom.net>
In-Reply-To: <20071203233752.GA7041@lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Mon, Dec 03, 2007 at 04:20:32PM -0500, Jon Smirl wrote:
>> The following series implements standard linux module aliasing for i2c modules
>> It then converts the mpc i2c driver from being a platform driver to an open
>> firmware one. I2C device names are picked up from the device tree. Module
>> aliasing is used to translate from device tree names into to linux kernel
>> names. Several i2c drivers are updated to use the new aliasing. 
> 
> May I ask why you want to modify the i2c layer instead of keeping the
> OF->i2c driver mapping in PPC code?

Because it doesn't belong there -- at the least, it should be in 
drivers/of.  But putting it in the driver is better, IMHO.

> It seems simpler to keep it in the
> PPC-specific code, since otherwise you might end up with confused i2c
> driver writers that make up their own OF names without knowing for sure
> that's what will be used. No?

How is this different from drivers that have of_platform bindings?

That said, there should probably be some sort of tag to indicate the 
namespace being matched against (OF, Linux, etc), to avoid matching an 
OF device with a non-OF name (or vice versa).

> I recently posted (and asked Paulus to pull) a patch where I consolidate
> the fsl_soc mapping code so I can also use that on pasemi, and modified
> the pasemi platform code to setup the board_info from the device tree
> accordingly.

Having just one bit i2c glue code for arch/powerpc is certainly an 
improvement over the current situation, but it's not really powerpc 
specific.  Just because other architectures don't use it now doesn't 
mean they won't in the future -- and I don't like the "we'll move it 
when they do" argument because I want to make it easy for other 
architectures to decide to use it. :-)

-Scott
