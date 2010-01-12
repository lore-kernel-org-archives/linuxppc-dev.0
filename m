Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9935BB6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 13:25:39 +1100 (EST)
Subject: Re: [PATCH] Make cpu hotplug driver lock part of ppc_md
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4B322DD6.60801@austin.ibm.com>
References: <4B30DB8B.3030305@austin.ibm.com>
	<1261520982.17348.8.camel@concordia>  <4B322DD6.60801@austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 13:23:16 +1100
Message-ID: <1263262996.724.176.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> The intention of the cpu_hotplug_driver_locks to add additional serialization
> during cpu hotplug operations.  For pseries this is used during DLPAR of cpu
> operations so that cpu hotplug actions cannot be initiated whiloe a DLPAR
> operation is in flight.  For example, during DLPAR add we take the lock while
> acquiring the cpu from firmware and updating the device tree with the new
> cpu information, after which we hotplug add the cpu to the system.  
> 
> There is nothing harmless about taking the lock on all platforms, I was just
> trying to avoid taking the lock if the additional serialization is not needed.
> 
> > 
> > If so, you could just make the mutex available to all powerpc code, and
> > rename it, and then we wouldn't need all this jiggery pokery just to
> > take & release a lock.
> 
> I can make the lock available to all powerpc code and not go through the
> ppc_md struct, it makes no difference to me personally.  Of course this would
> make all that fun pokery jiggery go away :)

Yeah, Michael is right, just make it global to powerpc, it should make
things simpler.

Cheers,
Ben.
