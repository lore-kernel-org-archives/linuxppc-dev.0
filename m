Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AC3967B6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 14:20:53 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Autran <gautran@mrv.com>
In-Reply-To: <42C153E1.3060004@mrv.com>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet> <20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>  <42C153E1.3060004@mrv.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:15:30 +1000
Message-Id: <1120018530.5133.241.camel@gaston>
Mime-Version: 1.0
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: get_mmu_context() for (very) FEW_CONTEXTS and
	KERNEL_PREEMPT race/starvation issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-06-28 at 09:42 -0400, Guillaume Autran wrote:
> Hi,
> 
> I happen to notice a race condition in the mmu_context code for the 8xx 
> with very few context (16 MMU contexts) and kernel preemption enable. It 
> is hard to reproduce has it shows only when many processes are 
> created/destroy and the system is doing a lot of IRQ processing.
> 
> In short, one process is trying to steal a context that is in the 
> process of being freed (mm->context == NO_CONTEXT) but not completely 
> freed (nr_free_contexts == 0).
> The steal_context() function does not do anything and the process stays 
> in the loop forever.
> 
> Anyway, I got a patch that fixes this part. Does not seem to affect 
> scheduling latency at all.
> 
> Comments are appreciated.

Your patch seems to do a hell lot more than fixing this race ... What
about just calling preempt_disable() in destroy_context() instead ?

Ben.
