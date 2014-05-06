Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79C6F140E81
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 12:13:24 +1000 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1399305499-6612-1-git-send-email-diana.craciun@freescale.com>
Date: Mon, 5 May 2014 21:12:59 -0500
Message-Id: <1FE471CC-2024-4B39-89E2-FBACF8F18A9B@kernel.crashing.org>
References: <1399305499-6612-1-git-send-email-diana.craciun@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Cc: scottwood@freescale.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 5, 2014, at 10:58 AM, Diana Craciun <diana.craciun@freescale.com> =
wrote:

> From: Diana Craciun <Diana.Craciun@freescale.com>
>=20
> The CoreNet coherency fabric is a fabric-oriented, conectivity
> infrastructure that enables the implementation of coherent, multicore
> systems. The CCF acts as a central interconnect for cores,
> platform-level caches, memory subsystem, peripheral devices and I/O =
host
> bridges in the system.
>=20
> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> ---
> v3:
> 	- added port ID mapping
> 	- removed fsl,corenetx-cf
>=20
> .../devicetree/bindings/powerpc/fsl/ccf.txt        | 42 =
++++++++++++++++++++++
> .../devicetree/bindings/powerpc/fsl/cpus.txt       |  8 +++++
> .../devicetree/bindings/powerpc/fsl/pamu.txt       |  8 +++++
> 3 files changed, 58 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/ccf.txt

[snip]

> --- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> @@ -20,3 +20,11 @@ PROPERTIES
> 	a property named fsl,eref-[CAT], where [CAT] is the abbreviated =
category
> 	name with all uppercase letters converted to lowercase, =
indicates that
> 	the category is supported by the implementation.
> +
> +	- fsl,portid-mapping : <u32>
> +	The Coherency Subdomain ID Port Mapping Registers and Snoop ID =
Port Mapping
> +	registers which are part of the CoreNet Coherency fabric (CCF) =
provide a
> +	CoreNet Coherency Subdomain ID/CoreNet Snoop ID to cpu mapping =
functions.
> +	Certain bits from these registers should be set if the =
coresponding CPU
> +	should be snooped. This property defines a bitmask which selects =
the bit that
> +	should be set if this cpu should be snooped.

Under what cases can software not figure out how to set this based on =
the PAMUs in the DT?

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt =
b/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
> index 1f5e329..827c637 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
> @@ -26,6 +26,13 @@ Required properties:
> 		  A standard property.
> - #size-cells	: <u32>
> 		  A standard property.
> +- fsl,portid-mapping : <u32>
> +	The Coherency Subdomain ID Port Mapping Registers and Snoop ID =
Port Mapping
> +	registers which are part of the CoreNet Coherency fabric (CCF) =
provide a
> +	CoreNet Coherency Subdomain ID/CoreNet Snoop ID to pamu mapping =
functions.
> +	Certain bits from these registers should be set if PAMUs should =
be snooped.
> +	This property defines a bitmask which selects the bits that =
should be set
> +	if PAMUs should be snooped.
>=20
> Optional properties:
> - reg		: <prop-encoded-array>
> @@ -88,6 +95,7 @@ Example:
> 		compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
> 		reg =3D <0x20000 0x5000>;
> 		ranges =3D <0 0x20000 0x5000>;
> +		fsl,portid-mapping =3D <0xf80000>;
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		interrupts =3D <
> --=20
> 1.7.11.7
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
