Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E667DDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 17:19:04 +1000 (EST)
Subject: Re: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 17:18:57 +1000
Message-Id: <1209021537.9060.156.camel@pasglop>
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


On Thu, 2008-04-24 at 00:37 -0500, Kumar Gala wrote:
> +       /*
> +        * interrupt stacks must be under 256MB, we cannot afford to
> take
> +        * SLB misses on them.
> +        */
> +       for_each_possible_cpu(i) {
> +               softirq_ctx[i] = (struct thread_info *)
> +                       __va(lmb_alloc_base(THREAD_SIZE,
> +                                           THREAD_SIZE, 0x10000000));
> +               hardirq_ctx[i] = (struct thread_info *)
> +                       __va(lmb_alloc_base(THREAD_SIZE,
> +                                           THREAD_SIZE, 0x10000000));
> +       }
> +

The comment is a bit bogus :-) (about SLB misses). lowmem is your limit
I think. Also, why not share the code with ppc64 ?

Ben.
