Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0052.outbound.protection.outlook.com [104.47.2.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDXrz4Z6yzDvNV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:16:19 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>, "ppc@mindchasers.com"
 <ppc@mindchasers.com>, "joe@perches.com" <joe@perches.com>,
 "pebolle@tiscali.nl" <pebolle@tiscali.nl>, "joakim.tjernlund@transmode.se"
 <joakim.tjernlund@transmode.se>
Subject: RE: [PATCH net-next v6 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Wed, 9 Nov 2016 17:16:12 +0000
Message-ID: <AM4PR04MB160440B1F671B4C86B238C2DECB90@AM4PR04MB1604.eurprd04.prod.outlook.com>
References: <1478117854-8952-1-git-send-email-madalin.bucur@nxp.com>
 <1478117854-8952-3-git-send-email-madalin.bucur@nxp.com>
 <20161103.155816.642712588084106823.davem@davemloft.net>
In-Reply-To: <20161103.155816.642712588084106823.davem@davemloft.net>
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

> From: Madalin-Cristian Bucur
> Sent: Monday, November 07, 2016 5:43 PM
>=20
> > From: David Miller [mailto:davem@davemloft.net]
> > Sent: Thursday, November 03, 2016 9:58 PM
> >
> > From: Madalin Bucur <madalin.bucur@nxp.com>
> > Date: Wed, 2 Nov 2016 22:17:26 +0200
> >
> > > This introduces the Freescale Data Path Acceleration Architecture
<snip>

> > > +	int numstats =3D sizeof(struct rtnl_link_stats64) / sizeof(u64);
> >  ...
> > > +		cpustats =3D (u64 *)&percpu_priv->stats;
> > > +
> > > +		for (j =3D 0; j < numstats; j++)
> > > +			netstats[j] +=3D cpustats[j];
> >
> > This is a memcpy() on well-typed datastructures which requires no
> > casting or special handling whatsoever, so use memcpy instead of
> > needlessly open coding the operation.
>=20
> Will fix.

Took a second look at this, it's not copying but adding the percpu
statistics into consolidated results.

Madalin
