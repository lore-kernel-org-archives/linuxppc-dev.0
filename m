Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B81B6B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jul 2011 04:24:44 +1000 (EST)
Subject: RE: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jul 2011 12:39:30 +0200
Message-ID: <1310726370.2586.312.camel@twins>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Shan Hai <haishan.bai@gmail.com>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
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
>=20
> Perhaps that is the bug!
> Whatever pagefault_disable() does, it shouldn't disable the
> SW dirty/young tracking - which should only needs bits moving
> in the page table itself (and TLB update??) rather than any
> operations on the rest of the data areas.
>=20
> It looks to me as though this could happen any time a page
> is marked inaccessible by the dirty/young tracking.
> Not just as a result of COW.

I've thought of that as well, but couldn't find the actual code in the
ppc fault bits. It could be it relies on vma information to know what it
should allow due to lack of bits in the pte.

If it requires the vma, it requires mmap_sem and it thus has to avoid
the whole thing when pagefault_disabled().
