Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB615DE101
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 06:23:39 +1000 (EST)
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
In-Reply-To: <20080717125645.GN20277@linux.vnet.ibm.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	<1216085521.7740.37.camel@pasglop>
	<20080717125645.GN20277@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 06:14:31 +1000
Message-Id: <1216325671.7740.359.camel@pasglop>
Mime-Version: 1.0
Cc: linux-rt-users@vger.kernel.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
	linux.kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> All these operations are done assuming that tlb_gather_mmu disables
> preemption and tlb_finish_mmu enables preemption again.
> This is not true for -rt.
> For x86, none of the code paths between tlb_gather_mmu and
> tlb_finish_mmu access any per_cpu variables.
> But this is not true for powerpc64 as we can see.
> 
> One way could be to make tlb_gather_mmu disable preemption as it does
> in mainline but only for powerpc.
> Although i am not sure, if this is the right step ahead.
> 
> I am attaching a patch below for the same.
> I have left out the tce bits, as they are fine.
> 
> Note: I haven't extensively tested the patch

A better option is to make sure that a context switch does the right
thing, flushing the pending batch. I think that's already the case,
which means that your original patch may work, but that needs to
be double-checked and commented properly.

Cheers,
Ben.
