Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F703B7D81
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:14:42 +1000 (EST)
Subject: Re: [PATCH 3/5] Removing dead CONFIG_SMP_750
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100609123557.GJ7801@zod.rchland.ibm.com>
References: <cover.1275925219.git.siccegge@cs.fau.de>
	<8bf8cfaf47590e1a85f9510bb546ca35e3458bf8.1275925219.git.siccegge@cs.fau.de>
	<20100609123557.GJ7801@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:14:21 +1000
Message-ID: <1276150461.1962.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, vamos@i4.informatik.uni-erlangen.de,
	Christoph Egger <siccegge@cs.fau.de>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-06-09 at 08:35 -0400, Josh Boyer wrote:
> On Wed, Jun 09, 2010 at 12:00:21PM +0200, Christoph Egger wrote:
> >CONFIG_SMP_750 doesn't exist in Kconfig, therefore removing all
> >references for it from the source code.
> 
> Yeah, we don't support SMP on 750 at the moment.  This code was carried over
> from the arch/ppc days, and that code was present pre-git.  I think we can
> drop it, but I'll leave that up to Ben.  Maybe he has crazy plans for a 750 SMP
> board.

Nope :-) Though it would be nice to also remove the call sites too and
thus remove the macro entirely.

Cheers,
Ben.

> josh
> 
> >
> >Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> >---
> > arch/powerpc/mm/tlb_hash32.c |    4 ----
> > 1 files changed, 0 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
> >index 8aaa8b7..925fecb 100644
> >--- a/arch/powerpc/mm/tlb_hash32.c
> >+++ b/arch/powerpc/mm/tlb_hash32.c
> >@@ -94,11 +94,7 @@ void tlb_flush(struct mmu_gather *tlb)
> >  * the cache operations on the bus.  Hence we need to use an IPI
> >  * to get the other CPU(s) to invalidate their TLBs.
> >  */
> >-#ifdef CONFIG_SMP_750
> >-#define FINISH_FLUSH	smp_send_tlb_invalidate(0)
> >-#else
> > #define FINISH_FLUSH	do { } while (0)
> >-#endif
> >
> > static void flush_range(struct mm_struct *mm, unsigned long start,
> > 			unsigned long end)
> >-- 
> >1.6.3.3
> >
> >_______________________________________________
> >Linuxppc-dev mailing list
> >Linuxppc-dev@lists.ozlabs.org
> >https://lists.ozlabs.org/listinfo/linuxppc-dev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
