Return-Path: <hughd@google.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DAD61A0CFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 18:33:12 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id 65so40795315pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 23:33:12 -0800 (PST)
Date: Sun, 10 Jan 2016 23:33:01 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Hugh Dickins <hughd@google.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: Re: [PATCH next] powerpc/mm: fix _PAGE_SWP_SOFT_DIRTY breaking swapoff
In-Reply-To: <87h9iktyo8.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1601102325490.2517@eggly.anvils>
References: <alpine.LSU.2.11.1601091651130.9808@eggly.anvils>
 <87mvscu0ve.fsf@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1601102149300.1634@eggly.anvils>
 <87h9iktyo8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Jan 2016, Aneesh Kumar K.V wrote:
> Hugh Dickins <hughd@google.com> writes:
> > On Mon, 11 Jan 2016, Aneesh Kumar K.V wrote:
> >> Hugh Dickins <hughd@google.com> writes:
> >> 
> >> > Swapoff after swapping hangs on the G5, when CONFIG_CHECKPOINT_RESTORE=y
> >> > but CONFIG_MEM_SOFT_DIRTY is not set.  That's because the non-zero
> >> > _PAGE_SWP_SOFT_DIRTY bit, added by CONFIG_HAVE_ARCH_SOFT_DIRTY=y, is not
> >> > discounted when CONFIG_MEM_SOFT_DIRTY is not set: so swap ptes cannot be
> >> > recognized.
> >> >
> >> > (I suspect that the peculiar dependence of HAVE_ARCH_SOFT_DIRTY on
> >> > CHECKPOINT_RESTORE in arch/powerpc/Kconfig comes from an incomplete
> >> > attempt to solve this problem.)
> >> >
> >> > It's true that the relationship between CONFIG_HAVE_ARCH_SOFT_DIRTY and
> >> > and CONFIG_MEM_SOFT_DIRTY is too confusing, and it's true that swapoff
> >> > should be made more robust; but nevertheless, fix up the powerpc ifdefs
> >> > as x86_64 and s390 (which met the same problem) have them, defining the
> >> > bits as 0 if CONFIG_MEM_SOFT_DIRTY is not set.
> >> 
> >> Do we need this patch, if we make the maybe_same_pte() more robust. The
> >> #ifdef with pte bits is always a confusing one and IMHO, we should avoid
> >> that if we can ?
> >
> > If maybe_same_pte() were more robust (as in the pte_same_as_swp() patch),
> > this patch here becomes an optimization rather than a correctness patch:
> > without this patch here, pte_same_as_swp() will perform an unnecessary 
> > transformation (masking out _PAGE_SWP_SOFT_DIRTY) from every one of the
> > millions of ptes it has to examine, on configs where it couldn't be set.
> > Or perhaps the processor gets that all nicely lined up without any actual
> > delay, I don't know.
> 
> But we have
> #ifndef CONFIG_HAVE_ARCH_SOFT_DIRTY
> static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> {
> 	return pte;
> }
> #endif 
> 
> If we fix the CONFIG_HAVE_ARCH_SOFT_DIRTY correctly, we can do the same
> optmization without the #ifdef of pte bits right ?

I'm not sure that I understand you (I'll have to look at your patch),
but suspect you're not optimizing the CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MEM_SOFT_DIRTY not set case.

Which would not be the end of the world, but...
 
> >
> > I've already agreed that the way SOFT_DIRTY is currently config'ed is
> > too confusing; but until that's improved, I strongly recommend that you
> > follow the same way of handling this as x86_64 and s390 are doing - going
> > off and doing it differently is liable to lead to error, as we have seen.

... as before, I don't think that doing it differently is a good idea.

Hugh
