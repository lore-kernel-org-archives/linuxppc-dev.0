Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWCQT277bzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 13:03:44 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id x7so9174990pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 18:03:44 -0800 (PST)
Date: Tue, 7 Nov 2017 13:03:33 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address
 boundary case allocation
Message-ID: <20171107130333.7498bdda@roar.ozlabs.ibm.com>
In-Reply-To: <d7815f37-cd13-4506-3e6b-cc2aa1cc0787@linux.vnet.ibm.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-2-npiggin@gmail.com>
 <87y3njsne9.fsf@linux.vnet.ibm.com>
 <20171106215447.787e58fd@roar.ozlabs.ibm.com>
 <13f9578b-f907-1809-9aaa-cbb87c419bc6@linux.vnet.ibm.com>
 <d7815f37-cd13-4506-3e6b-cc2aa1cc0787@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 7 Nov 2017 07:30:51 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> On 11/06/2017 04:35 PM, Aneesh Kumar K.V wrote:
> > 
> > 
> > On 11/06/2017 04:24 PM, Nicholas Piggin wrote:  
> >> On Mon, 06 Nov 2017 16:08:06 +0530
> >> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >>  
> >>> Nicholas Piggin <npiggin@gmail.com> writes:
> >>>  
> >>>> When allocating VA space with a hint that crosses 128TB, the SLB 
> >>>> addr_limit
> >>>> variable is not expanded if addr is not > 128TB, but the slice 
> >>>> allocation
> >>>> looks at task_size, which is 512TB. This results in slice_check_fit()
> >>>> incorrectly succeeding because the slice_count truncates off bit 128 
> >>>> of the
> >>>> requested mask, so the comparison to the available mask succeeds.  
> >>>
> >>>
> >>> But then the mask passed to slice_check_fit() is generated using
> >>> context.addr_limit as max value. So how did that return succcess? ie,
> >>> we get the request mask via
> >>>
> >>> slice_range_to_mask(addr, len, &mask);
> >>>
> >>> And the potential/possible mask using
> >>>
> >>> slice_mask_for_size(mm, psize, &good_mask);
> >>>
> >>> So how did slice_check_fit() return sucess with
> >>>
> >>> slice_check_fit(mm, mask, good_mask);  
> >>
> >> Because the addr_limit check is used to *limit* the comparison.
> >>
> >> The available mask had bit up to 127 set, and the mask had 127 and
> >> 128 set. However the 128T addr_limit causes only bits 0-127 to be
> >> compared.
> >>  
> > 
> > Should we fix it then via ? I haven't tested this yet. Also this result 
> > in us comparing more bits?
> > 
> > modified   arch/powerpc/mm/slice.c
> > @@ -169,13 +169,12 @@ static int slice_check_fit(struct mm_struct *mm,
> >                  struct slice_mask mask, struct slice_mask available)
> >   {
> >       DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> > -    unsigned long slice_count = 
> > GET_HIGH_SLICE_INDEX(mm->context.addr_limit);
> > 
> >       bitmap_and(result, mask.high_slices,
> > -           available.high_slices, slice_count);
> > +           available.high_slices, SLICE_NUM_HIGH);
> > 
> >       return (mask.low_slices & available.low_slices) == mask.low_slices &&
> > -        bitmap_equal(result, mask.high_slices, slice_count);
> > +        bitmap_equal(result, mask.high_slices, SLICE_NUM_HIGH)
> > 
> >   
> 
> Florian, will you be able to test this patch ? We may not really want to 
> push this. But it will confirm that we end up getting >128TB address 
> because of this.

Oh we are, I went through and traced it, and this is the reason hash's
get_unmapped_area gives out > 128TB addresses if addr + len crosses
128TB.

Thanks,
Nick
