Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdsyz51DkzDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:19:55 +1000 (AEST)
In-Reply-To: <1466729755-18618-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Jack Miller <jack@codezen.org>
Subject: Re: [v5] powerpc/timer - large decrementer support
Message-Id: <3rdsyz3N1hz9sCp@ozlabs.org>
Date: Tue, 28 Jun 2016 14:19:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-24-06 at 00:55:55 UTC, Oliver O'Halloran wrote:
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 7a482a7f4d8d..efebe52133ef 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -893,6 +894,86 @@ static void register_decrementer_clockevent(int cpu)
...
> +static void __init set_decrementer_max(void)
> +{
> +	struct device_node *cpu;
> +	const __be32 *fp;
> +	u64 bits = 32;
> +
> +	/* Prior to ISAv3 the decrementer is always 32 bit */
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +		return;
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	if (cpu)
> +		fp = of_get_property(cpu, "ibm,dec-bits", NULL);
> +
> +	if (cpu && fp) {
> +		bits = of_read_number(fp, 1);

Sorry I didn't catch it earlier, but I prefer of_property_read_u32().

You should be able to do:

	cpu = of_find_node_by_type(NULL, "cpu");
	if (of_property_read_u32(cpu, "ibm,dec-bits", &bits) == 0) {
		...
	}

cheers
