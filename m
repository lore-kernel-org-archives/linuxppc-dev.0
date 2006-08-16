Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE78E67B60
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 08:56:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GMu07u031188
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 18:56:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GMu0Hh282612
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 18:56:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GMtx62023375
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 18:56:00 -0400
Date: Wed, 16 Aug 2006 17:55:58 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816225558.GM20551@austin.ibm.com>
References: <44E34825.2020105@garzik.org> <44E38157.4070805@garzik.org>
	<20060816.134640.115912460.davem@davemloft.net>
	<200608162324.47235.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608162324.47235.arnd@arndb.de>
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

On Wed, Aug 16, 2006 at 11:24:46PM +0200, Arnd Bergmann wrote:
> 
> it only
> seems to be hard to make it go fast using any of them. 

Last round of measurements seemed linear for packet sizes between
60 and 600 bytes, suggesting that the hardware can handle a 
maximum of 120K descriptors/second, independent of packet size.
I don't know why this is.

> That may
> be the fault of strange locking rules 

My fault; a few months ago, we were in panic mode trying to get
the thing functioning reliably, and I put locks around anything
and everything.  This last patch removes those locks, and protects
only a few pointers (the incrementing of the head and the tail 
pointers, and the location ofthe low watermark) that actually 
needed protection. They need protection because the code can 
get called in various different ways.

> Cleaning up the TX queue only from ->poll() like all the others

I'll try this ... 

> sounds like the right approach to simplify the code.

Its not a big a driver. 'wc' says its 2.3 loc, which 
is 1/3 or 1/5 the size of tg3.c or the e1000*c files.

--linas
