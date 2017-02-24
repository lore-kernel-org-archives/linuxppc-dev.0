Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTwJw2nS0zDqTx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:38:40 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTwJv4RmFz9s7R
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:38:39 +1100 (AEDT)
Message-ID: <1487903902.23576.253.camel@kernel.crashing.org>
Subject: Re: [PATCH 05/12] drm/ast: Fix calculation of MCLK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.com
Date: Fri, 24 Feb 2017 13:38:22 +1100
In-Reply-To: <CACPK8XdU-HZOa7vtWU3Ns1nvQG=x10DccXKMKxh_8Eqjku_7Jw@mail.gmail.com>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-5-benh@kernel.crashing.org>
 <CACPK8XdU-HZOa7vtWU3Ns1nvQG=x10DccXKMKxh_8Eqjku_7Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-24 at 12:54 +1030, Joel Stanley wrote:
> On Fri, Feb 24, 2017 at 9:23 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Some braces were missing causing an incorrect calculation.
> > 
> > Y.C. Chen from Aspeed provided me with the right formula
> > which I tested on AST2400 and 2500.
> 
> Y. C. Chen, can you point out this calculation in the programming
> guide?
> 
> All of the PLL calculations I can find in the ast2400 documentation
> are different to this one.

Different PLL register, see my other email. I've checked the result
of the calculation on our AST2500 and AST2400 machines.

Cheers,
Ben.

> Cheers,
> 
> Joel
> 
> > 
> > The MCLK isn't currently used by the driver (it will eventually
> > to filter modes) so the issue isn't catastrophic.
> > 
> > Also make the printed value a bit more meaningful
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  drivers/gpu/drm/ast/ast_main.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ast/ast_main.c
> > b/drivers/gpu/drm/ast/ast_main.c
> > index 718c15b..d194af3 100644
> > --- a/drivers/gpu/drm/ast/ast_main.c
> > +++ b/drivers/gpu/drm/ast/ast_main.c
> > @@ -352,7 +352,7 @@ static int ast_get_dram_info(struct drm_device
> > *dev)
> >                 div = 0x1;
> >                 break;
> >         }
> > -       ast->mclk = ref_pll * (num + 2) / (denum + 2) * (div *
> > 1000);
> > +       ast->mclk = ref_pll * (num + 2) / ((denum + 2) * (div *
> > 1000));
> >         return 0;
> >  }
> > 
> > @@ -496,7 +496,9 @@ int ast_driver_load(struct drm_device *dev,
> > unsigned long flags)
> >                 if (ret)
> >                         goto out_free;
> >                 ast->vram_size = ast_get_vram_info(dev);
> > -               DRM_INFO("dram %d %d %d %08x\n", ast->mclk, ast-
> > >dram_type, ast->dram_bus_width, ast->vram_size);
> > +               DRM_INFO("dram MCLK=%u Mhz type=%d bus_width=%d
> > size=%08x\n",
> > +                        ast->mclk, ast->dram_type,
> > +                        ast->dram_bus_width, ast->vram_size);
> >         }
> > 
> >         if (need_post)
> > --
> > 2.9.3
> > 
