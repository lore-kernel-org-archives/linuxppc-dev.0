Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 708F91A19DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 17:31:39 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 12:01:35 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 80250E005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 12:02:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0B6VW1T53739724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 12:01:32 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0B6VRO7020346
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 12:01:31 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Hugh Dickins <hughd@google.com>
Cc: Hugh Dickins <hughd@google.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH next] powerpc/mm: fix _PAGE_SWP_SOFT_DIRTY breaking swapoff
In-Reply-To: <alpine.LSU.2.11.1601102149300.1634@eggly.anvils>
References: <alpine.LSU.2.11.1601091651130.9808@eggly.anvils>
 <87mvscu0ve.fsf@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1601102149300.1634@eggly.anvils>
Date: Mon, 11 Jan 2016 12:01:19 +0530
Message-ID: <87h9iktyo8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hugh Dickins <hughd@google.com> writes:

> On Mon, 11 Jan 2016, Aneesh Kumar K.V wrote:
>> Hugh Dickins <hughd@google.com> writes:
>> 
>> > Swapoff after swapping hangs on the G5, when CONFIG_CHECKPOINT_RESTORE=y
>> > but CONFIG_MEM_SOFT_DIRTY is not set.  That's because the non-zero
>> > _PAGE_SWP_SOFT_DIRTY bit, added by CONFIG_HAVE_ARCH_SOFT_DIRTY=y, is not
>> > discounted when CONFIG_MEM_SOFT_DIRTY is not set: so swap ptes cannot be
>> > recognized.
>> >
>> > (I suspect that the peculiar dependence of HAVE_ARCH_SOFT_DIRTY on
>> > CHECKPOINT_RESTORE in arch/powerpc/Kconfig comes from an incomplete
>> > attempt to solve this problem.)
>> >
>> > It's true that the relationship between CONFIG_HAVE_ARCH_SOFT_DIRTY and
>> > and CONFIG_MEM_SOFT_DIRTY is too confusing, and it's true that swapoff
>> > should be made more robust; but nevertheless, fix up the powerpc ifdefs
>> > as x86_64 and s390 (which met the same problem) have them, defining the
>> > bits as 0 if CONFIG_MEM_SOFT_DIRTY is not set.
>> 
>> Do we need this patch, if we make the maybe_same_pte() more robust. The
>> #ifdef with pte bits is always a confusing one and IMHO, we should avoid
>> that if we can ?
>
> If maybe_same_pte() were more robust (as in the pte_same_as_swp() patch),
> this patch here becomes an optimization rather than a correctness patch:
> without this patch here, pte_same_as_swp() will perform an unnecessary 
> transformation (masking out _PAGE_SWP_SOFT_DIRTY) from every one of the
> millions of ptes it has to examine, on configs where it couldn't be set.
> Or perhaps the processor gets that all nicely lined up without any actual
> delay, I don't know.

But we have
#ifndef CONFIG_HAVE_ARCH_SOFT_DIRTY
static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
{
	return pte;
}
#endif 

If we fix the CONFIG_HAVE_ARCH_SOFT_DIRTY correctly, we can do the same
optmization without the #ifdef of pte bits right ?

>
> I've already agreed that the way SOFT_DIRTY is currently config'ed is
> too confusing; but until that's improved, I strongly recommend that you
> follow the same way of handling this as x86_64 and s390 are doing - going
> off and doing it differently is liable to lead to error, as we have seen.
>
> So I recommend using the patch below too, whether or not you care for
> the optimization.
>
> Hugh


-aneesh
