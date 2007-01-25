Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51B9BDE0D6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:54:16 +1100 (EST)
Subject: Re: [PATCH 8/14] ps3: bind interrupt to cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45B8188A.5070900@am.sony.com>
References: <45B8188A.5070900@am.sony.com>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 14:54:05 +1100
Message-Id: <1169697245.24996.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -int ps3_alloc_io_irq(unsigned int interrupt_id, unsigned int *virq);
> +enum ps3_cpu_binding {
> +	PS3_BINDING_CPU_0 = 0,
> +	PS3_BINDING_CPU_1 = 1,
> +	PS3_BINDING_CPU_ANY = 3,
> +};

While this patch might still get in since it actually fixes a problem,
the normal way of expressing interrupt bindings on linux is via a
cpumask. I recommend you do that too and update the affinity mask in
the irq_desc even if you don't provide a set_affinity() callback to
do runtime change just yet (and maybe never due to HV limitations).

Ben.
