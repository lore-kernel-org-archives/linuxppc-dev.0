Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2F01A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 15:07:55 +1000 (EST)
Message-ID: <1406783260.29414.320.camel@snotra.buserror.net>
Subject: Re: [2/2] powerpc/fsl-booke: Add initial T1042RDB_PI board support
From: Scott Wood <scottwood@freescale.com>
To: Jain Priyanka-B32167 <Priyanka.Jain@freescale.com>
Date: Thu, 31 Jul 2014 00:07:40 -0500
In-Reply-To: <946e9d7e260c4d78b3c025c3eaeec0f5@BY1PR0301MB0853.namprd03.prod.outlook.com>
References: <1404879851-2914-1-git-send-email-Priyanka.Jain@freescale.com>
 <20140730201250.GA29789@home.buserror.net>
 <946e9d7e260c4d78b3c025c3eaeec0f5@BY1PR0301MB0853.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>, Aggrwal
 Poonam-B10812 <Poonam.Aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-30 at 23:37 -0500, Jain Priyanka-B32167 wrote:
> 
> -----Original Message-----
> From: Wood Scott-B07421 
> Sent: Thursday, July 31, 2014 1:43 AM
> To: Jain Priyanka-B32167
> Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Aggrwal Poonam-B10812; Kushwaha Prabhakar-B32579
> Subject: Re: [2/2] powerpc/fsl-booke: Add initial T1042RDB_PI board support
> 
> On Wed, Jul 09, 2014 at 09:54:11AM +0530, Priyanka Jain wrote:
> > diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi 
> > b/arch/powerpc/boot/dts/t104xrdb.dtsi
> > index 9aaefa5..e7e765f 100644
> > --- a/arch/powerpc/boot/dts/t104xrdb.dtsi
> > +++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
> > @@ -57,7 +57,8 @@
> >  		};
> >  
> >  		cpld@3,0 {
> > -			compatible = "fsl,t1040rdb-cpld","fsl,t1042rdb-cpld";
> > +			compatible = "fsl,t1040rdb-cpld","fsl,t1042rdb-cpld",
> > +					"fsl,t1042rdb_pi-cpld";
> >  			reg = <3 0 0x300>;
> >  		};
> >  	};
> 
> What's going on here?  This file is used by all three boards.  If you need to distinguish one board's CPLD from another's, you'll have to do it somewhere else.  If the CPLDs are exactly the same and no distinction needs to be made, then you don't need three compatible strings.  Even then, you may wish to specify the exact board as the first compatible string, but again you'll need to patch that in elsewhere so that it actually matches the board
> .
> As the register set of CPLD for all three boards is same, I am thinking of replacing this with t104srdb-cpld
> compatible = "fsl,t104xrdb-cpld","
> Is this OK?

No.  Wildcards aren't allowed in compatible strings, because you never
know what other devices might exist in the future that match the
wildcard.

If the CPLD logic is truly 100% identical, just pick one of the three to
be the canonical name.

-Scott
