Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAC001A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:42:42 +1000 (AEST)
Received: by wicgk12 with SMTP id gk12so3330889wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 02:42:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mvxectv1.fsf@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87mvxectv1.fsf@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 12:42:37 +0300
Message-ID: <CAPAsAGzVOdgU7KyvAqHK0SE+D4KXniv8cjA7Ryfg6SmyWV_scQ@mail.gmail.com>
Subject: Re: [PATCH V2 04/10] kasan: Don't use kasan shadow pointer in generic
 functions
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

2015-08-26 11:54 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>
> Missed to cherry-pick the updated version of this patch, before sending
> the series out.
>
> commit aeb324e09d95c189eda4ce03790da94b535d1dfc
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Fri Aug 14 12:28:58 2015 +0530
>
>     kasan: Don't use kasan shadow pointer in generic functions
>
>     We can't use generic functions like print_hex_dump to access kasan
>     shadow region. This require us to setup another kasan shadow region
>     for the address passed (kasan shadow address). Most architecture won't
>     be able to do that. Hence make a copy of the shadow region row and
>     pass that to generic functions.
>
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index d19d01823a68..60fdb0413f3b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -166,14 +166,20 @@ static void print_shadow_for_address(const void *addr)
>         for (i = -SHADOW_ROWS_AROUND_ADDR; i <= SHADOW_ROWS_AROUND_ADDR; i++) {
>                 const void *kaddr = kasan_shadow_to_mem(shadow_row);
>                 char buffer[4 + (BITS_PER_LONG/8)*2];
> +               char shadow_buf[SHADOW_BYTES_PER_ROW];
>
>                 snprintf(buffer, sizeof(buffer),
>                         (i == 0) ? ">%p: " : " %p: ", kaddr);
> -
> +               /*
> +                * We should not pass a shadow pointer to generic
> +                * function, because generic functions may try to
> +                * kasan mapping for the passed address.

may try to *access* kasan mapping?

> +                */
> +               memcpy(shadow_buf, shadow_row, SHADOW_BYTES_PER_ROW);
>                 kasan_disable_current();
>                 print_hex_dump(KERN_ERR, buffer,
>                         DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
> -                       shadow_row, SHADOW_BYTES_PER_ROW, 0);
> +                       shadow_buf, SHADOW_BYTES_PER_ROW, 0);
>                 kasan_enable_current();
>
>                 if (row_is_guilty(shadow_row, shadow))
>
