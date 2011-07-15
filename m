Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87C47B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jul 2011 09:47:51 +1000 (EST)
Subject: RE: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 16 Jul 2011 09:47:09 +1000
Message-ID: <1310773629.25044.2.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Shan Hai <haishan.bai@gmail.com>, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, dhowells@redhat.com, paulus@samba.org,
	tglx@linutronix.de, walken@google.com,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-15 at 11:32 +0100, David Laight wrote:
> > The fault causing futex_atomic_cmpxchg_inatomic() is
> > protected by pagefault_disable(), so the page fault handler has
> > no chance to toggle the SW dirty/young tracking.
> 
> Perhaps that is the bug!
> Whatever pagefault_disable() does, it shouldn't disable the
> SW dirty/young tracking - which should only needs bits moving
> in the page table itself (and TLB update??) rather than any
> operations on the rest of the data areas.
> 
> It looks to me as though this could happen any time a page
> is marked inaccessible by the dirty/young tracking.
> Not just as a result of COW.

Except that for many architectures, there's a hard wired assumption that
the state of the PTEs won't change at interrupt time.

If we allow the "atomic" user accesses, we'll break that rule (think
about perf backtraces for example), and so would have to at -least-
disable interrupts around all the PTE accessors, or use atomic ops,
which will slow things down all over the place.

Cheers,
Ben.
