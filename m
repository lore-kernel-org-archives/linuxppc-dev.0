Return-Path: <robherring2@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD2721A007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 00:27:37 +1000 (EST)
Received: from mail-vc0-x232.google.com (mail-vc0-x232.google.com
 [IPv6:2607:f8b0:400c:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 36C6D140120
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2014 00:27:37 +1000 (EST)
Received: by mail-vc0-f178.google.com with SMTP id la4so871905vcb.23
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2014 07:27:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409215247-10195-1-git-send-email-mpe@ellerman.id.au>
References: <1409215247-10195-1-git-send-email-mpe@ellerman.id.au>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 28 Aug 2014 09:27:12 -0500
Message-ID: <CAL_Jsq+DSC4DW-ULuFfUjowsCOXbRnXvYSQcLY4inuBuztuh7A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Check flat device tree version at boot
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Grant Likely <grant.likely@linaro.org>, linuxppc-dev@ozlabs.org,
 Rob Herring <robh+dt@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 28, 2014 at 3:40 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> In commit e6a6928c3ea1 "of/fdt: Convert FDT functions to use libfdt",
> the kernel stopped supporting old flat device tree formats. The minimum
> supported version is now 0x10.

Ugg. Is that something which needs to be supported? Supporting it at
this point would mean adding support to libfdt.

Rob

> There was a checking function added, early_init_dt_verify(), but it's
> not called on powerpc.
>
> The result is, if you boot with an old flat device tree, the kernel will
> fail to parse it correctly, think you have no memory etc. and hilarity
> ensues.
>
> We can't really fix it, but we can at least catch the fact that the
> device tree is in an unsupported format and panic(). We can't call
> BUG(), it's too early.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/prom.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4e139f8a69ef..bb777b255b1c 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -641,6 +641,10 @@ void __init early_init_devtree(void *params)
>
>         DBG(" -> early_init_devtree(%p)\n", params);
>
> +       /* Too early to BUG_ON(), do it by hand */
> +       if (!early_init_dt_verify(params))
> +               panic("BUG: Failed verifying flat device tree, bad version?");
> +
>         /* Setup flat device-tree pointer */
>         initial_boot_params = params;
>
> --
> 1.9.1
>
