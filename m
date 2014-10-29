Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466EA1A04EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 08:18:23 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53E6114003E
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2014 08:18:20 +1100 (AEDT)
Message-ID: <54515921.1080804@Freescale.com>
Date: Wed, 29 Oct 2014 16:16:17 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
References: <1414487751-31568-1-git-send-email-Emilian.Medve@Freescale.com>
 <1414487751-31568-2-git-send-email-Emilian.Medve@Freescale.com>
 <5DC63911-AD43-4EDA-8675-8A28EDC3F491__16064.0273978517$1414507192$gmane$org@codeaurora.org>
In-Reply-To: <5DC63911-AD43-4EDA-8675-8A28EDC3F491__16064.0273978517$1414507192$gmane$org@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 corbet@lwn.net, Geoff.Thorpe@Freescale.com, ijc+devicetree@hellion.org.uk,
 linux-doc@vger.kernel.org, scottwood@Freescale.com, linuxppc-dev@ozlabs.org,
 robh+dt@kernel.org, grant.likely@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,


Thanks for taking the time to review this

On 10/28/2014 09:39 AM, Kumar Gala wrote:
> On Oct 28, 2014, at 4:15 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
>> The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
>> BMan supports hardware allocation and deallocation of buffers belonging to
>> pools originally created by software with configurable depletion thresholds.
>> This binding covers the CCSR space programming model
>>
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
>> ---
>> .../devicetree/bindings/powerpc/fsl/bman.txt       | 95 ++++++++++++++++++++++
>> 1 file changed, 95 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> 
> Should these really be in bindings/powerpc/fsl, aren’t you guys using this on ARM SoCs as well?

We do, however, I didn't have any exposure yet to how the DPAA was
integrated there. From what I hear the biggest difference is in the
IOMMU area. Upstreaming the DPAA has been long overdue and I'd like to
make some progress with it as is on the PowerPC SoC(s)

> I can’t remember if the TI guys had a HW allocator as part of their
> similar HW. If so, possibly worth while to see where they have their
> binding.

Seems their data-path bindings are in
Documentation/devicetree/bindings/soc. I can move the B/QMan there and
it would level the way for the ARM SoC(s) with the DPAA

>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/bman.txt b/Documentation/devicetree/bindings/powerpc/fsl/bman.txt
>> new file mode 100644
>> index 0000000..d3fd1e3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/bman.txt
>> @@ -0,0 +1,95 @@
>> +QorIQ DPAA Buffer Manager Device Tree Bindings
>> +
>> +Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
>> +
>> +CONTENTS
>> +
>> +	- BMan Node
>> +	- BMan Private Memory Node
>> +	- Example
>> +
>> +BMan Node
>> +
>> +PROPERTIES
>> +
>> +- compatible
>> +	Usage:		Required
>> +	Value type:	<stringlist>
>> +	Definition:	Must include "fsl,bman"
>> +			May include "fsl,<SoC>-bman"
>> +
>> +- reg
>> +	Usage:		Required
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	Registers region within the CCSR address space
>> +
>> +- interrupts
>> +	Usage:		Required
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	Standard property. The error interrupt
>> +
>> +- fsl,liodn
>> +	Usage:		See pamu.txt
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	PAMU property used for static LIODN assignment
>> +
>> +- fsl,iommu-parent
>> +	Usage:		See pamu.txt
>> +	Value type:	<phandle>
>> +	Definition:	PAMU property used for dynamic LIODN assignment
>> +
>> +	For additional details about the PAMU/LIODN binding(s) see pamu.txt
>> +
>> +BMan Private Memory Node
>> +
>> +BMan requires a contiguous range of physical memory used for the backing store
>> +for BMan Free Buffer Proxy Records. This memory is reserved/allocated as a node
> 
> … Proxy Records (FBPR).  This
> 
> [ so we get context for the acronym used later ]

Will do

>> +under the /reserved-memory node
>> +
>> +The BMan FBPR memory node must be named "bman-fbpr"
>> +
>> +PROPERTIES
>> +
>> +- compatible
>> +	Usage:		required
>> +	Value type:	<stringlist>
>> +	Definition:	Must inclide "fsl,bman-fbpr"
>> +
>> +The following constraints are relevant to the FBPR private memory:
>> +	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB to
>> +	  16 GiB
>> +	- The alignment must be a muliptle of the memory size
>> +
>> +The size of the FBPR must be chosen by observing the hardware features configured
>> +via the RCW and that are relevant to a specific board (e.g. number of MAC(s)
>> +pinned-out, number of offline/host command FMan ports, etc.). The size configured
>> +in the DT must reflect the hardware capabilities and not the specific needs of an
>> +application
> 
> RCW doesn’t have any context here

Will expand it

>> +For additional details about reserved memory regions see reserved-memory.txt
>> +
>> +EXAMPLE
>> +
>> +The example below shows a BMan FBPR dynamic allocation memory node
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		bman-fbpr {
>> +			compatible = "fsl,bman-fbpr";
>> +			alloc-ranges = <0 0 0xf 0xffffffff>;
>> +			size = <0 0x1000000>;
>> +			alignment = <0 0x1000000>;
>> +		};
>> +	};
>> +
>> +The example below shows a (P4080) BMan CCSR-space node
>> +
>> +	bman@31a000 {
>> +		compatible = "fsl,bman";
>> +		reg = <0x31a000 0x1000>;
>> +		interrupts = <16 2 1 2>;
>> +		fsl,liodn = <0x17>;
> 
> no fsl,iommu-parent in the example?

Using the PAMU/IOMMU topology (for dynamic LIODN allocation) is not
working yet in the PAMU driver (not even programming only the parent
PAMU with the static LIODN from the node) so I'm not quite in the habit
of sprinkling those around. I'll add them into the examples

>> +	};
> 
> Do you not need a phandle between the bman and the memory node?

Nope. And I'm thinking two reasons: (1) (if it gets to it) unique
compatible(s) for the reserved-memory nodes and (2)
RESERVEDMEM_OF_DECLARE() takes care to connect the dots based on said
compatible(s)


Cheers,
