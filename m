Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A937DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 18:21:11 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l768L5g5914318
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 08:21:05 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l768L58c1736888
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 10:21:05 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l768L1ib014508
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 10:21:01 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: =?utf-8?q?J=C3=B6rn_Engel?= <joern@logfs.org>
Subject: Re: [PATCH 1/1] lro: Generic Large Receive Offload for TCP traffic
Date: Mon, 6 Aug 2007 09:51:11 +0200
References: <200708031441.20632.ossthema@de.ibm.com>
	<20070803134150.GH19344@lazybastard.org>
In-Reply-To: <20070803134150.GH19344@lazybastard.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200708060951.12408.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Andrew Gallatin <gallatin@myri.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi J=C3=B6rn

On Friday 03 August 2007 15:41, J=C3=B6rn Engel wrote:
> On Fri, 3 August 2007 14:41:19 +0200, Jan-Bernd Themann wrote:
> >=20
> > This patch provides generic Large Receive Offload (LRO) functionality
> > for IPv4/TCP traffic.
> >=20
> > LRO combines received tcp packets to a single larger tcp packet and=20
> > passes them then to the network stack in order to increase performance
> > (throughput). The interface supports two modes: Drivers can either pass
> > SKBs or fragment lists to the LRO engine.=20
>=20
> Maybe this is a stupid question, but why is LRO done at the device
> driver level?
>=20
> If it is a unversal performance benefit, I would have expected it to be
> done generically, i.e. have all packets moved into network layer pass
> through LRO instead.

The driver seems to be the right place:
=2D  There is the "page mode" interface that accepts fragment lists instead=
 of
   SKBs and does generate SKBs only in the end (see Andrew Gallatins=20
   mails where he described the advantages of this approach)

=2D  Some drivers (in particular for 10G NICs which actually could benefit
   from LRO) have multiple HW receive queues that do some sort of sorting,
   thus using one lro_mgr per queue increases the likelyhood of beeing able
   to do efficient LRO.
  =20

> > +void lro_flush_pkt(struct net_lro_mgr *lro_mgr,
> > +		   struct iphdr *iph, struct tcphdr *tcph);

> In particular this bit looks like it should be driven by a timeout,
> which would be settable via /proc/sys/net/core/lro_timeout or similar.

No, this function is needed for "page mode" as some HW provides
extra handling for small packets where packets are not stored in preallocat=
ed=20
pages but in extra queues. Thus the driver needs a way to flush old sessions
for this connection and handle these packets in a different way (for exampl=
e=20
create a SKB and copy the data there).

Timeouts are not used at all. Experiments showed that flushing at the end=20
of a NAPI poll round seems to be sufficient (see Andrew's test results)
and does not affect the latency too badly.

Regards,
Jan-Bernd
