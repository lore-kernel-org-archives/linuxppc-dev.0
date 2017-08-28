Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgpVL0cPJzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 20:51:36 +1000 (AEST)
Date: Mon, 28 Aug 2017 12:51:19 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 David Howells <dhowells@redhat.com>,
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
Subject: Re: [RFC Part1 PATCH v3 15/17] x86: Add support for changing memory
 encryption attribute in early boot
Message-ID: <20170828105119.xs73tinknqcmrgvk@pd.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170724190757.11278-16-brijesh.singh@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 02:07:55PM -0500, Brijesh Singh wrote:
> Some KVM-specific custom MSRs shares the guest physical address with

s/shares/share/

> hypervisor.

"the hypervisor."

> When SEV is active, the shared physical address must be mapped
> with encryption attribute cleared so that both hypervsior and guest can
> access the data.
> 
> Add APIs to change memory encryption attribute in early boot code.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |  17 ++++++
>  arch/x86/mm/mem_encrypt.c          | 117 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)

...

> +static int __init early_set_memory_enc_dec(resource_size_t paddr,
> +					   unsigned long size, bool enc)
> +{
> +	unsigned long vaddr, vaddr_end, vaddr_next;
> +	unsigned long psize, pmask;
> +	int split_page_size_mask;
> +	pte_t *kpte;
> +	int level;
> +
> +	vaddr = (unsigned long)__va(paddr);
> +	vaddr_next = vaddr;
> +	vaddr_end = vaddr + size;
> +
> +	/*
> +	 * We are going to change the physical page attribute from C=1 to C=0
> +	 * or vice versa. Flush the caches to ensure that data is written into
> +	 * memory with correct C-bit before we change attribute.
> +	 */
> +	clflush_cache_range(__va(paddr), size);
> +
> +	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
> +		kpte = lookup_address(vaddr, &level);
> +		if (!kpte || pte_none(*kpte))
> +			return 1;

Return before flushing TLBs? Perhaps you mean

			ret = 1;
			goto out;

here and out does

	__flush_tlb_all();
	return ret;

?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
