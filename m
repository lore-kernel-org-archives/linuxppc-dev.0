Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F57FDDE33
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:00:30 +1000 (EST)
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070726184800.0bb3b9fb.akpm@linux-foundation.org>
References: <200707250128.l6P1SWSF1336935@shell01.TheWorld.com>
	<1185347565.5439.310.camel@localhost.localdomain>
	<20070726184800.0bb3b9fb.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 27 Jul 2007 13:00:21 +1000
Message-Id: <1185505222.5495.182.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Alan Curry <pacman@theworld.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-26 at 18:48 -0700, Andrew Morton wrote:
> On Wed, 25 Jul 2007 17:12:45 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Tue, 2007-07-24 at 21:28 -0400, Alan Curry wrote:
> > > As of 2.6.22 the kernel doesn't recognize the i8042 keyboard/mouse controller
> > > on the PegasosPPC. This is because of a feature/bug in the OF device tree:
> > > the "device_type" attribute is an empty string instead of "8042" as the
> > > kernel expects. This patch (against 2.6.22.1) adds a secondary detection
> > > which looks for a device whose *name* is "8042" if there is no device whose
> > > *type* is "8042".
> > > 
> > > Signed-off-by: Alan Curry <pacman@world.std.com>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Note, if there's a volunteer, we could probably turn that code into a
> > nice table lookup.
> 
> Did this get merged, or otherwise fixed?  Even though the code in there has
> changed quite a bit, it looks to my untrained eye like the fix is still
> applicable?

Merged a fixed version:

f5d834fc34e61f1a40435981062000e5d2b2baa8

(In linus tree as of now)

Cheers,
Ben.

> 
> From: Alan Curry <pacman@TheWorld.com>
> 
> As of 2.6.22 the kernel doesn't recognize the i8042 keyboard/mouse
> controller on the PegasosPPC.  This is because of a feature/bug in the OF
> device tree: the "device_type" attribute is an empty string instead of
> "8042" as the kernel expects.  This patch (against 2.6.22.1) adds a
> secondary detection which looks for a device whose *name* is "8042" if
> there is no device whose *type* is "8042".
> 
> Signed-off-by: Alan Curry <pacman@world.std.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/kernel/setup-common.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff -puN /dev/null /dev/null
> diff -puN arch/powerpc/kernel/setup-common.c~powerpc-pegasos-keyboard-detection arch/powerpc/kernel/setup-common.c
> --- a/arch/powerpc/kernel/setup-common.c~powerpc-pegasos-keyboard-detection
> +++ a/arch/powerpc/kernel/setup-common.c
> @@ -496,6 +496,12 @@ int check_legacy_ioport(unsigned long ba
>  			break;
>  		}
>  		np = of_find_node_by_type(NULL, "8042");
> +		/*
> +		 * Pegasos has no device_type on its 8042 node, look for the
> +		 * name instead
> +		 */
> +		if (!np)
> +			np = of_find_node_by_name(NULL, "8042");
>  		break;
>  	case FDC_BASE: /* FDC1 */
>  		np = of_find_node_by_type(NULL, "fdc");
> _
> 
> 
> And ALan says that 2.6.22 is bust, but this patch no won't apply there so
> if we want to fix 2.6.22.x then Alan's original patch would be needed.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
