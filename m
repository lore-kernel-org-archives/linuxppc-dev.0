Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ms1h0N1SzF1nZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:03:35 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id 11-v6so3883431ois.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 06:03:35 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 17 May 2018 15:03:12 +0200
Message-ID: <CA+7wUsyEBW-sKiwP_KJpwuWC0JGi_Cg-xnxcnw0d_Wc7-GWeeA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant
 sizes
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 17, 2018 at 12:49 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> In my 8xx configuration, I get 208 calls to memcmp()
> Within those 208 calls, about half of them have constant sizes,
> 46 have a size of 8, 17 have a size of 16, only a few have a
> size over 16. Other fixed sizes are mostly 4, 6 and 10.
>
> This patch inlines calls to memcmp() when size
> is constant and lower than or equal to 16
>
> In my 8xx configuration, this reduces the number of calls
> to memcmp() from 208 to 123
>
> The following table shows the number of TB timeticks to perform
> a constant size memcmp() before and after the patch depending on
> the size
>
>         Before  After   Improvement
> 01:      7577    5682   25%
> 02:     41668    5682   86%
> 03:     51137   13258   74%
> 04:     45455    5682   87%
> 05:     58713   13258   77%
> 06:     58712   13258   77%
> 07:     68183   20834   70%
> 08:     56819   15153   73%
> 09:     70077   28411   60%
> 10:     70077   28411   60%
> 11:     79546   35986   55%
> 12:     68182   28411   58%
> 13:     81440   35986   55%
> 14:     81440   39774   51%
> 15:     94697   43562   54%
> 16:     79546   37881   52%
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/string.h | 46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 35f1aaad9b50..80cf0f9605dd 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -4,6 +4,8 @@
>
>  #ifdef __KERNEL__
>
> +#include <linux/kernel.h>
> +
>  #define __HAVE_ARCH_STRNCPY
>  #define __HAVE_ARCH_STRNCMP
>  #define __HAVE_ARCH_MEMSET
> @@ -51,10 +53,54 @@ static inline int strncmp(const char *p, const char *q, __kernel_size_t size)
>         return __strncmp(p, q, size);
>  }
>
> +static inline int __memcmp1(const void *p, const void *q, int off)

Does that change anything if you change void* to char* pointer ? I
find void* arithmetic hard to read.

> +{
> +       return *(u8*)(p + off) - *(u8*)(q + off);
> +}
> +
> +static inline int __memcmp2(const void *p, const void *q, int off)
> +{
> +       return be16_to_cpu(*(u16*)(p + off)) - be16_to_cpu(*(u16*)(q + off));
> +}
> +
> +static inline int __memcmp4(const void *p, const void *q, int off)
> +{
> +       return be32_to_cpu(*(u32*)(p + off)) - be32_to_cpu(*(u32*)(q + off));
> +}
> +
> +static inline int __memcmp8(const void *p, const void *q, int off)
> +{
> +       s64 tmp = be64_to_cpu(*(u64*)(p + off)) - be64_to_cpu(*(u64*)(q + off));

I always assumed 64bits unaligned access would trigger an exception.
Is this correct ?

> +       return tmp >> 32 ? : (int)tmp;
> +}
> +
> +static inline int __memcmp_cst(const void *p,const void *q,__kernel_size_t size)
> +{
> +       if (size == 1)
> +               return __memcmp1(p, q, 0);
> +       if (size == 2)
> +               return __memcmp2(p, q, 0);
> +       if (size == 3)
> +               return __memcmp2(p, q, 0) ? : __memcmp1(p, q, 2);
> +       if (size == 4)
> +               return __memcmp4(p, q, 0);
> +       if (size == 5)
> +               return __memcmp4(p, q, 0) ? : __memcmp1(p, q, 4);
> +       if (size == 6)
> +               return __memcmp4(p, q, 0) ? : __memcmp2(p, q, 4);
> +       if (size == 7)
> +               return __memcmp4(p, q, 0) ? : __memcmp2(p, q, 4) ? : __memcmp1(p, q, 6);
> +       return __memcmp8(p, q, 0);
> +}
> +
>  static inline int memcmp(const void *p,const void *q,__kernel_size_t size)
>  {
>         if (unlikely(!size))
>                 return 0;
> +       if (__builtin_constant_p(size) && size <= 8)
> +               return __memcmp_cst(p, q, size);
> +       if (__builtin_constant_p(size) && size <= 16)
> +               return __memcmp8(p, q, 0) ? : __memcmp_cst(p + 8, q + 8, size - 8);
>         return __memcmp(p, q, size);
>  }
>
> --
> 2.13.3
>
