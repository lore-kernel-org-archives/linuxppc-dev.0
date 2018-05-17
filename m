Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40n6GZ3t7xzF13V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 09:00:38 +1000 (AEST)
Date: Thu, 17 May 2018 18:00:08 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Ensure gcc doesn't move around cache flushing in
 __patch_instruction
Message-ID: <20180517230007.GC17342@gate.crashing.org>
References: <48284701fe497bb4f5bede5c55bbce9d70309562.camel@kernel.crashing.org>
 <20180517192331.GZ17342@gate.crashing.org>
 <18a52794a30857146396dd6023abf17179db53d0.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18a52794a30857146396dd6023abf17179db53d0.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 08:30:27AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-05-17 at 14:23 -0500, Segher Boessenkool wrote:
> > On Thu, May 17, 2018 at 01:06:10PM +1000, Benjamin Herrenschmidt wrote:
> > > The current asm statement in __patch_instruction() for the cache flushes
> > > doesn't have a "volatile" statement and no memory clobber. That means
> > > gcc can potentially move it around (or move the store done by put_user
> > > past the flush).
> > 
> > volatile is completely superfluous here, except maybe as documentation:
> > any asm without outputs is always volatile.
> 
> I wasn't aware of that. I was drilled early on to always stick volatile
> in my asm statements if they have any form of side effect :-)

If an asm without output was not marked automatically as having another
side effect, every such asm would be immediately deleted ;-)

Adding volatile as documentation for side effects can be good; it just
doesn't do much (nothing, in fact) for asms without output as far as
the compiler is concerned.

> > (And the memory clobber does not prevent the compiler from moving the
> > asm around, or duplicating it, etc., and neither does the volatile).
> 
> It prevents load/stores from moving around doesn't it ? I wanted to
> make sure the store of the instruction doesn't move in/pass the asm. If
> you say that's not needed then ignore the patch.

No, it's fine here, and you want either that or put exactly the memory
you are touching in a constraint (probably overkill here).  I just
wanted to say that a "memory" clobber does nothing more than say the
asm touches some unspecified memory; there is no magic other meaning
to it.  Your patch is correct, just the "volatile" part isn't needed,
and the explanation was a bit cargo-culty ;-)


Segher
