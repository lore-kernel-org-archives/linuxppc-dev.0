Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCL9W10ZgzDq96
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 20:11:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rui Teng <rui.teng@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, jia he <hejianet@linux.vnet.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: fix a hardcode on memory boundary checking
In-Reply-To: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
References: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
Date: Tue, 31 Jan 2017 20:11:41 +1100
Message-ID: <877f5bvbjm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rui Teng <rui.teng@linux.vnet.ibm.com> writes:

> The offset of hugepage block will not be 16G, if the expected
> page is more than one. Calculate the totol size instead of the
> hardcode value.

I assume you found this by code inspection and not by triggering an
actual bug?

cheers

> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 8033493..b829f8e 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -506,7 +506,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
>  	printk(KERN_INFO "Huge page(16GB) memory: "
>  			"addr = 0x%lX size = 0x%lX pages = %d\n",
>  			phys_addr, block_size, expected_pages);
> -	if (phys_addr + (16 * GB) <= memblock_end_of_DRAM()) {
> +	if (phys_addr + block_size * expected_pages <= memblock_end_of_DRAM()) {
>  		memblock_reserve(phys_addr, block_size * expected_pages);
>  		add_gpage(phys_addr, block_size, expected_pages);
>  	}
> -- 
> 2.9.0
