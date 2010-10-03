Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 1A12BB70AB
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2010 06:13:09 +1100 (EST)
Date: Sun, 3 Oct 2010 14:13:05 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ppc44x - how do i optimize driver for tlb hits
Message-ID: <20101003191305.GA7345@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
	<1285290444.14081.6.camel@pasglop>
	<20100924025849.GA5619@crust.elkhashab.com>
	<1285303432.14081.28.camel@pasglop>
	<20100924103034.GA27958@zod.rchland.ibm.com>
	<20100924130851.GA14016@crust.elkhashab.com>
	<1285366264.14081.33.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285366264.14081.33.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 25, 2010 at 08:11:04AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2010-09-24 at 08:08 -0500, Ayman El-Khashab wrote:
> > 
> > I suppose another option is to to use the kernel profiling option I 
> > always see but have never used.  Is that a viable option to figure out
> > what is happening here?  
> 
> With perf and stochastic sampling ? If you sample fast enough... but
> you'll mostly point to your routine I suppose... though it might tell
> you statistically where in your code, which -might- help.
> 

Thanks I didn't end up profiling it b/c we found the biggest culprit. 
Basically we were mapping this memory in kernel space and as long as we
did that ONLY everything was ok.  But then we would mmap the physical
addresses into user space.  Using MAP_SHARED made it extremely slow. 
Using MAP_PRIVATE made it very fast.  So it works, but why is MAP_SHARED
that much slower?

The other optimization was a change in the algorithm to take advantage
of the L2 prefetching.  Since we were operating on many simultaneous
streams it seems that the cache performance was not good.  

thanks
ame
