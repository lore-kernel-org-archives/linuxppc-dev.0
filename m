Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E19001A09A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 01:46:02 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joe Perches <joe@perches.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Liberman Igal <Igal.Liberman@freescale.com>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "pebolle@tiscali.nl"
 <pebolle@tiscali.nl>, "joakim.tjernlund@transmode.se"
 <joakim.tjernlund@transmode.se>
Subject: RE: [PATCH 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Fri, 24 Jul 2015 15:45:56 +0000
Message-ID: <BL2PR03MB545D22D02CEEDA05878E833E6810@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1437581806-17420-1-git-send-email-madalin.bucur@freescale.com>
 <1437581806-17420-2-git-send-email-madalin.bucur@freescale.com>
 <1437586665.20787.24.camel@perches.com>
In-Reply-To: <1437586665.20787.24.camel@perches.com>
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
> > This introduces the Freescale Data Path Acceleration Architecture
> > (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> > BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> > the Freescale DPAA QorIQ platforms.
>=20
> trivia:
>=20
> > +static void __hot _dpa_tx_conf(struct net_device	*net_dev,
> > +			       const struct dpa_priv_s	*priv,
> > +			       struct dpa_percpu_priv_s	*percpu_priv,
> > +			       const struct qm_fd	*fd,
> > +			       u32			fqid)
> > +{
> []
> > +static struct dpa_bp * __cold
> > +dpa_priv_bp_probe(struct device *dev)
>=20
> Do the __hot and __cold markings really matter?
> Some of them may be questionable.

Some may be, yes. I need to go through all of them.

> > +static int __init dpa_load(void)
> > +{
> []
> > +	err =3D platform_driver_register(&dpa_driver);
> > +	if (unlikely(err < 0)) {
> > +		pr_err(KBUILD_MODNAME
> > +			": %s:%hu:%s(): platform_driver_register() =3D %d\n",
> > +			KBUILD_BASENAME ".c", __LINE__, __func__, err);
> > +	}
> > +
> > +	pr_debug(KBUILD_MODNAME ": %s:%s() ->\n",
> > +		 KBUILD_BASENAME ".c", __func__);
>=20
> Perhaps these should use pr_fmt

Agree.

> > +static void __exit dpa_unload(void)
> > +{
> > +	pr_debug(KBUILD_MODNAME ": -> %s:%s()\n",
> > +		 KBUILD_BASENAME ".c", __func__);
>=20
> dynamic debug has __func__ available and perhaps
> the function tracer might be used instead.
>=20
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> []
> > +#define __hot
>=20
> curious.
>=20
> Maybe it'd be good to add a real __hot to compiler.h

They're mostly there to make readers aware the code is critical, any
changes could mess performance.

> > +struct dpa_buffer_layout_s {
> > +	u16	priv_data_size;
> > +	bool		parse_results;
> > +	bool		time_stamp;
> > +	bool		hash_results;
> > +	u16	data_align;
> > +};
>=20
> > +struct dpa_fq {
> > +	struct qman_fq		 fq_base;
> > +	struct list_head	 list;
> > +	struct net_device	*net_dev;
>=20
> some inconsistent indentation here and there

Yes, I've tried to align the style but given the many editors along the tim=
e the code existed=20
there still are areas out of sync.

> > +struct dpa_bp {
> > +	struct bman_pool		*pool;
> > +	u8				bpid;
> > +	struct device			*dev;
> > +	union {
> > +		/* The buffer pools used for the private ports are initialized
> > +		 * with target_count buffers for each CPU; at runtime the
> > +		 * number of buffers per CPU is constantly brought back to
> this
> > +		 * level
> > +		 */
> > +		int target_count;
> > +		/* The configured value for the number of buffers in the
> pool,
> > +		 * used for shared port buffer pools
> > +		 */
> > +		int config_count;
> > +	};
>=20
> Anonymous unions are relatively rare

We liked the direct access to members...
In this particular case the use is a bit excessive, we can do without it.

> > +	struct {
> > +		/**
>=20
> Maybe the /** style should be avoided

Will fix.

> > +		 * All egress queues to a given net device belong to one
> > +		 * (and the same) congestion group.
> > +		 */
> > +		struct qman_cgr cgr;
> > +	} cgr_data;
>=20
> []
>=20
> > +int dpa_stop(struct net_device *net_dev)
> > +{
> []
> > +	err =3D mac_dev->stop(mac_dev);
> > +	if (unlikely(err < 0))
> > +		netif_err(priv, ifdown, net_dev, "mac_dev->stop() =3D %d\n",
> > +			  err);
>=20
> Some of the likely/unlikely uses may not
> be useful/necessary.

In this particular case it's gratuitous, I'll go through all of them.

> > +
> > +	for_each_port_device(i, mac_dev->port_dev) {
> > +		error =3D fm_port_disable(
> > +				fm_port_drv_handle(mac_dev-
> >port_dev[i]));
> > +		err =3D error ? error : err;
>=20
> 		if (error)
> 			err =3D error;
>=20
> is more obvious to me.

Yes, it's more readable.

Thank you,
Madalin
