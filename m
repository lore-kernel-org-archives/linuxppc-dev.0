Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 901B267BF5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:48:33 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GNmTF6005110
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 19:48:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GNlTvu124448
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:47:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GNlSrl022024
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:47:29 -0600
Date: Wed, 16 Aug 2006 18:47:28 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816234728.GP20551@austin.ibm.com>
References: <44E34825.2020105@garzik.org> <200608162324.47235.arnd@arndb.de>
	<20060816225558.GM20551@austin.ibm.com>
	<200608170103.21097.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608170103.21097.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org, jklewis@us.ibm.com,
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

On Thu, Aug 17, 2006 at 01:03:20AM +0200, Arnd Bergmann wrote:
> 
> Could well be related to latencies when going to the remote
> node for descriptor DMAs. Have you tried if the hch's NUMA
> patch or using numactl makes a difference here?

No. I guess I should try.

> > > sounds like the right approach to simplify the code.
> >
> > Its not a big a driver. 'wc' says its 2.3 loc, which
> > is 1/3 or 1/5 the size of tg3.c or the e1000*c files.
> 
> Right, I was thinking of removing a lock or another, not
> throwing out half of the driver ;-)

There's only four lock points grand total. 
-- One on the receive side,
-- one to protect the transmit head pointer, 
-- one to protect the transmit tail pointer, 
-- one to protect the location of the transmit low watermark.

The last three share the same lock. I tried using distinct
locks, but this worsened things, probably due to cache-line 
trashing. I tried removing the head pointer lock, but this
failed. I don't know why, and was surprised by this. I thought
hard_start_xmit() was serialized.

--linas
