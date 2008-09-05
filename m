Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77D25DDEF7
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 08:38:08 +1000 (EST)
Subject: Re: [PATCH v3 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <828A65C6-A5DD-41C6-BA38-25BE04D76AA2@kernel.crashing.org>
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
	<1220465344-16753-2-git-send-email-galak@kernel.crashing.org>
	<1220497970.4879.36.camel@pasglop>
	<828A65C6-A5DD-41C6-BA38-25BE04D76AA2@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 06 Sep 2008 08:38:00 +1000
Message-Id: <1220654280.4879.202.camel@pasglop>
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

On Fri, 2008-09-05 at 14:44 -0500, Kumar Gala wrote:
> > I also wonder if you should first ensure that the PTE is invalid and
> > if not, clear it and flush the TLB page ... Or at least add a
> > WARN_ON(pte_valid()) in case we get that wrong ...
> 
> I believe that's an issue since kmap_atomic() will call set_pte_at and  
> have the valid bit set.

Hrm... on the other hand, it's safe because kmap_atomic() is per-CPU and
thus won't race with anything...

On the other hand, if others (mprotect, mremap, whoever...) does it,
it's not safe.

I'm keen on letting set_pte_at() to the job and maybe if we can remove
the explicit flush kmap_atomic does... Though it's not totally trivial
to "know" it's a flush that doesn't need global invalidations...

May be worth moving your current stuff into a __set_pte_at() that you
use from kmap atomic, and have set_pte_at() wrap that along with a
present warn. That would do for the time being.

Ben.
