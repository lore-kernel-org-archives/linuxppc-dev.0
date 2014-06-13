Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (torres.puc.rediris.es [130.206.18.22])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38D621A0558
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 21:56:13 +1000 (EST)
Date: Fri, 13 Jun 2014 13:55:53 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
Message-ID: <20140613115553.GA31054@visitor2.iram.es>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
 <1402518131.14780.60.camel@pasglop>
 <20140611210351.GA7155@visitor2.iram.es>
 <20140612122639.GA17838@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140612122639.GA17838@gate.crashing.org>
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

On Thu, Jun 12, 2014 at 07:26:39AM -0500, Segher Boessenkool wrote:
> > Actually, from gcc/config/rs6000.h:
> > 
> > /* 1 for registers that have pervasive standard uses
> >    and are not available for the register allocator.
> 
> [snip]
> 
> > So cr5, which is number 73, is never used by gcc. 
> 
> Not available for RA is not the same thing at all as not used by GCC.
> For example, GPR1 and XER[CA] are also fixed regs.

Indeed, I should have been more clear, it is never explicitly reserved
by any ABI like GPR1 for the stack pointer nor used implicitly by any pattern
like the carry (which is also never allocated, but used or clobbered
by many patterns). However no machine description pattern uses cr5.

The line "cr5 is not supposed to be used" has always been a mystery
to me, but gcc has always obeyed this rule. If memory serves it has 
been in rs6000.h since I got my first PPC board in 1997.

> 
> But, indeed, it does look like GCC doesn't use it.  It seems to me that
> some ABI forbade userland (or non-libraries or whatever) from using it.
> I'll see what I can find out.
> 

Take what I say with a grain of salt, but I always had the impression that
it was a remnant from the first port of GCC to Power, which could well have 
been AIX. This first port might have been done by Richard Kenner.

Actually, a long time ago (1999-2000?) I toyed with he idea of using cr5 for 
soft masking of interrupts on PPC32. But I got distracted by other things
and never came around to it.

	Gabriel
