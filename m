Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EFF6679F4
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 06:55:51 +1000 (EST)
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 06:55:37 +1000
Message-Id: <1144961737.4935.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> The above code should really look like this:
> 
>          mfmsr   r7
>          ori     r7,r7,MSR_EE
>          oris    r7,r7,MSR_POW@h
>          sync
>          isync
>          mtmsr   r7
>          isync
> label:
>          b label
> 	blr

Ohhh ... we always assumed mtmsr with MSR_POW was
immediate/synchronous ! That explains a lot. The problem with the above
though is that we'll never get out unless we also hack the exception
path to change the return address once an exception happens. It's not
that difficult especially since we already have a special case to handle
returning from NAP there, on ppc32 at least. ppc64 will need a bit more
investigation.

Do you see another way to loop until NAP has gone ? Maybe reading msr in
a loop until POW gets cleared would do the trick ?

> Hope this helps - I don't have hardware to test this on, so I can't  
> be sure, but it seems to explain the behavior you're seeing if I'm  
> understanding the problem correctly.

It definitely does ! Thanks a lot.

Ben.
