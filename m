Return-Path: <jwboyer@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 7425EDDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 07:22:14 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so595360eyi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Dec 2008 12:22:07 -0800 (PST)
Date: Mon, 8 Dec 2008 15:21:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: PPC4xx ECC Configs, Defines and Source
Message-ID: <20081208202152.GA10929@yoda.jdub.homelinux.org>
References: <C562B54F.1351E%gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C562B54F.1351E%gerickson@nuovations.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 08, 2008 at 11:28:15AM -0800, Grant Erickson wrote:
>Does anyone have any strong preferences on where configurations, definitions
>and sources for a PPC4xx ECC monitoring and reporting driver should go?
>
>Specifically, this concerns ECC handling code for the IBM DDR2 ECC
>controller found in the 405EX[r], 440SP, 440SPe, 460EX and 460GT. However,
>I'd like to do this in a way that other ECC contributors and maintainers can
>build on.
>
>Static Configs
>--------------
>
>I thought I might leverage the definitions Stefan Roese came up with for
>u-boot for the base memory controller:
>
>    CONFIG_PPC4xx_IBM_SDRAM:   Applicable to 405GP, 405CR, 405EP, AP1000,
>                               and ML2
>    CONFIG_PPC4xx_IBM_DDR:     Applicable to 440GP, 440GX, 440EP, and 440GR
>    CONFIG_PPC4xx_DENALI_DDR2: Applicable to 440EPX and 440GRX
>    CONFIG_PPC4xx_IBM_DDR2:    Applicable to 405EX[r], 440SP, 440SPe, 460EX
>                               and 460GT.

Config options for what?  Enabling certain function?  Not sure that's needed
if we can get away with it by just binding to the appropriate controller.

>Controlling whether ECC monitoring and reporting support should be compiled
>in or a module:
>
>    CONFIG_PPC_ECC or CONFIG_ECC

That's a bit too generic, unless you are trying to make a menu list under
that which would be used to allow people to enable things like:
CONFIG_4XX_ECC, CONFIG_FSL_ECC, etc.

>Dynamic Configs
>---------------
>Though, it appears that rainier.dts and sequioia.dts are already evolving in
>this direction with:
>
>    compatible = "ibm,sdram-440grx", "ibm,sdram-44x-ddr2denali";
>    compatible = "ibm,sdram-440epx", "ibm,sdram-44x-ddr2denali";
>
>In light of that, perhaps then:
>
>    compatible = "...", "ibm,sdram-4xx";
>    compatible = "...", "ibm,sdram-4xx-ddr";
>    compatible = "...", "ibm,sdram-4xx-ddr2";
>    compatible = "...", "ibm,sdram-4xx-ddr2denali";

These look better than the first list.  We'll probably have to redefine
some of the existing dts file mappings.

>Source
>------
>
>    arch/powerpc/sysdev/
>        ppc4xx_ibm_sdram_ecc.c [future]
>        ppc4xx_ibm_ddr_ecc.c [future]
>        ppc4xx_ibm_ddr2_ecc.c
>        ppc4xx_ibm_ddr2denali_ecc.c [future]

Why is there a need to have so many files?  I would think you could
have a single file with all the ECC monitoring implementations in it
called ppc4xx_ecc.c (or such).  Surely they would share some amount
of code?

>Headers and Defines
>-------------------
>
>    arch/powerpc/include/asm/ppc4xx_ibm_ddr2.h
>
>    OR
>
>    arch/powerpc/sysdev/ppc4xx_ibm_ddr2.h

That depends on the contents of the file.  If it's DCR defines, etc
it should be in the dcr-regs.h file.  Otherwise, I would think having
the header in sysdev should be sufficient unless there is some other
facility that would need whatever the contents there are.

josh
