Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7C24B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 Aug 2009 17:55:00 +1000 (EST)
Subject: Re: [PATCH] Fix perfctr oops on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1249133370.24204.3.camel@macbook.infradead.org>
References: <1249133370.24204.3.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Sun, 02 Aug 2009 17:54:47 +1000
Message-Id: <1249199687.12047.12.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-08-01 at 14:29 +0100, David Woodhouse wrote:
> This seems to be the reason why the Fedora rawhide 2.6.31-rc kernel
> doesn't boot. With some CPUs, cur_cpu_spec->oprofile_cpu_type can be
> NULL -- which makes strcmp() unhappy.
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

Thanks David !

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paulus, do you want to put that in your new perfctr-powerpc tree or I'll
just stick that in my merge brange next week along with other fixes ?

Cheers,
Ben.

> ---
> At first glance, it looks like there are a bunch of other places which
> use cur_cpu_spec->oprofile_cpu_type without first checking if it's
> non-NULL, but maybe those are all 64-bit and all 64-bit cpu types have
> it set?
> 
> diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
> index 75ff47f..ea383c1 100644
> --- a/arch/powerpc/kernel/mpc7450-pmu.c
> +++ b/arch/powerpc/kernel/mpc7450-pmu.c
> @@ -408,7 +408,8 @@ struct power_pmu mpc7450_pmu = {
>  
>  static int init_mpc7450_pmu(void)
>  {
> -	if (strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
> +	if (cur_cpu_spec->oprofile_cpu_type &&
> +	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc/7450"))
>  		return -ENODEV;
>  
>  	return register_power_pmu(&mpc7450_pmu);
> 
> 
