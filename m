Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BECC7DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:28:23 +1000 (EST)
Subject: Re: [PATCH] do firmware feature fixups after features are initialised
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <9094.1181275235@neuling.org>
References: <9094.1181275235@neuling.org>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 20:28:10 +1000
Message-Id: <1184149691.6059.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-08 at 14:00 +1000, Michael Neuling wrote:
> On pSeries the firmware features are not setup until ppc_md.init_early,
> so we can't do the firmware feature sections fixups till after this.
> 
> Currently firmware feature sections is only used on iSeries which inits
> the firmware features much earlier.  This is a bug in waiting on
> pSeries. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> paulus: since we aren't hitting this currently, it can wait for 2.6.23. 

This patch will cause the kernel to blow up at boot on various machines,
I'm surprised we haven't hit that already.

The problem is that we can't service SLB miss on a !iseries machine if
CONFIG_PPC_ISERIES is set, before the fixup occurs. (Some iseries code
in there will not have been nop'ed out and SRR0 will be loaded with
crap).

Thus we die when unflattening the device-tree on some machines.

There are two possibly solutions I see in the long run:

 - We could set the FW features earlier on pseries, though that is a bit
annoying because that means doing it before the device-tree is
unflattened.

 - We could constraint lmb_alloc to the first segment until the FW fixup
occurs, either within lmb_alloc itself, or fixup the callers such as
unflatten_device_tree, to pass an explicit limit.

What do you think ?

Ben.
