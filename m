Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 965B31A074A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:59:54 +1000 (AEST)
Date: Mon, 13 Apr 2015 13:59:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
Message-Id: <20150413135951.b3d9f431892dbfa7156cc1b0@linux-foundation.org>
In-Reply-To: <20150413140219.GA14480@node.dhcp.inet.fi>
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com>
 <552BC619.9080603@parallels.com>
 <20150413140219.GA14480@node.dhcp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rik van Riel <riel@redhat.com>, Pavel Emelyanov <xemul@parallels.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, criu@openvz.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
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

On Mon, 13 Apr 2015 17:02:19 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> > Kirill, if I'm right with it, can you suggest the header where to put
> > the "generic" mremap hook's (empty) body?
> 
> I initially thought it would be enough to put it into
> <asm-generic/mmu_context.h>, expecting it works as
> <asm-generic/pgtable.h>. But that's not the case.
> 
> It probably worth at some point rework all <asm/mmu_context.h> to include
> <asm-generic/mmu_context.h> at the end as we do for <asm/pgtable.h>.
> But that's outside the scope of the patchset, I guess.
> 
> I don't see any better candidate for such dummy header. :-/

Do away with __HAVE_ARCH_REMAP and do it like this:

arch/x/include/asm/y.h:

	extern void arch_remap(...);
	#define arch_remap arch_remap

include/linux/z.h:

	#include <asm/y.h>

	#ifndef arch_remap
	static inline void arch_remap(...) { }
	#define arch_remap arch_remap
	#endif
