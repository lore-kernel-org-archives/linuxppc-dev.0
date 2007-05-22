Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF1CCDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 08:42:40 +1000 (EST)
Subject: Re: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Liu <r63238@freescale.com>
In-Reply-To: <1179831375.3827.4.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 May 2007 08:42:22 +1000
Message-Id: <1179873742.32247.864.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 18:56 +0800, Dave Liu wrote:
> On Tue, 2007-05-22 at 13:09 +1000, Benjamin Herrenschmidt wrote:
> > In the end, the best solution might still be to simply not do any of
> > this and instead send an IPI on invalidations. That's the method used by
> > most architectures in linux (if not all) that do software TLB load on
> > SMP. Basically, the invalidate code path then does:
> > 
> > 	- Update the linux PTE
> > 	- write barrier
> > 	- send IPI interrupt to all CPUs in mm->cpu_vm_mask
> > 	- local TLB flush
> > 
> > And the IPI does a local TLB flush on all affected CPUs.
> 
> How to avoid IPI interrupt missing if the IPI interrupt is edge-
> triggered?
> 
> or How to make sure TLB flushed on the else all affected CPUs?

The IPIs should be buffered by the PIC ... delivered only once but
still. Also, IPI handling in linux is synchronous, there is an ack to
wait for the remote function to complete.

Ben.
