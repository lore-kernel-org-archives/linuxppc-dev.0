Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 61113DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 12:59:01 +1000 (EST)
Message-Id: <BD25BA47-04A5-4FF7-86FD-959BCDB898A0@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1213835374-10868-4-git-send-email-ntl@pobox.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC/PATCH 3/3] adjust cpu power for secondary threads on POWER6
Date: Wed, 18 Jun 2008 21:58:59 -0500
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
	<1213835374-10868-4-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> +static unsigned int pseries_cpu_power(int cpu, unsigned int  
> default_power)
> +{
> +	struct device_node *np;
> +	unsigned int thread, power;
> +
> +	if (!cpu_has_feature(CPU_FTR_ASYM_POWER))
> +		return default_power;
> +
> +	power = default_power;

Why not just NULL out the cpu_power function pointers on platforms  
that don't have the feature bit instead? (or the other way around:  
NULL by default, and set only on platforms that have imbalanced threads.

It'd be even nicer to do so without using up a cpu feature bit, since  
it'd then only be used in determining whether to set the ppc_md  
function pointer or not, but I don't know if there's a convenient way  
to probe for this at runtime (cpu device tree node properties?).


-Olof
