Return-Path: <mark.rutland@arm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 115FC1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 01:30:10 +1100 (AEDT)
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 3E37214007B
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2014 01:30:08 +1100 (AEDT)
Date: Wed, 22 Oct 2014 15:29:31 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [PATCH 2/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
 portal(s)
Message-ID: <20141022142931.GA4010@leverpostej>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <1413986972-621-2-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413986972-621-2-git-send-email-Emilian.Medve@Freescale.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "Geoff.Thorpe@freescale.com" <Geoff.Thorpe@freescale.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2014 at 03:09:30PM +0100, Emil Medve wrote:
> Portals are used by software running on processor cores, accelerators and
> network interfaces to communicate with the BMan

What exactly is a portal?

Is it a region of shared memory? A device?

I only received emails 2 and 3 of this series, so I'm lacking the
context necessary to understand the bindings.

> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Change-Id: I6d245ffc14ba3d0e91d403ac7c3b91b75a9e6a95
> ---
>  .../bindings/powerpc/fsl/bman-portals.txt          | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt b/Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
> new file mode 100644
> index 0000000..40e607e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
> @@ -0,0 +1,50 @@
> +QorIQ DPAA Buffer Manager Portals Device Tree Binding
> +
> +Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
> +
> +CONTENTS
> +
> +	- BMan Portal
> +	- Example
> +
> +NOTE:	The bindings described in this document are preliminary and subject to
> +	change

While we've tried that elsewhere, unstable DT bindings have been shown
to be a major source of pain. I'd feel rather uncomfortable accepting a
binding that we already believe to be insufficient to describe the
hardware.

What do you expect to change?

> +
> +BMan Portal Node
> +
> +PROPERTIES
> +
> +- compatible
> +	Usage:		Required
> +	Value type:	<stringlist>
> +	Definition:	Must include "fsl,bman-portal-<hardware revision>"
> +			May include "fsl,<SoC>-bman-portal" or "fsl,bman-portal"
> +
> +- reg
> +	Usage:		Required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Two regions. The first is the cache-enabled region of
> +			the portal. The second is the cache-inhibited region of
> +			the portal
> +
> +EXAMPLE
> +
> +The example below shows a (P4080) BMan portals container/bus node with two portals

Is there any particular reason to place these under a simple-bus?

> +
> +	bman-portals@ff4000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges = <0 0xf 0xf4000000 0x200000>;
> +
> +		bman-portal@0 {
> +			compatible = "fsl,bman-portal-1.0.0", "fsl,bman-portal";
> +			reg = <0x0 0x4000 0x100000 0x1000>;

It would be easier to read is each entry had its own set of brackets.
Initially this looked to me like a single 64-bit address/size pair.

> +			interrupts = <105 2 0 0>;
> +		};

Given the description above, surely you need to know what the portal is
used for? Or is that queried from the portal?

Thanks,
Mark.

> +		bman-portal@4000 {
> +			compatible = "fsl,bman-portal-1.0.0", "fsl,bman-portal";
> +			reg = <0x4000 0x4000 0x101000 0x1000>;
> +			interrupts = <107 2 0 0>;
> +		};
> +	};
> -- 
> 2.1.2
> 
> 
