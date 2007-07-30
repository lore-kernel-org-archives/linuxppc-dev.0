Return-Path: <gallatin@myri.com>
Received: from myri.com (dsl.myri.com [64.172.73.26])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93FB5DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 03:52:25 +1000 (EST)
Message-ID: <46AE232F.3080409@myri.com>
Date: Mon, 30 Jul 2007 13:43:11 -0400
From: Andrew Gallatin <gallatin@myri.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
References: <200707301724.33865.ossthema@de.ibm.com>
	<20070730170038.GA4884@austin.ibm.com>
In-Reply-To: <20070730170038.GA4884@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
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


Here is a quick reply before something more official can
be written up:

Linas Vepstas wrote:

 > -- what is LRO?

Large Receive Offload

 > -- Basic principles of operation?

LRO is analogous to a receive side version of TSO.  The NIC (or
driver) merges several consecutive segments from the same connection,
fixing up checksums, etc.  Rather than up to 45 separate 1500 byte
frames (meaning up to 45 trips through the network stack), the driver
merges them into one 65212 byte frame.  It currently works only
with TCP over IPv4.

LRO was, AFAIK, first though of by Neterion.  They had a paper about
it at OLS2005.
http://www.linuxinsight.com/files/ols2005/grossman-reprint.pdf

 > -- Can I use it in my driver?

Yes, it can be used in any driver.

 > -- Does my hardware have to have some special feature before I can 
use it?

No.

 > -- What sort of performance improvement does it provide? Throughput?
 >    Latency? CPU usage? How does it affect DMA allocation? Does it
 >    improve only a certain type of traffic (large/small packets, etc.)

The benefit is directly proportional to the packet rate.

See my reply to the previous RFC for performance information.  The
executive summary is that for the myri10ge 10GbE driver on low end
hardware with 1500b frames, I've seen it increase throughput by a
factor of nearly 2.5x, while at the same time reducing CPU utilization
by 17%.  The affect for jumbo frames is less dramatic, but still
impressive (1.10x, 14% CPU reduction)

You can achieve better speedups if your driver receives into
high-order pages.

 > -- Example code? What's the API? How should my driver use it?

The 3/4 in this patch showed an example of converting a driver
to use LRO for skb based receive buffers.   I'm working on
a patch for myri10ge that shows how you would use it in a driver
which receives into pages.

Cheers,

Drew
