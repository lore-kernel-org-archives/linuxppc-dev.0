Return-Path: <SRS0=a+gK=ON=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 77E63DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 15:33:39 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Date: Mon, 17 Sep 2007 07:34:08 +0200
References: <200709161352.03459.sr@denx.de>
	<20070916185330.GA32314@gate.ebshome.net>
In-Reply-To: <20070916185330.GA32314@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709170734.09079.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 16 September 2007, Eugene Surovegin wrote:
> Hmm, I just noticed that you basically added a copy of existing
> driver with small changes to support OF while keeping OCP one.
>
> Why not just add OF support to the existing code (under some ifdef),
> and then remove OCP support as soon as ppc -> powerpc transition is
> finished? Why have two almost identical code in the tree?

My understanding was, that adding many #ifdef's into the code was not the 
preferred way. I could of course change this patch to not add an additional 
driver but extend the existing driver with a bunch of #ifdef's to support 
both versions.

This approach of multiple drivers seems to be common in the kernel right now:

drivers/mtd/maps/physmap.c
drivers/mtd/maps/physmap_of.c

or

drivers/usb/host/ohci-ppc-soc.c
drivers/usb/host/ohci-ppc-of.c

Any other opinions on this? How should this be handled to get accepted 
upstream? Two different drivers with removing the "old" one later when 
arch/ppc is gone, or one driver which supports both versions and removing the 
ocp support in this driver later?

> I also personally don't like this _iic -> _of name change (you
> removed peripheral name and added something which has nothing to do
> with iic, I never heard of OF peripheral in 4xx chips). Whether you
> use OCP or OF to pass a little information is quite irrelevant to the
> iic driver operation.

The "old" name "i2c-ibm_iic" is kind of redundant. Nearly all bus drivers are 
named "i2c-platform". Perhaps a better name would be "i2c-ppc4xx" then. 
This "of" name was borrowed from already existing device-tree aware drivers 
like drivers/mtd/maps/physmap_of.c or drivers/usb/host/ohci-ppc-of.c.

> If you insist on this approach, please add yourself as a maintainer of
> this code, because I'm not going to support two identical copies of my
> code in the kernel tree.

I "insist" in nothing. I'm just trying to get this device-tree aware I2C 
driver support upstream.

Best regards,
Stefan
