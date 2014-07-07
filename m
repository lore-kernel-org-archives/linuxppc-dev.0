Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569B11A000A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 08:16:40 +1000 (EST)
Message-ID: <1404771387.21434.212.camel@snotra.buserror.net>
Subject: Re: [3/3,v4] powerpc/t2080rdb: Add T2080RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <Shengzhou.Liu@freescale.com>
Date: Mon, 7 Jul 2014 17:16:27 -0500
In-Reply-To: <8f75541b111b44e3a26e2f6f4dc9df77@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1402481406-10830-3-git-send-email-Shengzhou.Liu@freescale.com>
 <20140625233450.GA13860@home.buserror.net>
 <8f75541b111b44e3a26e2f6f4dc9df77@DM2PR03MB398.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-07 at 05:26 -0500, Liu Shengzhou-B36685 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, June 26, 2014 7:35 AM
> > To: Liu Shengzhou-B36685
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [3/3,v4] powerpc/t2080rdb: Add T2080RDB board support
> > 
> > On Wed, Jun 11, 2014 at 06:10:06PM +0800, Shengzhou Liu wrote:
> > > +				i2c@0 {
> > > +					#address-cells = <1>;
> > > +					#size-cells = <0>;
> > > +					reg = <0x0>;
> > > +
> > > +					sfp@50 {
> > > +						compatible = "optics,sfp";
> > > +						reg = <0x50>;
> > > +					};
> > > +				};
> > 
> > What is "sfp"?  Please use generic node names when possible.
> > 
> > I'm not able to easily find what chip this is referring to by googling
> > "optics sfp".  I suspect this compatible is too vague -- what is the
> > actual part number?  Could you provide a URL to a description of the chip?
> > 
> > If "optics" is the correct vendor name, it needs to go into vendor-prefixes.txt.
> > 
> > -Scott
>
> [Shengzhou] SFP is "Small Form-factor Pluggable transceiver" for 10Gpbs
> optics module.  Actually, there is no a specific vendor for this case,
> it is a general sfp cage to which we can plug in different optics
> module from different vendors.  And there is no need to configure it by
> SW.  

Do not put arbitrary things in the vendor prefix.

What is the programming interface that is made available on i2c port
0x50?  If it can change based on user configuration, then perhaps it
should just be left out.

-Scott
