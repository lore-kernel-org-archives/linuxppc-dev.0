Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 855FCDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 07:46:02 +1100 (EST)
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1226502685.19156.2.camel@localhost.localdomain>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
	<1226464663.13515.1.camel@pasglop>
	<20081112063129.4d3ae18b@zod.rchland.ibm.com>
	<1226490730.7154.16.camel@pasglop>
	<1226502685.19156.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Nov 2008 07:44:56 +1100
Message-Id: <1226522696.7154.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, yanok@emcraft.com, kvm-ppc@vger.kernel.org,
	dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-12 at 09:11 -0600, Hollis Blanchard wrote:
> Forget pages. The errata is about the last 256 bytes of physical
> memory.
> 
> > I still find it a bit tricky to have memory nodes not aligned on
> nice
> > fat big boundaries tho.
> 
> I don't know what you're referring to. The patch I sent doesn't touch
> memory nodes, so they are indeed still aligned on nice fat big
> boundaries.

My last comment was about the approach of modifying the memory node.

> I don't think this is overengineering at all. We can't touch the last
> 256 bytes, so we mark it reserved, and then we won't. Altering memory
> nodes is far more complicated and error-prone.

But your approach is going to be painful for kexec which will have to
duplicate that logic.

Again, why can't we just stick something in the kernel code that
reserves the last page ? It could be in prom.c or it could be called by
affected 4xx platforms by the platform code, whatever, but the reserve
map isn't really meant for that and will not be passed over from kernel
to kernel by kexec.

Ben.
