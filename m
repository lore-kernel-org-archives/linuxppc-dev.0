Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrJGQ29NHzF1WK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 23:41:17 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1RCe3kL135566
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 07:41:15 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gd6b8u2cf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 07:41:14 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 12:41:12 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
In-Reply-To: <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
 <87bmga7qng.fsf@linux.vnet.ibm.com>
 <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
Date: Tue, 27 Feb 2018 18:11:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tbe7ggs.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue, 27 Feb 2018 14:31:07 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>> > The number of high slices a process might use now depends on its
>> > address space size, and what allocation address it has requested.
>> >
>> > This patch uses that limit throughout call chains where possible,
>> > rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
>> > This saves some cost for processes that don't use very large address
>> > spaces.  
>> 
>> I haven't really looked at the final code. One of the issue we had was
>> with the below scenario.
>> 
>> mmap(addr, len) where addr < 128TB and addr+len > 128TB  We want to make
>> sure we build the mask such that we don't find the addr available.
>
> We should run it through the mmap regression tests. I *think* we moved
> all of that logic from the slice code to get_ummapped_area before going
> in to slices. I may have missed something though, it would be good to
> have more eyes on it.
>

mmap(-1,...) failed with the test. Something like below fix it

@@ -756,7 +770,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
        mm->context.low_slices_psize = lpsizes;
 
        hpsizes = mm->context.high_slices_psize;
-       high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+       high_slices = SLICE_NUM_HIGH;
        for (i = 0; i < high_slices; i++) {
                mask_index = i & 0x1;
                index = i >> 1;

I guess for everything in the mm_context_t, we should compute it till
SLICE_NUM_HIGH. The reason for failure was, even though we recompute the
slice mask cached in mm_context on slb_addr_limit, it was still derived
from the high_slices_psizes which was computed with lower value.

-aneesh
