Return-Path: <satyakiran@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id C8502DF1A4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 12:18:48 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so24748wxd
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 19:18:47 -0700 (PDT)
Message-ID: <acbcf3840707171918h5dee75d9t96d6a62e8a0161fa@mail.gmail.com>
Date: Tue, 17 Jul 2007 21:18:47 -0500
From: Satya <satyakiran@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: hugetlbfs for ppc440 - kernel BUG -- follow up
In-Reply-To: <1184723616.25235.186.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <acbcf3840707171407x21c1bc1al9b46ff0c692b2b4d@mail.gmail.com>
	<1184723616.25235.186.camel@localhost.localdomain>
Cc: kazutomo@mcs.anl.gov, linuxppc-dev@ozlabs.org, edi@linux.vnet.ibm.com,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/17/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Tue, 2007-07-17 at 16:07 -0500, Satya wrote:
> > hello,
> >
> > Upon investigating the below issue further, I found that
> > pte_alloc_map() calls kmap_atomic. The allocated pte page must be
> > unmapped before invoking any function that might_sleep.
> >
> > In this case clear_huge_page() is being called without invoking
> > pte_unmap(). The 'normal' counterpart of hugetlb_no_page (which is
> > do_no_page() in mm/memory.c) does call pte_unmap() before calling
> > alloc_page() (which might sleep).
> >
> > So, I believe pte_unmap() must be invoked first in hugetlb_no_page().
> > But the problem here is, we do not have a reference to the pmd to map
> > the pte again (using pte_offset_map()). The do_no_page() function does
> > have a pmd_t* parameter, so it can remap the pte when required.
> >
> > For now, I resolved the problem by expanding the pte_alloc_map() macro
> > by hand and replacing kmap_atomic with kmap(), although I think it is
> > not the right thing to do.
> >
> > Let me know if my analysis is helping you figure out the problem here. Thanks!
>
> Except that I don't see where pte_alloc_map() has been called before
> hand... hugetlb_no_page() is called by hugetlb_fault() which is called
> by __handle_mm_fault(), with no lock held.
>

the calling sequence is :

__handle_mm_fault -> hugetlb_fault -> huge_pte_alloc() -> pte_alloc_map()

where -> stands for 'calls'.

hugetlb_fault() calls hugetlb_no_page() after returning from huge_pte_alloc().

[huge_pte_alloc() is an arch specific call back implemented in the
patch referred to in my earlier posts]

Satya.

> Ben.
>
>
>


-- 
...what's remarkable, is that atoms have assembled into entities which
are somehow able to ponder their origins.
--
http://cs.uic.edu/~spopuri
