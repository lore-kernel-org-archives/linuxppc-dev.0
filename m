Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 34074DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 19:12:32 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 23 May 2007 11:12:22 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fsl booke MM vs. SMP questions
Message-ID: <20070523091222.GB4481@iram.es>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<20070522084645.GA12009@iram.es>
	<1179825278.32247.827.camel@localhost.localdomain>
	<20070522100212.GA13225@iram.es>
	<1179828342.32247.832.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179828342.32247.832.camel@localhost.localdomain>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Dave Liu <r63238@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 08:05:42PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2007-05-22 at 12:02 +0200, Gabriel Paubert wrote:
> > 
> > Well, there should always be an stwcx. to clear reservation before
> > any interrupt return. Otherwise you'll be able to cause hard to
> > reproduce bugs in the interrupted code.
> 
> Well, that's the point. The BookE TLB refill exception is a very fast
> path that doesn't use the normal interrupt return code path. It thus
> needs to be careful about not leaving dangling reservations.

Ok, thanks. I missed that critical piece of information from
the context. In this case it makes sense, although I wonder
if a different order of instructions could shave some latency 
from the critical path:

	 1 - rX = read PTE value (normal load)
	 2 - if (!_PAGE_PRESENT)) -> out
 	 3 - rY = rX | _PAGE_ACCESSED
	 4 - if (rX != rY)
	
Specifically here, I wonder whether instead of the sequence:
	ori	ry, rx, PAGE_ACCESSED
	cmpw	rx, ry
	beq	11f	; Needs non-default static prediction?


it might be better to write it as:
	andi.	rz, rx, PAGE_ACCESSED
	ori	ry, rx, PAGE_ACCESSED
	bne	11f

since on some processors the branch might be resolved one cycle
earlier. But I don't know very well the processors with these MMU.

	 5 -   rZ = lwarx PTE value
	 6 -   if (rZ != rX)
	 7 -	stdcx. PTE, rZ (rewrite just read value to clear reserv)

Hmm, lWarx paired with stDcx., looks like a typo ?

	 8 - 	goto 1 (try again)
	 9 -   stdcx. PTE, rY 
Ditto.
	10 -   if failed -> goto 1 (try again)
	11 - that's it ! 

I suspect that in the TLB handler, you've got something
like 4 registers and one CR field to play with. So more
clever solutions may be impossible to implement.

> On some CPUs, there are also performance issues with leaving dangling
> lwarx iirc but I don't have the details off the top of my mind.
> 

I don't know of any, but I almost exclusively use 603e and 750.


	Gabriel
