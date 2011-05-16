Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80A05B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 09:38:01 +1000 (EST)
Subject: Re: Updating the define_machine() structure at runtime?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4DD14F15.5070902@freescale.com>
References: <4DD14F15.5070902@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 May 2011 09:37:50 +1000
Message-ID: <1305589070.2781.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-16 at 11:21 -0500, Timur Tabi wrote:
> I would like to get some opinions on the following.
> 
> I'm working on extending our existing board definition files to support our
> ePAPR reference hypervisor.  Because our hypervisor provides a virtual PIC, we
> need to have different functions for define_machine() structure that related to
> the PIC, but most everything else can stay the same.

 .../...

> static int __init p4080_ds_probe(void)
> {
> 	...
> #ifdef CONFIG_FSL_HYPERVISOR
> 	if (of_flat_dt_is_compatible(root, "fsl,P4080DS-hv")) {
> 		mach_p4080_ds.get_irq = ehv_pic_get_irq;
> 		...
> 		return 1;
> 	} else
> 		return 0;
> #endif	

One approach i've been taking more often nowadays is to have the PIC
code setup the ppc_md hooks itself.

You don't need to do it in probe(), just in setup_arch or init_IRQ,
wherever you do your PIC discovery, have it set it up.

For example, xics sets get_irq itself, which is necessary because the
xics code itself can have multiple variants.

We could probably make mpic.c do the same when MPIC_PRIMARY is set (or
keep that a wrapper for now).
 
Cheers,
Ben.
