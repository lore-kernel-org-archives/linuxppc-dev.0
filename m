Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DFE3DDFD9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:55:43 +1100 (EST)
Subject: Re: [PATCH 9/14] ps3: add interrupt alloc for outlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45B8188E.7020602@am.sony.com>
References: <45B8188E.7020602@am.sony.com>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 14:55:34 +1100
Message-Id: <1169697334.24996.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +int ps3_alloc_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
> +	unsigned int *virq)
> +{
> +	return ps3_connect_irq(cpu, outlet, virq);
> +}
> +
> +int ps3_free_irq(unsigned int virq)
> +{
> +	ps3_disconnect_irq(virq);
> +	return 0;
> +}
> +
>  #define PS3_INVALID_OUTLET ((irq_hw_number_t)-1)
>  #define PS3_PLUG_MAX 63

I'm not too fan of this... those 2 functions do strictly -nothing- other
than export the ones they call (not even changing arguments).

So why not export ps3_connect_irq / ps3_disconnect_irq directly ?

Ben.
