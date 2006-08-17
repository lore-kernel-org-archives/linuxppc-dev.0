Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 174D767B76
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 17:45:53 +1000 (EST)
Subject: Re: SMP in 32-bit arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1155799144.28319.7.camel@localhost.localdomain>
References: <1154507145.24203.0.camel@localhost.localdomain>
	<E1G8HvV-0007o7-0C@jdl.com>
	<1155769968.11312.110.camel@localhost.localdomain>
	<1155799144.28319.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 09:45:31 +0200
Message-Id: <1155800731.11312.165.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 08:19 +0100, Adrian Cox wrote:
> On Thu, 2006-08-17 at 01:12 +0200, Benjamin Herrenschmidt wrote:
> > For completeness, there is a known bug with 32 bits and SMP regarding
> > icache coherency.... If you have random SIGILL/SEGV under load, that's
> > probably what you are hitting. The problem is due to the way we do the
> > coherency and isn't trivial to fix unfortunately, though it's also
> > fairly rare.
> 
> Could you give a few more details?  I'd not heard of the problem before,
> and I couldn't find any references with a few quick searches. I've not
> seen the problem myself, but I've not run any heavy page fault loads,
> only Altivec load.

Currently, we do the sync in update_mmu_cache() which is called some
time after we instert a new PTE. Thus, there is the scenario where CPU A
gets in set_pte() to insert a new PTE for some code, and before it
reaches update_mmu_cache(), CPU B will hash in that PTE and try to
execute the code (typical case is swapping in code).

The "fix" would be to do the flush in hash_page but it's a bit
complicated since 32 bits hash_page is completely assembly, and going to
struct page PG_arch1 from there will require a few contorsions. We also
want to avoid 2 CPUs flushing at the same time. One thing I thought
about was to have set_pte "mirror" PG_arch1 into a PTE bit and have
hash_page fail with a minor fault whenever that bit isn't set,
effectively delaying until update_mmu_cache is called (you gotta hope
it's always called sometime after we do set_pte ... I'm not even sure we
can rely on that nowadays, I have to check)

Ben.
