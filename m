Return-Path: <B43644@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E18C02C0120
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Jul 2013 12:14:13 +1000 (EST)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 1/3] powerpc/85xx: Add SEC6.0 device tree
Date: Mon, 29 Jul 2013 02:14:07 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DB1727@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1374806479-812-1-git-send-email-Po.Liu@freescale.com> (from
 Po.Liu@freescale.com on Thu Jul 25 21:41:17 2013)
 <1374875723.30721.26@snotra>
In-Reply-To: <1374875723.30721.26@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  -----Original Message-----
>  From: Wood Scott-B07421
>  Sent: Saturday, July 27, 2013 5:55 AM
>  To: Liu Po-B43644
>  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming Andy-
>  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
>  Subject: Re: [PATCH v2 1/3] powerpc/85xx: Add SEC6.0 device tree
> =20
>  On 07/25/2013 09:41:17 PM, Po Liu wrote:
>  > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > +Job Ring (JR) Node
>  > +
>  > +    Child of the crypto node defines data processing interface to
>  > SEC 6
>  > +    across the peripheral bus for purposes of processing
>  > +    cryptographic descriptors. The specified address
>  > +    range can be made visible to one (or more) cores.
>  > +    The interrupt defined for this node is controlled within
>  > +    the address range of this node.
>  > +
>  > +  - compatible
>  > +      Usage: required
>  > +      Value type: <string>
>  > +      Definition: Must include "fsl,sec-v6.0-job-ring", if it is
>  > +      back compatible with old version, better add them all.
> =20
>  Please don't use colloquialisms such as "[you'd] better do this" in a
>  formal specification.
> =20
>  Just say 'Must include "fsl,sec-v6.0-job-ring"' and leave it at that,
>  like the other bindings do.
Ok, I'll remove redundant words.
> =20
>  > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > +Full Example
>  > +
>  > +Since some chips may embeded with more than one SEC 6, we abstract
>  > +all the same properties into one file qoriq-sec6.0-0.dtsi. Each chip
>  > +want to binding the node could simply include it in its own device
>  > +node tree. Below is full example in C293PCIE:
> =20
>  Replace this with:
> =20
>  Since some chips may contain more than one SEC, the dtsi contains only
>  the node contents, not the node itself.  A chip using the SEC should
>  include the dtsi inside each SEC node.  Example:
> =20
>  > +In qoriq-sec6.0-0.dtsi:
>  > +
>  > +	compatible =3D "fsl,sec-v6.0";
>  > +	fsl,sec-era =3D <6>;
>  > +	#address-cells =3D <1>;
>  > +	#size-cells =3D <1>;
>  > +
>  > +	jr@1000 {
>  > +		compatible =3D "fsl,sec-v6.0-job-ring",
>  > +			     "fsl,sec-v5.2-job-ring",
>  > +			     "fsl,sec-v5.0-job-ring",
>  > +			     "fsl,sec-v4.4-job-ring",
>  > +			     "fsl,sec-v4.0-job-ring";
>  > +		reg	   =3D <0x1000 0x1000>;
>  > +	};
>  > +
>  > +	jr@2000 {
>  > +		compatible =3D "fsl,sec-v6.0-job-ring",
>  > +			     "fsl,sec-v5.2-job-ring",
>  > +			     "fsl,sec-v5.0-job-ring",
>  > +			     "fsl,sec-v4.4-job-ring",
>  > +			     "fsl,sec-v4.0-job-ring";
>  > +		reg	   =3D <0x2000 0x1000>;
>  > +	};
>  > +
>  > +In the C293 device tree, we add the include of public property:
>  > +
>  > +crypto@a0000 {
>  > +/include/ "qoriq-sec6.0-0.dtsi"
>  > +	};
> =20
>  Whitespace
> =20
>  > +
>  > +	crypto@a0000 {
>  > +		reg =3D <0xa0000 0x20000>;
>  > +		ranges =3D <0x0 0xa0000 0x20000>;
>  > +
>  > +		jr@1000{
>  > +			interrupts =3D <49 2 0 0>;
>  > +		};
>  > +		jr@2000{
>  > +			interrupts =3D <50 2 0 0>;
>  > +		};
>  > +	};
> =20
>  You could combine the above like this:
> =20
>  	crypto@a0000 {
>  		reg =3D <0xa0000 0x20000>;
>  		ranges =3D <0 0xa0000 0x20000>;
> =20
>  		/include/ "qoriq-sec6.0-0.dtsi"
> =20
>  		jr@1000 {
>  			interrupts =3D <49 2 0 0>;
>  		};
> =20
>  		jr@2000 {
>  			interrupts =3D <50 2 0 0>;
>  		};
>  	};
> =20
>  Why is it "qoriq-sec6.0-0.dtsi" and not "qoriq-sec6.0-dtsi"?
Ok, I'll change to qoriq-sec6.0.dtsi
> =20
>  -Scott
