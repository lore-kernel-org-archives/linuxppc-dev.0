Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C786DDFFC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 13:01:47 +1000 (EST)
Subject: Re: hugetlbfs for ppc440 - kernel BUG -- follow up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Satya <satyakiran@gmail.com>
In-Reply-To: <acbcf3840707171918h5dee75d9t96d6a62e8a0161fa@mail.gmail.com>
References: <acbcf3840707171407x21c1bc1al9b46ff0c692b2b4d@mail.gmail.com>
	<1184723616.25235.186.camel@localhost.localdomain>
	<acbcf3840707171918h5dee75d9t96d6a62e8a0161fa@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 13:01:26 +1000
Message-Id: <1184727686.25235.203.camel@localhost.localdomain>
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

On Tue, 2007-07-17 at 21:18 -0500, Satya wrote:
> the calling sequence is :
> 
> __handle_mm_fault -> hugetlb_fault -> huge_pte_alloc() ->
> pte_alloc_map()
> 
> where -> stands for 'calls'.
> 
> hugetlb_fault() calls hugetlb_no_page() after returning from
> huge_pte_alloc().
> 
> [huge_pte_alloc() is an arch specific call back implemented in the
> patch referred to in my earlier posts]

Ok, so I think the problem might be there. If you look at other
implementations of hugetlbfs, such as x86, there is no need to do any
mapping in huge_pte_alloc(). Only the PTE pages can be mapped/unmapped
and the huge pages are stored at the PMD level. You may want to do
something similar, and if you need a PTE level for huge pages
specifically, then you could do your own allocations there that don't
require a mapping.

Ben.
