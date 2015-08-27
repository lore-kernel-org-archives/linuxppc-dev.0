Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0792F1A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:46:07 +1000 (AEST)
Received: by wijn1 with SMTP id n1so49763266wij.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 02:46:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 12:46:03 +0300
Message-ID: <CAPAsAGyN-yGEXmVFXSEs=tQ1We6MNS89omm=DOPGogfXWqn_qg@mail.gmail.com>
Subject: Re: [PATCH V2 05/10] kasan: Enable arch to hook into kasan callbacks.
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> We add enable/disable callbacks in this patch which architecture
> can implemement. We will use this in the later patches for architecture
> like ppc64, that cannot have early zero page kasan shadow region for the
> entire virtual address space. Such architectures also cannot use
> inline kasan support.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  mm/kasan/kasan.c |  9 +++++++++
>  mm/kasan/kasan.h | 15 +++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 7b28e9cdf1c7..e4d33afd0eaf 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -43,6 +43,9 @@ static void kasan_poison_shadow(const void *address, size_t size, u8 value)
>  {
>         void *shadow_start, *shadow_end;
>
> +       if (!kasan_enabled())
> +               return;
> +

By the time this function called we already should have shadow,
so it should be safe to remove this check.


>         shadow_start = kasan_mem_to_shadow(address);
>         shadow_end = kasan_mem_to_shadow(address + size);
>
> @@ -51,6 +54,9 @@ static void kasan_poison_shadow(const void *address, size_t size, u8 value)
>
>  void kasan_unpoison_shadow(const void *address, size_t size)
>  {
> +       if (!kasan_enabled())
> +               return;
> +

Ditto.

>         kasan_poison_shadow(address, size, 0);
>
>         if (size & KASAN_SHADOW_MASK) {
> @@ -238,6 +244,9 @@ static __always_inline void check_memory_region(unsigned long addr,
>  {
>         struct kasan_access_info info;
>
> +       if (!kasan_enabled())
> +               return;
> +
>         if (unlikely(size == 0))
>                 return;
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index a6b46cc94907..deb547d5a916 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -68,6 +68,21 @@ static inline bool kasan_report_enabled(void)
>         return !current->kasan_depth;
>  }
>
> +#ifndef kasan_enabled
> +/*
> + * Some archs may want to disable kasan callbacks.
> + */
> +static inline bool kasan_enabled(void)
> +{
> +       return true;
> +}
> +#define kasan_enabled kasan_enabled

Why we need this define?

> +#else
> +#ifdef CONFIG_KASAN_INLINE
> +#error "Kasan inline support cannot work with KASAN arch hooks"
> +#endif
> +#endif
> +
>  void kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>
> --
> 2.5.0
>
