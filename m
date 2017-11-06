Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVqFw5GQkzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:55:00 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id a192so7900291pge.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:55:00 -0800 (PST)
Date: Mon, 6 Nov 2017 21:54:47 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address
 boundary case allocation
Message-ID: <20171106215447.787e58fd@roar.ozlabs.ibm.com>
In-Reply-To: <87y3njsne9.fsf@linux.vnet.ibm.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-2-npiggin@gmail.com>
 <87y3njsne9.fsf@linux.vnet.ibm.com>
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

On Mon, 06 Nov 2017 16:08:06 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > When allocating VA space with a hint that crosses 128TB, the SLB addr_limit
> > variable is not expanded if addr is not > 128TB, but the slice allocation
> > looks at task_size, which is 512TB. This results in slice_check_fit()
> > incorrectly succeeding because the slice_count truncates off bit 128 of the
> > requested mask, so the comparison to the available mask succeeds.  
> 
> 
> But then the mask passed to slice_check_fit() is generated using
> context.addr_limit as max value. So how did that return succcess? ie,
> we get the request mask via
> 
> slice_range_to_mask(addr, len, &mask);
> 
> And the potential/possible mask using
> 
> slice_mask_for_size(mm, psize, &good_mask);
> 
> So how did slice_check_fit() return sucess with
> 
> slice_check_fit(mm, mask, good_mask);

Because the addr_limit check is used to *limit* the comparison.

The available mask had bit up to 127 set, and the mask had 127 and
128 set. However the 128T addr_limit causes only bits 0-127 to be
compared.

> > Fix this by using mm->context.addr_limit instead of mm->task_size for
> > testing allocation limits. This causes such allocations to fail.
> >
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> > Reported-by: Florian Weimer <fweimer@redhat.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/slice.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> > index 45f6740dd407..567db541c0a1 100644
> > --- a/arch/powerpc/mm/slice.c
> > +++ b/arch/powerpc/mm/slice.c
> > @@ -96,7 +96,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
> >  {
> >  	struct vm_area_struct *vma;
> >
> > -	if ((mm->task_size - len) < addr)
> > +	if ((mm->context.addr_limit - len) < addr)  
> 
> I was looking at these as generic boundary check against task size and
> for specific range check we should have created mask always using
> context.addr_limit. That should keep the boundary condition check same
> across radix/hash.

We need to actually fix the radix case too for other-but-similar reasons,
so fixing it like this does end up with the same tests for both. See
the later radix patch.

Thanks,
Nick
