Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 183D1DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 11:55:24 +1000 (EST)
Date: Thu, 29 May 2008 18:53:12 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <1212098739.8888.58.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0805291840430.18973@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop>
	<adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop>
	<adaiqwzsa83.fsf@cisco.com>  <yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<1212097223.8888.55.camel@pasglop>
	<Pine.LNX.4.64.0805291442420.18832@t2.domain.actdsltmp>
	<1212098739.8888.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 May 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-29 at 14:48 -0700, Trent Piepho wrote:
>
>> I wrote a JTAG over gpio driver for the powerpc MPC8572DS platform.  With the
>> non-raw io accessors, the JTAG clock can run at almost ~9.5 MHz.  Using raw
>> versions (which I had to write since powerpc doesn't have any), the clock
>> speed increases to about 28 MHz.  So it can make a very significant different.
>
> Yes, sync's can hurt a lot. This is why I initially tried to get more
> relaxed semantics.
>
> We could implement something like __ variants and do something that
> would still have eieio's but not sync's for example (ie. MMIOs are still
> ordered vs. each other but not vs. coherent memory).

The problem current with the raw variants is that not all archs have them. 
And for those that do, there is no defined semantics.  Each arch is different
as to what ordering they have (and endianness too).

If you want to write a driver that is (or might be one day) multi-platform,
there aren't any less ordered accessors one can use.  A lot of drivers don't
even use coherent DMA, and could use less strictly ordered semantics quite
trivially.  Except there aren't any.
