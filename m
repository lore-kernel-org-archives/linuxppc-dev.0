Return-Path: <lg@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23256DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 23:45:02 +1100 (EST)
Subject: Re: [PATCH v2] [POWERPC] Update MPC8610 HPCD to support audio drivers
From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080108115654.d0ac909b.sfr@canb.auug.org.au>
References: <1199732204949-git-send-email-timur@freescale.com>
	<1199732204578-git-send-email-timur@freescale.com>
	<20080108115654.d0ac909b.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 12:39:14 +0000
Message-Id: <1199795954.19903.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-01-08 at 11:56 +1100, Stephen Rothwell wrote:
> Hi Timur,
> 
> On Mon,  7 Jan 2008 12:56:43 -0600 Timur Tabi <timur@freescale.com> wrote:
> >
> > +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> > @@ -34,9 +34,27 @@
> >  
> >  #include <asm/mpic.h>
> >  
> > +#include <linux/of_platform.h>
> >  #include <sysdev/fsl_pci.h>
> >  #include <sysdev/fsl_soc.h>
> >  
> > +static struct of_device_id mpc8610_ids[] = {
> 
> __initdata
> 
> > +	{ .compatible = "fsl,mpc8610", },
> > +	{}
> > +};
> > +
> > +static int __init mpc8610_declare_of_platform_devices(void)
> > +{
> > +	if (!machine_is(mpc86xx_hpcd))
> > +		return 0;
> > +
> > +	/* Without this call, the SSI device driver won't get probed. */
> > +	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
> > +
> > +	return 0;
> > +}
> > +device_initcall(mpc8610_declare_of_platform_devices);
> 
> We have machine_device_initcall for this now.
> 

Now changed in ASoC dev branch.

Liam
