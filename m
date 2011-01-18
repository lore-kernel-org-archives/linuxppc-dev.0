Return-Path: <meador_inge@mentor.com>
Message-ID: <4D34EB06.9040908@mentor.com>
Date: Mon, 17 Jan 2011 19:21:10 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Stuart Yoder <stuart.yoder@freescale.com>
Subject: Re: [PATCH] define binding for fsl mpic interrupt controllers
References: <1295306382-3246-1-git-send-email-stuart.yoder@freescale.com>
	<AANLkTim5i89k4OpUBWw0UgMoa5vwN5eSZ1MCs34S0VXB@mail.gmail.com>
In-Reply-To: <AANLkTim5i89k4OpUBWw0UgMoa5vwN5eSZ1MCs34S0VXB@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Meador Inge <meador_inge@mentor.com>, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stuart,

> From: Stuart Yoder<stuart.yoder@freescale.com>
>
> define the binding for compatible = "fsl,mpic", including
> the definition of 4-cell interrupt specifiers.  The
> 3rd and 4th cells are needed to define additional
> types of interrupt source outside the "normal"
> external and internal interrupts in FSL SoCs.  Define
> error interrupt, IPIs, and PIC timer sources.

Recently I posted an RFC concerning a binding for the MPIC [1].  I also 
submitted a patch based on that feedback today (patch subject '[PATCH 
1/2] powerpc: document the MPIC device tree binding').  You provide much 
more information concerning the interrupt sources and how interrupt 
specifiers are encoded.  I had a few more properties listed: 'name', 
'device_type', 'protected-sources', and 'no-reset'.  The 'no-reset' 
property is a proposed addition to the binding, the others are already 
in use.

Perhaps we should merge the proposals?

[1] http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-December/087644.html

