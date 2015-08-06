Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3DED1A3BF9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:40:11 +1000 (AEST)
Date: Wed, 5 Aug 2015 23:39:38 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc32: optimise csum_partial() loop
Message-ID: <20150806043938.GE18479@gate.crashing.org>
References: <cover.1435655733.git.christophe.leroy@c-s.fr>
 <67cf476f657e87b2ea586951a57ae3ba3c1e3c0c.1435655733.git.christophe.leroy@c-s.fr>
 <20150806003059.GD18479@gate.crashing.org>
 <1438828301.2097.126.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438828301.2097.126.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 09:31:41PM -0500, Scott Wood wrote:
> On Wed, 2015-08-05 at 19:30 -0500, Segher Boessenkool wrote:
> > On Wed, Aug 05, 2015 at 03:29:35PM +0200, Christophe Leroy wrote:
> > > On the 8xx, load latency is 2 cycles and taking branches also takes
> > > 2 cycles. So let's unroll the loop.
> > 
> > This is not true for most other 32-bit PowerPC; this patch makes
> > performance worse on e.g. 6xx/7xx/7xxx.  Let's not!
> 
> Chips with a load latency greater than 2 cycles should also benefit from the 
> unrolling.  Have you benchmarked this somewhere and seen it reduce 
> performance?  Do you know of any 32-bit PPC chips with a load latency less 
> than 2 cycles?

The original loop was already optimal, as the comment said.  The new
code adds extra instructions and a mispredicted branch.  You also
might get less overlap between the loads and adde (I didn't check
if there is any originally): those instructions are no longer
interleaved.

I think it is a stupid idea to optimise code for all 32-bit PowerPC
CPUs based on solely what is best for a particularly simple, slow
implementation; and that is what this patch is doing.


Segher
