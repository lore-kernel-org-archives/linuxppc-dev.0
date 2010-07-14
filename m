Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 059521007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 01:42:32 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via proc
From: Matthew McClintock <msm@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <C26140FB-4F77-4D8E-B6C4-63BC9C9EDD83@kernel.crashing.org>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<C26140FB-4F77-4D8E-B6C4-63BC9C9EDD83@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Jul 2010 10:42:43 -0500
Message-ID: <1279122163.13098.2.camel@localhost>
MIME-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-07-14 at 17:35 +0200, Segher Boessenkool wrote:
> > V4: Fixed misspelling
> 
> Any particular reason you fixed only one of the two
> mispelings I pointed out?  (device tree is two words,
> not one).

Ahh, my fault.

> 
> > +	prop = of_find_property(node, "linux,devicetree-start", NULL);
> > +	if (prop)
> > +		prom_remove_property(node, prop);
> > +
> > +	prop = of_find_property(node, "linux,devicetree-end", NULL);
> > +	if (prop)
> > +		prom_remove_property(node, prop);
> > +
> > +	flat_dt_start = virt_to_phys(initial_boot_params);
> > +	flat_dt_end = virt_to_phys(initial_boot_params)
> > +				+ initial_boot_params->totalsize;
> > +	prom_add_property(node, &flat_dt_start_prop);
> > +	prom_add_property(node, &flat_dt_end_prop);
> 
> You could use one property instead of two; use addr+len
> like every other property does.
> 
> You also should use a better name for the property; is this
> the previous kernel's device tree?  Just "device-tree" makes
> no sense, it is not pointing to "the" device tree for sure!
> 

What about just one node called "flat-device-tree"?

-Matthew
