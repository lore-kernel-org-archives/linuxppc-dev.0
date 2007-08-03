Return-Path: <joern@lazybastard.org>
Received: from longford.lazybastard.org (lazybastard.de [212.112.238.170])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F7AEDDE11
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 00:27:20 +1000 (EST)
Date: Fri, 3 Aug 2007 15:41:50 +0200
From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 1/1] lro: Generic Large Receive Offload for TCP traffic
Message-ID: <20070803134150.GH19344@lazybastard.org>
References: <200708031441.20632.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200708031441.20632.ossthema@de.ibm.com>
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

On Fri, 3 August 2007 14:41:19 +0200, Jan-Bernd Themann wrote:
> 
> This patch provides generic Large Receive Offload (LRO) functionality
> for IPv4/TCP traffic.
> 
> LRO combines received tcp packets to a single larger tcp packet and 
> passes them then to the network stack in order to increase performance
> (throughput). The interface supports two modes: Drivers can either pass
> SKBs or fragment lists to the LRO engine. 

Maybe this is a stupid question, but why is LRO done at the device
driver level?

If it is a unversal performance benefit, I would have expected it to be
done generically, i.e. have all packets moved into network layer pass
through LRO instead.

> +void lro_flush_pkt(struct net_lro_mgr *lro_mgr,
> +		   struct iphdr *iph, struct tcphdr *tcph);

In particular this bit looks like it should be driven by a timeout,
which would be settable via /proc/sys/net/core/lro_timeout or similar.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson
