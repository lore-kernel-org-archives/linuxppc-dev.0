Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w5RJ573MzDr6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 17:47:21 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id i2-v6so9349911uah.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 00:47:21 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
References: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 May 2018 09:47:17 +0200
Message-ID: <CAMuHMdVSKigQPUQH=BVc2fRSRmuEThLaf+V9ghMPDT9_m1C6BA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

CC Geoff

On Tue, May 29, 2018 at 8:03 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>   CC      arch/powerpc/kernel/nvram_64.o
> arch/powerpc/kernel/nvram_64.c: In function 'nvram_create_partition':
> arch/powerpc/kernel/nvram_64.c:1042:2: error: 'strncpy' specified bound 12 equals destination size [-Werror=stringop-truncation]
>   strncpy(new_part->header.name, name, 12);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   CC      arch/powerpc/kernel/trace/ftrace.o
> In function 'make_field',
>     inlined from 'ps3_repository_read_boot_dat_address' at arch/powerpc/platforms/ps3/repository.c:900:9:
> arch/powerpc/platforms/ps3/repository.c:106:2: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
>   strncpy((char *)&n, text, 8);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Thanks for your patch!

> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -1039,7 +1039,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
>         new_part->index = free_part->index;
>         new_part->header.signature = sig;
>         new_part->header.length = size;
> -       strncpy(new_part->header.name, name, 12);
> +       memcpy(new_part->header.name, name, strnlen(name, sizeof(new_part->header.name)));

The comment for nvram_header.lgnth says:

        /* Terminating null required only for names < 12 chars. */

This will not terminate the string with a zero (the struct is
allocated with kmalloc).
So the original code is correct, the new one isn't.

>         new_part->header.checksum = nvram_checksum(&new_part->header);
>
>         rc = nvram_write_header(new_part);
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index 50dbaf24b1ee..e49c887787c4 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -101,9 +101,9 @@ static u64 make_first_field(const char *text, u64 index)
>
>  static u64 make_field(const char *text, u64 index)
>  {
> -       u64 n;
> +       u64 n = 0;
>
> -       strncpy((char *)&n, text, 8);
> +       memcpy((char *)&n, text, strnlen(text, sizeof(n)));

This changes behavior: strncpy() fills the remainder of the buffer with
zeroes.  I don't remember the details of the PS3 repository structure,
but given this writes to a fixed size u64 buffer, I'd expect the PS3
hypervisor code to (1) rely on the zero padding, and (2) not need a zero
terminator if there are 8 characters in the buffer, so probably the
original code is correct, and the "fixed" code isn't.

Has this been tested on a PS3?

>         return n + index;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
