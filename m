Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Litke <agl@us.ibm.com>
In-Reply-To: <1172000736.22940.48.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<1172000736.22940.48.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 06:51:47 +1100
Message-Id: <1172001107.18571.127.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 13:45 -0600, Adam Litke wrote:
> Your patch drops the pgoff check that prepare_hugepage_range used to
> check.  The misaligned_offset test in libhugetlbfs identified the
> problem.  The following patch (applied on top of yours) makes the
> problem go away.  I am not necessarily suggesting it's the correct
> fix... just concisely describing the problem.

Ok, I'll fold that into the patch. Ultimately, when I finally do the
generic changes, prepare_hugepage_range() will be going away. I will
either pass pgoff along to slice_g_u_a for it to validate the pgoff, or
I will let f_ops->mmap() be responsible of checking it. For SPEs, I do
the pgoff check there. Any reason tht wouldn't work for huge pages ?

Ben.

> commit 95bcfa9c7b086de320cd9a1ff9c7281f7f16b15f
> Author: Adam Litke <agl@us.ibm.com>
> Date:   Tue Feb 20 11:44:46 2007 -0800
> 
>     Restore the pgoff check for prepare_hugepage_range()
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index cbb8c52..f38ab78 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -349,6 +349,9 @@ int prepare_hugepage_range(unsigned long addr, unsigned long len, pgoff_t pgoff)
>  
>  	printk("prepare_hugepage_range(addr=0x%lx, len=0x%lx\n", addr, len);
>  
> +	if (pgoff & (~HPAGE_MASK >> PAGE_SHIFT))
> +		return -EINVAL;
> +
>  	/* This is only useful for MAP_FIXED so we turn it into that */
>  	gua_addr = slice_get_unmapped_area(addr, len, MAP_FIXED,
>  					   mmu_huge_psize, 1, 0);
> 
