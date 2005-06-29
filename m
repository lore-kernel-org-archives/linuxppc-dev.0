Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58D9B67B98
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 09:29:48 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Autran <gautran@mrv.com>
In-Reply-To: <42C2BF03.9000402@mrv.com>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet> <20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>  <42C153E1.3060004@mrv.com>
	<1120018530.5133.241.camel@gaston>  <42C2BF03.9000402@mrv.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:24:15 +1000
Message-Id: <1120087455.31924.11.camel@gaston>
Mime-Version: 1.0
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: get_mmu_context() for (very) FEW_CONTEXTS
	and	KERNEL_PREEMPT race/starvation issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I'm still a bit confused with "kernel preemption". One thing for sure
> is that disabling kernel preemption does indeed fix my problem.
> So, my question is, what if a task in the middle of being schedule
> gets preempted by an IRQ handler, where will this task restart
> execution ? Back at the beginning of schedule or where it left of ?

I very much doubt that schedule itself can be preempted :)

> The idea behind my patch was to get rid of that nr_free_contexts
> counter that is (I thing) redundant with the context_map.
