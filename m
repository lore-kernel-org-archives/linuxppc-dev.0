Return-Path: <hollisb@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00082DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 06:54:20 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mADJrP10015954
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 12:53:25 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mADJsGaR110024
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 12:54:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mADJsF0I026146
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 12:54:16 -0700
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1226522696.7154.28.camel@pasglop>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
	<1226464663.13515.1.camel@pasglop>
	<20081112063129.4d3ae18b@zod.rchland.ibm.com>
	<1226490730.7154.16.camel@pasglop>
	<1226502685.19156.2.camel@localhost.localdomain>
	<1226522696.7154.28.camel@pasglop>
Content-Type: text/plain
Date: Thu, 13 Nov 2008 13:54:15 -0600
Message-Id: <1226606055.5339.31.camel@localhost.localdomain>
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

On Thu, 2008-11-13 at 07:44 +1100, Benjamin Herrenschmidt wrote:
> 
> Again, why can't we just stick something in the kernel code that
> reserves the last page ? It could be in prom.c or it could be called by
> affected 4xx platforms by the platform code, whatever, but the reserve
> map isn't really meant for that and will not be passed over from kernel
> to kernel by kexec.

Reserving a page is overkill; only the last 256 bytes are affected. We
need to intercept at the LMB level, because allocations are already done
there, so by the time we hit bootmem it's way too late.

I simply don't see a good place to do this in the kernel. It would have
to be before the first lmb_alloc() call, which for safety would put it
inside early_init_devtree() -- along with the other lmb_reserve()
calls.[1]

However, ppc_md.probe() hasn't even been called yet, so there's no way
of knowing if we're on an affected system, unless you want to add a
special of_scan_flat_dt() call here.

I'm open to suggestions, but I don't see a better way than what I
already sent. I think the important part is to call lmb_add() for all
memory, but lmb_reserve() the last 256 bytes before lmb_alloc() happens.

It sounds like kexec must have some knowledge of the platform and device
tree already, so is this really a big deal? At any rate, this
conversation is somewhat academic, since there is no kexec on 44x... so
maybe this can be re-addressed when that becomes a real issue.

[1] This is exactly where flat device tree reservations are done, and
that's why the patch I submitted works.

-- 
Hollis Blanchard
IBM Linux Technology Center
