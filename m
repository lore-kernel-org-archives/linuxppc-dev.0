Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EA1B67C5F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:51:07 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB7HosIH026479
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 12:50:54 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB7Horbc536716
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 10:50:53 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB7HoqX0001269
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 10:50:53 -0700
Date: Thu, 7 Dec 2006 11:50:46 -0600
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/16] Spidernet RX Locking
Message-ID: <20061207175046.GB4614@austin.ibm.com>
References: <20061206223223.GH17931@austin.ibm.com>
	<20061206233134.GC4649@austin.ibm.com> <4577E850.6040500@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4577E850.6040500@pobox.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 07, 2006 at 05:09:20AM -0500, Jeff Garzik wrote:
> Linas Vepstas wrote:
> >The RX packet handling can be called from several
> >places, yet does not protect the rx ring structure.
> >This patch places the ring buffer pointers under a lock.
> >
> >Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> >Cc: James K Lewis <jklewis@us.ibm.com>
> >Cc: Arnd Bergmann <arnd@arndb.de>
> 
> This is a HUGELY invasive patch.  A sledgehammer.

I am rather unlear what you perceive as being invasive, 
since the patch summary states:

 drivers/net/spider_net.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

> What /specifically/ are these "several places", 

spider_net_decode_one_descr() is called from
spider_net_poll() (which is the netdev->poll callback)
and also from spider_net_handle_rxram_full(). 

The rxramfull routine is called from a tasklet that
is fired off after a "RX ram full" interrupt is receved.
This interrupt is generated when the hardware runs out
of space to store incoming packets. We are seeing this
interrupt fire when the CPU is heavily loaded, and a
lot of traffic is being fired at the device.

> and what other 
> non-sledgehammer approaches were discarded before arriving at this one?

Well, I'm not that good at kernel programming, so I guess
I did not perceive this as a "sledgehammer."  And alternative
approach is to simply ignore the rxramfull interrupt entirely,
and depend on poll() do all the work.   I'll try this shortly.

--linas
