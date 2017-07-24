Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGHdl1rFyzDrKN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:28:27 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id d145so6954333qkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 03:28:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724010109.21263-2-matthew.brown.dev@gmail.com>
References: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
 <20170724010109.21263-2-matthew.brown.dev@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 24 Jul 2017 20:28:23 +1000
Message-ID: <CAKTCnzmT0E=4u9B5vYE2nmCm9T+uMAX1cfJv0bRsrb6x3VYrzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 11:01 AM, Matt Brown
<matthew.brown.dev@gmail.com> wrote:
> This adds emulations for the popcntb, popcntw, and popcntd instructions.
> Tested for correctness against the popcnt{b,w,d} instructions on ppc64le.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> v2:
>         - fixed opcodes
>         - fixed typecasting
>         - fixed bitshifting error for both 32 and 64bit arch
> ---
>  arch/powerpc/lib/sstep.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 87d277f..e6a16a3 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -612,6 +612,35 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
>         regs->gpr[rd] = out_val;
>  }
>
> +/*
> + * The size parameter is used to adjust the equivalent popcnt instruction.
> + * popcntb = 8, popcntw = 32, popcntd = 64
> + */
> +static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
> +                               int size, int ra)
> +{
> +       unsigned long long high, low, mask;
> +       unsigned int n;
> +       int i, j;
> +
> +       high = 0;
> +       low = 0;
> +
> +       for (i = 0; i < (64 / size); i++) {
> +               n = 0;
> +               for (j = 0; j < size; j++) {
> +                       mask = 1UL << (j + (i * size));
> +                       if (v1 & mask)
> +                               n++;
> +               }
> +               if ((i * size) < 32)
> +                       low |= n << (i * size);
> +               else
> +                       high |= n << ((i * size) - 32);
> +       }
> +       regs->gpr[ra] = (high << 32) | low;
> +}

There's a way to do it in very efficient way via the Giles-Miller
method of side-ways addition

Please see

http://opensourceforu.com/2012/06/power-programming-bitwise-tips-tricks/
and lib/hweight.c, you can reuse the code from lib/hweight.c

Balbir Singh
