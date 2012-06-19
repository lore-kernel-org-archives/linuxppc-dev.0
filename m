Return-Path: <michael@ellerman.id.au>
Message-ID: <1340066853.638.7.camel@concordia>
Subject: Re: CPU-local TLB flushing
From: Michael Ellerman <michael@ellerman.id.au>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date: Tue, 19 Jun 2012 10:47:33 +1000
In-Reply-To: <4FDF95C5.3090903@linux.vnet.ibm.com>
References: <4FDF95C5.3090903@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>, Minchan Kim <minchan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-18 at 15:55 -0500, Seth Jennings wrote:
> This is a continuation of a thread a few months ago:
...
> 
> With local_flush_tlb_kernel_range() being a stub,
> the new function local_unmap_kernel_range() is exactly
> the same as unmap_kernel_range() since 
> local_flush_tlb_kernel_range() and flush_tlb_kernel_range()
> are both stubs on ppc64.
> 
> My knowledge of the ppc64 hashing tlb design is almost
> nothing, but it seems like this should work, albeit slowly
> since it would be a global flush rather than cpu-local.
> 
> I was wondering if anyone could tell me why this doesn't work,
> and what needs to be done to make it work.

Hi Seth,

I don't know it that well either, but the way I think it should be
working is:

unmap_kernel_range()
 -> vunmap_page_range()
    -> vunmap_pud/pmd/pte_range()
       -> ptep_get_and_clear()		(arch/powerpc/include/asm/pgtable-ppc64.h)
          -> pte_update()		(arch/powerpc/include/asm/pgtable-ppc64.h)
	     -> hpte_need_flush()
		-> flush_hash_page()	(because you don't have a batch active - I assume)
		   -> pSeries_lpar_hpte_invalidate()


So step one would be to confirm you're getting that far, that would at
least confirm we are doing the invalidate.

cheers
