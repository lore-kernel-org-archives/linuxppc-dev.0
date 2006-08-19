Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2487767A3D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 14:34:09 +1000 (EST)
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060818234532.GA8644@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
	<20060818.155116.112621100.davem@davemloft.net>
	<20060818232942.GO26889@austin.ibm.com>
	<20060818234532.GA8644@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 19 Aug 2006 14:33:42 +1000
Message-Id: <1155962022.5803.68.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-18 at 18:45 -0500, Linas Vepstas wrote:
> On Fri, Aug 18, 2006 at 06:29:42PM -0500, linas wrote:
> > 
> > I don't understand what you are saying. If I call the transmit 
> > queue cleanup code from the poll() routine, nothing hapens, 
> > because the kernel does not call the poll() routine often 
> > enough. I've stated this several times.  
> 
> OK, Arnd gave me a clue stick. I need to call the (misnamed)
> netif_rx_schedule() from the tx interrupt in order to get 
> this to work. That makes sense, and its easy, I'll send the 
> revised patch.. well, not tonight, but shortly.

You might not want to call it all the time though... You need some
interrupt mitigation and thus a timer that calls netif_rx_schedule()
might be of some use still...

Ben.
