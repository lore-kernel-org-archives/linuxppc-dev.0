Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0148.outbound.protection.outlook.com [157.56.111.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9ABF1A1F45
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 16:57:14 +1000 (AEST)
From: Lu Y.B. <yangbo.lu@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH v3] powerpc/dts: Add and fix 1588 timer node for eTSEC
Date: Mon, 7 Sep 2015 06:57:06 +0000
Message-ID: <BY1PR0301MB1192C89856016BF12FB9765AF2540@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1438153958-1400-1-git-send-email-yangbo.lu@freescale.com>
In-Reply-To: <1438153958-1400-1-git-send-email-yangbo.lu@freescale.com>
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

Any comments?

-Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@freescale.com]
> Sent: Wednesday, July 29, 2015 3:13 PM
> To: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Wood
> Scott-B07421
> Cc: Lu Yangbo-B47093
> Subject: [PATCH v3] powerpc/dts: Add and fix 1588 timer node for eTSEC
>=20
> Add 1588 timer node in files:
> arch/powerpc/boot/dts/bsc9131rdb.dtsi
> arch/powerpc/boot/dts/bsc9132qds.dtsi
> arch/powerpc/boot/dts/p1010rdb.dtsi
> arch/powerpc/boot/dts/p1020rdb-pd.dts
> arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> arch/powerpc/boot/dts/p1022ds.dtsi
> arch/powerpc/boot/dts/p1025twr.dtsi
> For P2020RDB-PC, registers' values should be calculated based on default
> 1588 reference clock(300MHz) not 250MHz, and fix this in file:
> arch/powerpc/boot/dts/p2020rdb-pc.dtsi
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v3:
> 	- Changed 'tmr-add' to hex value
> 	- Modified commit message
> Changes for v2:
> 	- Changed hex value to decimal value in dts
> 	- Modified commit message
> 	- Modified 1588 node in p2020rdb-pc.dtsi
> ---
>  arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 12 ++++++++++++
> arch/powerpc/boot/dts/bsc9132qds.dtsi  | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1010rdb.dtsi    | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1020rdb-pd.dts  | 12 ++++++++++++
> arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1022ds.dtsi     | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1025twr.dtsi    | 12 ++++++++++++
>  arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 12 ++++++------
>  8 files changed, 90 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> index 45efcba..f4d96d2 100644
> --- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> +++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> @@ -80,6 +80,18 @@
>  		status =3D "disabled";
>  	};
>=20
> +	ptp_clock@b0e00 {
> +		compatible =3D "fsl,etsec-ptp";
> +		reg =3D <0xb0e00 0xb0>;
> +		interrupts =3D <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	=3D <5>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0xcccccccd>;
> +		fsl,tmr-fiper1	=3D <999999995>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <249999999>;
> +	};
> +
>  	enet0: ethernet@b0000 {
>  		phy-handle =3D <&phy0>;
>  		phy-connection-type =3D "rgmii-id";
> diff --git a/arch/powerpc/boot/dts/bsc9132qds.dtsi
> b/arch/powerpc/boot/dts/bsc9132qds.dtsi
> index af8e888..7a13bf2 100644
> --- a/arch/powerpc/boot/dts/bsc9132qds.dtsi
> +++ b/arch/powerpc/boot/dts/bsc9132qds.dtsi
> @@ -87,6 +87,18 @@
>  		};
>  	};
>=20
> +	ptp_clock@b0e00 {
> +		compatible =3D "fsl,etsec-ptp";
> +		reg =3D <0xb0e00 0xb0>;
> +		interrupts =3D <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	=3D <5>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0xcccccccd>;
> +		fsl,tmr-fiper1	=3D <999999995>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <249999999>;
> +	};
> +
>  	enet0: ethernet@b0000 {
>  		phy-handle =3D <&phy0>;
>  		tbi-handle =3D <&tbi0>;
> diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi
> b/arch/powerpc/boot/dts/p1010rdb.dtsi
> index ea534ef..0f0ced6 100644
> --- a/arch/powerpc/boot/dts/p1010rdb.dtsi
> +++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
> @@ -186,6 +186,18 @@
>  		};
>  	};
>=20
> +	ptp_clock@b0e00 {
> +		compatible =3D "fsl,etsec-ptp";
> +		reg =3D <0xb0e00 0xb0>;
> +		interrupts =3D <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	=3D <10>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0x80000016>;
> +		fsl,tmr-fiper1	=3D <999999990>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <199999999>;
> +	};
> +
>  	enet0: ethernet@b0000 {
>  		phy-handle =3D <&phy0>;
>  		phy-connection-type =3D "rgmii-id";
> diff --git a/arch/powerpc/boot/dts/p1020rdb-pd.dts
> b/arch/powerpc/boot/dts/p1020rdb-pd.dts
> index 987017e..c7c6416 100644
> --- a/arch/powerpc/boot/dts/p1020rdb-pd.dts
> +++ b/arch/powerpc/boot/dts/p1020rdb-pd.dts
> @@ -225,6 +225,18 @@
>  			};
>  		};
>=20
> +		ptp_clock@b0e00 {
> +			compatible =3D "fsl,etsec-ptp";
> +			reg =3D <0xb0e00 0xb0>;
> +			interrupts =3D <68 2 0 0 69 2 0 0>;
> +			fsl,tclk-period	=3D <10>;
> +			fsl,tmr-prsc	=3D <2>;
> +			fsl,tmr-add	=3D <0x80000016>;
> +			fsl,tmr-fiper1	=3D <999999990>;
> +			fsl,tmr-fiper2	=3D <99990>;
> +			fsl,max-adj	=3D <199999999>;
> +		};
> +
>  		enet0: ethernet@b0000 {
>  			fixed-link =3D <1 1 1000 0 0>;
>  			phy-connection-type =3D "rgmii-id";
> diff --git a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> index d6274c5..e8a0f95 100644
> --- a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> +++ b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> @@ -224,6 +224,18 @@
>  		};
>  	};
>=20
> +	ptp_clock@b0e00 {
> +		compatible =3D "fsl,etsec-ptp";
> +		reg =3D <0xb0e00 0xb0>;
> +		interrupts =3D <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	=3D <10>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0x80000016>;
> +		fsl,tmr-fiper1	=3D <999999990>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <199999999>;
> +	};
> +
>  	enet0: ethernet@b0000 {
>  		fixed-link =3D <1 1 1000 0 0>;
>  		phy-connection-type =3D "rgmii-id";
> diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi
> b/arch/powerpc/boot/dts/p1022ds.dtsi
> index 957e0dc..149da0f 100644
> --- a/arch/powerpc/boot/dts/p1022ds.dtsi
> +++ b/arch/powerpc/boot/dts/p1022ds.dtsi
> @@ -215,6 +215,18 @@
>  		};
>  	};
>=20
> +	ptp_clock@b0e00 {
> +		compatible =3D "fsl,etsec-ptp";
> +		reg =3D <0xb0e00 0xb0>;
> +		interrupts =3D <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	=3D <5>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0xc01ebd3d>;
> +		fsl,tmr-fiper1	=3D <999999995>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <266499999>;
> +	};
> +
>  	ethernet@b0000 {
>  		phy-handle =3D <&phy0>;
>  		phy-connection-type =3D "rgmii-id";
> diff --git a/arch/powerpc/boot/dts/p1025twr.dtsi
> b/arch/powerpc/boot/dts/p1025twr.dtsi
> index 8453501..08816fb 100644
> --- a/arch/powerpc/boot/dts/p1025twr.dtsi
> +++ b/arch/powerpc/boot/dts/p1025twr.dtsi
> @@ -138,6 +138,18 @@
>  		};
>  	};
>=20
> +	ptp_clock@b0e00 {
> +		compatible =3D "fsl,etsec-ptp";
> +		reg =3D <0xb0e00 0xb0>;
> +		interrupts =3D <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	=3D <10>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0xc0000021>;
> +		fsl,tmr-fiper1	=3D <999999990>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <133333332>;
> +	};
> +
>  	enet0: ethernet@b0000 {
>  		phy-handle =3D <&phy0>;
>  		phy-connection-type =3D "rgmii-id";
> diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> index c21d1c7..ad2e242 100644
> --- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> +++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> @@ -215,12 +215,12 @@
>  	};
>=20
>  	ptp_clock@24e00 {
> -		fsl,tclk-period =3D <5>;
> -		fsl,tmr-prsc =3D <200>;
> -		fsl,tmr-add =3D <0xCCCCCCCD>;
> -		fsl,tmr-fiper1 =3D <0x3B9AC9FB>;
> -		fsl,tmr-fiper2 =3D <0x0001869B>;
> -		fsl,max-adj =3D <249999999>;
> +		fsl,tclk-period	=3D <5>;
> +		fsl,tmr-prsc	=3D <2>;
> +		fsl,tmr-add	=3D <0xaaaaaaab>;
> +		fsl,tmr-fiper1	=3D <999999995>;
> +		fsl,tmr-fiper2	=3D <99990>;
> +		fsl,max-adj	=3D <299999999>;
>  	};
>=20
>  	enet0: ethernet@24000 {
> --
> 2.1.0.27.g96db324
