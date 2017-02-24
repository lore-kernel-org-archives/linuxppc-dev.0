Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTvxW0nkQzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:21:51 +1100 (AEDT)
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com
 [IPv6:2607:f8b0:4002:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTvxV3lSJz9s7R
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:21:50 +1100 (AEDT)
Received: by mail-yb0-x241.google.com with SMTP id i66so361960yba.1
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:21:50 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-10-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-10-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:51:27 +1030
Message-ID: <CACPK8XckSCM=Nk0vstx+W6sQ6L55=8zHR528JCex2GF0QEys=g@mail.gmail.com>
Subject: Re: [PATCH 10/12] drm/ast: POST code for the new AST2500
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
> From: "Y.C. Chen" <yc_chen@aspeedtech.com>
>
> This is used when the BMC isn't running any code and thus has
> to be initialized by the host.
>
> The code originates from Aspeed (Y.C. Chen) and has been cleaned
> up for coding style purposes by BenH.
>
> Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> --
>
> v2. - Fix bug in ddr_test_2500 reported by Emil Velikov
>     - Rebase on updated mmc_test factoring patch
>     - Fix missing else statement in 2500 POST code
> ---
>  drivers/gpu/drm/ast/ast_dram_tables.h |  62 +++++
>  drivers/gpu/drm/ast/ast_post.c        | 417 +++++++++++++++++++++++++++++++++-
>  2 files changed, 476 insertions(+), 3 deletions(-)
>

> +void ast_post_chip_2500(struct drm_device *dev)
> +{
> +       struct ast_private *ast = dev->dev_private;
> +       u32 temp;
> +       u8 reg;
> +
> +       reg = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd0, 0xff);
> +       if ((reg & 0x80) == 0) {/* vga only */
> +               /* Clear bus lock condition */
> +               ast_moutdwm(ast, 0x1e600000, 0xAEED1A03);
> +               ast_moutdwm(ast, 0x1e600084, 0x00010000);
> +               ast_moutdwm(ast, 0x1e600088, 0x00000000);
> +               ast_moutdwm(ast, 0x1e6e2000, 0x1688A8A8);
> +               ast_write32(ast, 0xf004, 0x1e6e0000);
> +               ast_write32(ast, 0xf000, 0x1);
> +               ast_write32(ast, 0x12000, 0x1688a8a8);
> +               while (ast_read32(ast, 0x12000) != 0x1)
> +                       ;
> +
> +               ast_write32(ast, 0x10000, 0xfc600309);
> +               while (ast_read32(ast, 0x10000) != 0x1)
> +                       ;
> +
> +               /* Slow down CPU/AHB CLK in VGA only mode */
> +               temp = ast_read32(ast, 0x12008);
> +               temp |= 0x73;
> +               ast_write32(ast, 0x12008, temp);
> +
> +               /* Reset USB port to patch USB unknown device issue */

Really?!

> +               ast_moutdwm(ast, 0x1e6e2090, 0x20000000);
> +               temp  = ast_mindwm(ast, 0x1e6e2094);
> +               temp |= 0x00004000;
> +               ast_moutdwm(ast, 0x1e6e2094, temp);
> +               temp  = ast_mindwm(ast, 0x1e6e2070);
> +               if (temp & 0x00800000) {
> +                       ast_moutdwm(ast, 0x1e6e207c, 0x00800000);
> +                       mdelay(100);
> +                       ast_moutdwm(ast, 0x1e6e2070, 0x00800000);
> +               }
> +
> +               if (!ast_dram_init_2500(ast))
> +                       DRM_ERROR("DRAM init failed !\n");
> +
> +               temp = ast_mindwm(ast, 0x1e6e2040);
> +               ast_moutdwm(ast, 0x1e6e2040, temp | 0x40);
> +       }
> +
> +       /* wait ready */
> +       do {
> +               reg = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xd0, 0xff);
> +       } while ((reg & 0x40) == 0);
> +}
> --
> 2.9.3
>
