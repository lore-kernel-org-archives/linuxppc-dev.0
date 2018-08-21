Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vj2X3WLxzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 17:28:20 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id ba4-v6so8371715plb.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 00:28:20 -0700 (PDT)
Date: Tue, 21 Aug 2018 17:28:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/64s/hash: convert SLB miss handlers to C
Message-ID: <20180821172813.3676d9b7@roar.ozlabs.ibm.com>
In-Reply-To: <a8f6f7ca5ae67e0a7bce6ed8a37d50f6e282d256.camel@au1.ibm.com>
References: <20180821051306.17869-1-npiggin@gmail.com>
 <a8f6f7ca5ae67e0a7bce6ed8a37d50f6e282d256.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Aug 2018 16:12:44 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Tue, 2018-08-21 at 15:13 +1000, Nicholas Piggin wrote:
> > This patch moves SLB miss handlers completely to C, using the standard
> > exception handler macros to set up the stack and branch to C.
> > 
> > This can be done because the segment containing the kernel stack is
> > always bolted, so accessing it with relocation on will not cause an
> > SLB exception.
> > 
> > Arbitrary kernel memory may not be accessed when handling kernel space
> > SLB misses, so care should be taken there. However user SLB misses can
> > access any kernel memory, which can be used to move some fields out of
> > the paca (in later patches).
> > 
> > User SLB misses could quite easily reconcile IRQs and set up a first
> > class kernel environment and exit via ret_from_except, however that
> > doesn't seem to be necessary at the moment, so we only do that if a
> > bad fault is encountered.
> > 
> > [ Credit to Aneesh for bug fixes, error checks, and improvements to bad
> >   address handling, etc ]
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > 
> > Since RFC:
> > - Send patch 1 by itself to focus on the big change.
> > - Added MSR[RI] handling
> > - Fixed up a register loss bug exposed by irq tracing (Aneesh)
> > - Reject misses outside the defined kernel regions (Aneesh)
> > - Added several more sanity checks and error handlig (Aneesh), we may
> >   look at consolidating these tests and tightenig up the code but for
> >   a first pass we decided it's better to check carefully.
> > ---
> >  arch/powerpc/include/asm/asm-prototypes.h |   2 +
> >  arch/powerpc/kernel/exceptions-64s.S      | 202 +++----------
> >  arch/powerpc/mm/Makefile                  |   2 +-
> >  arch/powerpc/mm/slb.c                     | 257 +++++++++--------
> >  arch/powerpc/mm/slb_low.S                 | 335 ----------------------
> >  5 files changed, 185 insertions(+), 613 deletions(-)  
>                     ^^^                ^^^
> 
> Nice ! :-)

So I did some measurements with context switching (that takes quite a
few SLB faults), we lose about 3-5% performance on that benchmark.

Top SLB involved profile entries before:

   7.44%  [k] switch_slb
   3.43%  [k] slb_compare_rr_to_size
   1.64%  [k] slb_miss_common
   1.24%  [k] slb_miss_kernel_load_io
   0.58%  [k] exc_virt_0x4480_instruction_access_slb

After:

   7.15%  [k] switch_slb
   3.90%  [k] slb_insert_entry
   3.65%  [k] fast_exception_return
   1.00%  [k] slb_allocate_user
   0.59%  [k] exc_virt_0x4480_instruction_access_slb

With later patches we can reduce SLB misses to zero on this workload
(and generally an order of magnitude lower on small workloads). But
each miss will be more expensive and very large memory workloads are
going to have mandatory misses. Will be good to try verifying that
we can do smarter SLB allocation and reclaim to make up for that on
workloads like HANA. I think we probably could because round robin
isn't great.

Thanks,
Nick
