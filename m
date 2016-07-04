Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjj1R3RxtzDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 19:50:19 +1000 (AEST)
Message-ID: <1467625765.13965.4.camel@kernel.crashing.org>
Subject: Re: [PATCH][v2] driver/memory: Update dependency of IFC for Layerscape
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Raghav Dogra
 <raghav.dogra@nxp.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Scott Wood <scottwood@freescale.com>
Cc: linux-mtd@lists.infradead.org, prabhakar.kushwaha@nxp.com,
 leoyang.li@nxp.com, oss@buserror.net, computersforpeace@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 04 Jul 2016 19:49:25 +1000
In-Reply-To: <20160704112926.351aebf4@bbrezillon>
References: <1467388950-4895-1-git-send-email-raghav.dogra@nxp.com>
 <20160704112926.351aebf4@bbrezillon>
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

On Mon, 2016-07-04 at 11:29 +0200, Boris Brezillon wrote:
> +PPC maintainers.

+ Scott for FSL stuff

> Hi Raghav,
>
> Since you're touching powerpc drivers, the least you could do is add
> ppc maintainers in Cc, so that they can ack/review your patch...
> 
> On Fri, 1 Jul 2016 21:32:30 +0530
> Raghav Dogra <raghav.dogra@nxp.com> wrote:
> 
> > This patch enables IFC NAND support on ARM layerscape platform.
> > It fixes the dependency to enable NAND. The include files are being
> > modified
> > to ensure complilation for both PowerPC and ARM architectures.
> 
> Still think this could be separated in 2 commits:
> - the first one getting rid of the asm/prom.h inclusion
> - the second one changing the Kconfig dependency
> 
> > 
> > Signed-off-by: Raghav Dogra <raghav.dogra@nxp.com>
> > ---
> > Applicable to git://git.infradead.org/l2-mtd.git
> > 
> > Changes for v2: updated commit description
> > 
> >  drivers/memory/Kconfig   | 2 +-
> >  drivers/memory/fsl_ifc.c | 4 +++-
> >  drivers/mtd/nand/Kconfig | 2 +-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index 81ddb17..5645705 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -104,7 +104,7 @@ config FSL_CORENET_CF
> >  
> >  config FSL_IFC
> >  	bool
> > -	depends on FSL_SOC
> > +	depends on FSL_SOC || ARCH_LAYERSCAPE
> >  
> >  config JZ4780_NEMC
> >  	bool "Ingenic JZ4780 SoC NEMC driver"
> > diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> > index 904b4af..1b182b1 100644
> > --- a/drivers/memory/fsl_ifc.c
> > +++ b/drivers/memory/fsl_ifc.c
> > @@ -31,7 +31,9 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/fsl_ifc.h>
> > -#include <asm/prom.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> >  
> >  struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
> >  EXPORT_SYMBOL(fsl_ifc_ctrl_dev);
> > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > index f05e0e9..eace3ef 100644
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -438,7 +438,7 @@ config MTD_NAND_FSL_ELBC
> >  
> >  config MTD_NAND_FSL_IFC
> >  	tristate "NAND support for Freescale IFC controller"
> > -	depends on MTD_NAND && FSL_SOC
> > +	depends on MTD_NAND && (FSL_SOC || ARCH_LAYERSCAPE)
> >  	select FSL_IFC
> >  	select MEMORY
> >  	help
