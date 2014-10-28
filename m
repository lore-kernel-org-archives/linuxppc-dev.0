Return-Path: <galak@codeaurora.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC1561A011A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 01:36:51 +1100 (AEDT)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DB59140077
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2014 01:36:51 +1100 (AEDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
Date: Tue, 28 Oct 2014 09:36:41 -0500
Message-Id: <EA33D307-CCDA-4A30-9386-46FA832FE0CA@codeaurora.org>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 scottwood@Freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 22, 2014, at 9:09 AM, Emil Medve <Emilian.Medve@freescale.com> =
wrote:

> The Buffer Manager is part of the Data-Path Acceleration Architecture =
(DPAA).
> BMan supports hardware allocation and deallocation of buffers =
belonging to
> pools originally created by software with configurable depletion =
thresholds.
> This binding covers the CCSR space programming model
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
> ---
> .../devicetree/bindings/powerpc/fsl/bman.txt       | 98 =
++++++++++++++++++++++
> 1 file changed, 98 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/bman.txt

Should these really be in bindings/powerpc/fsl, aren=92t you guys using =
this on ARM SoCs as well?

I can=92t remember if the TI guys had a HW allocator as part of their =
similar HW.

>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/bman.txt =
b/Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> new file mode 100644
> index 0000000..c30bdde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> @@ -0,0 +1,98 @@
> +QorIQ DPAA Buffer Manager Device Tree Bindings
> +
> +Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
> +
> +CONTENTS
> +
> +	- BMan Node
> +	- BMan Private Memory Node
> +	- Example
> +
> +NOTE:	The bindings described in this document are preliminary =
and subject to
> +	change
> +
> +BMan Node
> +
> +PROPERTIES
> +
> +- compatible
> +	Usage:		Required
> +	Value type:	<stringlist>
> +	Definition:	Must include "fsl,bman"
> +			May include "fsl,<SoC>-bman"
> +
> +- reg
> +	Usage:		Required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Registers region within the CCSR address space
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
> +	For additional details about the PAMU/LIODN binding(s) see =
pamu.txt
> +

interrupts should be in this list.

> +BMan Private Memory Node
> +
> +BMan requires a contiguous range of physical memory used for the =
backing store
> +for BMan Free Buffer Proxy Records. This memory is reserved/allocated =
as a node
> +under the /reserved-memory node
> +
> +The BMan FBPR memory node must be named "bman-fbpr"
> +
> +PROPERTIES
> +
> +- compatible
> +	Usage:		required
> +	Value type:	<stringlist>
> +	Definition:	Must inclide "fsl,bman-fbpr"
> +
> +The following constraints are relevant to the FBPR private memory:
> +	- The size must be 2^(size + 1), with size =3D 11..33. That is 4 =
KiB to
> +	  16 GiB
> +	- The alignment must be a muliptle of the memory size
> +
> +The size of the FBPR must be chosen by observing the hardware =
features configured
> +via the RCW and that are relevant to a specific board (e.g. number of =
MAC(s)
> +pinned-out, number of offline/host command FMan ports, etc.). The =
size configured
> +in the DT must reflect the hardware capabilities and not the specific =
needs of an
> +application

RCW doesn=92t have any context here

> +
> +If the memory reserved in the device tree proves to be larger then =
the needs of
> +the application a BMan driver may provide a method to release the =
extra memory
> +back to the OS
> +
> +For additional details about reserved memory regions see =
reserved-memory.txt
> +
> +EXAMPLE
> +
> +The example below shows a BMan FBPR dynamic allocation memory node
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		bman-fbpr {
> +			compatible =3D "fsl,bman-fbpr";
> +			alloc-ranges =3D <0 0 0xf 0xffffffff>;
> +			size =3D <0 0x1000000>;
> +			alignment =3D <0 0x1000000>;
> +		};
> +
> +	};
> +
> +The example below shows a (P4080) BMan CCSR-space node
> +
> +	bman@31a000 {
> +		compatible =3D "fsl,bman";
> +		reg =3D <0x31a000 0x1000>;
> +		interrupts =3D <16 2 1 2>;
> +		fsl,liodn =3D <0x17>;

no fsl,iommu-parent in the example?

> +	};

Do you not need a phandle between the bman and the memory node?

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora =
Forum,
a Linux Foundation Collaborative Project
