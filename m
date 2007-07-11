Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B14DDDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 00:47:23 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6BElI7Z078462
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 14:47:18 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6BElHoM1818876
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 16:47:17 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6BElHnv008682
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 16:47:17 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [RFC 0/3] lro: Generic Large Receive Offload for TCP traffic
Date: Wed, 11 Jul 2007 16:21:24 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707111621.24852.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Generic Large Receive Offload proposal

After some discussions on the mailing list concerning our LRO approach,
we agreed to provide a generic LRO patch. The algorithm is based on
the version we developed for eHEA. The performance improvements we
observed were significant.

The LRO functionality is provided as a module, the files are put in
linux/net/ipv4/inet_lro.c
linux/include/linux/inet_lro.h

Would this be the proper place for this functionality?

Currently, the interface is exported via EXPORT_SYMBOL. Or should we use
EXPORT_SYMBOL_GPL instead?


The interface for the network drivers (see inet_lro.h):

A driver has to declare a "LRO Management" struct (lro_mgr) and a LRO descriptor array
of a driver defined size and enters the address of the array and the number of its
elements in the lro_mgr struct. The driver also specifies how many packets
may be aggregated per tcp session in the lro_mgr struct. In addition to that
the driver provides a function that determines the TCP and IP header for the
incoming packet (also entered in the lro_mgr struct). For some ethernet chips this
function doesn't need to do a lot of checking there as the tcp / ip checksums are 
checked by the HW and provides information about the packet protocoll.

To pass packets to the network stack using LRO the following functions are used 
in the NAPI poll function:

void lro_receive_skb(struct net_lro_mgr *lro_mgr,
                     struct sk_buff *skb,
                     void *priv);

or 

void lro_vlan_hwaccel_receive_skb(struct net_lro_mgr *lro_mgr,
                                  struct sk_buff *skb,
                                  struct vlan_group *vgrp,
                                  u16 vlan_tag,
                                  void *priv);

and before leaving the poll function the driver has to flush all open LRO sessions 
and pass the aggregated packets to the stack:

void lro_flush_all(struct net_lro_mgr *lro_mgr);

[RFC 3/3] includes an eHEA patch which shows how LRO is integrated
in the eHEA driver using this interface.


Regards,
Jan-Bernd
