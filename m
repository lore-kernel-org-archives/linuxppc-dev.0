Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B48D67B5F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 07:58:44 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GLwfme004780
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:58:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GLweds317410
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 15:58:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GLwdiH006388
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 15:58:40 -0600
Date: Wed, 16 Aug 2006 16:58:39 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816215839.GK20551@austin.ibm.com>
References: <44E34825.2020105@garzik.org>
	<20060816203043.GJ20551@austin.ibm.com>
	<44E38157.4070805@garzik.org>
	<20060816.134640.115912460.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060816.134640.115912460.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, arnd@arndb.de, netdev@vger.kernel.org,
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

On Wed, Aug 16, 2006 at 01:46:40PM -0700, David Miller wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Wed, 16 Aug 2006 16:34:31 -0400
> 
> > Linas Vepstas wrote:
> > > I was under the impression that NAPI was for the receive side only.
> > 
> > That depends on the driver implementation.
> 
> What Jeff is trying to say is that TX reclaim can occur in
> the NAPI poll routine, and in fact this is what the vast
> majority of NAPI drivers do.

I'll experiment with this.  When doing, say, an ftp, there are 
enough TCP ack packets coming back to have NAPI netdev->poll 
be called frequently enough? 

> implied.  In fact, I get the impression that spidernet is limited
> in some way and that's where all the strange approaches are coming
> from :)

Hmm. Or maybe I'm just getting old. Once upon a time, low watermarks
were considered the "best" way of doing anything; never occurred to me
it would be considered "strange".  Based on my probably obsolete idea
of what constitutes "slick hardware", I was actually impressed by what
the spidernet could do.

Aside from cleaning up the transmit ring in the receive poll loop,
what would be the not-so-strange way of doing things?

--linas
