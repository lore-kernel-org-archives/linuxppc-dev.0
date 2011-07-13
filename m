Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D661FB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 15:48:40 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/44x: don't use tlbivax on AMP systems
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110705043803.GG13483@ozlabs.org>
Date: Wed, 13 Jul 2011 00:48:21 -0500
Message-Id: <D1C71884-DD31-4F3C-8BF5-C6DB3BF4EC8F@kernel.crashing.org>
References: <20110705043803.GG13483@ozlabs.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 4, 2011, at 11:38 PM, Tony Breeds wrote:

> +#ifdef CONFIG_PPC_47x
> +void __init early_init_mmu_47x(void)
> +{
> +#ifdef CONFIG_SMP
> +	unsigned long root = of_get_flat_dt_root();
> +	if (of_get_flat_dt_prop(root, "cooperative-partition", NULL))
> +		mmu_clear_feature(MMU_FTR_USE_TLBIVAX_BCAST);
> +#endif /* CONFIG_SMP */
> +}
> +#endif /* CONFIG_PPC_47x */
> +

Is this device tree prop spec'd anywhere?

- k
