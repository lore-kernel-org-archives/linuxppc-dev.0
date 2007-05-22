Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 695F0DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:09:38 +1000 (EST)
Subject: Re: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Liu <r63238@freescale.com>
In-Reply-To: <1179785273.32247.742.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 May 2007 13:09:27 +1000
Message-Id: <1179803367.32247.785.camel@localhost.localdomain>
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


> > > Now, the tlb invalidation code (which can use a batch to be even more
> > > efficient, see how 64 bits or x86 use batching for TLB invalidations)
> > > can then use the fact that the mm carries a cpu bitmask of all CPUs that
> > > ever touched that mm and thus can do, after a PTE has changed and before
> > > broadcasting an invalidation:
> > 
> > How to interlock this PTE change with the PTE change of tlb miss?
> 
> Look at pgtables-ppc32.h. PTE changes done by linux are atomic. If you
> use the procedure I outlined above, you will also have PTE modifications
> done by the TLB miss handler be atomic, though you also skip the atomic
> bit when not necessary (when _PAGE_ACCESSED is already set for example).
> 
> Thus, the situation is basically that linux PTE changes need to

Note that overall, my method requires at least those barriers:

	- setting the flag to 1 vs. reading the PTE
	- writing the TLB entry vs. setting the flag to 0

Which means two barriers in the TLB refill handler. I'm not 100%
familiar with the barriers you have on fsl BookE and their exact
semantics and performance issues but you may need to closely look at the
impact of taking those.

In the end, the best solution might still be to simply not do any of
this and instead send an IPI on invalidations. That's the method used by
most architectures in linux (if not all) that do software TLB load on
SMP. Basically, the invalidate code path then does:

	- Update the linux PTE
	- write barrier
	- send IPI interrupt to all CPUs in mm->cpu_vm_mask
	- local TLB flush

And the IPI does a local TLB flush on all affected CPUs.

Ben.
