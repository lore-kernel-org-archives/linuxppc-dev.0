Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 60FE22C012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 03:04:46 +1000 (EST)
Message-ID: <524074A7.7000001@wwwdotorg.org>
Date: Mon, 23 Sep 2013 11:04:39 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v10 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
References: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
 <1379499333-4745-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1379499333-4745-3-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, vinod.koul@intel.com, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/18/2013 04:15 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch adds
> the device tree nodes for them.

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt

> +Required properties:
> +
> +- compatible        : must include "fsl,elo3-dma"
> +- reg               : DMA General Status Registers, i.e. DGSR0 which contains
> +                      status for channel 1~4, and DGSR1 for channel 5~8

Is that a single entry, which is large enough to cover both registers,
or a pair of entries, one per register? Reading the text, I might assume
the former, but looking at the examples, it's the latter.

...
 +Example:
> +dma@100300 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "fsl,elo3-dma";
> +	reg = <0x100300 0x4>,
> +	      <0x100600 0x4>;
