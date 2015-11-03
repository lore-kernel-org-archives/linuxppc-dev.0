Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0110.outbound.protection.outlook.com [207.46.100.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B70071A30D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:37:29 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: Scott Wood <scottwood@freescale.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "ppc@mindchasers.com" <ppc@mindchasers.com>,
 Roy Pledge <roy.pledge@freescale.com>, Liberman Igal
 <Igal.Liberman@freescale.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joe@perches.com" <joe@perches.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [net-next v4 2/8] dpaa_eth: add support for DPAA Ethernet
Date: Tue, 3 Nov 2015 09:37:22 +0000
Message-ID: <BL2PR03MB545ED95392F5CB88EC06B11E62B0@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-3-git-send-email-madalin.bucur@freescale.com>
 <1446537357.21216.49.camel@transmode.se>
In-Reply-To: <1446537357.21216.49.camel@transmode.se>
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
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
>=20
> On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> > +       if (unlikely(fd_status & FM_FD_STAT_RX_ERRORS) !=3D 0) {
> > +               if (net_ratelimit())
> > +                       netif_warn(priv, hw, net_dev, "FD status =3D
> 0x%08x\n",
> > +                                  fd_status & FM_FD_STAT_RX_ERRORS);
> > +
> > +               percpu_stats->rx_errors++;
> > +               goto _release_frame;
> > +       }
>=20
> I cannot find any detailed error accounting(maybe I am not looking hard
> enough) but I
> would appreciate if both TX and RX errors where better
> accounted(rx_length_errors, rx_frame_errors,
> rx_crc_errors, rx_fifo_errors etc.). This has helped me many times in the
> past diagnosing
> board HW problems.
>=20
>  Jocke

Hi Jocke,

There are some error counters exported through ethtool (used to be debugfs)=
.
FMan HW provides more debug information than we currently export, that will=
 be
improved in the future but given the current priority of having a codebase =
as
small and reviewable as possible we had to drop some things from the initia=
l
submission.

Madalin
