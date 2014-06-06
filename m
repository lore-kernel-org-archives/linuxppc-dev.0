Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DCE71A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 15:04:27 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: "prabhakar@freescale.com" <prabhakar@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [linuxppc-release] [PATCH][v10] powerpc/mpc85xx:Add initial
 device	tree support of T104x
Date: Fri, 6 Jun 2014 05:04:12 +0000
Message-ID: <c0213fde8dd24026af31ccce2fec21bf@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1398080069-3807-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1398080069-3807-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 "Poonam.Aggrwal@freescale.com" <Poonam.Aggrwal@freescale.com>,
 "prabhakar@freescale.com" <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-release-bounces@linux.freescale.net [mailto:linuxppc-
> release-bounces@linux.freescale.net] On Behalf Of Prabhakar Kushwaha
> Sent: Monday, April 21, 2014 7:34 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Wood Scott-B07421; Jain Priyanka-B32167; Aggrwal Poonam-B10812;
> Kushwaha Prabhakar-B32579
> Subject: [linuxppc-release] [PATCH][v10] powerpc/mpc85xx:Add initial
> device tree support of T104x
>=20
> The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
> processor cores with high-performance data path acceleration architecture
> and network peripheral interfaces required for networking &
> telecommunications.
>=20
> +
> +	iommu@20000 {
> +		compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
> +		reg =3D <0x20000 0x1000>;
> +		ranges =3D <0 0x20000 0x1000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		interrupts =3D <
> +			24 2 0 0
> +			16 2 1 30>;
> +		pamu0: pamu@0 {
> +			reg =3D <0 0x1000>;
> +			fsl,primary-cache-geometry =3D <128 1>;
> +			fsl,secondary-cache-geometry =3D <16 2>;
> +		};


[Shengzhou]  T1040 RM says:
Hardware coherent PAMU Look-aside caches to improve performance
* A 32-entry, direct-mapped primary PAACT cache
* A 128-entry, 2-way, set-associative secondary PAACT cache
It appears it should be:=20
       fsl,primary-cache-geometry =3D <32 1>;
       fsl,secondary-cache-geometry =3D <128 2>;

is there any reason that it was "<128 1>,  <16 2>" ?
