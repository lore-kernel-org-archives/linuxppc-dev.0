Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0147.outbound.protection.outlook.com [157.56.110.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 089351A1BCE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:59:40 +1000 (AEST)
Message-ID: <1438023565.2993.299.camel@freescale.com>
Subject: Re: [PATCH 02/10] dpaa_eth: add support for DPAA Ethernet
From: Scott Wood <scottwood@freescale.com>
To: Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>
CC: Joe Perches <joe@perches.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Liberman Igal-B31950
 <Igal.Liberman@freescale.com>, "ppc@mindchasers.com" <ppc@mindchasers.com>,
 "pebolle@tiscali.nl" <pebolle@tiscali.nl>, "joakim.tjernlund@transmode.se"
 <joakim.tjernlund@transmode.se>
Date: Mon, 27 Jul 2015 13:59:25 -0500
In-Reply-To: <BL2PR03MB545D22D02CEEDA05878E833E6810@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1437581806-17420-1-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-2-git-send-email-madalin.bucur@freescale.com>
 <1437586665.20787.24.camel@perches.com>
 <BL2PR03MB545D22D02CEEDA05878E833E6810@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-24 at 10:45 -0500, Bucur Madalin-Cristian-B32716 wrote:
> > -----Original Message-----
> > From: Joe Perches [mailto:joe@perches.com]
> > On Wed, 2015-07-22 at 19:16 +0300, Madalin Bucur wrote:
> > > +static int __init dpa_load(void)
> > > +{
> > []
> > > + err = platform_driver_register(&dpa_driver);
> > > + if (unlikely(err < 0)) {
> > > +         pr_err(KBUILD_MODNAME
> > > +                 ": %s:%hu:%s(): platform_driver_register() = %d\n",
> > > +                 KBUILD_BASENAME ".c", __LINE__, __func__, err);
> > > + }
> > > +
> > > + pr_debug(KBUILD_MODNAME ": %s:%s() ->\n",
> > > +          KBUILD_BASENAME ".c", __func__);
> > 
> > Perhaps these should use pr_fmt
> 
> Agree.

How about dropping all that complexity, and just using pr_debug("%s\n", 
__func__), or dev_dbg where possible?

> 
> > > +static void __exit dpa_unload(void)
> > > +{
> > > + pr_debug(KBUILD_MODNAME ": -> %s:%s()\n",
> > > +          KBUILD_BASENAME ".c", __func__);
> > 
> > dynamic debug has __func__ available and perhaps
> > the function tracer might be used instead.
> > 
> > > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> > []
> > > +#define __hot
> > 
> > curious.
> > 
> > Maybe it'd be good to add a real __hot to compiler.h
> 
> They're mostly there to make readers aware the code is critical, any
> changes could mess performance.

Mostly or entirely?  Why not just use a comment, which could also point out 
specific things that were done for performance?

-Scott
