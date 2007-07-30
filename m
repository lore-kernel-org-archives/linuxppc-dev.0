Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C4B7DDEBC
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 03:00:45 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6UH0gUn026923
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 13:00:42 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6UH0fML204066
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 11:00:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6UH0e95014146
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 11:00:41 -0600
Date: Mon, 30 Jul 2007 12:00:40 -0500
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
Message-ID: <20070730170038.GA4884@austin.ibm.com>
References: <200707301724.33865.ossthema@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707301724.33865.ossthema@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
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

On Mon, Jul 30, 2007 at 05:24:33PM +0200, Jan-Bernd Themann wrote:
> 
> Changes to http://www.spinics.net/lists/netdev/msg36912.html
> 
> 1) A new field called "features" has been added to the net_lro_mgr struct.
>    It is set by the driver to indicate:
>    - LRO_F_NAPI:            Use NAPI / netif_rx to pass packets to stack
> 
>    - LRO_F_EXTRACT_VLAN_ID: Set by driver if HW extracts VLAN IDs for VLAN
>         packets but does not modify ETH protocol (ETH_P_8021Q)
> 
> 2) Padded frames are not aggregated for now. Bug fixed
> 
> 3) Correct header length now used. No minimal header length for aggregated
>    packets used anymore.
> 
> 4) Statistic counters were introduced. They are stored in a new struct in
>    the net_lro_mgr. This has the advantage that no locking is required in
>    cases where the driver uses multiple lro_mgrs for different receive queues.
>    Thus we get the following statistics per lro_mgr / eth device:
>    - Number of aggregated packets
>    - Number of flushed packets
>    - Number of times we run out of lro_desc.
> 
>    The ratio of "aggregated packets" and "flushed packets" give you an
>    idea how well LRO is working.

I'd like to see an edited form of this, together with an introduction to
LRO, written up in the Documentation subdirectory.  

As someone with some driver experience, but not on te bleeding edge,
some basc newbie questions pop into mind:

-- what is LRO?
-- Basic principles of operation?
-- Can I use it in my driver?  
-- Does my hardware have to have some special feature before I can use it?
-- What sort of performance improvement does it provide? Throughput?
   Latency? CPU usage? How does it affect DMA allocation? Does it 
   improve only a certain type of traffic (large/small packets, etc.)
-- Example code? What's the API? How should my driver use it?

Right now, I can maybe find answers by doing lots of googling.  I'd like
to have some quick way of getting a grip on this.

--linas
   
