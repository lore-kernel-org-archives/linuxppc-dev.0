Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75EE21A05C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 08:18:27 +1000 (AEST)
Date: Tue, 11 Aug 2015 17:18:05 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: Michael Gschwind <mkg@us.ibm.com>, Alan Modra <amodra@gmail.com>,
 Bill Schmidt <wschmidt@us.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
Message-ID: <20150811221805.GD4711@gate.crashing.org>
References: <20150805140300.218ef661@kryten>
 <20150805041928.GA32178@gate.crashing.org>
 <OFD0811845.CF7950C1-ON86257E9A.002065FB-C1257E9A.00208EE6@us.ibm.com>
 <20150810145228.3f78c8e4@kryten> <20150811200829.GC4711@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150811200829.GC4711@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2015 at 03:08:29PM -0500, Segher Boessenkool wrote:
> [snip code]
> 
> After the prologue there are 46 insns executed before the epilogue.
> Many of those are conditional branches (that are not executed); it is
> all fall-through until it jumps to the "tail" (the few insns before
> the epilogue).  GCC knows how to duplicate a tail so that it can do
> shrink-wrapping (the original tail needs to be followed by an epilogue,
> the duplicated one does not want one); but it can only do it in very
> simple cases (one basic block or at least no control flow), and that
> is not the case here.  We need to handle more generic tails.

And never mind the elephant in the room: the "fastpath" instructions
already use a few non-volatile registers, and the shrink-wrap pass
(which runs after register allocation) cannot fix that.  Ugh.

> This seems related to (if not the same as!) <http://gcc.gnu.org/PR51982>.

This has that same problem, too.


Segher
