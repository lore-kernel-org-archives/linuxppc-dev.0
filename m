Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE2A0679FC
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:46:29 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IMkJEh019458
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:46:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IMkJ71271822
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:46:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IMkIM0006332
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:46:19 -0400
Date: Fri, 18 Aug 2006 17:46:18 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818224618.GN26889@austin.ibm.com>
References: <20060811170813.GJ10638@austin.ibm.com>
	<1155771820.11312.116.camel@localhost.localdomain>
	<20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818.142513.29571851.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 02:25:13PM -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Fri, 18 Aug 2006 14:23:56 -0500
> 
> > On Thu, Aug 17, 2006 at 01:43:40AM +0200, Benjamin Herrenschmidt wrote:
> > > 
> > > Sounds good (without actually looking at the code though :), that was a
> > > long required improvement to that driver. Also, we should probably look
> > > into using NAPI polling for tx completion queue as well, no ?
> > 
> > Just for a lark, I tried using NAPI polling, while disabling all TX
> > interrupts. Performance was a disaster: 8Mbits/sec, fom which I conclude
> > that the tcp ack packets do not flow back fast enough to allw reliance
> > on NAPI polling for transmit.
> 
> The idea is to use NAPI polling with TX interrupts disabled.

The idea of a low-watermark mark interrupt is that there are *zero*
interrupts, as long as the kernel keeps feeding packets to the device.

In my last email to you, I attached a real-life vmstat trace 
showing exactly zero interrupts over a two minute period. 

However, the zero-interrupt scenario only occurs if the kernel
is actually feeding packets to the driver.  If the socket beffers
are small, then the app blocks, the kernel is idle, and there
are not enough tcp ack packets coming back the other way to 
actually get the NAPI polling to keep the adapter fed.

> We're not saying to use the RX interrupt as the trigger for
> RX and TX work.  Rather, either of RX or TX interrupt will
> schedule the NAPI poll.

And, for a lark, this is exactly what I did. Just to see.
Because there are so few ack packets, there are very few 
RX interrupts -- not enough to get NAPI to actually keep
the device busy.

------
I'm somewhat disoriened from this conversation. Its presumably
clear that low-watermark mechanisms are superior to NAPI. 
>From what I gather, NAPI was invented to deal with cheap 
or low-function hardware; it adds nothing to this particular
situation. Why are we talking about this?

--linas
