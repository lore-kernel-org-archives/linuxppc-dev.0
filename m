Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B74DBDDE08
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 16:22:59 +1000 (EST)
Date: Sun, 16 Sep 2007 23:22:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070917062257.GC32314@gate.ebshome.net>
References: <200709161352.03459.sr@denx.de>
	<20070916185330.GA32314@gate.ebshome.net>
	<200709170734.09079.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709170734.09079.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 07:34:08AM +0200, Stefan Roese wrote:
> 
> My understanding was, that adding many #ifdef's into the code was not the 
> preferred way. 

But just making a copy seems to be a proffered one? Wow.

OCP and/or OF part is quite small part of the driver; another approach 
would been completely splitting OCP and OF specific part out 
(e.g. i2c-ibm_iic.c + i2c-ibm_iic_ocp.c / i2c_ibm_iic_of.c). I 
personally thing it's not worth the effort and just adding couple of 
ifdef'ed code is good enough, especially as a transitional thing.

> I could of course change this patch to not add an additional 
> driver but extend the existing driver with a bunch of #ifdef's to support 
> both versions.
> 
> This approach of multiple drivers seems to be common in the kernel right now:
> 
> drivers/mtd/maps/physmap.c
> drivers/mtd/maps/physmap_of.c
> 
> or
> 
> drivers/usb/host/ohci-ppc-soc.c
> drivers/usb/host/ohci-ppc-of.c

I don't think these are good examples, physmap.c seems to differ from 
physmap_of.c significantly. These drivers are mostly a glue, and it 
makes sense to have different versions, because there isn't much there 
except for platform/bus/glue specific code.

> Any other opinions on this? How should this be handled to get accepted 
> upstream? Two different drivers with removing the "old" one later when 
> arch/ppc is gone,

ppc has been going away for the last two years at least and still 
isn't gone. What makes you think this isn't gonna take another year or 
two :) ?

> 
> The "old" name "i2c-ibm_iic" is kind of redundant. Nearly all bus drivers are 
> named "i2c-platform". Perhaps a better name would be "i2c-ppc4xx" then. 

Sure, that'd be a much better choice.

-- 
Eugene
