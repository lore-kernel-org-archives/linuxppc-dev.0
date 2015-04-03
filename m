Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C508B1A0C4D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 19:54:43 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH RFC 06/10] dpaa_eth: add ethtool functionality
Date: Fri, 3 Apr 2015 08:54:36 +0000
Message-ID: <BL2PR03MB54597F6E69800CDAE4D31D0E6F10@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
> On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> > Add support for basic ethtool operations.
>=20
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> []
> > +static int __cold dpa_get_settings(struct net_device *net_dev,
> > +				   struct ethtool_cmd *et_cmd)
> > +{
> > +	int			 _errno;
>=20
> Using a variable name of _errno is misleading at best,
> (btw: the only return value for phy_ethtool_gset is 0)

I'll rename all miss-used occurrences of _errno.
=20
> > +static void __cold dpa_get_drvinfo(struct net_device *net_dev,
> > +				   struct ethtool_drvinfo *drvinfo)
> > +{
> > +	int		 _errno;
> > +
> > +	strncpy(drvinfo->driver, KBUILD_MODNAME,
> > +		sizeof(drvinfo->driver) - 1)[sizeof(drvinfo->driver) - 1] =3D 0;
>=20
> That's a really odd and unusual construct
> more commonly written as strlcpy

I will change this.

> > +	_errno =3D snprintf(drvinfo->version, sizeof(drvinfo->version),
>=20
> Using errno here is especially misleading as that's
> not the return value of an snprintf

I will take care of this one too.

Thank you,
Madalin
