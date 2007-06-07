Return-Path: <TKLEIN@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA6FBDDED5
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 18:15:01 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l578Ev55059726
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 08:14:57 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l578EvT74079694
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 10:14:57 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l578EuCM003840
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 10:14:56 +0200
In-Reply-To: <1181176500.4166.1.camel@concordia.ozlabs.ibm.com>
Subject: Re: [PATCH 2.6.22-rc4] ehea: Fixed possible kernel panic on
	VLAN	packet recv
To: michael@ellerman.id.au
Message-ID: <OF26993092.A6D2FCCC-ONC12572F3.002C9D0F-C12572F3.002D3FB4@de.ibm.com>
From: Thomas Q Klein <TKLEIN@de.ibm.com>
Date: Thu, 7 Jun 2007 10:14:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, tklein@linux.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> wrote on 06/07/2007 02:35:00 AM:

> On Wed, 2007-06-06 at 20:53 +0200, Thomas Klein wrote:
> > This patch fixes a possible kernel panic due to not checking the vlan
group
> > when processing received VLAN packets and a malfunction in
VLAN/hypervisor
> > registration.
> >
> >
> > Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> > ---
> >
> >
> > diff -Nurp -X dontdiff linux-2.6.22-rc4/drivers/net/ehea/ehea.h
> patched_kernel/drivers/net/ehea/ehea.h
> > --- linux-2.6.22-rc4/drivers/net/ehea/ehea.h   2007-06-05 02:57:
> 25.000000000 +0200
> > +++ patched_kernel/drivers/net/ehea/ehea.h   2007-06-06 12:53:58.
> 000000000 +0200
> > @@ -39,7 +39,7 @@
> >  #include <asm/io.h>
> >
> >  #define DRV_NAME   "ehea"
> > -#define DRV_VERSION   "EHEA_0061"
> > +#define DRV_VERSION   "EHEA_0064"
> >
> >  #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
> >     | NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
> > diff -Nurp -X dontdiff linux-2.6.22-
> rc4/drivers/net/ehea/ehea_main.c
patched_kernel/drivers/net/ehea/ehea_main.c
> > --- linux-2.6.22-rc4/drivers/net/ehea/ehea_main.c   2007-06-05 02:
> 57:25.000000000 +0200
> > +++ patched_kernel/drivers/net/ehea/ehea_main.c   2007-06-06 12:
> 53:58.000000000 +0200
> > @@ -1947,7 +1945,7 @@ static void ehea_vlan_rx_add_vid(struct
> >     }
> >
> >     index = (vid / 64);
> > -   cb1->vlan_filter[index] |= ((u64)(1 << (vid & 0x3F)));
> > +   cb1->vlan_filter[index] |= ((u64)(0x8000000000000000 >> (vid &
0x3F)));
> >
> >     hret = ehea_h_modify_ehea_port(adapter->handle,
port->logical_port_id,
> >                     H_PORT_CB1, H_PORT_CB1_ALL, cb1);
> > @@ -1982,7 +1980,7 @@ static void ehea_vlan_rx_kill_vid(struct
> >     }
> >
> >     index = (vid / 64);
> > -   cb1->vlan_filter[index] &= ~((u64)(1 << (vid & 0x3F)));
> > +   cb1->vlan_filter[index] &= ~((u64)(0x8000000000000000 >> (vid &
0x3F)));
>
> These two seem ripe for splitting into some sort of helper routine.
> Which would leave only one place to get it right.
>
Basically agreed. But as we're already at rc4 I wanted to keep the
patch as least invasive as possible. The modification you suggest
can be implemented as a code improvement in 2.6.23.
