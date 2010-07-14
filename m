Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B85C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 01:34:36 +1000 (EST)
In-Reply-To: <1279120733-13584-1-git-send-email-msm@freescale.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C26140FB-4F77-4D8E-B6C4-63BC9C9EDD83@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
Date: Wed, 14 Jul 2010 17:35:43 +0200
To: Matthew McClintock <msm@freescale.com>
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

> V4: Fixed misspelling

Any particular reason you fixed only one of the two
mispelings I pointed out?  (device tree is two words,
not one).

> +	prop = of_find_property(node, "linux,devicetree-start", NULL);
> +	if (prop)
> +		prom_remove_property(node, prop);
> +
> +	prop = of_find_property(node, "linux,devicetree-end", NULL);
> +	if (prop)
> +		prom_remove_property(node, prop);
> +
> +	flat_dt_start = virt_to_phys(initial_boot_params);
> +	flat_dt_end = virt_to_phys(initial_boot_params)
> +				+ initial_boot_params->totalsize;
> +	prom_add_property(node, &flat_dt_start_prop);
> +	prom_add_property(node, &flat_dt_end_prop);

You could use one property instead of two; use addr+len
like every other property does.

You also should use a better name for the property; is this
the previous kernel's device tree?  Just "device-tree" makes
no sense, it is not pointing to "the" device tree for sure!


Segher
