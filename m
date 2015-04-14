Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7C4F1A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 05:38:57 +1000 (AEST)
Date: Tue, 14 Apr 2015 12:38:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
Message-Id: <20150414123853.a3e61b7fa95b6c634e0fcce0@linux-foundation.org>
In-Reply-To: <552CDD35.2030901@linux.vnet.ibm.com>
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com>
 <552BC619.9080603@parallels.com>
 <20150413140219.GA14480@node.dhcp.inet.fi>
 <20150413135951.b3d9f431892dbfa7156cc1b0@linux-foundation.org>
 <552CDD35.2030901@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rik van Riel <riel@redhat.com>, Pavel Emelyanov <xemul@parallels.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, criu@openvz.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Apr 2015 11:26:13 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> > Do away with __HAVE_ARCH_REMAP and do it like this:
> > 
> > arch/x/include/asm/y.h:
> > 
> > 	extern void arch_remap(...);
> > 	#define arch_remap arch_remap
> > 
> > include/linux/z.h:
> > 
> > 	#include <asm/y.h>
> > 
> > 	#ifndef arch_remap
> > 	static inline void arch_remap(...) { }
> > 	#define arch_remap arch_remap
> > 	#endif
> 
> Hi Andrew,
> 
> I like your idea, but I can't find any good candidate for <asm/y.h> and
> <linux/z.h>.
> 
> I tried with <linux/mm.h> and <asm/mmu_context.h> but
> <asm/mmu_context.h> is already including <linux/mm.h>.
> 
> Do you have any suggestion ?
> 
> Another option could be to do it like the actual arch_unmap() in
> <asm-generic/mm_hooks.h> but this is the opposite of your idea, and Ingo
> was not comfortable with this idea due to the impact of the other
> architectures.

I don't see any appropriate header files for this.  mman.h is kinda
close.

So we create new header files, that's not a problem.  I'm torn between

a) include/linux/mm-arch-hooks.h (and 31
   arch/X/include/asm/mm-arch-hooks.h).  Mandate: mm stuff which can be
   overridded by arch

versus

b) include/linux/mremap.h (+31), with a narrower mandate.


This comes up fairly regularly so I suspect a) is better.  We'll add
things to it over time, and various bits of existing ad-hackery can be
moved over as cleanups.
