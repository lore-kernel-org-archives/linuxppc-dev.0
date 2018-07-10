Return-Path: <srs0=oyn9=j2=google.com=keescook@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PnWK23NdzDr2J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 13:19:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41PnWK1FtHz8t6f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 13:19:57 +1000 (AEST)
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41PnWH3dJGz9s0W
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2018 13:19:54 +1000 (AEST)
Received: by mail-yb0-x241.google.com with SMTP id x15-v6so8065665ybm.2
 for <linuxppc-dev@ozlabs.org>; Mon, 09 Jul 2018 20:19:54 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180710020836.23571-1-mpe@ellerman.id.au>
References: <20180710020836.23571-1-mpe@ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Jul 2018 20:19:50 -0700
Message-ID: <CAGXu5j+JvY34VRH17=2xgT0ah9Tmj=jchZsxjSV03B_0cN19eA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Add powerpc options for
 spec_store_bypass_disable
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 9, 2018 at 7:08 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Document the support for spec_store_bypass_disable that was added for
> powerpc in commit a048a07d7f45 ("powerpc/64s: Add support for a store
> forwarding barrier at kernel entry/exit").
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> I tried documenting the differences between the PPC options and X86 ones in one
> section, but it got quite messy, so I went with this instead. Happy to take
> advice on how better to structure it if anyone has opinions.
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc7aa7a0670..f320c7168b04 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4060,6 +4060,8 @@
>                         This parameter controls whether the Speculative Store
>                         Bypass optimization is used.
>
> +                       On x86 the options are:
> +
>                         on      - Unconditionally disable Speculative Store Bypass
>                         off     - Unconditionally enable Speculative Store Bypass
>                         auto    - Kernel detects whether the CPU model contains an
> @@ -4075,12 +4077,20 @@
>                         seccomp - Same as "prctl" above, but all seccomp threads
>                                   will disable SSB unless they explicitly opt out.
>
> -                       Not specifying this option is equivalent to
> -                       spec_store_bypass_disable=auto.
> -
>                         Default mitigations:
>                         X86:    If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
>
> +                       On powerpc the options are:
> +
> +                       on,auto - On Power8 and Power9 insert a store-forwarding
> +                                 barrier on kernel entry and exit. On Power7
> +                                 perform a software flush on kernel entry and
> +                                 exit.
> +                       off     - No action.
> +
> +                       Not specifying this option is equivalent to
> +                       spec_store_bypass_disable=auto.
> +
>         spia_io_base=   [HW,MTD]
>         spia_fio_base=
>         spia_pedr=
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
