Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2303B6FB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 01:49:28 +1000 (EST)
In-Reply-To: <1306059295-25806-2-git-send-email-dbaryshkov@gmail.com>
References: <1306059295-25806-1-git-send-email-dbaryshkov@gmail.com>
	<1306059295-25806-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b16a2ec616a4b9d221fb760e5d2222df@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V2 2/2] cpc925_edac: support single-processor
	configurations
Date: Mon, 23 May 2011 17:50:59 +0200
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> If second CPU is not enabled, CPC925 EDAC driver will spill out 
> warnings
> about errors on second Processor Interface. Support masking that out,
> by detecting at runtime which CPUs are present in device tree.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Harry Ciao <qingtao.cao@windriver.com>
> Cc: Doug Thompson <dougthompson@xmission.com>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

Minor stuff...

> +	/* Get first CPU node */

Comment doesn't match code.

> +	for (cpunode = NULL;
> +	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {

Use a while loop instead?

> +		const u32 *reg = of_get_property(cpunode, "reg", NULL);
> +
> +		if (!strcmp(cpunode->type, "cpu") && reg != NULL)
> +			mask &= ~APIMASK_ADI(*reg);
> +	}

You might want to check if the "reg" value is < 2, you get C undefined
behaviour if it is too big (not that that should happen), and it's 
clearer
code anyway.

> +	cpumask = cpc925_cpu_getmask();

You could choose a function name that makes more clear these are the
processor _interfaces_ that are _not_ used :-)

You could cache this value as well.


Segher
