Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6AB4679F4
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 08:37:35 +1000 (EST)
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <C7A11372-61BF-4EF7-9869-62B0FD5D8F44@freescale.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<1144961737.4935.28.camel@localhost.localdomain>
	<C7A11372-61BF-4EF7-9869-62B0FD5D8F44@freescale.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 08:37:21 +1000
Message-Id: <1144967841.4935.32.camel@localhost.localdomain>
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


> FYI, the user's manual recommends this sequence:
> loop:
>        sync
>        mtmsr POW
>        isync
>        b     loop

Ok, that's what OS X does... I always wondered ...

So ideally, we should do something similar to the above and set some
global bit somewhere telling the exception path to change the return
address. In either case, the actual form of the loop becomes fairly
irrelevant.

I need to verify what's up with the 970. I noticed Apple has some
additional weird tricks involving setting the DEC to a short value but
setting POW without EE (though I don't remember for sure, I should dbl
check their code). I suppose I should ask some IBM folks there.

Ben.
 
