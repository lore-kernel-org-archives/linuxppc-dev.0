Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 28E9C1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 19:17:38 +1100 (EST)
Date: Thu, 26 Nov 2009 09:17:24 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
Message-ID: <20091126081724.GA6538@iram.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
	<CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
	<1259210216.16367.249.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259210216.16367.249.camel@pasglop>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 03:36:56PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-11-24 at 22:00 +0100, Segher Boessenkool wrote:
> > 
> > Sure, the memory controllers don't do coherency.  I'm slightly worried
> > about two things:
> > 1) Will the generic code use M=0 as well?  Is it a problem if it  
> > doesn't?
> 
> We can make it not do it.
> 
> > 2) Do lwarx. etc. work in M=0? 
> 
> They should hopefully... as long as you don't rely on the reservation
> blowing as a result of a DMA write.

Hmm, this really depends on whether the DMA transfers generate bus cycles
that require coherency or not. Not the other way around. M=1 only forces
bus cycles to be snooped by other processors (asserting the GBL signal
on 603/604/750 busses).

The host bridge is free to systematically snoop processor accesses (to make 
sure that data queued in the bridge and not yet written to memory is seen
in the coherent memory domain even if, for example, interrupts propagate 
so fast that DMA target addresses are accessed before it is written to RAM).

On memory coherent systems, the host bridge has to assert the GBL signal,
to force data to be written to memory (for most DMA accesses), or to  
invalidate caches (for full line writes from devices).

	Gabriel
