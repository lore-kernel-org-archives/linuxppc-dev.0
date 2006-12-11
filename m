Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17788.50257.766004.944381@cargo.ozlabs.ibm.com>
Date: Mon, 11 Dec 2006 13:37:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
In-Reply-To: <7C2DAE95-6401-4159-9B7D-FB19C81D4700@kernel.crashing.org>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
	<177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
	<17786.267.627624.105175@cargo.ozlabs.ibm.com>
	<7C2DAE95-6401-4159-9B7D-FB19C81D4700@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Except we use a trap with TO=0 so the CPU could optimise the
> dependency away -- or where does it say this is prohibited?

I don't know that it explicitly says it is prohibited, but Ed Silha
agreed when I asked him that optimizing this would be against the
spirit of the architecture, at least.  I don't think the cpu designers
would bother optimizing this since it wouldn't get them any extra
performance on any benchmark.

> My only nit is I can't find a guarantee that the trap instruction will
> have to get the read data as input before it can "report the exceptions
> it caused".  Would you have anything on that?  I'll sleep so much better
> if I know it's safe :-)

Well, clearly in general the conditional-trap instructions would have
to see their input operand(s) before they can report an exception,
since reporting an exception before that would be incorrect behaviour
- you would end up taking a 700 interrupt when you shouldn't.  In
other words I am asserting that if an instruction reports a trap
exception, that leads inevitably to a 700 interrupt (in the
architecture sense of "interrupt"), unless of course an earlier
instruction also reports an exception.

Your point about TO=0 is reasonable, and something I also worried
about a little, but Ed Silha didn't seem to think it was a problem.

Paul.
