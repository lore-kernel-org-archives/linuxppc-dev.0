Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5CD5B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 19:46:16 +1100 (EST)
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20091126081724.GA6538@iram.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
	<CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
	<1259210216.16367.249.camel@pasglop>  <20091126081724.GA6538@iram.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 19:46:04 +1100
Message-ID: <1259225164.16367.332.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 09:17 +0100, Gabriel Paubert wrote:
> 
> > They should hopefully... as long as you don't rely on the reservation
> > blowing as a result of a DMA write.
> 
> Hmm, this really depends on whether the DMA transfers generate bus cycles
> that require coherency or not. Not the other way around. M=1 only forces
> bus cycles to be snooped by other processors (asserting the GBL signal
> on 603/604/750 busses).

You are absolutely right. Which makes it even more likely that
lwarx/stwcx. won't care unless the L2 cache plays tricks.

> The host bridge is free to systematically snoop processor accesses (to make 
> sure that data queued in the bridge and not yet written to memory is seen
> in the coherent memory domain even if, for example, interrupts propagate 
> so fast that DMA target addresses are accessed before it is written to RAM).
> 
> On memory coherent systems, the host bridge has to assert the GBL signal,
> to force data to be written to memory (for most DMA accesses), or to  
> invalidate caches (for full line writes from devices). 

Cheers,
Ben.
