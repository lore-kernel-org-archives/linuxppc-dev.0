Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17973.13523.57567.352585@cargo.ozlabs.ibm.com>
Date: Mon, 30 Apr 2007 10:14:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] powerpc: fix suspend states again
In-Reply-To: <1177711372.3565.73.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
	<20070427215338.GB17224@lixom.net>
	<1177710883.3565.66.camel@johannes.berg>
	<1177711372.3565.73.camel@johannes.berg>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> +void save_processor_state(void)
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
> +#ifdef CONFIG_SPE
> +	enable_kernel_spe();
> +#endif
> +}

This achieves essentially the same effect as prepare_to_copy() in
arch/powerpc/kernel/process.c, except that we don't end up with fp,
altivec and/or spe enabled - but that's OK since the following code
doesn't actually need fp/altivec/spe.

It would be good to avoid this duplication, or at least to use the
flush_* calls instead of the enable_kernel_* calls.

Paul.
