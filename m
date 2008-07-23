Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31D9ADDFA6
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 08:18:25 +1000 (EST)
Subject: Re: [PATCH 0/2][RT] powerpc - fix bug in irq reverse mapping radix
	tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <20080723165932.57e3ada2@bull.net>
References: <20080723165932.57e3ada2@bull.net>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 08:17:38 +1000
Message-Id: <1216851458.11027.346.camel@pasglop>
Mime-Version: 1.0
Cc: Tim Chavez <tinytim@us.ibm.com>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	paulus@samba.org, Gilles Carry <Gilles.Carry@ext.bull.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>   The root cause of this bug lies in the fact that the XICS interrupt controller
> uses a radix tree for its reverse irq mapping and that we cannot allocate the tree
> nodes (even GFP_ATOMIC) with preemption disabled.

Is that yet another caes of -rt changing some basic kernel semantics ?

>   In fact, we have 2 nested preemption disabling when we want to allocate
> a new node:
> 
>   - setup_irq() does a spin_lock_irqsave() before calling xics_startup() which
>     then calls irq_radix_revmap() to insert a new node in the tree
> 
>   - irq_radix_revmap() also does a spin_lock_irqsave() (in irq_radix_wrlock())
>     before the radix_tree_insert()
> 
>   The first patch moves the call to irq_radix_revmap() from xics_startup() out to
> xics_host_map_direct() and xics_host_map_lpar() which are called with preemption
> enabled.

I suppose that would work.

>   The second patch is a little more involved in that it takes advantage of
> the concurrent radix tree to simplify the locking requirements and allows
> to allocate a new node outside a preemption disabled section.
> 
>   I just hope I've correctly understood the concurrent radix trees semantic
> and got the (absence of) locking right.

Hrm, that will need some scrutinity.

Thanks for looking at this.

Cheers,
Ben.
