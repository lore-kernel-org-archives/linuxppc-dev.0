Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHDY76xNBzDvc8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:11:54 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id a20so11590298wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 18:11:53 -0800 (PST)
Date: Mon, 14 Nov 2016 05:11:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, benh@au1.ibm.com, michaele@au1.ibm.com,
 michael.neuling@au1.ibm.com, paulus@au1.ibm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 2/2] mm: THP page cache support for ppc64
Message-ID: <20161114021145.GA5180@node.shutemov.name>
References: <20161113150025.17942-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161113150025.17942-2-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161113150025.17942-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 13, 2016 at 08:30:25PM +0530, Aneesh Kumar K.V wrote:
> Add arch specific callback in the generic THP page cache code that will
> deposit and withdarw preallocated page table. Archs like ppc64 use
> this preallocated table to store the hash pte slot information.
> 
> Testing:
> kernel build of the patch series on tmpfs mounted with option huge=always
> 
> The related thp stat:
> thp_fault_alloc 72939
> thp_fault_fallback 60547
> thp_collapse_alloc 603
> thp_collapse_alloc_failed 0
> thp_file_alloc 253763
> thp_file_mapped 4251
> thp_split_page 51518
> thp_split_page_failed 1
> thp_deferred_split_page 73566
> thp_split_pmd 665
> thp_zero_page_alloc 3
> thp_zero_page_alloc_failed 0
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

One nit-pick below, but otherwise

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> @@ -2975,6 +3004,13 @@ static int do_set_pmd(struct fault_env *fe, struct page *page)
>  	ret = 0;
>  	count_vm_event(THP_FILE_MAPPED);
>  out:
> +	/*
> +	 * If we are going to fallback to pte mapping, do a
> +	 * withdraw with pmd lock held.
> +	 */
> +	if (arch_needs_pgtable_deposit() && (ret == VM_FAULT_FALLBACK))

Parenthesis are redundant around ret check.

> +		fe->prealloc_pte = pgtable_trans_huge_withdraw(vma->vm_mm,
> +							       fe->pmd);
>  	spin_unlock(fe->ptl);
>  	return ret;
>  }

-- 
 Kirill A. Shutemov
