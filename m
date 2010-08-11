Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11187B6EF0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 18:22:03 +1000 (EST)
Subject: Re: [PATCH] powerpc: Feature nop out reservation clear when stcx
	checks address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20100811064152.GC15252@drongo>
References: <20100811052005.GV29316@kryten>  <20100811064152.GC15252@drongo>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 18:21:57 +1000
Message-ID: <1281514917.2987.225.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-08-11 at 16:41 +1000, Paul Mackerras wrote:
> On Wed, Aug 11, 2010 at 03:20:05PM +1000, Anton Blanchard wrote:
> 
> > All recent POWER CPUs check the address before letting the stcx succeed
> > so we can create a CPU feature and nop it out. As Ben suggested, we can
> > only do this in our syscall path because there is a remote possibility
> > some kernel code gets interrupted by an exception that ends up operating
> > on the same cacheline.
> 
> Nice...  Just one nit, and that is that I think we now need a dummy
> stcx in the context switch code so there is no possibility of getting
> from one user context to another with a reservation still pending from
> the first context.  I guess our chances of getting through schedule()
> without doing any atomics, bitops or spinlocks are pretty remote, but
> nevertheless it might be as well to make sure.

Do we care ? IE. If we define that the moment you have done a syscall,
the reservation state is undefined, we are clear here, don't you think ?

Cheers,
Ben.
