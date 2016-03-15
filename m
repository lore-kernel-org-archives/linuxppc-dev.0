Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com
 [IPv6:2607:f8b0:4003:c01::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPcgf4qtFzDqyC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 01:38:54 +1100 (AEDT)
Received: by mail-ob0-x22b.google.com with SMTP id m7so18945274obh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 07:38:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160315174634.6766cd88@canb.auug.org.au>
References: <20160315174634.6766cd88@canb.auug.org.au>
Date: Tue, 15 Mar 2016 16:38:51 +0200
Message-ID: <CAHp75VcjmDsgStAZVA=0EU4nQwCx-s+4kF_CsmSrrZtVpVg1bA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the aio tree
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-next <linux-next@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org,
 Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2016 at 8:46 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Benjamin,
>
> After merging the aio tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
>
> fs/built-in.o: In function `aio_thread_op_foo_at':
> aio.c:(.text+0x4dab4): undefined reference to `__get_user_bad'
> aio.c:(.text+0x4daec): undefined reference to `__get_user_bad'

avr32 seems affected as well and the below solution is not suitable
(should be much more verbose in asm, I guess).

>
> Caused by commit
>
>   150a0b4905f1 ("aio: add support for async openat()")
>
> despite commit
>
>   d2f7a973e11e ("aio: don't use __get_user() for 64 bit values")
>
> This is due to a bug in the powerpc __get_user_check() macro (the return
> value is defined to be "unsigned long" which is only 32 bits on a 32
> bit platform).
>
> I applied the patch below which seems to help (Michael, what do you
> think?), but given Al's and Christoph's reactions, I am inclined to
> remove the aio tree from tomorrow and maybe it can be revisited after
> the merge window.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 Mar 2016 16:36:06 +1100
> Subject: [PATCH] powerpc: fix get_user for 64 bit typs on 32 bit platforms
>
> solution borrowed from the x86 uaccess.h
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/uaccess.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index b7c20f0b8fbe..52262b2f37fc 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -261,10 +261,13 @@ do {                                                              \
>         }                                                       \
>  } while (0)
>
> +#define __inttype(x) \
> +       __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
> +
>  #define __get_user_nocheck(x, ptr, size)                       \
>  ({                                                             \
>         long __gu_err;                                          \
> -       unsigned long __gu_val;                                 \
> +       __inttype(*(ptr)) __gu_val;                             \
>         __typeof__(*(ptr)) __user *__gu_addr = (ptr);   \
>         __chk_user_ptr(ptr);                                    \
>         if (!is_kernel_addr((unsigned long)__gu_addr))          \
> @@ -277,7 +280,7 @@ do {                                                                \
>  #define __get_user_check(x, ptr, size)                                 \
>  ({                                                                     \
>         long __gu_err = -EFAULT;                                        \
> -       unsigned long  __gu_val = 0;                                    \
> +       __inttype(*(ptr)) __gu_val = 0;                         \
>         __typeof__(*(ptr)) __user *__gu_addr = (ptr);           \
>         might_fault();                                                  \
>         if (access_ok(VERIFY_READ, __gu_addr, (size)))                  \
> @@ -289,7 +292,7 @@ do {                                                                \
>  #define __get_user_nosleep(x, ptr, size)                       \
>  ({                                                             \
>         long __gu_err;                                          \
> -       unsigned long __gu_val;                                 \
> +       __inttype(*(ptr)) __gu_val;                             \
>         __typeof__(*(ptr)) __user *__gu_addr = (ptr);   \
>         __chk_user_ptr(ptr);                                    \
>         __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
> --
> 2.7.0
>
> --
> Cheers,
> Stephen Rothwell



-- 
With Best Regards,
Andy Shevchenko
