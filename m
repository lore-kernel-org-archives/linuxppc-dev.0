Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38FAB1A105E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:06 +1000 (AEST)
In-Reply-To: <20150629051150.17663.63753.stgit@drishya>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: [RESEND] powerpc/powernv: Fix vma page prot flags in opal-prd
 driver
Message-Id: <20150707103805.DAE711402C9@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-29-06 at 05:17:55 UTC, Vaidyanathan Srinivasan wrote:
> opal-prd driver will mmap() firmware code/data area as private
> mapping to prd user space daemon.  Write to this page will
> trigger COW faults.  The new COW pages are normal kernel RAM
> pages accounted by the kernel and are not special.
> 
> vma->vm_page_prot value will be used at page fault time
> for the new COW pages, while pgprot_t value passed in
> remap_pfn_range() is used for the initial page table entry.
> 
> Hence:
> * Do not add _PAGE_SPECIAL in vma, but only for remap_pfn_range()
> * Also remap_pfn_range() will add the _PAGE_SPECIAL flag using
>   pte_mkspecial() call, hence no need to specify in the driver
> 
> This fix resolves the page accounting warning shown below:
> BUG: Bad rss-counter state mm:c0000007d34ac600 idx:1 val:19
> 
> The above warning is triggered since _PAGE_SPECIAL was incorrectly
> being set for the normal kernel COW pages.
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=d8ea782b56d9d2c46a47b3231cfd16ecfb538c60

cheers
