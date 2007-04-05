Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7A84DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 09:02:06 +1000 (EST)
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <a5ebb728f4c22755d884910149e43c86@kernel.crashing.org>
References: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
	<19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
	<20070404.122129.45875882.davem@davemloft.net>
	<a5ebb728f4c22755d884910149e43c86@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 09:01:47 +1000
Message-Id: <1175814107.30879.143.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It would remove the millions of casts (and the need for the GCC
> -fstrict-aliasing flag for this code).

Ugh ? We don't need casts with void *, that's the whole point ... while
we would do if we used char * ...

I'm not familiar with the details of the strict-breaking-good-programs
rules also known as strict-aliasing but isn't void * supposed to alias
all ? if not, that's really stupid... But even then, I fail to see how
this would break an aliasing rule as we aren't accessing the same object
from two different types and we aren't even writing to it.

> I agree.  However when making this code more generally useful,
> it would be good to make it more correct at the same time, since
> it will only get harder to do so later on.

I think it's perfectly correct with void * ...

Ben.
