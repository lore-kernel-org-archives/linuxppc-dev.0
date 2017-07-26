Return-Path: <bp@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHMZd4Vb7zDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:29:29 +1000 (AEST)
Date: Wed, 26 Jul 2017 06:28:40 +0200
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
Subject: Re: [RFC Part1 PATCH v3 03/17] x86/mm: Secure Encrypted
 Virtualization (SEV) support
Message-ID: <20170726042840.GB30702@nazgul.tnic>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170724190757.11278-4-brijesh.singh@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 02:07:43PM -0500, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Provide support for Secure Encyrpted Virtualization (SEV). This initial

Your subject misses a verb and patch subjects should have an active verb
denoting what the patch does. The sentence above is a good example.

> support defines a flag that is used by the kernel to determine if it is
> running with SEV active.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h | 2 ++
>  arch/x86/mm/mem_encrypt.c          | 3 +++
>  include/linux/mem_encrypt.h        | 8 +++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)

...

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 0fbd092..1e4643e 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -40,6 +40,9 @@ static char sme_cmdline_off[] __initdata = "off";
>  unsigned long sme_me_mask __section(.data) = 0;
>  EXPORT_SYMBOL_GPL(sme_me_mask);
>  
> +unsigned int sev_enabled __section(.data) = 0;
> +EXPORT_SYMBOL_GPL(sev_enabled);

So sev_enabled is a pure bool used only in bool context, not like
sme_me_mask whose value is read too. Which means, you can make the
former static and query it only through accessor functions.

>  /* Buffer used for early in-place encryption by BSP, no locking needed */
>  static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
>  
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index 1255f09..ea0831a 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -22,12 +22,18 @@
>  #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
>  #define sme_me_mask	0UL
> +#define sev_enabled	0
>  
>  #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
>  static inline bool sme_active(void)
>  {
> -	return !!sme_me_mask;
> +	return (sme_me_mask && !sev_enabled);

You don't need the brackets. Below too.

> +}
> +
> +static inline bool sev_active(void)
> +{
> +	return (sme_me_mask && sev_enabled);
>  }

So this is confusing, TBH. SME and SEV are not mutually exclusive and
yet the logic here says so. Why?

I mean, in the hypervisor context, sme_active() is still true.

/me is confused.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
