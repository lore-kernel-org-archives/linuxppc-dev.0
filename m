Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AB551A0C66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:48:07 +1000 (AEST)
Received: by widdq5 with SMTP id dq5so39273613wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 02:48:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 12:48:04 +0300
Message-ID: <CAPAsAGwU7+uB6xqtUYNyKFBnDp3a+_-b9KM6XtXvNJTjHGqqMg@mail.gmail.com>
Subject: Re: [PATCH V2 06/10] kasan: Allow arch to overrride kasan shadow
 offsets
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
> Some archs may want to provide kasan shadow memory as a constant
> offset from the address. Such arch even though cannot use inline kasan
> support, they can work with outofline kasan support.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  include/linux/kasan.h | 3 +++
>  mm/kasan/kasan.h      | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5486d777b706..e458ca64cdaf 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -15,11 +15,14 @@ struct vm_struct;
>  #include <asm/kasan.h>
>  #include <linux/sched.h>
>
> +#ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
>         return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>                 + KASAN_SHADOW_OFFSET;
>  }
> +#define kasan_mem_to_shadow kasan_mem_to_shadow

Again, why we need this define here? I think it should be safe to remove it.

> +#endif
>
>  /* Enable reporting bugs after kasan_disable_current() */
>  static inline void kasan_enable_current(void)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index deb547d5a916..c0686f2b1224 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -57,11 +57,14 @@ struct kasan_global {
>  void kasan_report_error(struct kasan_access_info *info);
>  void kasan_report_user_access(struct kasan_access_info *info);
>
> +#ifndef kasan_shadow_to_mem
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>         return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
>                 << KASAN_SHADOW_SCALE_SHIFT);
>  }
> +#define kasan_shadow_to_mem kasan_shadow_to_mem

ditto

> +#endif
>
>  static inline bool kasan_report_enabled(void)
>  {
> --
> 2.5.0
>
