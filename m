Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B83CDE0C0
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:54:14 +1000 (EST)
Subject: Re: hugetlbfs for ppc440 - kernel BUG -- follow up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Satya <satyakiran@gmail.com>
In-Reply-To: <acbcf3840707171407x21c1bc1al9b46ff0c692b2b4d@mail.gmail.com>
References: <acbcf3840707171407x21c1bc1al9b46ff0c692b2b4d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 11:53:36 +1000
Message-Id: <1184723616.25235.186.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Tue, 2007-07-17 at 16:07 -0500, Satya wrote:
> hello,
> 
> Upon investigating the below issue further, I found that
> pte_alloc_map() calls kmap_atomic. The allocated pte page must be
> unmapped before invoking any function that might_sleep.
> 
> In this case clear_huge_page() is being called without invoking
> pte_unmap(). The 'normal' counterpart of hugetlb_no_page (which is
> do_no_page() in mm/memory.c) does call pte_unmap() before calling
> alloc_page() (which might sleep).
> 
> So, I believe pte_unmap() must be invoked first in hugetlb_no_page().
> But the problem here is, we do not have a reference to the pmd to map
> the pte again (using pte_offset_map()). The do_no_page() function does
> have a pmd_t* parameter, so it can remap the pte when required.
> 
> For now, I resolved the problem by expanding the pte_alloc_map() macro
> by hand and replacing kmap_atomic with kmap(), although I think it is
> not the right thing to do.
> 
> Let me know if my analysis is helping you figure out the problem here. Thanks!

Except that I don't see where pte_alloc_map() has been called before
hand... hugetlb_no_page() is called by hugetlb_fault() which is called
by __handle_mm_fault(), with no lock held.

Ben.
