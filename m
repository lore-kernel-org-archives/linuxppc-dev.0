Return-Path: <leoyang.li@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0076.outbound.protection.outlook.com [104.47.0.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xylhB0pBwzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 04:36:54 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>
CC: "oss@buserror.net" <oss@buserror.net>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "arnd@arndb.de"
 <arnd@arndb.de>, Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: RE: [v5 04/12] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
Date: Thu, 21 Sep 2017 18:36:47 +0000
Message-ID: <AM4PR0401MB1699D419007FB551153BD9CD8F660@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Roy Pledge [mailto:roy.pledge@nxp.com]
> Sent: Monday, September 18, 2017 3:40 PM
> To: Leo Li <leoyang.li@nxp.com>; linuxppc-dev@lists.ozlabs.org; linux-arm=
-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: oss@buserror.net; Madalin-cristian Bucur <madalin.bucur@nxp.com>;
> catalin.marinas@arm.com; linux@armlinux.org.uk; arnd@arndb.de;
> mark.rutland@arm.com; Roy Pledge <roy.pledge@nxp.com>
> Subject: [v5 04/12] dt-bindings: soc/fsl: Update reserved memory binding =
for
> QBMan
>=20
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatible with
> the shared-dma-pool usage.
>=20
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Hi Rob and Mark,

Would you help to review this binding patch and ACK if it is ok?

Regards,
Leo

> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++++++++++++++=
-
> -----
>  2 files changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> index 47ac834..48eed14 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> @@ -65,8 +65,8 @@ to the respective BMan instance
>  BMan Private Memory Node
>=20
>  BMan requires a contiguous range of physical memory used for the backing
> store
> -for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/alloc=
ated
> as a
> -node under the /reserved-memory node
> +for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/alloc=
ated
> as
> +a node under the /reserved-memory node.
>=20
>  The BMan FBPR memory node must be named "bman-fbpr"
>=20
> @@ -75,7 +75,9 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,bman-fbpr"
> +	Definition:	PPC platforms: Must include "fsl,bman-fbpr"
> +			ARM platforms: Must include "shared-dma-pool"
> +				       as well as the "no-map" property
>=20
>  The following constraints are relevant to the FBPR private memory:
>  	- The size must be 2^(size + 1), with size =3D 11..33. That is 4 KiB to
> @@ -100,10 +102,10 @@ The example below shows a BMan FBPR dynamic
> allocation memory node
>  		ranges;
>=20
>  		bman_fbpr: bman-fbpr {
> -			compatible =3D "fsl,bman-fbpr";
> -			alloc-ranges =3D <0 0 0x10 0>;
> +			compatible =3D "shared-mem-pool";
>  			size =3D <0 0x1000000>;
>  			alignment =3D <0 0x1000000>;
> +			no-map;
>  		};
>  	};
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/qman.txt
> b/Documentation/devicetree/bindings/soc/fsl/qman.txt
> index 556ebb8..ee96afd 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/qman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/qman.txt
> @@ -60,6 +60,12 @@ are located at offsets 0xbf8 and 0xbfc
>  	Value type:	<prop-encoded-array>
>  	Definition:	Reference input clock. Its frequency is half of the
>  			platform clock
> +- memory-regions
> +	Usage:		Required for ARM
> +	Value type:	<phandle array>
> +	Definition:	List of phandles referencing the QMan private memory
> +			nodes (described below). The qman-fqd node must be
> +			first followed by qman-pfdr node. Only used on ARM
>=20
>  Devices connected to a QMan instance via Direct Connect Portals (DCP) mu=
st
> link
>  to the respective QMan instance
> @@ -74,7 +80,9 @@ QMan Private Memory Nodes
>=20
>  QMan requires two contiguous range of physical memory used for the backi=
ng
> store
>  for QMan Frame Queue Descriptor (FQD) and Packed Frame Descriptor Record
> (PFDR).
> -This memory is reserved/allocated as a nodes under the /reserved-memory
> node
> +This memory is reserved/allocated as a node under the /reserved-memory
> node.
> +
> +For additional details about reserved memory regions see reserved-memory=
.txt
>=20
>  The QMan FQD memory node must be named "qman-fqd"
>=20
> @@ -83,7 +91,9 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,qman-fqd"
> +	Definition:	PPC platforms: Must include "fsl,qman-fqd"
> +			ARM platforms: Must include "shared-dma-pool"
> +				       as well as the "no-map" property
>=20
>  The QMan PFDR memory node must be named "qman-pfdr"
>=20
> @@ -92,7 +102,9 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,qman-pfdr"
> +	Definition:	PPC platforms: Must include "fsl,qman-pfdr"
> +			ARM platforms: Must include "shared-dma-pool"
> +				       as well as the "no-map" property
>=20
>  The following constraints are relevant to the FQD and PFDR private memor=
y:
>  	- The size must be 2^(size + 1), with size =3D 11..29. That is 4 KiB to
> @@ -117,16 +129,16 @@ The example below shows a QMan FQD and a PFDR
> dynamic allocation memory nodes
>  		ranges;
>=20
>  		qman_fqd: qman-fqd {
> -			compatible =3D "fsl,qman-fqd";
> -			alloc-ranges =3D <0 0 0x10 0>;
> +			compatible =3D "shared-dma-pool";
>  			size =3D <0 0x400000>;
>  			alignment =3D <0 0x400000>;
> +			no-map;
>  		};
>  		qman_pfdr: qman-pfdr {
> -			compatible =3D "fsl,qman-pfdr";
> -			alloc-ranges =3D <0 0 0x10 0>;
> +			compatible =3D "shared-dma-pool";
>  			size =3D <0 0x2000000>;
>  			alignment =3D <0 0x2000000>;
> +			no-map;
>  		};
>  	};
>=20
> --
> 2.7.4
