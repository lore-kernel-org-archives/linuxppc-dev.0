Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C393DDF68
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 03:06:10 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: fix suspend states again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070319105358.796834000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105358.796834000@sipsolutions.net>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 17:06:05 +0100
Message-Id: <1174320365.5044.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +
> +int save_processor_state(void)
> +{
> +	/* Giveup the lazy FPU & vec so we don't have to back them
> +	 * up from the low level code
> +	 */
> +	enable_kernel_fp();
> +
> +#ifdef CONFIG_ALTIVEC
> +	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
> +		enable_kernel_altivec();
> +#endif /* CONFIG_ALTIVEC */
> +
> +	return 0;
> +}

You need to check if there's an FPU I suppose for enable_kernel_fp()
since this is generic code potentially used with embedded CPUs as well.
In fact, it would be good to also add some of the freescale stuff.

Ben.
