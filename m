Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0144.outbound.protection.outlook.com [207.46.100.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 137B51A3396
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:41:20 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joe Perches <joe@perches.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Scott Wood
 <scottwood@freescale.com>, Liberman Igal <Igal.Liberman@freescale.com>, "Roy
 Pledge" <roy.pledge@freescale.com>, "ppc@mindchasers.com"
 <ppc@mindchasers.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [net-next v4 3/8] dpaa_eth: add support for S/G frames
Date: Tue, 3 Nov 2015 09:41:14 +0000
Message-ID: <BL2PR03MB5455FAD900C81B20022392CE62B0@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-4-git-send-email-madalin.bucur@freescale.com>
 <1446494829.24485.63.camel@perches.com>
In-Reply-To: <1446494829.24485.63.camel@perches.com>
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
>=20
> On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> > Add support for Scater/Gather (S/G) frames. The FMan can place
> > the frame content into multiple buffers and provide a S/G Table
> > (SGT) into one first buffer with references to the others.
>=20
> trivia: scatter
>=20
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c
> []
> > @@ -1177,10 +1177,42 @@ void dpaa_eth_init_ports(struct mac_device
> *mac_dev,
> >  			      port_fqs->rx_defq, &buf_layout[RX]);
> >  }
> >
> > +void dpa_release_sgt(struct qm_sg_entry *sgt)
> > +{
> > +	struct dpa_bp *dpa_bp;
> > +	struct bm_buffer bmb[DPA_BUFF_RELEASE_MAX];
>=20
> Where is "struct bm_buffer" defined?
>=20

Thank you, I'll address this and the other observations you have sent.
The struct bm_buffer is defined in the Buffer Manager driver header file,
in include/soc/fsl/bman.h.

Madalin
