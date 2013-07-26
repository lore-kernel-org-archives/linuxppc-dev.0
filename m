Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9BEA2C00EC
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Jul 2013 07:55:41 +1000 (EST)
Date: Fri, 26 Jul 2013 16:55:23 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/3] powerpc/85xx: Add SEC6.0 device tree
To: Po Liu <Po.Liu@freescale.com>
In-Reply-To: <1374806479-812-1-git-send-email-Po.Liu@freescale.com> (from
 Po.Liu@freescale.com on Thu Jul 25 21:41:17 2013)
Message-ID: <1374875723.30721.26@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>,
 afleming@freescale.com, Po Liu <Po.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 09:41:17 PM, Po Liu wrote:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Job Ring (JR) Node
> +
> +    Child of the crypto node defines data processing interface to =20
> SEC 6
> +    across the peripheral bus for purposes of processing
> +    cryptographic descriptors. The specified address
> +    range can be made visible to one (or more) cores.
> +    The interrupt defined for this node is controlled within
> +    the address range of this node.
> +
> +  - compatible
> +      Usage: required
> +      Value type: <string>
> +      Definition: Must include "fsl,sec-v6.0-job-ring", if it is
> +      back compatible with old version, better add them all.

Please don't use colloquialisms such as "[you'd] better do this" in a =20
formal specification.

Just say 'Must include "fsl,sec-v6.0-job-ring"' and leave it at that, =20
like the other bindings do.

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Full Example
> +
> +Since some chips may embeded with more than one SEC 6, we abstract
> +all the same properties into one file qoriq-sec6.0-0.dtsi. Each chip
> +want to binding the node could simply include it in its own device
> +node tree. Below is full example in C293PCIE:

Replace this with:

Since some chips may contain more than one SEC, the dtsi contains only =20
the node contents, not the node itself.  A chip using the SEC should =20
include the dtsi inside each SEC node.  Example:

> +In qoriq-sec6.0-0.dtsi:
> +
> +	compatible =3D "fsl,sec-v6.0";
> +	fsl,sec-era =3D <6>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	jr@1000 {
> +		compatible =3D "fsl,sec-v6.0-job-ring",
> +			     "fsl,sec-v5.2-job-ring",
> +			     "fsl,sec-v5.0-job-ring",
> +			     "fsl,sec-v4.4-job-ring",
> +			     "fsl,sec-v4.0-job-ring";
> +		reg	   =3D <0x1000 0x1000>;
> +	};
> +
> +	jr@2000 {
> +		compatible =3D "fsl,sec-v6.0-job-ring",
> +			     "fsl,sec-v5.2-job-ring",
> +			     "fsl,sec-v5.0-job-ring",
> +			     "fsl,sec-v4.4-job-ring",
> +			     "fsl,sec-v4.0-job-ring";
> +		reg	   =3D <0x2000 0x1000>;
> +	};
> +
> +In the C293 device tree, we add the include of public property:
> +
> +crypto@a0000 {
> +/include/ "qoriq-sec6.0-0.dtsi"
> +	};

Whitespace

> +
> +	crypto@a0000 {
> +		reg =3D <0xa0000 0x20000>;
> +		ranges =3D <0x0 0xa0000 0x20000>;
> +
> +		jr@1000{
> +			interrupts =3D <49 2 0 0>;
> +		};
> +		jr@2000{
> +			interrupts =3D <50 2 0 0>;
> +		};
> +	};

You could combine the above like this:

	crypto@a0000 {
		reg =3D <0xa0000 0x20000>;
		ranges =3D <0 0xa0000 0x20000>;

		/include/ "qoriq-sec6.0-0.dtsi"

		jr@1000 {
			interrupts =3D <49 2 0 0>;
		};

		jr@2000 {
			interrupts =3D <50 2 0 0>;
		};
	};

Why is it "qoriq-sec6.0-0.dtsi" and not "qoriq-sec6.0-dtsi"?

-Scott=
