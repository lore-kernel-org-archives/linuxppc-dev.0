Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id 5BD97474C1
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 06:28:25 +1100 (EST)
Date: Mon, 08 Dec 2008 11:28:15 -0800
Subject: PPC4xx ECC Configs, Defines and Source
From: Grant Erickson <gerickson@nuovations.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Message-ID: <C562B54F.1351E%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone have any strong preferences on where configurations, definitions
and sources for a PPC4xx ECC monitoring and reporting driver should go?

Specifically, this concerns ECC handling code for the IBM DDR2 ECC
controller found in the 405EX[r], 440SP, 440SPe, 460EX and 460GT. However,
I'd like to do this in a way that other ECC contributors and maintainers can
build on.

Static Configs
--------------

I thought I might leverage the definitions Stefan Roese came up with for
u-boot for the base memory controller:

    CONFIG_PPC4xx_IBM_SDRAM:   Applicable to 405GP, 405CR, 405EP, AP1000,
                               and ML2
    CONFIG_PPC4xx_IBM_DDR:     Applicable to 440GP, 440GX, 440EP, and 440GR
    CONFIG_PPC4xx_DENALI_DDR2: Applicable to 440EPX and 440GRX
    CONFIG_PPC4xx_IBM_DDR2:    Applicable to 405EX[r], 440SP, 440SPe, 460EX
                               and 460GT.

Controlling whether ECC monitoring and reporting support should be compiled
in or a module:

    CONFIG_PPC_ECC or CONFIG_ECC

Dynamic Configs
---------------

It seems as though the DTS entries for SDRAM0: sdram { compatible = "..." }
would need to be expanded to include the above information as well were any
such ECC driver going to attempt to bind to the runtime DTS information.

Perhaps:

    compatible = "...", "ibm,sdram-4xx-sdram";
    compatible = "...", "ibm,sdram-4xx-ddr";
    compatible = "...", "ibm,sdram-4xx-ddr2";
    compatible = "...", "denali,sdram-4xx-ddr2";

Though, it appears that rainier.dts and sequioia.dts are already evolving in
this direction with:

    compatible = "ibm,sdram-440grx", "ibm,sdram-44x-ddr2denali";
    compatible = "ibm,sdram-440epx", "ibm,sdram-44x-ddr2denali";

In light of that, perhaps then:

    compatible = "...", "ibm,sdram-4xx";
    compatible = "...", "ibm,sdram-4xx-ddr";
    compatible = "...", "ibm,sdram-4xx-ddr2";
    compatible = "...", "ibm,sdram-4xx-ddr2denali";

Source
------

    arch/powerpc/sysdev/
        ppc4xx_ibm_sdram_ecc.c [future]
        ppc4xx_ibm_ddr_ecc.c [future]
        ppc4xx_ibm_ddr2_ecc.c
        ppc4xx_ibm_ddr2denali_ecc.c [future]

Headers and Defines
-------------------

    arch/powerpc/include/asm/ppc4xx_ibm_ddr2.h

    OR

    arch/powerpc/sysdev/ppc4xx_ibm_ddr2.h

Thoughts? Comments?

Regards,

Grant
