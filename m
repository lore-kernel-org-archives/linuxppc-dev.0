Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5E783DDF35
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 10:22:07 +1100 (EST)
Date: Tue, 19 Dec 2006 17:22:02 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add a device_initcall to call
	of_platform_bus_probe on all fsl SoCs
Message-Id: <20061219172202.29ef9b1d.kim.phillips@freescale.com>
In-Reply-To: <1166569246.19254.86.camel@localhost.localdomain>
References: <20061219153102.20ab3345.kim.phillips@freescale.com>
	<1166569246.19254.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Dec 2006 10:00:46 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2006-12-19 at 15:31 -0600, Kim Phillips wrote:
> > Utilize of_platform_bus_probe() in lieu of manually
> > calling of_platform_device_create for each ucc_geth device
> > (consequently, the QE is added to of_default_bus_ids).
> > 
> > This has been extended outside mpc83xx platform code,
> > since other fsl SoCs are going to need it (thanks Kumar).
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> 
> Big NACK

[this implies a nack on the consolidate 83xx files patch]
 
> The effect of this patch is that of_platform_bus_probe() will be
> unconditionally called on anything if a paltform using fsl_soc.c is
> included in the build.

well, that's the whole point.  85xx will soon need this.

> I want that called by the platform code or by something called by the
> platform code for FSL boards, not totally unconditional like that.

it's not characteristic of FSL _boards_ per se.  It's characteristic of FSL powerpc SoC chips, and it resides in a file that will only be built for that case.  This is a legitimate way to support multiple platforms in a single image without incurring multiple device_initcall()s with the same parameter.  I didn't see an appropriate ppc_md. function to use; are you suggesting we add one just for this?  wouldn't that be fsl specific also, but reside in common code?

> Ben.
>  
Kim
