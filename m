Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMfgn12QyzDrJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 14:03:48 +1000 (AEST)
Date: Wed, 2 Aug 2017 06:02:56 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>
Subject: Re: [RFC Part1 PATCH v3 11/17] x86/mm, resource: Use PAGE_KERNEL
 protection for ioremap of memory pages
Message-ID: <20170802040255.GA4336@nazgul.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-12-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170724190757.11278-12-brijesh.singh@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 02:07:51PM -0500, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> In order for memory pages to be properly mapped when SEV is active, we
> need to use the PAGE_KERNEL protection attribute as the base protection.
> This will insure that memory mapping of, e.g. ACPI tables, receives the
> proper mapping attributes.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/mm/ioremap.c  | 28 ++++++++++++++++++++++++++++
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 17 +++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index c0be7cf..7b27332 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -69,6 +69,26 @@ static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
>  	return 0;
>  }
>  
> +static int __ioremap_res_desc_other(struct resource *res, void *arg)
> +{
> +	return (res->desc != IORES_DESC_NONE);
> +}
> +
> +/*
> + * This function returns true if the target memory is marked as
> + * IORESOURCE_MEM and IORESOURCE_BUSY and described as other than
> + * IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
> + */
> +static bool __ioremap_check_if_mem(resource_size_t addr, unsigned long size)
> +{
> +	u64 start, end;
> +
> +	start = (u64)addr;
> +	end = start + size - 1;
> +
> +	return (walk_mem_res(start, end, NULL, __ioremap_res_desc_other) == 1);
> +}
> +
>  /*
>   * Remap an arbitrary physical address space into the kernel virtual
>   * address space. It transparently creates kernel huge I/O mapping when
> @@ -146,7 +166,15 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  		pcm = new_pcm;
>  	}
>  
> +	/*
> +	 * If the page being mapped is in memory and SEV is active then
> +	 * make sure the memory encryption attribute is enabled in the
> +	 * resulting mapping.
> +	 */
>  	prot = PAGE_KERNEL_IO;
> +	if (sev_active() && __ioremap_check_if_mem(phys_addr, size))
> +		prot = pgprot_encrypted(prot);

Hmm, so this function already does walk_system_ram_range() a bit
earlier and now on SEV systems we're going to do it again. Can we make
walk_system_ram_range() return a distinct value for SEV systems and act
accordingly in __ioremap_caller() instead of repeating the operation?

It looks to me like we could...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
