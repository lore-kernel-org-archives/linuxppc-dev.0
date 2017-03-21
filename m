Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vngDs1fTKzDqsY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 04:44:44 +1100 (AEDT)
Date: Tue, 21 Mar 2017 11:45:29 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Optimised memset64/memset32 for powerpc
Message-ID: <20170321164527.GJ4402@gate.crashing.org>
References: <20170320211447.GB5073@bombadil.infradead.org>
 <18c572e8-a269-c76e-b3a1-e745ac20e5a7@c-s.fr>
 <20170321132910.GA4482@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321132910.GA4482@bombadil.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2017 at 06:29:10AM -0700, Matthew Wilcox wrote:
> > Unrolling the loop could help a bit on old powerpc32s that don't have branch
> > units, but on those processors the main driver is the time spent to do the
> > effective write to memory, and the operations necessary to unroll the loop
> > are not worth the cycle added by the branch.
> > 
> > On more modern powerpc32s, the branch unit implies that branches have a zero
> > cost.
> 
> Fair enough.  I'm just surprised it was worth unrolling the loop on
> powerpc64 and not on powerpc32 -- see mem_64.S.

We can do at most one loop iteration per cycle, but we can do multiple
stores per cycle, on modern, bigger CPUs.  Many old or small CPUs have
only one load/store unit on the other hand.  There are other issues,
but that is the biggest difference.


Segher
