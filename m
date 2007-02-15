Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56216DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:50:00 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: introduce "slices" (aka. meta-segments)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200702152009.58367.arnd@arndb.de>
References: <1171528608.20192.264.camel@localhost.localdomain>
	<200702152009.58367.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 07:49:49 +1100
Message-Id: <1171572589.5644.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-15 at 20:09 +0100, Arnd Bergmann wrote:
> On Thursday 15 February 2007 09:36, Benjamin Herrenschmidt wrote:
> >  arch/powerpc/Kconfig              |    5
> >  arch/powerpc/kernel/asm-offsets.c |   16 -
> >  arch/powerpc/mm/Makefile          |    1
> >  arch/powerpc/mm/hash_utils_64.c   |    4
> >  arch/powerpc/mm/hugetlbpage.c     |  514 -------------------------------------
> >  arch/powerpc/mm/mmu_context_64.c  |    4
> >  arch/powerpc/mm/slb.c             |   11
> >  arch/powerpc/mm/slb_low.S         |   50 ++-
> >  arch/powerpc/mm/slice.c           |  517 ++++++++++++++++++++++++++++++++++++++
> >  include/asm-powerpc/mmu.h         |   12
> >  include/asm-powerpc/paca.h        |    2
> >  include/asm-powerpc/page_64.h     |   83 ++----
> >  12 files changed, 625 insertions(+), 594 deletions(-)
> 
> I tried to review your patch, but I found it hard because of the amount of
> code that that just gets moved from hugetlbpage.c to slice.c. Could you
> send the next version of as two patches, with one of them only moving the
> code without changing it?

There is not that much code that gets moved. It mostly gets rewritten.

Ben.
