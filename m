Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wkSk4yykzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:35:50 +1000 (AEST)
Date: Wed, 30 May 2018 03:35:40 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 2/4] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20180530083540.GG17342@gate.crashing.org>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-3-git-send-email-wei.guo.simon@gmail.com>
 <20180528110558.GZ17342@gate.crashing.org>
 <20180530081402.GB5951@simonLocalRHEL7.x64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530081402.GB5951@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 30, 2018 at 04:14:02PM +0800, Simon Guo wrote:
> Hi Segher,
> On Mon, May 28, 2018 at 06:05:59AM -0500, Segher Boessenkool wrote:
> > On Fri, May 25, 2018 at 12:07:34PM +0800, wei.guo.simon@gmail.com wrote:
> > > +	/* save and restore cr0 */
> > > +	mfocrf  r5,64
> > > +	EXIT_VMX_OPS
> > > +	mtocrf	64,r5
> > > +	b	.LcmpAB_lightweight
> > 
> > That's cr1, not cr0.  You can use mcrf instead, it is cheaper (esp. if
> > you have it in a non-volatile CR field before so you need only one, if any).
> > 
> You are right :) How about using mtcr/mfcr instead, I think they are
> fast as well and more readable.

Those are much worse than m[ft]ocrf.

You probably should just shuffle things around so that EXIT_VMX_OPS
does not clobber the CR field you need to keep.


Segher
