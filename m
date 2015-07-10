Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 046761A0429
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 07:12:51 +1000 (AEST)
Message-ID: <1436562732.2658.177.camel@freescale.com>
Subject: Re: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
From: Scott Wood <scottwood@freescale.com>
To: Pledge Roy-R01356 <roy.pledge@freescale.com>
CC: Paul Bolle <pebolle@tiscali.nl>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 10 Jul 2015 16:12:12 -0500
In-Reply-To: <BN3PR0301MB12673A340E327986F0BC39E58C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
 <1436528160.20619.159.camel@tiscali.nl>
 <1436549595.2658.159.camel@freescale.com>
 <BN3PR0301MB12673A340E327986F0BC39E58C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
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

On Fri, 2015-07-10 at 15:57 -0500, Pledge Roy-R01356 wrote:
> > 
> > On Fri, 2015-07-10 at 13:36 +0200, Paul Bolle wrote:
> > > On do, 2015-07-09 at 16:21 -0400, Roy Pledge wrote:
> > > > +#ifdef CONFIG_FSL_DPA_CHECKING
> > > > +#define DPA_ASSERT(x) \
> > > > +   do { \
> > > > +           if (!(x)) { \
> > > > +                   pr_crit("ASSERT: (%s:%d) %s\n", __FILE__, 
> > > > __LINE__, \
> > > > +                           __stringify_1(x)); \
> > > > +                   dump_stack(); \
> > > > +                   panic("assertion failure"); \
> > > 
> > > Not my call, but why panic() here?
> > 
> > I'm pretty sure I've complained about this before (as well as all the
> > BUG_ONs).
> > 
> Is the concern here just the call to panic()?  I'm happy to change what 
> happens when an issue is detected but the DPA_ASSERT() calls are very 
> useful when testing changes to the driver and when bringing up the drivers 
> on new silicon variants. 

Use WARN_ON() or a variant thereof.

-Scott
