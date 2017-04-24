Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBDsS4JCNzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 15:09:16 +1000 (AEST)
Message-ID: <1493010542.25766.201.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Fix opal entry/exit MSR_RI coverage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 15:09:02 +1000
In-Reply-To: <20170424145500.7a3cb11b@roar.ozlabs.ibm.com>
References: <20170330121004.11991-1-npiggin@gmail.com>
 <1492998468.25766.195.camel@kernel.crashing.org>
 <20170424145500.7a3cb11b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-24 at 14:55 +1000, Nicholas Piggin wrote:
> On Mon, 24 Apr 2017 11:47:48 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Thu, 2017-03-30 at 22:10 +1000, Nicholas Piggin wrote:
> > > There are some windows in opal entry/exit that can not recover from a
> > > re-entrant interrupt (e.g., machine check) due to using SRR registers,
> > > but they currently do not have MSR_RI clear.
> > > 
> > > These were found by machine check injection coverage tests using the
> > > powerpc system simulator (Mambo).  
> > 
> > So you make us enter/exit OPAL with RI off with your patch.
> 
> It should hrfid to opal with MSR_RI set. It seems to be doing the right
> thing when stepping through it with the simulator.

Ok, it's me mis-reading it...

I am not fan of changing FIXUP_ENDIAN but I suppose we don't have much
choice. This will slow down OPAL entry/exit further...maybe we should
use HSRR0/1 instead ? That way we don't have to touch RI ...

Cheers,
Ben.
