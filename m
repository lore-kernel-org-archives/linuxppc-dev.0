Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E773B7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 11:24:29 +1000 (EST)
Subject: Re: PPC PCI bus registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
In-Reply-To: <4AB16292.9020704@embeddedarm.com>
References: <4A9F0377.1070606@embeddedarm.com>
	<1251972032.15089.30.camel@pasglop> <4AB13550.1070506@embeddedarm.com>
	<1253138086.8375.290.camel@pasglop> <4AB16292.9020704@embeddedarm.com>
Content-Type: text/plain
Date: Thu, 17 Sep 2009 11:24:11 +1000
Message-Id: <1253150651.8375.328.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-16 at 15:11 -0700, Eddie Dawydiuk wrote:
> Benjamin,
> 
> > Out of order execution != out of order storage. ioremap() will give you
> > guarded space which means it cannot be speculatively accessed for
> > example, and you do get -some- guarantees but not that your stores are
> > going to hit the device in order, nor that your loads are going to be
> > performed until the CPU actually use the result of the load, which can
> > be delayed beyond a store.
> 
> Interesting. So IIUC if I were to use ioremap and then bit bang bus cycles using 
> readN() / writeN() I would need to add memory barrier to ensure the order of the 
> load and store operations does not change. Is my understanding correct? 

Only if you use the __raw variants. readN/writeN already provide full
barriers, including barriers against leakage outside of locks and
barriers vs. cacheable accesses (MMIO vs. DMA) and thus are slow.

If you use the raw variants, it then depends whether your code is going
to be ppc specific, in which case you can manually use things like
eieio() etc... or not in which case ... it's harder :-) You can always
use rmb/wmb/mb but those are more heavyweight than just an eieio

There's iobarrier_r/w/rw, dunno if those are generic tho.

> If so 
> what are the recommended macros/functions for adding memory barriers, or are 
> there preferred functions to use in place of ioremap() and readN()/writeN?

ioremap + readN / writeN will give you fully ordered behaviour. It's
only when you try to be sneaky or speedy and use the __raw  variants
that you have to be more careful.

> PS I've looked in Documentation/ in the 2.6.30 Linux kernel tree for more 
> information, but I was unable to find any. If there are any example drivers or 
> documentation that you know of on this topic I'd be quite interested if you 
> could point me to it.
> 
> Thanks for your patience and time you've been quite helpful.

Cheers,
Ben.
