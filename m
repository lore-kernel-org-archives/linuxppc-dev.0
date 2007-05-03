Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73E31DDFD9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 16:35:53 +1000 (EST)
Date: Thu, 3 May 2007 10:35:34 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070503103534.63ff67b6@localhost.localdomain>
In-Reply-To: <20070501051804.GB3881@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 May 2007 15:18:04 +1000
David Gibson wrote:

> powerpc_flash_init(), the only function in arch/powerpc/sysdev/rom.c,
> goes through the device tree finding anything with device_type=="rom"
> and creating of_platform devices for them, which will be picked up by
> the physmap_of mtd driver.  This has two serious conceptual errors and
> one bad implementation error which is quite an accomplishment for 15
> lines of code.
> 
It should be rewritten then - the way it does init is obsoleted by
the of_platform_bus_probe() now and is confusion-prone. Have to admit I missed
this part while reviewing that rom of_device patch.

[snip]

> 
> Unless someone who actually knows how this code was intended to be
> used can suggest a more polite way of fixing it.
> 
I guess, the idea was for this stuff to be updated once one of the dts inside boot/ would have physmap nodes
added. I have rom/physmap[dts] rehaul in my TODO list, but it has (so far at least) little chance to happen during this merge window. Yet, if someone has suggestions and/or some interest for this to be cured, it will gain priority. Otherwise, I'll replace actual erroneous code with kind of rant that it's up to BSP code to take care of of_devices to be registered, using of_platform_bus_probe() or other way.

-- 
Sincerely, Vitaly
