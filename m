Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 171D567BD2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 07:10:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Mon, 4 Sep 2006 23:11:20 +0200
References: <200609041237.46528.ossthema@de.ibm.com>
	<20060904201606.GA24386@electric-eye.fr.zoreil.com>
In-Reply-To: <20060904201606.GA24386@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609042311.21202.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Monday 04 September 2006 22:16 schrieb Francois Romieu:
> > +#include "ehea.h"
> > +#include "ehea_qmr.h"
> > +#include "ehea_phyp.h"
>
> Afaik none of those is included in this patch nor in my 2.6.18-git tree.


They are in 5, 3 and 2, respectively

> Happy bissect in sight.

The driver should get merged as a single commit anyway, even
if split diffs are posted for review. Even if it gets merged
like this, bisect will work since the Kconfig option is added
in the final patch.

> > +
> > +static struct net_device_stats *ehea_get_stats(struct net_device *dev)
> > +{
> > +=A0=A0=A0=A0=A0struct ehea_port *port =3D netdev_priv(dev);
> > +=A0=A0=A0=A0=A0struct net_device_stats *stats =3D &port->stats;
> > +=A0=A0=A0=A0=A0struct hcp_ehea_port_cb2 *cb2;
> > +=A0=A0=A0=A0=A0u64 hret, rx_packets;
> > +=A0=A0=A0=A0=A0int i;
>
> unsigned int ?

does it matter? int as a counter is pretty standard.

> > +
> > +=A0=A0=A0=A0=A0if (netif_msg_hw(port))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ehea_dump(cb2, sizeof(*cb2), "n=
et_device_stats");
> > +
> > +=A0=A0=A0=A0=A0rx_packets =3D 0;
>
> Could be initialized when it is declared.
>
> > +=A0=A0=A0=A0=A0for (i =3D 0; i < port->num_def_qps; i++)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rx_packets +=3D port->port_res[=
i].rx_packets;

In one of the previous reviews, we told them to do it this way
instead. Initializing at declaration is error-prone.

> > +
> > +=A0=A0=A0=A0=A0intreq =3D ((pr->p_state.ehea_poll & 0xF) =3D=3D 0xF);
>
> Arguable parenthesis.
>

I'd argue to keep them ;-)

> > +
> > +=A0=A0=A0=A0=A0hret =3D ehea_h_modify_ehea_port(port->adapter->handle,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 port->logical_port_id,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 H_PORT_CB0, mask, cb0);
> > +=A0=A0=A0=A0=A0if (hret !=3D H_SUCCESS) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D -EIO;
>
> Why can't ehea_xyz return -EIO/0 directly ?
>

the lowest-level hypercall should return H_* by convention.

Then again, it should also be called plpar_modify_ehea_port()
in that case.

> > +static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
> > +{
> > +=A0=A0=A0=A0=A0struct ehea_port *port =3D netdev_priv(dev);
> > +=A0=A0=A0=A0=A0struct ehea_port_res *pr;
> > +=A0=A0=A0=A0=A0struct ehea_swqe *swqe;
> > +=A0=A0=A0=A0=A0unsigned long flags;
> > +=A0=A0=A0=A0=A0u32 lkey;
> > +=A0=A0=A0=A0=A0int swqe_index;
> > +
> > +=A0=A0=A0=A0=A0pr =3D &port->port_res[0];
>
> Initialization and declaration can happen at the same time.

it's a gray area. In general, I recommend not to combine them
at all. Initialization to NULL or 0 is always bad, this one
is harmless, but I'd still leave it this way, especially after
telling them to clean this up earlier ;-)

	Arnd <><