> Signed-off-by: Stuart Yoder<stuart.yoder@freescale.com>
> ---
>   Documentation/powerpc/dts-bindings/fsl/mpic.txt |  158 +++++++++++++++++------
>   1 files changed, 116 insertions(+), 42 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/mpic.txt
> b/Documentation/powerpc/dts-bindings/fsl/mpic.txt
> index 71e39cf..e1fe67c 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/mpic.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/mpic.txt
> @@ -1,42 +1,116 @@
> -* OpenPIC and its interrupt numbers on Freescale's e500/e600 cores
> -
> -The OpenPIC specification does not specify which interrupt source has to
> -become which interrupt number. This is up to the software implementation
> -of the interrupt controller. The only requirement is that every
> -interrupt source has to have an unique interrupt number / vector number.
> -To accomplish this the current implementation assigns the number zero to
> -the first source, the number one to the second source and so on until
> -all interrupt sources have their unique number.
> -Usually the assigned vector number equals the interrupt number mentioned
> -in the documentation for a given core / CPU. This is however not true
> -for the e500 cores (MPC85XX CPUs) where the documentation distinguishes
> -between internal and external interrupt sources and starts counting at
> -zero for both of them.
> -
> -So what to write for external interrupt source X or internal interrupt
> -source Y into the device tree? Here is an example:
> -
> -The memory map for the interrupt controller in the MPC8544[0] shows,
> -that the first interrupt source starts at 0x5_0000 (PIC Register Address
> -Map-Interrupt Source Configuration Registers). This source becomes the
> -number zero therefore:
> - External interrupt 0 = interrupt number 0
> - External interrupt 1 = interrupt number 1
> - External interrupt 2 = interrupt number 2
> - ...
> -Every interrupt number allocates 0x20 bytes register space. So to get
> -its number it is sufficient to shift the lower 16bits to right by five.
> -So for the external interrupt 10 we have:
> -  0x0140>>  5 = 10
> -
> -After the external sources, the internal sources follow. The in core I2C
> -controller on the MPC8544 for instance has the internal source number
> -27. Oo obtain its interrupt number we take the lower 16bits of its memory
> -address (0x5_0560) and shift it right:
> - 0x0560>>  5 = 43
> -
> -Therefore the I2C device node for the MPC8544 CPU has to have the
> -interrupt number 43 specified in the device tree.
> -
> -[0] MPC8544E PowerQUICCTM III, Integrated Host Processor Family
> Reference Manual
> -    MPC8544ERM Rev. 1 10/2007
> +=====================================================================
> +Freescale MPIC Interrupt Controller Node
> +Copyright (C) 2010,2011 Freescale Semiconductor Inc.
> +=====================================================================
> +
> +The Freescale MPIC interrupt controller is found on all PowerQUICC
> +and QorIQ processors and is compatible with the Open PIC.  The
> +notable difference from Open PIC binding is the addition of 2
> +additional cells in the interrupt specifier defining interrupt type
> +information.
> +
> +PROPERTIES
> +
> +  - compatible
> +      Usage: required
> +      Value type:<string>
> +      Definition: Shall include "fsl,mpic".  Freescale MPIC
> +      controlers compatible with this binding have Block
> +      Revision Registers BRR1 and BRR2 at offset 0x0 and
> +      0x10 in the MPIC.
> +
> +  - reg
> +      Usage: required
> +      Value type:<prop-encoded-array>
> +      Definition: A standard property.  Specifies the physical
> +          offset and length of the device's registers within the
> +          CCSR address space.
> +
> +  - interrupt-controller
> +      Usage: required
> +      Value type:<empty>
> +      Definition: Specifies that this node is an interrupt
> +      controller
> +
> +  - #interrupt-cells
> +      Usage: required
> +      Value type:<u32>
> +      Definition: Shall be 2 or 4.  A value of 2 means that interrupt
> +      specifiers do not contain the interrupt-type or type-specific
> +      information cells.
> +
> +  - #address-cells
> +      Usage: required
> +      Value type:<u32>
> +      Definition: Shall be 0.
> +
> +INTERRUPT SPECIFIER DEFINITION
> +
> +  Interrupt specifiers consists of 4 cells encoded as
> +  follows:
> +
> +<1st-cell>      interrupt-number
> +
> +                 Identifies the interrupt source.  The MPIC
> +                 contains a block of registers referred
> +                 to as the "Interrupt Source Configuration
> +                 Registers".  Each source has 32-bytes of
> +                 registers (vector/priority and destination)
> +                 in this region.   So interrupt 0 is at
> +                 offset 0x0, interrupt 1 is at offset 0x20,
> +                 and so on.
> +
> +<2nd-cell>      level-sense information, encoded as follows:
> +                    0 = low-to-high edge triggered
> +                    1 = active low level-sensitive
> +                    2 = active high level-sensitive
> +                    3 = high-to-low edge triggered
> +
> +<3rd-cell>     interrupt-type
> +
> +                The following types are supported:
> +
> +                  0 = external or normal SoC device interrupt
> +
> +                      The interrupt-number field contains
> +                      the SoC device interrupt number.  The
> +                      type-specific cell is undefined.
> +
> +                  1 = error interrupt
> +
> +                      The interrupt-number field contains
> +                      the SoC device interrupt number for
> +                      the error interrupt.  The type-specific
> +                      cell identifies the specific error
> +                      interrupt number.
> +
> +                  2 = MPIC inter-processor interrupt (IPI)
> +
> +                      The interrupt-number field identifies
> +                      the MPIC IPI number.  The type-specific
> +                      cell is undefined.
> +
> +                  3 = MPIC timer interrupt
> +
> +                      The interrupt-number field identifies
> +                      the MPIC timer number.  The type-specific
> +                      cell is undefined.
> +
> +<4th-cell>     type-specific information
> +
> +                The type-specific cell is encoded as follows:
> +
> +                 - For interrupt-type 1 (error interrupt),
> +                   the type-specific field contains the
> +                   bit number of the error interrupt in the
> +                   Error Interrupt Summary Register.
> +
> +EXAMPLE
> +
> +       mpic: pic@40000 {
> +           compatible = "fsl,mpic";
> +           interrupt-controller;
> +           #interrupt-cells =<4>;
> +           #address-cells =<0>;
> +           reg =<0x40000 0x40000>;
> +       };
> --
> 1.7.2.2
>
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>
>


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
