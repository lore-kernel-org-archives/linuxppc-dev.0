Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B112F1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 06:08:40 +1000 (AEST)
Date: Tue, 11 Aug 2015 15:08:29 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: Bill Schmidt <wschmidt@us.ibm.com>, Alan Modra <amodra@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Gschwind <mkg@us.ibm.com>,
 paulus@samba.org, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
Message-ID: <20150811200829.GC4711@gate.crashing.org>
References: <20150805140300.218ef661@kryten>
 <20150805041928.GA32178@gate.crashing.org>
 <OFD0811845.CF7950C1-ON86257E9A.002065FB-C1257E9A.00208EE6@us.ibm.com>
 <20150810145228.3f78c8e4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150810145228.3f78c8e4@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2015 at 02:52:28PM +1000, Anton Blanchard wrote:
> Hi Bill, Segher,
> 
> > I agree with Segher.  We already know we have opportunities to do a
> > better job with shrink-wrapping (pushing this kind of useless
> > activity down past early exits), so having examples of code to look
> > at to improve this would be useful.
> 
> I'll look out for specific examples. I noticed this one today when
> analysing malloc(8). It is an instruction trace of _int_malloc().
> 
> The overall function is pretty huge, which I assume leads to gcc using
> so many non volatiles.

That is one part of it; also GCC deals out volatiles too generously.

> Perhaps in this case we should separate out the
> slow path into another function marked noinline.

Or GCC could do that, effectively at least.

> This is just an upstream glibc build, but I'll send the preprocessed
> source off list.

Thanks :-)

[snip code]

After the prologue there are 46 insns executed before the epilogue.
Many of those are conditional branches (that are not executed); it is
all fall-through until it jumps to the "tail" (the few insns before
the epilogue).  GCC knows how to duplicate a tail so that it can do
shrink-wrapping (the original tail needs to be followed by an epilogue,
the duplicated one does not want one); but it can only do it in very
simple cases (one basic block or at least no control flow), and that
is not the case here.  We need to handle more generic tails.

This seems related to (if not the same as!) <http://gcc.gnu.org/PR51982>.


Segher
