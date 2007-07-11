Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22A00DDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 21:06:46 +1000 (EST)
In-Reply-To: <1184149691.6059.82.camel@localhost.localdomain>
References: <9094.1181275235@neuling.org>
	<1184149691.6059.82.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3269B7A5-2D77-4C4D-B28D-397CB73E8568@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] do firmware feature fixups after features are initialised
Date: Wed, 11 Jul 2007 13:06:25 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There are two possibly solutions I see in the long run:
>
>  - We could set the FW features earlier on pseries, though that is  
> a bit
> annoying because that means doing it before the device-tree is
> unflattened.
>
>  - We could constraint lmb_alloc to the first segment until the FW  
> fixup
> occurs, either within lmb_alloc itself, or fixup the callers such as
> unflatten_device_tree, to pass an explicit limit.

c) use a different SLB handler during early boot;
d) preload some SLB entries at very early boot to cover
    the first 4GB or so.

d) sounds nice and simple, but will it work?


Segher
