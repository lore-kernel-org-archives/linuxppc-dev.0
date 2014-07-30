Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DEF31A01F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 06:13:05 +1000 (EST)
Date: Wed, 30 Jul 2014 15:12:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [2/2] powerpc/fsl-booke: Add initial T1042RDB_PI board support
Message-ID: <20140730201250.GA29789@home.buserror.net>
References: <1404879851-2914-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1404879851-2914-1-git-send-email-Priyanka.Jain@freescale.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>, Poonam
 Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 09, 2014 at 09:54:11AM +0530, Priyanka Jain wrote:
> diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/t104xrdb.dtsi
> index 9aaefa5..e7e765f 100644
> --- a/arch/powerpc/boot/dts/t104xrdb.dtsi
> +++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
> @@ -57,7 +57,8 @@
>  		};
>  
>  		cpld@3,0 {
> -			compatible = "fsl,t1040rdb-cpld","fsl,t1042rdb-cpld";
> +			compatible = "fsl,t1040rdb-cpld","fsl,t1042rdb-cpld",
> +					"fsl,t1042rdb_pi-cpld";
>  			reg = <3 0 0x300>;
>  		};
>  	};

What's going on here?  This file is used by all three boards.  If you
need to distinguish one board's CPLD from another's, you'll have to do it
somewhere else.  If the CPLDs are exactly the same and no distinction
needs to be made, then you don't need three compatible strings.  Even
then, you may wish to specify the exact board as the first compatible
string, but again you'll need to patch that in elsewhere so that it
actually matches the board.

-Scott
