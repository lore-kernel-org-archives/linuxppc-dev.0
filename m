Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D4E967D2F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 03:37:31 +1100 (EST)
In-Reply-To: <17788.50257.766004.944381@cargo.ozlabs.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
	<177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
	<17786.267.627624.105175@cargo.ozlabs.ibm.com>
	<7C2DAE95-6401-4159-9B7D-FB19C81D4700@kernel.crashing.org>
	<17788.50257.766004.944381@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6F399702-6985-4B20-B562-0AB90F7F7258@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
Date: Mon, 11 Dec 2006 17:37:19 +0100
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

>> Except we use a trap with TO=0 so the CPU could optimise the
>> dependency away -- or where does it say this is prohibited?
>
> I don't know that it explicitly says it is prohibited, but Ed Silha
> agreed when I asked him that optimizing this would be against the
> spirit of the architecture, at least.

Yeah true.  Weirder things that go against "the spirit of the
architecture" have happened though :-)

> I don't think the cpu designers
> would bother optimizing this since it wouldn't get them any extra
> performance on any benchmark.

Not directly for this case -- but it might happen as a side
effect of a more general optimisation perhaps.  Who knows.

>> My only nit is I can't find a guarantee that the trap instruction  
>> will
>> have to get the read data as input before it can "report the  
>> exceptions
>> it caused".  Would you have anything on that?  I'll sleep so much  
>> better
>> if I know it's safe :-)
>
> Well, clearly in general the conditional-trap instructions would have
> to see their input operand(s) before they can report an exception,
> since reporting an exception before that would be incorrect behaviour
> - you would end up taking a 700 interrupt when you shouldn't.

I meant for the case where the exceptions it reports are
"no exceptions".  In some cases (like TO=0) the CPU could
short-circuit the evaluation of what exceptions can be
caused before it has all the input data.  As another
(farfetched but perhaps more realistic) example, a CPU that
does a lot of (memory) speculation could decide that an
instruction will not cause an exception, if it doesn't do
so on any of the possible (speculated) paths.

> Your point about TO=0 is reasonable, and something I also worried
> about a little, but Ed Silha didn't seem to think it was a problem.

It would be lovely to get a guarantee about this in the
architecture.  Failing that, what about this comment (edited
from Linas' patch and your mail):


Read operations have additional twi & isync to make sure the read
is actually performed (i.e. the data has come back) before we start
executing any following instructions.

isync is context synchronizing.  In the definition of context
synchronization, the architecture documents say "2.  The operation
is not initiated, or in the case of isync, does not complete, until
all instructions already in execution have completed to a point at
which they have reported all exceptions they will cause".  The twi
conditionally causes an exception depending on the data from the
previous load; on all current CPUs it will not complete until it
sees the data from the load.  Therefore the isync cannot complete
(and allow following instructions to start) until the data from the
load has returned.


Segher
