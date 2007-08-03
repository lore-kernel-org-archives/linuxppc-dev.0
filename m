Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09A0FDDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 23:10:46 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l73DAf6Y153234
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 13:10:41 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l73DAflg1908898
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:10:41 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l73DAb0q007039
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:10:38 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 0/1] lro: Generic Large Receive Offload for TCP traffic
Date: Fri, 3 Aug 2007 14:41:14 +0200
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708031441.14780.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Andrew Gallatin <gallatin@myri.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I think this patch could be the final version for now. It has been tested
on two platforms (power and x86_64) and works very well.

Apart from David Miller and Evgeniy Polaykov, we'd like to thank especially
Andrew Gallatin for his great reviews and help to make that happen.

After some discussion we decided to post the LRO patch separately from the 
driver patches. Our final driver patches for LRO will be posted later with
some additional fixes for upstream inclusion to the netdev git.
However, I'll also post our LRO patch for the driver today as an example
of how to use this interface.

Thanks a lot,
Jan-Bernd 

[PATCH 1/1] lro: Generic Large Receive Offload for TCP traffic

Changes to http://www.spinics.net/lists/netdev/msg37084.html

1) Fixed the LRO_MAX_PG_HLEN bug

2) skb->ip_summed can now be defined by driver for aggregated packets

3) The problem that the "ramp up" for tcp connections between machines
   with different MTU size (1500 vs 9000) is very slow has been fixed
   by setting skb->gso_size.

4) Checksum problem for little endian machines has been fixed

5) missing additon of vlan_hdr_len for TCP header determination has been added.
