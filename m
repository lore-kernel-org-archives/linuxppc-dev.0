Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0120.outbound.protection.outlook.com [65.55.169.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A1961A0A57
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Dec 2014 10:16:19 +1100 (AEDT)
Message-ID: <1419030955.5581.154.camel@freescale.com>
Subject: Re: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Fri, 19 Dec 2014 17:15:55 -0600
In-Reply-To: <DM2PR0301MB0864AA31CD1A7438F476020FE26B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
 <1416966592.15957.172.camel@freescale.com>
 <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1418940078.5581.143.camel@freescale.com>
 <DM2PR0301MB0864AA31CD1A7438F476020FE26B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
 Liberman Igal-B31950 <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-19 at 01:23 -0600, Xie Shaohui-B21989 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, December 19, 2014 6:01 AM
> > To: Xie Shaohui-B21989
> > Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Medve Emilian-
> > EMMEDVE1; Liberman Igal-B31950
> > Subject: Re: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
> > 
> > On Thu, 2014-12-18 at 06:53 -0600, Xie Shaohui-B21989 wrote:
> > > Ping.
> > >
> > > Best Regards,
> > > Shaohui Xie
> > 
> > I can't put patches in my -next until the merge window closes.
> > 
> > > > > > +EXAMPLE
> > > > > > +
> > > > > > +Example for FMan v2 external MDIO:
> > > > > > +
> > > > > > +mdio@f1000 {
> > > > > > +	compatible = "fsl,fman-xmdio";
> > > > > > +	reg = <0xf1000 0x1000>;
> > > > > > +	bus-frequency = <20000>;
> > > > > > +};
> > > > >
> > > > > So the bus frequency is only 20 KHz?  Or is the unit supposed to
> > > > > be something other than Hz?
> > > > [S.H] it's only an example, it could be different on real SoCs, but
> > > > they always lower than the standard one, The standard one is 2.5MHz, I have
> > to use Hz for it.
> > 
> > Is there any SoC for which 20 kHz is the right frequency?  I just want to make
> > sure the example is realistic.
> [S.H] the clock divider has a limitation that the MAX value it can get on Fman v2 is 255 (0xff, 8 bits),
> On Fman v3 is 511(0x1ff, 9 bits).
> 
> So the lowest frequency on Fman v2 is: Fman_clock / (2 * 255),
> On Fman v3 is: Fman_clock / ((2 * 511) + 1).
> 
> Take default Fman frequency setting from SDK1.7 as example, the lowest clock used for Fman v2 is 581MHz,
> The lowest clock for Fman v3 is 600MHz.
> 
> Then the lowest bus frequency can get is:
> Fman v2: ~1140KHz
> Fman v3: ~587KHz
> 
> 20KHz is not practice, we don't have a suggested value in errata document.
> For this example, should I post a new version with a value like 1200KHz?

This is different from how you described the problem before.  If the
limitation is on the divider, rather than the absolute bus frequency,
then specifiy the max divider.  Or better, since according to the above
this correlates with fman version, just have the driver know what the
max divider is for each fman version.

-Scott
