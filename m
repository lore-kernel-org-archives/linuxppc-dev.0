Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5D521A0591
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 14:25:45 +1100 (AEDT)
Message-ID: <1456197945.12877.1.camel@ellerman.id.au>
Subject: Re: [PATCH v5] powerpc32: provide VIRT_CPU_ACCOUNTING
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, Christophe Leroy
 <christophe.leroy@c-s.fr>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 23 Feb 2016 14:25:45 +1100
In-Reply-To: <1456193718.2463.142.camel@buserror.net>
References: <20160211161650.1F12C1A2400@localhost.localdomain>
 <1455657664.2463.68.camel@buserror.net>
 <1456193080.16667.1.camel@ellerman.id.au>
 <1456193718.2463.142.camel@buserror.net>
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

On Mon, 2016-02-22 at 20:15 -0600, Scott Wood wrote:
> On Tue, 2016-02-23 at 13:04 +1100, Michael Ellerman wrote:
> > On Tue, 2016-02-16 at 15:21 -0600, Scott Wood wrote:
> > > On Thu, 2016-02-11 at 17:16 +0100, Christophe Leroy wrote:
> > > > This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
> > > > PPC32 doesn't have the PACA structure, so we use the task_info
> > > > structure to store the accounting data.
> > > > 
> > > > In order to reuse on PPC32 the PPC64 functions, all u64 data has
> > > > been replaced by 'unsigned long' so that it is u32 on PPC32 and
> > > > u64 on PPC64
> > > > 
> > > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > > ---
> > > > Changes in v3: unlike previous version of the patch that was inspired
> > > > from IA64 architecture, this new version tries to reuse as much as
> > > > possible the PPC64 implementation.
> > > > 
> > > > PPC32 doesn't have PACA and past discusion on v2 version has shown
> > > > that it is not worth implementing a PACA in PPC32 architecture
> > > > (see below benh opinion)
> > > > 
> > > > benh: PACA is actually a data structure and you really really don't want
> > > > it
> > > > on ppc32 :-) Having a register point to current works, having a register
> > > > point to per-cpu data instead works too (ie, change what we do today),
> > > > but don't introduce a PACA *please* :-)
> > > 
> > > And Ben never replied to my reply at the time:
> > > 
> > > "What is special about 64-bit that warrants doing things differently from
> > > 32
> > > -bit?
> > 
> > Nothing. It's just historical cruft. But we're not realistically going to
> > get
> > rid of it anytime soon on 64-bit.
> 
> I wasn't suggesting getting rid of it on 64-bit, but rather adding it on 32
> -bit, to hold things that are used by both.  I was confused by the vehemence
> of Ben's objection.

OK right. I think he's just saying we'd like to (eventually) get rid of it on
64-bit, so adding it on 32-bit would be a step backward.

> > > What is the difference between PACA and "per-cpu data", other than the
> > > obscure name?"
> > 
> > Not much. The pacas are allocated differently to per-cpu data, they're
> > available earlier in boot etc.
> 
> Ah, I was thinking of the general concept of per-cpu data, not the specific
> mechanism that Linux implements in percpu.h etc.

Oh ok, in that case no it's not special at all.

> >  What we'd like is to have r13 point to the
> > per-cpu data area, and then the contents of the paca could just be regular
> > per-cpu data. But like I said above that's a big change.
> 
> That change seems orthogonal to the question of making the mechanism available
> on 32-bit to ease unification of code which uses it.

That's true.

Though in this case I think you actually do want to store those values in the thread_info.
If you look at eg. vtime_delta() where we use those values, it's passed a task
struct.

So your suggestion to define a common struct that is shared between the 32-bit
thread_info and the 64-bit paca would be a good solution I think.

cheers
