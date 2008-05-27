Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0162DDDFD1
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 04:33:07 +1000 (EST)
Message-ID: <483C5414.6050308@freescale.com>
Date: Tue, 27 May 2008 13:33:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<Pine.LNX.4.64.0805271043150.7453@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0805271043150.7453@t2.domain.actdsltmp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:
> Is there an issue with anything _besides_ coherent DMA?
> 
> Could one have a special version of the accessors for drivers that
> want to assume they are strictly ordered vs coherent DMA memory?
> That would be much easier to get right, without slowing _everything_
> down.

It's better to be safe by default and then optimize the fast paths than 
to be relaxed by default and hang the machine in some piece of code that 
runs once a month.  "Premature optimization is the root of all evil", 
and what not.

> One could even go as far as to allow a driver to "#define 
> WANT_STRICT_IO" and then it would get the strict versions.  Add that
> to any driver that uses DMA and then worry about vetting those
> drivers.

See above -- if you must have a #define, then it should be WANT_RELAXED_IO.

-Scott
