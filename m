Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wqWp1mSPzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 13:24:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] powerpc/xive: Initialize symbol before usage
In-Reply-To: <1534877212-22678-1-git-send-email-leitao@debian.org>
References: <1534877212-22678-1-git-send-email-leitao@debian.org>
Date: Thu, 23 Aug 2018 13:24:01 +1000
Message-ID: <87lg8xlq9a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Breno,

Breno Leitao <leitao@debian.org> writes:
> Function xive_native_get_ipi() might uses chip_id without it being
> initialized. This gives the following error on 'smatch' tool:
>
> 	error: uninitialized symbol 'chip_id'

Which is correct, it can be used uninitialised. I'm surprised GCC
doesn't warn about it.

> This patch simply sets chip_id initial value to 0.

I'd prefer we fixed it differently, by explicitly initialising to zero
at the appropriate place in the code.

> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 311185b9960a..fc56673a3c0f 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -239,7 +239,7 @@ static bool xive_native_match(struct device_node *node)
>  static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>  {
>  	struct device_node *np;
> -	unsigned int chip_id;
> +	unsigned int chip_id = 0;
>  	s64 irq;
>  
>  	/* Find the chip ID */

The current code is:

	/* Find the chip ID */
	np = of_get_cpu_node(cpu, NULL);
	if (np) {
		if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
			chip_id = 0;
	}

Where if np is NULL then we don't initialise chip_id.

Which could be:

	np = of_get_cpu_node(cpu, NULL);
        if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
                chip_id = 0;

Because of_property_read_u32() will just return an error if np is NULL.

It's also missing an of_node_put() of np, you should do a separate patch
to fix that. You can just do it unconditionally after the
of_property_read_u32().

cheers
