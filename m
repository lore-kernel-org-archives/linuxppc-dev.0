Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0283E1A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 21:57:58 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 12:57:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B122A1B08076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 12:58:24 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3FBvoNN58982596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 11:57:50 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3FBvmcD005950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 07:57:50 -0400
Message-ID: <552E523A.1020905@linux.vnet.ibm.com>
Date: Wed, 15 Apr 2015 13:57:46 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
 <20150413115811.GA12354@node.dhcp.inet.fi>
 <552BB972.3010704@linux.vnet.ibm.com>
 <20150413131357.GC12354@node.dhcp.inet.fi>
 <552BC2CA.80309@linux.vnet.ibm.com>	<552BC619.9080603@parallels.com>
 <20150413140219.GA14480@node.dhcp.inet.fi>
 <20150413135951.b3d9f431892dbfa7156cc1b0@linux-foundation.org>
 <552CDD35.2030901@linux.vnet.ibm.com>
 <20150414123853.a3e61b7fa95b6c634e0fcce0@linux-foundation.org>
In-Reply-To: <20150414123853.a3e61b7fa95b6c634e0fcce0@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
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

On 14/04/2015 21:38, Andrew Morton wrote:
> On Tue, 14 Apr 2015 11:26:13 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>>> Do away with __HAVE_ARCH_REMAP and do it like this:
>>>
>>> arch/x/include/asm/y.h:
>>>
>>> 	extern void arch_remap(...);
>>> 	#define arch_remap arch_remap
>>>
>>> include/linux/z.h:
>>>
>>> 	#include <asm/y.h>
>>>
>>> 	#ifndef arch_remap
>>> 	static inline void arch_remap(...) { }
>>> 	#define arch_remap arch_remap
>>> 	#endif
>>
>> Hi Andrew,
>>
>> I like your idea, but I can't find any good candidate for <asm/y.h> and
>> <linux/z.h>.
>>
>> I tried with <linux/mm.h> and <asm/mmu_context.h> but
>> <asm/mmu_context.h> is already including <linux/mm.h>.
>>
>> Do you have any suggestion ?
>>
>> Another option could be to do it like the actual arch_unmap() in
>> <asm-generic/mm_hooks.h> but this is the opposite of your idea, and Ingo
>> was not comfortable with this idea due to the impact of the other
>> architectures.
> 
> I don't see any appropriate header files for this.  mman.h is kinda
> close.
> 
> So we create new header files, that's not a problem.  I'm torn between
> 
> a) include/linux/mm-arch-hooks.h (and 31
>    arch/X/include/asm/mm-arch-hooks.h).  Mandate: mm stuff which can be
>    overridded by arch
> 
> versus
> 
> b) include/linux/mremap.h (+31), with a narrower mandate.
> 
> 
> This comes up fairly regularly so I suspect a) is better.  We'll add
> things to it over time, and various bits of existing ad-hackery can be
> moved over as cleanups.

Thanks for the advice,

I'll do a), starting with the arch_remap macro, adding the 30 "empty"
arch/x/include/asm/mm-arch-hooks.h files, and implementing arch_remap
for powerpc.

Then, if the first patch is accepted, I may move the arch_*() stuff
defined in include/asm-generic/mm_hooks.h into
include/linux/mm-arch-hooks.h and filled some
arch/X/include/asm/mm-arch-hooks.h. The file
include/asm-generic/mm_hooks.h will then become empty, and been removed.

Cheers,
Laurent.


  * Anglais - détecté
  * Français
  * Anglais

  * Français
  * Anglais

 <javascript:void(0);>
