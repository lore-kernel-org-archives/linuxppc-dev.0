Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5C6E1400E3
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2014 07:03:41 +1000 (EST)
Received: by mail-wg0-f48.google.com with SMTP id l18so2818wgh.19
 for <linuxppc-dev@ozlabs.org>; Mon, 07 Apr 2014 14:03:37 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <13762.1395708188@ale.ozlabs.ibm.com>
References: <13762.1395708188@ale.ozlabs.ibm.com>
Date: Mon, 7 Apr 2014 23:03:36 +0200
Message-ID: <CAMuHMdV7BuSMu5gyhBcxY_8v+u3KnVStDgvC-JSN=hX3VZw3+g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/opal: Add missing include
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Linux-Next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2014 at 1:43 AM, Michael Neuling <mikey@neuling.org> wrote:
> next-20140324 currently fails compiling celleb_defconfig with:
>
> arch/powerpc/include/asm/opal.h:894:42: error: 'struct notifier_block' declared inside parameter list [-Werror]
> arch/powerpc/include/asm/opal.h:894:42: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]
> arch/powerpc/include/asm/opal.h:896:14: error: 'struct notifier_block' declared inside parameter list [-Werror]
>
> This is due to a missing include which is added here.

This build issue has now been in mainline since a few days.

> Signed-off-by: Michael Neuling <mikey@neuling.org>
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index fe2aa0b..f57fb58 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -177,6 +177,8 @@ extern int opal_enter_rtas(struct rtas_args *args,
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/notifier.h>
> +
>  /* Other enums */
>  enum OpalVendorApiTokens {
>         OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
