Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A85BE1A1773
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 07:07:12 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0105.outbound.protection.outlook.com [157.56.110.105])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 32E5E14007F
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2014 07:07:10 +1100 (AEDT)
Message-ID: <54480DF8.3070604@Freescale.com>
Date: Wed, 22 Oct 2014 15:05:12 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/4] dt/bindings: Introduce the FSL QorIQ DPAA QMan
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <1413986972-621-3-git-send-email-Emilian.Medve@Freescale.com>
 <20141022143732.GB4010@leverpostej>
In-Reply-To: <20141022143732.GB4010@leverpostej>
Content-Type: text/plain; charset="windows-1252"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "Geoff.Thorpe@freescale.com" <Geoff.Thorpe@Freescale.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "scottwood@freescale.com" <scottwood@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mark,


On 10/22/2014 09:37 AM, Mark Rutland wrote:
> On Wed, Oct 22, 2014 at 03:09:31PM +0100, Emil Medve wrote:
>> The Queue Manager is part of the Data-Path Acceleration Architecture (DPAA).
>> QMan supports queuing and QoS scheduling of frames to CPUs, network interfaces
>> and DPAA logic modules, maintains packet ordering within flows. Besides
>> providing flow-level queuing, is also responsible for congestion management
>> functions such as RED/WRED, congestion notifications and tail discards. This
>> binding covers the CCSR space programming model
>>
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> Change-Id: I3acb223893e42003d6c9dc061db568ec0b10d29b
>> ---
>>  .../devicetree/bindings/powerpc/fsl/qman.txt       | 134 +++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/qman.txt
>>
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/qman.txt b/Documentation/devicetree/bindings/powerpc/fsl/qman.txt
>> new file mode 100644
>> index 0000000..b9f288f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/qman.txt
>> @@ -0,0 +1,134 @@
>> +QorIQ DPAA Queue Manager Device Tree Binding
>> +
>> +Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
>> +
>> +CONTENTS
>> +
>> +	- QMan Node
>> +	- QMan Private Memory Nodes
>> +	- Example
>> +
>> +NOTE:	The bindings described in this document are preliminary and subject to
>> +	change
> 
> As with the BMan portal binding, I'm rather uncomfortable with a
> preliminary binding.

Ditto

>> +
>> +QMan Node
>> +
>> +PROPERTIES
>> +
>> +- compatible
>> +	Usage:		Required
>> +	Value type:	<stringlist>
>> +	Definition:	Must include "fsl,qman"
>> +			May include "fsl,<SoC>-qman"
>> +
>> +- reg
>> +	Usage:		Required
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	Registers region within the CCSR address space
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
> 
> This is not present in the example. Is this always required?

Sort of. Initial hardware (and current documentation) programming
suggestion was to configure all the PAMU instances the same way
regardless of what devices were behind them. Given the PAMU internal
caches sizes, this proved suboptimal from a performance perspective so
we're trying to discover/describe/use the PAMU topology

fsl,liodn is part of the undocumented static LIODN assignment binding
that the current PAMU driver uses. If fsl,iommu-parent is present,
fsl,liodn can be ignored and the LIODN can be assigned dynamically
and/or programmed only in the relevant PAMU instance

>> +
>> +- clocks
>> +	Usage:		See clock-bindings.txt and qoriq-clock.txt
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	Half of the platform clock
>> +
> 
> I don't understand the description here. What is the clock from the PoV
> of the QMan? Which input line on the QMan is this clock attached to?
> 
> Is there only one clock input? Or jsut one that you need to manage at
> the moment?

As part of the programming model (QoS features specifically) QMan needs
to know its clock speed. Prior to the existence of the
clock-bindings.txt, a "static" clock-frequency property was/is used
convey such information. Using clock-binding.txt to describe the
clocking hierarchy in the SoC makes it easier with DFS, power
management, etc.

The platform clock/PLL binding is part of qoriq-clock.txt

> You also seem to have an interrupt in the example. How many do you
> expect, and what are their their logical functions?

That's the error interrupt and hopefully it never triggers. I didn't add
[many] words about it as it's a standard property

>> +QMan Private Memory Nodes
>> +
>> +QMan requires two contiguous range of physical memory used for the backing store
>> +for QMan Frame Queue Descriptor and Packed Frame Descriptor Record. This memory
>> +is reserved/allocated as a nodes under the /reserved-memory node
>> +
>> +The QMan FQD memory node must be named "qman-fqd"
>> +
>> +PROPERTIES
>> +
>> +- compatible
>> +	Usage:		required
>> +	Value type:	<stringlist>
>> +	Definition:	Must inclide "fsl,qman-fqd"
>> +
>> +The QMan PFDR memory node must be named "qman-pfdr"
>> +
>> +PROPERTIES
>> +
>> +- compatible
>> +	Usage:		required
>> +	Value type:	<stringlist>
>> +	Definition:	Must inclide "fsl,qman-pfdr"
>> +
>> +The following constraints are relevant to the FQD and PFDR private memory:
>> +	- The size must be 2^(size + 1), with size = 11..29. That is 4 KiB to
>> +	  1 GiB
>> +	- The alignment must be a muliptle of the memory size
>> +
>> +The size of the FQD and PFDP must be chosen by observing the hardware features
>> +configured via the RCW and that are relevant to a specific board (e.g. number of
>> +MAC(s) pinned-out, number of offline/host command FMan ports, etc.). The size
>> +configured in the DT must reflect the hardware capabilities and not the specific
>> +needs of an application
>> +
>> +If the memory reserved in the device tree proves to be larger then the needs of
>> +the application a QMan driver may provide a method to release the extra memory
>> +back to the OS
> 
> Driver details should be unimportant to the binding. This sentence can
> disappear.

I'm trying to discourage reserved-memory nodes to be used to "optimize"
the memory allocation/usage. If it comes to it, I can drop this sentence


Cheers,


> Thanks,
> Mark.
> 
>> +
>> +For additional details about reserved memory regions see reserved-memory.txt
>> +
>> +EXAMPLE
>> +
>> +The example below shows a QMan FQD and a PFDR dynamic allocation memory nodes
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		qman-fqd {
>> +			compatible = "fsl,qman-fqd";
>> +			alloc-ranges = <0 0 0xf 0xffffffff>;
>> +			size = <0 0x400000>;
>> +			alignment = <0 0x400000>;
>> +		};
>> +		qman-pfdr {
>> +			compatible = "fsl,qman-pfdr";
>> +			alloc-ranges = <0 0 0xf 0xffffffff>;
>> +			size = <0 0x2000000>;
>> +			alignment = <0 0x2000000>;
>> +		};
>> +	};
>> +
>> +The example below shows a (P4080) QMan CCSR-space node
>> +
>> +	clockgen: global-utilities@e1000 {
>> +		...
>> +		sysclk: sysclk {
>> +			...
>> +		};
>> +		...
>> +		platform-pll: platform-pll@c00 {
>> +			#clock-cells = <1>;
>> +			reg = <0xc00 0x4>;
>> +			compatible = "fsl,qoriq-platform-pll-1.0";
>> +			clocks = <&sysclk>;
>> +			clock-output-names = "platform-pll", "platform-pll-div2";
>> +		};
>> +		...
>> +	};
>> +
>> +	qman@318000 {
>> +		compatible = "fsl,qman";
>> +		reg = <0x318000 0x1000>;
>> +		interrupts = <16 2 1 3>
>> +		fsl,liodn = <0x16>;
>> +		clocks = <&platform-pll 1>;
>> +	};
>> -- 
>> 2.1.2
