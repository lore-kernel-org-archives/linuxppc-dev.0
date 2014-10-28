Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B6CE1A00E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 05:43:33 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C056140077
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2014 05:43:31 +1100 (AEDT)
Message-ID: <1414520877.23458.97.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/4] dt/bindings: Introduce the FSL QorIQ DPAA QMan
 portal(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 28 Oct 2014 13:27:57 -0500
In-Reply-To: <1413986972-621-4-git-send-email-Emilian.Medve@Freescale.com>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <1413986972-621-4-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 galak@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-22 at 09:09 -0500, Emil Medve wrote:
> +- fsl,liodn
> +	Usage:		See pamu.txt
> +	Value type:	<prop-encoded-array>
> +	Definition:	PAMU property used for static LIODN assignment

There are two LIODNs on these nodes; you need to specifiy here which is
which.  Likewise on the crypto subnode.

> +The currently support sub-nodes are:
> +	* fman@0
> +	* fman@1
> +	* pme@0
> +	* crypto@0

s/support/supported/

> +These subnodes should have the following properties:
> +
> +- fsl,liodn
> +	Usage:		See pamu.txt
> +	Value type:	<prop-encoded-array>
> +	Definition:	PAMU property used for static LIODN assignment
> +
> +- fsl,iommu-parent
> +	Usage:		See pamu.txt
> +	Value type:	<phandle>
> +	Definition:	PAMU property used for dynamic LIODN assignment
> +
> +- dev-handle
> +	Usage:		Required
> +	Value type:	<phandle>
> +	Definition:	The phandle to the particular hardware device that this
> +			portal is connected to.
> +
> +DPAA QMan Pool Channel Nodes
> +
> +Pool Channels are defined with the following properties.
> +
> +PROPERTIES
> +
> +- compatible
> +	Usage:		Required
> +	Value type:	<stringlist>
> +	Definition:	Must include "fsl,qman-pool-channel"
> +			May include "fsl,<SoC>-qman-pool-channel"
> +
> +- fsl,qman-channel-id
> +	Usage:		Required
> +	Value type:	<u32>
> +	Definition:	The hardware index of the channel. This can also be
> +			determined by dividing any of the channel's 8 work queue
> +			IDs by 8
> +
> +EXAMPLE
> +
> +The example below shows a (P4080) BMan portals container/bus node with two portals
> +
> +	qman-portals@ff4200000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges = <0 0xf 0xf4200000 0x200000>;
> +
> +		qman-portal@0 {
> +			cell-index = <0>;
> +			compatible = "fsl,qman-portal-1.2.0", "fsl,qman-portal";
> +			reg = <0 0x4000 0x100000 0x1000>;
> +			interrupts = <104 2 0 0>;
> +			fsl,liodn = <1 2>;
> +			fsl,qman-channel-id = <0>;
> +
> +			fman@0 {
> +				fsl,liodn = <0x21>;
> +				dev-handle = <&fman0>;
> +			};
> +			fman@1 {
> +				fsl,liodn = <0xa1>;
> +				dev-handle = <&fman1>;
> +			};
> +			crypto@0 {
> +				fsl,liodn = <0x41 0x66>;
> +				dev-handle = <&crypto>;
> +			};

Shouldn't have unit address without reg; use fman0/fman1/crypto instead.

-Scott
