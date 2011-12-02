Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 98750B6F6B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 18:20:22 +1100 (EST)
Subject: Re: [PATCH] pq3: Add default tbi address
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322809549-32622-2-git-send-email-afleming@freescale.com>
Date: Fri, 2 Dec 2011 01:20:19 -0600
Message-Id: <B84C6222-2359-46D5-BA54-5024E43ECD3F@kernel.crashing.org>
References: <1322809549-32622-1-git-send-email-afleming@freescale.com>
 <1322809549-32622-2-git-send-email-afleming@freescale.com>
To: Andy Fleming <afleming@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 2, 2011, at 1:05 AM, Andy Fleming wrote:

> The MDIO driver has been changed so that it no longer supports
> scanning the MDIO bus for a free address for the TBI PHY. This
> feature was fragile, and required scanning the bus before the bus
> was fully up and registered. The intended way for FSL devices to
> specify the TBI PHY's address is via a tbi node in the device tree.
> All of the device trees had such a node, except for the recent p1/p2
> trees. Rather than hand-fixing all of those boards, set a default
> value (most boards were using 0x11, anyway), and any board which
> wants to change it from that default can then override it in its
> board dts file.
>=20
> This fixes an issue where p1/p2 boards would fail to bring up
> Ethernet, due to not finding a tbi node.

Is this only needed on 1st controller because its what has external PHY =
control?

> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi |    5 +++++
> arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |    5 +++++
> 2 files changed, 10 insertions(+), 0 deletions(-)

This doesn't seem correct, meaning this should really be in the board =
.dts not in the IP.

I think the driver should check and warn if this property doesn't exist.

>=20
> diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi =
b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
> index a1979ae..0a42e21 100644
> --- a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
> @@ -50,4 +50,9 @@ mdio@24520 {
> 	#size-cells =3D <0>;
> 	compatible =3D "fsl,gianfar-mdio";
> 	reg =3D <0x24520 0x20>;
> +
> +	tbi-phy@11 {
> +		device-type =3D "tbi-phy";
> +		reg =3D <0x11>;
> +	};
> };
> diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi =
b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> index 1382fec..964670a 100644
> --- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> @@ -38,6 +38,11 @@ mdio@24000 {
> 	#size-cells =3D <0>;
> 	compatible =3D "fsl,etsec2-mdio";
> 	reg =3D <0x24000 0x1000 0xb0030 0x4>;
> +
> +	tbi-phy@11 {
> +		device-type =3D "tbi-phy";
> +		reg =3D <0x11>;
> +	};
> };
>=20
> ethernet@b0000 {
> --=20
> 1.7.3.4
>=20
