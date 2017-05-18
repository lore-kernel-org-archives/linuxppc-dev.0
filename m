Return-Path: <srs0=jr4t=4y=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTJqw1F96zDqcD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 04:00:11 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wTJqt4Nb8z8wWT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 04:00:10 +1000 (AEST)
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wTJqs4F5fz9s03
 for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2017 04:00:09 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id k74so7053155qke.2
 for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2017 11:00:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495103851-14916-1-git-send-email-mpe@ellerman.id.au>
References: <1495103851-14916-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 19 May 2017 04:00:06 +1000
Message-ID: <CAKTCnzna2SFRhwd=fHEX_XevEHr+yZ6ar3UExr_gpXusFMYpXg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Kees Cook <keescook@chromium.org>, Breno Leitao <leitao@debian.org>,
 Laura Abbott <labbott@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 18, 2017 at 8:37 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> virt_addr_valid() is supposed to tell you if it's OK to call virt_to_page() on
> an address. What this means in practice is that it should only return true for
> addresses in the linear mapping which are backed by a valid PFN.
>
> We are failing to properly check that the address is in the linear mapping,
> because virt_to_pfn() will return a valid looking PFN for more or less any
> address. That bug is actually caused by __pa(), used in virt_to_pfn().
>
> eg: __pa(0xc000000000010000) = 0x10000  # Good
>     __pa(0xd000000000010000) = 0x10000  # Bad!
>     __pa(0x0000000000010000) = 0x10000  # Bad!
>

I fixed something similar in skiboot and KVM, I should have audited this space
as well.

> This started happening after commit bdbc29c19b26 ("powerpc: Work around gcc
> miscompilation of __pa() on 64-bit") (Aug 2013), where we changed the definition
> of __pa() to work around a GCC bug. Prior to that we subtracted PAGE_OFFSET from
> the value passed to __pa(), meaning __pa() of a 0xd or 0x0 address would give
> you something bogus back.
>
> Until we can verify if that GCC bug is no longer an issue, or come up with
> another solution, this commit does the minimal fix to make virt_addr_valid()
> work, by explicitly checking that the address is in the linear mapping region.
>
> Fixes: bdbc29c19b26 ("powerpc: Work around gcc miscompilation of __pa() on 64-bit")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/page.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 2a32483c7b6c..8da5d4c1cab2 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -132,7 +132,19 @@ extern long long virt_phys_offset;
>  #define virt_to_pfn(kaddr)     (__pa(kaddr) >> PAGE_SHIFT)
>  #define virt_to_page(kaddr)    pfn_to_page(virt_to_pfn(kaddr))
>  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
> +/*
> + * On hash the vmalloc and other regions alias to the kernel region when passed
> + * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() can
> + * return true for some vmalloc addresses, which is incorrect. So explicitly
> + * check that the address is in the kernel region.
> + */
> +#define virt_addr_valid(kaddr) (REGION_ID(kaddr) == KERNEL_REGION_ID && \
> +                               pfn_valid(virt_to_pfn(kaddr)))
> +#else
>  #define virt_addr_valid(kaddr) pfn_valid(virt_to_pfn(kaddr))
> +#endif
>

Looks good to me

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
