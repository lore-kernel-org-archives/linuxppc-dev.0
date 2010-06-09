Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FC0B1007D3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 22:36:21 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59CW08k013651
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 06:32:00 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59Ca0HI095394
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 06:36:02 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o59CZxTh019942
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 06:36:00 -0600
Date: Wed, 9 Jun 2010 08:35:57 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Egger <siccegge@cs.fau.de>
Subject: Re: [PATCH 3/5] Removing dead CONFIG_SMP_750
Message-ID: <20100609123557.GJ7801@zod.rchland.ibm.com>
References: <cover.1275925219.git.siccegge@cs.fau.de>
	<8bf8cfaf47590e1a85f9510bb546ca35e3458bf8.1275925219.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8bf8cfaf47590e1a85f9510bb546ca35e3458bf8.1275925219.git.siccegge@cs.fau.de>
Cc: vamos@i4.informatik.uni-erlangen.de, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 12:00:21PM +0200, Christoph Egger wrote:
>CONFIG_SMP_750 doesn't exist in Kconfig, therefore removing all
>references for it from the source code.

Yeah, we don't support SMP on 750 at the moment.  This code was carried over
from the arch/ppc days, and that code was present pre-git.  I think we can
drop it, but I'll leave that up to Ben.  Maybe he has crazy plans for a 750 SMP
board.

josh

>
>Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
>---
> arch/powerpc/mm/tlb_hash32.c |    4 ----
> 1 files changed, 0 insertions(+), 4 deletions(-)
>
>diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
>index 8aaa8b7..925fecb 100644
>--- a/arch/powerpc/mm/tlb_hash32.c
>+++ b/arch/powerpc/mm/tlb_hash32.c
>@@ -94,11 +94,7 @@ void tlb_flush(struct mmu_gather *tlb)
>  * the cache operations on the bus.  Hence we need to use an IPI
>  * to get the other CPU(s) to invalidate their TLBs.
>  */
>-#ifdef CONFIG_SMP_750
>-#define FINISH_FLUSH	smp_send_tlb_invalidate(0)
>-#else
> #define FINISH_FLUSH	do { } while (0)
>-#endif
>
> static void flush_range(struct mm_struct *mm, unsigned long start,
> 			unsigned long end)
>-- 
>1.6.3.3
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
