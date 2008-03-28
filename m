Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D746CDE391
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 04:19:36 +1100 (EST)
Message-ID: <47ED289D.3020607@freescale.com>
Date: Fri, 28 Mar 2008 12:19:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 2/2 v4] Add DIU platform code for MPC8610HPCD
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<1206672058321-git-send-email-yorksun@freescale.com>
In-Reply-To: <1206672058321-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

York Sun wrote:
> +	np = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
> +	if (np) {
> +		of_address_to_resource(np, 0, &r);
> +		of_node_put(np);
> +		pixis_bdcfg0 = ioremap(r.start + 0x00000008, sizeof(u8));
> +		if (!pixis_bdcfg0) {
> +			printk(KERN_ERR "Err: can't map FPGA cfg register!\n");
> +			return;
> +		}
> +		pixis_arch = ioremap(r.start + 0x00000001, sizeof(u8));
> +		if (!pixis_arch) {
> +			printk(KERN_ERR "Err: can't map FPGA arch register!\n");
> +			return;
> +		}

Just of_iomap() the whole resource, rather than doing it a byte at a time.

> +int __init preallocate_diu_videomemory(void)
> +{
> +	pr_debug("diu_size=%lu\n", diu_ops.diu_size);
> +
> +	diu_ops.diu_mem = __alloc_bootmem(diu_ops.diu_size, 8, 0);
> +	if (!diu_ops.diu_mem) {
> +		printk(KERN_ERR "fsl-diu: cannot allocate %lu bytes\n",
> +			diu_ops.diu_size);
> +		return -ENOMEM;
> +	}
> +
> +	printk(KERN_INFO "%s: diu_mem=%p\n", __func__, diu_ops.diu_mem);

The pr_debug line is more useful information than the KERN_INFO line...

-Scott
