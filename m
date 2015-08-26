Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com
 [IPv6:2a00:1450:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C03781A0179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 03:00:58 +1000 (AEST)
Received: by wicja10 with SMTP id ja10so21195175wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 10:00:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 26 Aug 2015 20:00:54 +0300
Message-ID: <CAPAsAGw9xx36H5vKmfsunQRZ2qhuLUUTupVK=_v=eztBzDsqAQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/10] kasan: MODULE_VADDR is not available on all archs
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
> Conditionalize the check using #ifdef
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  mm/kasan/report.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index e07c94fbd0ac..71ce7548d914 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -85,9 +85,14 @@ static void print_error_description(struct kasan_access_info *info)
>
>  static inline bool kernel_or_module_addr(const void *addr)
>  {
> -       return (addr >= (void *)_stext && addr < (void *)_end)
> -               || (addr >= (void *)MODULES_VADDR
> -                       && addr < (void *)MODULES_END);
> +       if (addr >= (void *)_stext && addr < (void *)_end)
> +               return true;
> +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> +       if (addr >= (void *)MODULES_VADDR
> +                       && addr < (void *)MODULES_END)
> +               return true;
> +#endif

I don't think that this is correct change.
On ppc64 modules are in VMALLOC, so you should check for this.
Yes, we don't handle VMALLOC now, but we will at some point.

So I think we should use is_module_address() here.
It will be slower, but we don't care about performance in error reporting route.
