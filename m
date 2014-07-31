Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2ECD41A0206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 14:37:55 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [2/2] powerpc/fsl-booke: Add initial T1042RDB_PI board support
Date: Thu, 31 Jul 2014 04:37:22 +0000
Message-ID: <946e9d7e260c4d78b3c025c3eaeec0f5@BY1PR0301MB0853.namprd03.prod.outlook.com>
References: <1404879851-2914-1-git-send-email-Priyanka.Jain@freescale.com>
 <20140730201250.GA29789@home.buserror.net>
In-Reply-To: <20140730201250.GA29789@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "prabhakar@freescale.com" <prabhakar@freescale.com>,
 "Poonam.Aggrwal@freescale.com" <Poonam.Aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Wood Scott-B07421=20
Sent: Thursday, July 31, 2014 1:43 AM
To: Jain Priyanka-B32167
Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Aggrwal Poon=
am-B10812; Kushwaha Prabhakar-B32579
Subject: Re: [2/2] powerpc/fsl-booke: Add initial T1042RDB_PI board support

On Wed, Jul 09, 2014 at 09:54:11AM +0530, Priyanka Jain wrote:
> diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi=20
> b/arch/powerpc/boot/dts/t104xrdb.dtsi
> index 9aaefa5..e7e765f 100644
> --- a/arch/powerpc/boot/dts/t104xrdb.dtsi
> +++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
> @@ -57,7 +57,8 @@
>  		};
> =20
>  		cpld@3,0 {
> -			compatible =3D "fsl,t1040rdb-cpld","fsl,t1042rdb-cpld";
> +			compatible =3D "fsl,t1040rdb-cpld","fsl,t1042rdb-cpld",
> +					"fsl,t1042rdb_pi-cpld";
>  			reg =3D <3 0 0x300>;
>  		};
>  	};

What's going on here?  This file is used by all three boards.  If you need =
to distinguish one board's CPLD from another's, you'll have to do it somewh=
ere else.  If the CPLDs are exactly the same and no distinction needs to be=
 made, then you don't need three compatible strings.  Even then, you may wi=
sh to specify the exact board as the first compatible string, but again you=
'll need to patch that in elsewhere so that it actually matches the board
.
As the register set of CPLD for all three boards is same, I am thinking of =
replacing this with t104srdb-cpld
compatible =3D "fsl,t104xrdb-cpld","
Is this OK?

-Scott
