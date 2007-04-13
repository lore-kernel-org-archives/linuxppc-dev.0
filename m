Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75917DDF53
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:28:43 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <aeef7937e978aec33074251c48dca389@kernel.crashing.org>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
	<aeef7937e978aec33074251c48dca389@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 12:28:30 +1000
Message-Id: <1176431310.5764.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The difference between these two is
> 
> #define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS)
> #define CPU_FTRS_750    (CPU_FTR_COMMON)
> 
> 750GX excludes COMMON, which seems like a bug.  With
> your change, 750CL uses DUAL_PLL_750FX; does it actually
> have that feature?

Looks indeed like that lack of COMMON in the GX entry is a bug...

Josh, care to fix that too while at it ? :-)

> Either way, it seems a good idea to create a CPU_FTRS_750CL,
> the CL is an evolution of the CX, not the FX/GX (in name
> at least, dunno about the gory details).

Agreed.

> > -		.cpu_setup		= __setup_cpu_750cx,
> > +		.cpu_setup		= __setup_cpu_750fx,
> 
> Same thing here.  Are you sure 750CL doesn't need
> the NAP workaround?  [Is anyone sure the 750CX
> actually needs it -- the comment in cpu_setup_6xx.S
> doesn't instill much confidence.]

Agreed too.

Ben.
