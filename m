Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F971A0339
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 00:17:05 +1000 (EST)
Date: Fri, 13 Jun 2014 09:16:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
Message-ID: <20140613141616.GA7350@gate.crashing.org>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
 <1402518131.14780.60.camel@pasglop> <20140611210351.GA7155@visitor2.iram.es>
 <20140612122639.GA17838@gate.crashing.org>
 <20140613115553.GA31054@visitor2.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140613115553.GA31054@visitor2.iram.es>
Cc: Tejun Heo <htejun@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@gentwo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > So cr5, which is number 73, is never used by gcc. 
> > 
> > Not available for RA is not the same thing at all as not used by GCC.
> > For example, GPR1 and XER[CA] are also fixed regs.
> 
> Indeed, I should have been more clear, it is never explicitly reserved
> by any ABI like GPR1 for the stack pointer nor used implicitly by any pattern
> like the carry (which is also never allocated, but used or clobbered
> by many patterns). However no machine description pattern uses cr5.
> 
> The line "cr5 is not supposed to be used" has always been a mystery
> to me, but gcc has always obeyed this rule. If memory serves it has 
> been in rs6000.h since I got my first PPC board in 1997.

It's been there (in the public repo) since 1992.  The copyrights for
some  of the rest of the port go back to 1990, so the code has most
likely existed at least that far back.

> > But, indeed, it does look like GCC doesn't use it.  It seems to me that
> > some ABI forbade userland (or non-libraries or whatever) from using it.
> > I'll see what I can find out.
> 
> Take what I say with a grain of salt, but I always had the impression that
> it was a remnant from the first port of GCC to Power, which could well have 
> been AIX. This first port might have been done by Richard Kenner.

That is all correct as far as I can see.

Presumably the AIX ABI at that time (AIX2? AIX3?) had cr5 reserved.

Still digging...


Segher
