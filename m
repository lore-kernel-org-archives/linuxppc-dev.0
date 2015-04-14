Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 563F41A0BDE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 19:26:28 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 10:26:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2EFB3219005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 10:26:01 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E9QFQG56295456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 09:26:15 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E9QEuI030634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 03:26:15 -0600
Message-ID: <552CDD35.2030901@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 11:26:13 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com>	<552BC619.9080603@parallels.com>
 <20150413140219.GA14480@node.dhcp.inet.fi>
 <20150413135951.b3d9f431892dbfa7156cc1b0@linux-foundation.org>
In-Reply-To: <20150413135951.b3d9f431892dbfa7156cc1b0@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Cc: Rik van Riel <riel@redhat.com>, Pavel Emelyanov <xemul@parallels.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, criu@openvz.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/04/2015 22:59, Andrew Morton wrote:
> On Mon, 13 Apr 2015 17:02:19 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
>>> Kirill, if I'm right with it, can you suggest the header where to put
>>> the "generic" mremap hook's (empty) body?
>>
>> I initially thought it would be enough to put it into
>> <asm-generic/mmu_context.h>, expecting it works as
>> <asm-generic/pgtable.h>. But that's not the case.
>>
>> It probably worth at some point rework all <asm/mmu_context.h> to include
>> <asm-generic/mmu_context.h> at the end as we do for <asm/pgtable.h>.
>> But that's outside the scope of the patchset, I guess.
>>
>> I don't see any better candidate for such dummy header. :-/
> 
> Do away with __HAVE_ARCH_REMAP and do it like this:
> 
> arch/x/include/asm/y.h:
> 
> 	extern void arch_remap(...);
> 	#define arch_remap arch_remap
> 
> include/linux/z.h:
> 
> 	#include <asm/y.h>
> 
> 	#ifndef arch_remap
> 	static inline void arch_remap(...) { }
> 	#define arch_remap arch_remap
> 	#endif

Hi Andrew,

I like your idea, but I can't find any good candidate for <asm/y.h> and
<linux/z.h>.

I tried with <linux/mm.h> and <asm/mmu_context.h> but
<asm/mmu_context.h> is already including <linux/mm.h>.

Do you have any suggestion ?

Another option could be to do it like the actual arch_unmap() in
<asm-generic/mm_hooks.h> but this is the opposite of your idea, and Ingo
was not comfortable with this idea due to the impact of the other
architectures.

Cheers,
Laurent.
