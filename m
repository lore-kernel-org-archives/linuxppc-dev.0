Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0AF3DDF50
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:55:23 +1000 (EST)
Subject: Re: [PATCH 1/2] Add irq_free_host() to free an irq_host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
References: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Wed, 14 May 2008 23:55:12 -0700
Message-Id: <1210834512.8297.87.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-08 at 14:23 +1000, Michael Ellerman wrote:
> +void irq_free_host(struct irq_host *host)
> +{
> +       /* If it's still very early in boot we can't free, oh well. */
> +       if (mem_init_done)
> +               kfree(host);
> +}

Hrm... that means that a host that was allocated before mem_init_done
and freed later will call kfree on memory obtained from bootmem... no
good.

In which case do we need to free and irq host other than failure in
irq_alloc_host ?

Cheers,
Ben.
