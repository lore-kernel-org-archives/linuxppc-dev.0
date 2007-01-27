Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C1944DE0FF
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 13:11:41 +1100 (EST)
Date: Fri, 26 Jan 2007 18:11:39 -0800 (PST)
Message-Id: <20070126.181139.45511900.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: David Miller <davem@davemloft.net>
In-Reply-To: <1169851257.24996.185.camel@localhost.localdomain>
References: <m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
	<20070126171928.GA22275@colo.lackof.org>
	<1169851257.24996.185.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: grundler@parisc-linux.org, greg@kroah.com, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 27 Jan 2007 09:40:57 +1100

> 
> > What?!!! The whole point of the abstraction ("flat space") is
> > to be able to do reverse lookups for additional information.
> 
> You may want to look at the virtual irq scheme we implemented for
> powerpc, I think it could be useful for other architectures as well in
> fact... One mistake I did was to put the documentation in the .h instead
> of near the code though :-) asm-powerpc/irq.h is a good start to read.
> 
> The main reasons we did it in the first place are two fold:
> 
>  - On pSeries and to some extent with other hypervisors, IRQ numbers can
> be pretty big, from encoding the geographical informations about the
> slot/irq to just being an opaque 64 bits "token" from the hypervisor. So
> we need the ability to map that to/from linux smaller and flatter space.

We do the same thing on sparc64 btw, for the same reasons.  The
hypervisor on Niagara specifies IRQ numbers as opaque 64-bit
quantities.
