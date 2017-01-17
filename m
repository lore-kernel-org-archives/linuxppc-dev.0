Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2gch0Q7YzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:46:44 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id t6so3116706pgt.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 22:46:43 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Jan 2017 12:16:35 +0530
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/mm: refactor radix physical page mapping
Message-ID: <20170117064635.GB8963@dhcp-9-109-223-248.in.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 01:07:43PM -0600, Reza Arbab wrote:
> Move the page mapping code in radix_init_pgtable() into a separate
> function that will also be used for memory hotplug.
> 
> The current goto loop progressively decreases its mapping size as it
> covers the tail of a range whose end is unaligned. Change this to a for
> loop which can do the same for both ends of the range.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 88 +++++++++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 623a0dc..2ce1354 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -107,54 +107,66 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  	return 0;
>  }
>  
> +static inline void __meminit print_mapping(unsigned long start,
> +					   unsigned long end,
> +					   unsigned long size)
> +{
> +	if (end <= start)
> +		return;

Should we pr_err for start > end?

> +
> +	pr_info("Mapped range 0x%lx - 0x%lx with 0x%lx\n", start, end, size);
> +}
> +
> +static int __meminit create_physical_mapping(unsigned long start,
> +					     unsigned long end)
> +{
> +	unsigned long addr, mapping_size;
> +
> +	start = _ALIGN_UP(start, PAGE_SIZE);
> +	for (addr = start; addr < end; addr += mapping_size) {
> +		unsigned long gap, previous_size;
> +		int rc;
> +
> +		gap = end - addr;
> +		previous_size = mapping_size;
> +
> +		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
> +		    mmu_psize_defs[MMU_PAGE_1G].shift)
> +			mapping_size = PUD_SIZE;
> +		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
> +			 mmu_psize_defs[MMU_PAGE_2M].shift)
> +			mapping_size = PMD_SIZE;
> +		else
> +			mapping_size = PAGE_SIZE;
> +
> +		if (mapping_size != previous_size) {
> +			print_mapping(start, addr, previous_size);
> +			start = addr;
> +		}
> +
> +		rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
> +					    PAGE_KERNEL_X, mapping_size);
> +		if (rc)
> +			return rc;

Should we try a lower page size if map_kernel_page fails for this mapping_size?
I like the cleanup very much, BTW

Balbir Singh.
