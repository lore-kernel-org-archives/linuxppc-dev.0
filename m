Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTvxC20rhzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:21:35 +1100 (AEDT)
Received: from mail-yb0-x22d.google.com (mail-yb0-x22d.google.com
 [IPv6:2607:f8b0:4002:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTvxB487Jz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:21:34 +1100 (AEDT)
Received: by mail-yb0-x22d.google.com with SMTP id n76so2394076ybg.3
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:21:34 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-2-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-2-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:51:11 +1030
Message-ID: <CACPK8XfqnCm7ufoXQhvpx3tbhcoJtrtEzxJFrhmY-Q4Oif5Q_Q@mail.gmail.com>
Subject: Re: [PATCH 02/12] drm/ast: Handle configuration without P2A bridge
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.come
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

>  static int ast_get_dram_info(struct drm_device *dev)
>  {
> +       struct device_node *np = dev->pdev->dev.of_node;
>         struct ast_private *ast = dev->dev_private;
> -       uint32_t data, data2;
> -       uint32_t denum, num, div, ref_pll;
> +       uint32_t mcr_cfg, mcr_scu_mpll, mcr_scu_strap;
> +       uint32_t denum, num, div, ref_pll, dsel;
>
> -       if (ast->DisableP2A)
> -       {
> +       switch (ast->config_mode) {
> +       case ast_use_dt:
> +               /*
> +                * If some properties are missing, use reasonable
> +                * defaults for AST2400
> +                */
> +               if (of_property_read_u32(np, "ast,mcr-configuration", &mcr_cfg))
> +                       mcr_cfg = 0x00000577;
> +               if (of_property_read_u32(np, "ast,ast,mcr-scu-mpll",
> +                                        &mcr_scu_mpll))
> +                       mcr_scu_mpll = 0x000050C0;
> +               if (of_property_read_u32(np, "ast,ast,mcr-scu-strap",

Are these properties supposed to repeat the prefix "ast,ast"?

We've chosen aspeed as the vendor prefix for Aspeed stuff.

> +                                        &mcr_scu_strap))
> +                       mcr_scu_strap = 0;
> +               break;
> +       case ast_use_p2a:
> +               ast_write32(ast, 0xf004, 0x1e6e0000);
> +               ast_write32(ast, 0xf000, 0x1);
> +               mcr_cfg = ast_read32(ast, 0x10004);
> +               mcr_scu_mpll = ast_read32(ast, 0x10120);
> +               mcr_scu_strap = ast_read32(ast, 0x10170);
> +               break;
> +       case ast_use_defaults:
> +       default:
>                 ast->dram_bus_width = 16;
>                 ast->dram_type = AST_DRAM_1Gx16;
>                 ast->mclk = 396;
> +               return 0;
>         }
> -       else
> -       {
> -               ast_write32(ast, 0xf004, 0x1e6e0000);
> -               ast_write32(ast, 0xf000, 0x1);
> -               data = ast_read32(ast, 0x10004);
>
> -               if (data & 0x40)
> -                       ast->dram_bus_width = 16;
> -               else
> -                       ast->dram_bus_width = 32;
> -
> -               if (ast->chip == AST2300 || ast->chip == AST2400) {
> -                       switch (data & 0x03) {
> -                       case 0:
> -                               ast->dram_type = AST_DRAM_512Mx16;
> -                               break;
> -                       default:
> -                       case 1:
> -                               ast->dram_type = AST_DRAM_1Gx16;
> -                               break;
> -                       case 2:
> -                               ast->dram_type = AST_DRAM_2Gx16;
> -                               break;
> -                       case 3:
> -                               ast->dram_type = AST_DRAM_4Gx16;
> -                               break;
> -                       }
> -               } else {
> -                       switch (data & 0x0c) {
> -                       case 0:
> -                       case 4:
> -                               ast->dram_type = AST_DRAM_512Mx16;
> -                               break;
> -                       case 8:
> -                               if (data & 0x40)
> -                                       ast->dram_type = AST_DRAM_1Gx16;
> -                               else
> -                                       ast->dram_type = AST_DRAM_512Mx32;
> -                               break;
> -                       case 0xc:
> -                               ast->dram_type = AST_DRAM_1Gx32;
> -                               break;
> -                       }
> -               }
> +       if (mcr_cfg & 0x40)
> +               ast->dram_bus_width = 16;
> +       else
> +               ast->dram_bus_width = 32;
>
> -               data = ast_read32(ast, 0x10120);
> -               data2 = ast_read32(ast, 0x10170);
> -               if (data2 & 0x2000)
> -                       ref_pll = 14318;
> -               else
> -                       ref_pll = 12000;
> -
> -               denum = data & 0x1f;
> -               num = (data & 0x3fe0) >> 5;
> -               data = (data & 0xc000) >> 14;
> -               switch (data) {
> -               case 3:
> -                       div = 0x4;
> +       if (ast->chip == AST2300 || ast->chip == AST2400) {
> +               switch (mcr_cfg & 0x03) {
> +               case 0:
> +                       ast->dram_type = AST_DRAM_512Mx16;
>                         break;
> -               case 2:
> +               default:
>                 case 1:
> -                       div = 0x2;
> +                       ast->dram_type = AST_DRAM_1Gx16;
>                         break;
> -               default:
> -                       div = 0x1;
> +               case 2:
> +                       ast->dram_type = AST_DRAM_2Gx16;
> +                       break;
> +               case 3:
> +                       ast->dram_type = AST_DRAM_4Gx16;
>                         break;
>                 }
> -               ast->mclk = ref_pll * (num + 2) / (denum + 2) * (div * 1000);
> +       } else {
> +               switch (mcr_cfg & 0x0c) {
> +               case 0:
> +               case 4:
> +                       ast->dram_type = AST_DRAM_512Mx16;
> +                       break;
> +               case 8:
> +                       if (mcr_cfg & 0x40)
> +                               ast->dram_type = AST_DRAM_1Gx16;
> +                       else
> +                               ast->dram_type = AST_DRAM_512Mx32;
> +                       break;
> +               case 0xc:
> +                       ast->dram_type = AST_DRAM_1Gx32;
> +                       break;
> +               }
> +       }
> +
> +       if (mcr_scu_strap & 0x2000)

This bit confused me. Bit 13 of the strap (SCU70) is the SPI mode.

> +               ref_pll = 14318;
> +       else
> +               ref_pll = 12000;
> +
> +       denum = mcr_scu_mpll & 0x1f;
> +       num = (mcr_scu_mpll & 0x3fe0) >> 5;
> +       dsel = (mcr_scu_mpll & 0xc000) >> 14;

These calculations don't make sense for the ast2400 or ast2500.

> +       switch (dsel) {
> +       case 3:
> +               div = 0x4;
> +               break;
> +       case 2:
> +       case 1:
> +               div = 0x2;
> +               break;
> +       default:
> +               div = 0x1;
> +               break;
>         }
> +       ast->mclk = ref_pll * (num + 2) / (denum + 2) * (div * 1000);
>         return 0;
>  }
