Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33E7D67B70
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:24:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GNOW8U024350
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 19:24:32 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GNOMYa074710
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:24:22 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GNOLa4005911
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:24:22 -0600
Date: Wed, 16 Aug 2006 18:24:21 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816232421.GN20551@austin.ibm.com>
References: <44E38157.4070805@garzik.org>
	<20060816.134640.115912460.davem@davemloft.net>
	<200608162324.47235.arnd@arndb.de>
	<20060816.143203.11626235.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060816.143203.11626235.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, arnd@arndb.de, jeff@garzik.org, netdev@vger.kernel.org,
	jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 16, 2006 at 02:32:03PM -0700, David Miller wrote:
> 
> The best schemes seem to be to interrupt mitigate using a combination
> of time and number of TX entries pending to be purged.  This is what
> most gigabit chips seem to offer.

I seem to be having a multi-hour delay for email delivery, so maybe
we've crossed emails.

A "low watermark interrupt" is an interrupt that is generated when
some queue is "almost empty". This last set of patches implement this
for the TX queue. The interrupt pops when 3/4ths of the packets 
in the queue have been processed.  Playing with ths setting
(3/4ths or some other number) seemed to make little difference.

> On Tigon3, for example, we tell the chip to interrupt if either 53
> frames or 150usecs have passed since the first TX packet has become
> available for reclaim.

The nature of a low-watermark interrupt is that it NEVER pops, as long
as the kernel keeps putting more stuff into the queue, so as to keep 
the queue at least 1/4'th full. I don't know how to mitigate interrupts 
more than that.

--linas
