Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A498BDDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 18:25:59 +1100 (EST)
Subject: Re: Large stack usage in fs code (especially for PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0811171522030.18283@nehalem.linux-foundation.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
	<1226963596.7178.254.camel@pasglop>
	<alpine.LFD.2.00.0811171522030.18283@nehalem.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 18:25:20 +1100
Message-Id: <1226993120.7178.287.camel@pasglop>
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > It makes some sort of sense I suppose on very static embedded workloads
> > with no swap nor demand paging.
> 
> It makes perfect sense for anything that doesn't use any MMU. 

To a certain extent. There's two different aspects to having an MMU and
in embedded space it's useful to have one and not the other, ie,
protection & address space isolation vs. paging.

Thus, it does make sense for those embedded devices with few files
(mostly a statically linked busybox, a few /dev entries and some app
stuff) to use large page sizes. Of course, as soon as they try to
populate their ramfs with lots of small files they lose... but mostly,
the idea is that the entire working set fits in the TLB and thus the
cost of TLB miss becomes irrelevant.

Now, regarding the shortcomings of the powerpc server MMU, well, we know
them, we know your opinion and mostly share it, and until we can get the
HW to change we are stuck with it.

Cheers,
Ben.
