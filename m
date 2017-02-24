Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTw0y0nptzDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:24:50 +1100 (AEDT)
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTw0x3h8lz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:24:49 +1100 (AEDT)
Received: by mail-yb0-x244.google.com with SMTP id i66so364175yba.1
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:24:49 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-5-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-5-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:54:26 +1030
Message-ID: <CACPK8XdU-HZOa7vtWU3Ns1nvQG=x10DccXKMKxh_8Eqjku_7Jw@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/ast: Fix calculation of MCLK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2017 at 9:23 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Some braces were missing causing an incorrect calculation.
>
> Y.C. Chen from Aspeed provided me with the right formula
> which I tested on AST2400 and 2500.

Y. C. Chen, can you point out this calculation in the programming guide?

All of the PLL calculations I can find in the ast2400 documentation
are different to this one.

Cheers,

Joel

>
> The MCLK isn't currently used by the driver (it will eventually
> to filter modes) so the issue isn't catastrophic.
>
> Also make the printed value a bit more meaningful
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/gpu/drm/ast/ast_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
> index 718c15b..d194af3 100644
> --- a/drivers/gpu/drm/ast/ast_main.c
> +++ b/drivers/gpu/drm/ast/ast_main.c
> @@ -352,7 +352,7 @@ static int ast_get_dram_info(struct drm_device *dev)
>                 div = 0x1;
>                 break;
>         }
> -       ast->mclk = ref_pll * (num + 2) / (denum + 2) * (div * 1000);
> +       ast->mclk = ref_pll * (num + 2) / ((denum + 2) * (div * 1000));
>         return 0;
>  }
>
> @@ -496,7 +496,9 @@ int ast_driver_load(struct drm_device *dev, unsigned long flags)
>                 if (ret)
>                         goto out_free;
>                 ast->vram_size = ast_get_vram_info(dev);
> -               DRM_INFO("dram %d %d %d %08x\n", ast->mclk, ast->dram_type, ast->dram_bus_width, ast->vram_size);
> +               DRM_INFO("dram MCLK=%u Mhz type=%d bus_width=%d size=%08x\n",
> +                        ast->mclk, ast->dram_type,
> +                        ast->dram_bus_width, ast->vram_size);
>         }
>
>         if (need_post)
> --
> 2.9.3
>
