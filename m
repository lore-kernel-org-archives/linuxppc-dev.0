Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dh969GczDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:23:21 +1000 (AEST)
In-Reply-To: <1491991867-8758-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm: Fix swapper_pg_dir size on 64-bit hash w/64K pages
Message-Id: <3w3dh94qgFz9sNl@ozlabs.org>
Date: Thu, 13 Apr 2017 21:23:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 10:11:07 UTC, Michael Ellerman wrote:
> Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB"),
> we increased H_PGD_INDEX_SIZE to 15 when we're building with 64K pages. This
> makes it larger than RADIX_PGD_INDEX_SIZE (13), which means the logic to
> calculate MAX_PGD_INDEX_SIZE in book3s/64/pgtable.h is wrong.
> 
> The end result is that the PGD (Page Global Directory, ie top level page table)
> of the kernel (aka. swapper_pg_dir), is too small.
> 
> This generally doesn't lead to a crash, as we don't use the full range in normal
> operation. However if we try to dump the kernel pagetables we can trigger a
> crash because we walk off the end of the pgd into other memory and eventually
> try to dereference something bogus:
> 
>   $ cat /sys/kernel/debug/kernel_pagetables
>   Unable to handle kernel paging request for data at address 0xe8fece0000000000
>   Faulting instruction address: 0xc000000000072314
>   cpu 0xc: Vector: 380 (Data SLB Access) at [c0000000daa13890]
>       pc: c000000000072314: ptdump_show+0x164/0x430
>       lr: c000000000072550: ptdump_show+0x3a0/0x430
>      dar: e802cf0000000000
>   seq_read+0xf8/0x560
>   full_proxy_read+0x84/0xc0
>   __vfs_read+0x6c/0x1d0
>   vfs_read+0xbc/0x1b0
>   SyS_read+0x6c/0x110
>   system_call+0x38/0xfc
> 
> The root cause is that MAX_PGD_INDEX_SIZE isn't actually computed to be
> the max of H_PGD_INDEX_SIZE or RADIX_PGD_INDEX_SIZE. To fix that move
> the calculation into asm-offsets.c where we can do it easily using
> max().
> 
> Fixes: f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/03dfee6d5f824d14e3ecb742518740

cheers
