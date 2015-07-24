Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43EEC1A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 01:49:45 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joe Perches <joe@perches.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Liberman Igal <Igal.Liberman@freescale.com>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "pebolle@tiscali.nl"
 <pebolle@tiscali.nl>, "joakim.tjernlund@transmode.se"
 <joakim.tjernlund@transmode.se>
Subject: RE: [PATCH 03/10] dpaa_eth: add configurable bpool thresholds
Date: Fri, 24 Jul 2015 15:49:39 +0000
Message-ID: <BL2PR03MB545AA0E6D98232FF43B6CE9E6810@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1437581806-17420-1-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-2-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-3-git-send-email-madalin.bucur@freescale.com>
 <1437587228.20787.26.camel@perches.com>
In-Reply-To: <1437587228.20787.26.camel@perches.com>
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

> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> On Wed, 2015-07-22 at 19:16 +0300, Madalin Bucur wrote:
> > Allow the user to tweak the refill threshold and the total number
> > of buffers in the buffer pool. The provided values are for one CPU.
>=20
> Any value in making these module parameters instead?

I expect one would (hardly ever) change these to improve some corner
cases then use them with the new values. It may help in the tuning process
but afterwards the bloat to the bootcmd would probably be  a nuisance.

> > +config FSL_DPAA_ETH_MAX_BUF_COUNT
> > +	int "Maximum number of buffers in private bpool"
> > +	range 64 2048
> > +	default "128"
> > +	---help---
> > +	  The maximum number of buffers to be by default allocated in the
> DPAA-Ethernet private port's
> > +	  buffer pool. One needn't normally modify this, as it has probably
> been tuned for performance
> > +	  already. This cannot be lower than DPAA_ETH_REFILL_THRESHOLD.
> > +
> > +config FSL_DPAA_ETH_REFILL_THRESHOLD
> > +	int "Private bpool refill threshold"
> > +	range 32 FSL_DPAA_ETH_MAX_BUF_COUNT
> > +	default "80"
> > +	---help---
> > +	  The DPAA-Ethernet driver will start replenishing buffer pools whose
> count
> > +	  falls below this threshold. This must be related to
> DPAA_ETH_MAX_BUF_COUNT. One needn't normally
> > +	  modify this value unless one has very specific performance reasons.
> > +
> >  config FSL_DPAA_CS_THRESHOLD_1G
> >  	hex "Egress congestion threshold on 1G ports"
> >  	range 0x1000 0x10000000
>=20
>=20
