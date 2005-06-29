Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20AB467B67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 07:46:54 +1000 (EST)
Date: Wed, 29 Jun 2005 14:00:20 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20050629170020.GC4262@logos.cnet>
References: <f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston> <42C153E1.3060004@mrv.com>
	<1120018530.5133.241.camel@gaston> <42C2BF03.9000402@mrv.com>
	<20050629155445.GA3560@logos.cnet> <42C311CD.1040405@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42C311CD.1040405@mrv.com>
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


Hi!

On Wed, Jun 29, 2005 at 05:25:33PM -0400, Guillaume Autran wrote:
> In that case, what happen when a higher priority task steal the context 
> of the lower priority task after get_mmu_context() but before 
> set_mmu_context() ?
> Then when the lower priority task resumes, its context may no longer be 
> valid...
> Do I get this right ?

Yep... but its OK and expected for the "lower prio task" in question to have
its context invalidated: In this case it will call get_mmu_context() again
and reserve the next one available before executing.

> I'm going to do like this instead of my previous attempt:
> 
>        /* Setup new userspace context */
>        preempt_disable();
>        get_mmu_context(next);
>        set_context(next->context, next->pgd);
>        preempt_enable();
> 
> To make sure we don't loose our context in between.

There should be no need - the window for the race is inside
get_mmu_context().

ie. It should be safe to preempt after setting "next_mm_context". 
