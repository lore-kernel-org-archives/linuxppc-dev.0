Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF191DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 01:53:54 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6UFrnYW061666
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 15:53:49 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6UFrnFX2953464
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 16:53:49 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6UFrXIA007638
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 16:53:33 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP traffic
Date: Mon, 30 Jul 2007 17:24:33 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707301724.33865.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>,
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

Hi,

this patch set contains the latest generic LRO code, a Kconfig / Makefile
and an eHEA patch demonstrating how the "aggregate SKB" interface has to
to be used.
Drew, could you provide a patch for the myri10ge driver to show how the
"receive in page" interface works?

Please check the Kconfig / Makefile patch. Is that the right place for
the LRO entries?

There is still one open question for the "receive in page" mode:
How many data (length) has to be copied to skb->data for packets that
do not work for LRO (other protocols?). Currently I choose 64 as default.
Is that ok?

Thanks,
Jan-Bernd

[PATCH 1/4][RFC] lro: Generic Large Receive Offload for TCP traffic
[PATCH 2/4][RFC] lro: Kconfig and Makefile
[PATCH 3/4][RFC] ehea: LRO support
[PATCH 4/4][RFC] ehea: Kconfig


Changes to http://www.spinics.net/lists/netdev/msg36912.html

1) A new field called "features" has been added to the net_lro_mgr struct.
   It is set by the driver to indicate:
   - LRO_F_NAPI:            Use NAPI / netif_rx to pass packets to stack

   - LRO_F_EXTRACT_VLAN_ID: Set by driver if HW extracts VLAN IDs for VLAN
        packets but does not modify ETH protocol (ETH_P_8021Q)

2) Padded frames are not aggregated for now. Bug fixed

3) Correct header length now used. No minimal header length for aggregated
   packets used anymore.

4) Statistic counters were introduced. They are stored in a new struct in
   the net_lro_mgr. This has the advantage that no locking is required in
   cases where the driver uses multiple lro_mgrs for different receive queues.
   Thus we get the following statistics per lro_mgr / eth device:
   - Number of aggregated packets
   - Number of flushed packets
   - Number of times we run out of lro_desc.

   The ratio of "aggregated packets" and "flushed packets" give you an
   idea how well LRO is working.
