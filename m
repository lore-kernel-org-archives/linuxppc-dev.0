Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75D40DDF26
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:53:54 +1100 (EST)
Subject: Re: PPC4xx ECC Configs, Defines and Source
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081208202152.GA10929@yoda.jdub.homelinux.org>
References: <C562B54F.1351E%gerickson@nuovations.com>
	<20081208202152.GA10929@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 19:53:36 +1100
Message-Id: <1228899216.22413.52.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >I thought I might leverage the definitions Stefan Roese came up with for
> >u-boot for the base memory controller:
> >
> >    CONFIG_PPC4xx_IBM_SDRAM:   Applicable to 405GP, 405CR, 405EP, AP1000,
> >                               and ML2
> >    CONFIG_PPC4xx_IBM_DDR:     Applicable to 440GP, 440GX, 440EP, and 440GR
> >    CONFIG_PPC4xx_DENALI_DDR2: Applicable to 440EPX and 440GRX
> >    CONFIG_PPC4xx_IBM_DDR2:    Applicable to 405EX[r], 440SP, 440SPe, 460EX
> >                               and 460GT.
> 
> Config options for what?  Enabling certain function?  Not sure that's needed
> if we can get away with it by just binding to the appropriate controller.

You still want to have ways to enable compilation of only selected ones,
so that if I build a kernel for only a single board, I don't carry the
code for everybody else...

The way I see things is that there would be one master config option
that is user visible "Support for ECC monitoring on 4xx SoCs".

The various SoCs themselves are already select'ed by the various
platforms you enabled, so the SoC Kconfig entries could silently then
select which type of memory controllers are enabled

The combination of those types and the master option defines which
sub-drivers are actually built.

> >Controlling whether ECC monitoring and reporting support should be compiled
> >in or a module:
> >
> >    CONFIG_PPC_ECC or CONFIG_ECC
> 
> That's a bit too generic, unless you are trying to make a menu list under
> that which would be used to allow people to enable things like:
> CONFIG_4XX_ECC, CONFIG_FSL_ECC, etc.

Agreed.

> Why is there a need to have so many files?  I would think you could
> have a single file with all the ECC monitoring implementations in it
> called ppc4xx_ecc.c (or such).  Surely they would share some amount
> of code?

Well, it depends how much they share, but I'd rather have separate files
with helpers in ppc4xx_soc.c if it's small, that way, it's easier to
only build selected files based on what SoC support is enabled.

Cheers,
Ben.
