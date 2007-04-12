Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AC51DDFB5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 03:12:08 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CHC1hS009376
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:12:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CHC1mH126754
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 11:12:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CHC0Re026867
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 11:12:01 -0600
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <aeef7937e978aec33074251c48dca389@kernel.crashing.org>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
	<aeef7937e978aec33074251c48dca389@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 12:10:56 -0500
Message-Id: <1176397856.6379.75.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 18:41 +0200, Segher Boessenkool wrote:
> > PowerPC 750CL has high BATs.  The patch below sets cpu_features to 
> > match that.
> > Without it, the original firmware mappings in the high BATs aren't 
> > cleared
> > which can cause "odd" address translations to occur.
> 
> > -		.cpu_features		= CPU_FTRS_750,
> > +		.cpu_features		= CPU_FTRS_750GX,
> 
> The difference between these two is
> 
> #define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS)
> #define CPU_FTRS_750    (CPU_FTR_COMMON)
> 
> 750GX excludes COMMON, which seems like a bug.  With

CPU_FTR_COMMON is actually a nop in this case anyway.  It should
probably be listed for "completeness", but it's defined to be 0 so it
doesn't really do anything.

> your change, 750CL uses DUAL_PLL_750FX; does it actually
> have that feature?

No, it doesn't, I missed that in the GX feature list.  Good catch.

> 
> Either way, it seems a good idea to create a CPU_FTRS_750CL,
> the CL is an evolution of the CX, not the FX/GX (in name
> at least, dunno about the gory details).

I can do that, or I can just do:

CPU_FTRS_750 | CPU_FTR_HAS_HIGH_BATS

> 
> > -		.cpu_setup		= __setup_cpu_750cx,
> > +		.cpu_setup		= __setup_cpu_750fx,
> 
> Same thing here.  Are you sure 750CL doesn't need
> the NAP workaround?  [Is anyone sure the 750CX
> actually needs it -- the comment in cpu_setup_6xx.S
> doesn't instill much confidence.]

This should be fine.

I'll send out a newer version, and fixup the description with the
comment Milton made.

josh
