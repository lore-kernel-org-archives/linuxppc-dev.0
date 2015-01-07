Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0109.outbound.protection.outlook.com [65.55.169.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 167901A0F36
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 05:05:50 +1100 (AEDT)
Message-ID: <1420653934.4961.58.camel@freescale.com>
Subject: Re: [PATCH] [v3] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Wed, 7 Jan 2015 12:05:34 -0600
In-Reply-To: <DM2PR0301MB08645ABD93708FFE011EF362E2460@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1419321466-5575-1-git-send-email-shh.xie@gmail.com>
 <DM2PR0301MB08640979E5088618D1395CFAE2580@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1420590520.4961.38.camel@freescale.com>
 <DM2PR0301MB08645ABD93708FFE011EF362E2460@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-06 at 23:29 -0600, Xie Shaohui-B21989 wrote:
> > > > +- interrupts
> > > > +		Usage: optional
> > > > +		Value type: <prop-encoded-array>
> > > > +		Definition: Event interrupt of external MDIO controller.
> > > > +		1 Gb/s MDIO and 10 Gb/s MDIO has one interrupt respectively.
> > 
> > I'm confused by "respectively" here.  Does fsl,fman-memac-mdio have two
> > interrupts (one for 1 Gb/s and one for 10 Gb/s)?
> [S.H] We use two MDIO controllers for external PHY management. One for 1 Gb/s,
> One for 10 Gb/s, and two MDIO interrupts connected to MPIC.

If there can be two interrupts you need to make that clear and specify
the order.

Is it possible for one MDIO controller to have an interrupt connected
but not the other, on the same system?  How would you represent that in
the device tree?  If there are two MDIO controllers why are they in the
same node?

>   Does "optional" mean it's used if and
> > only if external MDIO is used, or is it optional even with external MDIO?  I see
> > it's not present in the example -- do we not have a real example that has the
> > interrupt?
> [S.H] "optional" means it's available on hardware, but MDIO driver does not use interrupt. 
> So we don't have a real example.

<record type="broken">The device tree describes the hardware, not the
driver</record>

-Scott
