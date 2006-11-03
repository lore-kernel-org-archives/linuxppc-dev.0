Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83D7567C32
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 07:46:20 +1100 (EST)
Subject: Re: Fw: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Winiecki <stevewin@us.ibm.com>
In-Reply-To: <OFCD6BEB84.DE407CA1-ON8725721B.00508624-8525721B.00552A5F@us.ibm.com>
References: <OFCD6BEB84.DE407CA1-ON8725721B.00508624-8525721B.00552A5F@us.ibm.com>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 07:46:15 +1100
Message-Id: <1162586775.10630.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> OK - so in this sense PPC_MULTIPLATFORM would be used more to help
> categorize (make ppc platforms depend on it in Kconfig) as opposed to
> enabling different code/function? (thus some of Sascha's patches
> getting rid of CONFIG_PPC_MMULTIPLATFORM ifdefs)

I'd rather get rid of it completely.

> I should have more properly said "the majority of the existing
> 'embedded' platforms (not PSERIES, CHRP, PREP etc.) currently
> implmented in /power seem to define CONFIG_DEFAULT_UIMAGE"

Yes. Though I hope we'll see some alternatives to uboot soon

/me looks towards ojn and segher....

> Makes sense.  Specific to the current wrapper though - the boot
> Makefile currently keys off the following for the different zImage
> 'types'
> 
> image-$(CONFIG_PPC_PSERIES)             += zImage.pseries
> image-$(CONFIG_PPC_MAPLE)               += zImage.pseries
> image-$(CONFIG_PPC_IBM_CELL_BLADE)      += zImage.pseries
> image-$(CONFIG_PPC_CHRP)                += zImage.chrp
> image-$(CONFIG_PPC_PMAC)                += zImage.pmac
> image-$(CONFIG_DEFAULT_UIMAGE)          += uImage
> 
> My original point really was that if I have a ppc 'embedded' board
> which I don't want to classify/define as
> PSERIES/MAPLE/CELL_BLADE/CHRP/PMAC, and I don't want to generate a
> uImage, I think there needs to be another definition, something like
> CONFIG_DEFAULT_ZIMAGE (similar to how CONFIG_DEFAULT_UIMAGE is used in
> some of the existing /power platform defs to create a uImage) which
> would be used to produce a 'normal' zImage type (zImage.pseries?).

Yeah, that's what the zImage.pseries is :) Bad name I agree.

>   Basically - a definition analogous to the exisiting
> CONFIG_DEFAULT_UIMAGE, but for zImage.  It would be used in a similar
> way - where any platform could select in its configuration to result
> in a 'normal' zImage being created (indeed, could
> PPC_PSERIES/MAPLE/BLADE just select this more generic definition and
> the Makefile use it instead?)

Ben.
