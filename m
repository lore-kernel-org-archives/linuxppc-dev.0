Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9165D67B6D
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 20:32:31 +1100 (EST)
In-Reply-To: <17786.267.627624.105175@cargo.ozlabs.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
	<177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
	<17786.267.627624.105175@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7C2DAE95-6401-4159-9B7D-FB19C81D4700@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
Date: Sat, 9 Dec 2006 10:32:13 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> isync is context synchronizing.  In the definition of context
> synchronization, it says "2.  The operation is not initiated, or in
> the case of isync, does not complete, until all instructions already
> in execution have completed to a point at which they have reported all
> exceptions they will cause".

> The twi conditionally causes an exception

Except we use a trap with TO=0 so the CPU could optimise the
dependency away -- or where does it say this is prohibited?

For conditional branches, this behaviour (not optimising away
branches, even if they have a result independent on the data)
is explicitly documented.

> depending on the data from the previous load, therefore it
> cannot complete to a point at which is has reported all exceptions it
> will cause until it sees the data from the load.  Therefore the isync
> cannot complete (and allow following instructions to start) until the
> data from the load has returned.
>
> I once asked Ed Silha (one of the PowerPC architects) whether this
> reasoning was good, and he agreed it was.

My only nit is I can't find a guarantee that the trap instruction will
have to get the read data as input before it can "report the exceptions
it caused".  Would you have anything on that?  I'll sleep so much better
if I know it's safe :-)


Segher
