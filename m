Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 121001A032B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 16:59:23 +1100 (AEDT)
Message-ID: <1413525535.7417.27.camel@aoeu.buserror.net>
Subject: Re: [PATCH 2/2] clk: ppc-corenet: don't use platform_driver to init
 the clock device
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 17 Oct 2014 07:58:55 +0200
In-Reply-To: <20141016225552.GC9593@pek-khao-d1.corp.ad.wrs.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413458321-23880-3-git-send-email-haokexin@gmail.com>
 <1413496523.7417.12.camel@aoeu.buserror.net>
 <20141016225552.GC9593@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Gerhard Sittig <gsi@denx.de>, Jingchang Lu <jingchang.lu@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-17 at 06:55 +0800, Kevin Hao wrote:
> On Thu, Oct 16, 2014 at 11:55:23PM +0200, Scott Wood wrote:
> > On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> > > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> > > index e56b89a792ed..7677cfecb787 100644
> > > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/kdev_t.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/clk-provider.h>
> > >  
> > >  #include <asm/time.h>
> > >  #include <asm/machdep.h>
> > > @@ -188,11 +189,17 @@ static int __init corenet_generic_probe(void)
> > >  	return 0;
> > >  }
> > >  
> > > +static void __init corenet_gen_init(void)
> > > +{
> > > +	of_clk_init(NULL);
> > > +}
> > 
> > Why is this board-specific?
> 
> I have thought about to put it in a more common place such as time_init(),
> but this will be in conflict with mpc512x board. How about add an
> arch_initcall(mpc85xx_clk_init) in arch/powerpc/platforms/85xx/common.c?

Gerhard, does 512x really require of_clk_init() to be called at that
specific time, or can it be replaced by a common of_clk_init()?

-Scott
