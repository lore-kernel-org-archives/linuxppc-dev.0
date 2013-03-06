Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E20552C031F
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 11:16:05 +1100 (EST)
Date: Tue, 5 Mar 2013 18:15:55 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/8] powerpc/fsl-booke: Add initial silicon device tree for
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-5-git-send-email-galak@kernel.crashing.org>
 (from galak@kernel.crashing.org on Tue Mar  5 17:15:57 2013)
Message-ID: <1362528955.25308.12@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/2013 05:15:57 PM, Kumar Gala wrote:
> Enable a baseline T4240 SoC to boot.  There are several things missing
> from the device trees for T4240:
>=20
> * Thread support on e6500

Why did threads get removed from the device tree?  It's supposed to =20
describe hardware, not what Linux currently supports.

> * Proper PAMU topology information
> * DPAA related nodes (Qman, Bman, Fman, Rman, DCE)
> * Prefetch Manager
> * Thermal monitor unit
> * Interlaken

The dts should be marked preliminary somehow -- we really should get =20
out of the habit of letting device nodes trickle in as drivers get =20
added.

> +/* controller at 0x240000 */
> +&pci0 {
> +	compatible =3D "fsl,t4240-pcie", "fsl,qoriq-pcie-v3.0";

We have a version register -- do we really need to keep sticking the =20
version number in the compatible?  Note that we've had device trees =20
that specified the version incorrectly in the past.

> +	device_type =3D "pci";
> +	#size-cells =3D <2>;
> +	#address-cells =3D <3>;
> +	bus-range =3D <0x0 0xff>;
> +	clock-frequency =3D <33333333>;

This clock-frequency is not correct (I doubt it's needed at all).

> +		PowerPC,e6500@1 {
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			next-level-cache =3D <&L2_1>;
> +		};
> +		PowerPC,e6500@2 {
> +			device_type =3D "cpu";
> +			reg =3D <4>;
> +			next-level-cache =3D <&L2_1>;
> +		};
> +		PowerPC,e6500@3 {
> +			device_type =3D "cpu";
> +			reg =3D <6>;
> +			next-level-cache =3D <&L2_1>;
> +		};
> +
> +		PowerPC,e6500@4 {
> +			device_type =3D "cpu";
> +			reg =3D <8>;
> +			next-level-cache =3D <&L2_2>;
> +		};

Inconsistent whitespace.

As usual, the pre/post split is unnecessary.  Everything in it can go =20
in post.

-Scott=
