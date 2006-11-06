Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0B8367C6E
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 15:15:22 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA64Fapr001652
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 23:15:36 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA64FIxp090456
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 23:15:18 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA64FIYC022614
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 23:15:18 -0500
Subject: Re: fixup_bigphys_addr and ioremap64 question
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1162786162.28571.286.camel@localhost.localdomain>
References: <1162783045.28571.283.camel@localhost.localdomain>
	<1162784661.19697.4.camel@crusty.rchland.ibm.com>
	<1162786162.28571.286.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 22:16:20 -0600
Message-Id: <1162786580.19697.9.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 15:09 +1100, Benjamin Herrenschmidt wrote:
> > > So why do we have both ioremap and ioremap64 knowing that the former is
> > > defined to take a phys_addr_t argument ?
> > > 
> > > Currently, we have both, with the only difference being that ioremap
> > > calls ioremap64 but also passes the argument through a
> > > fixup_bigphys_addr() function first.
> > > 
> > > It took me a while to find it ... it's not defined in generic code but
> > > in platform code (ugh !). In fact, the only version of it we have in
> > > arch/powerpc is in the 85xx support and does:
> > 
> > It's in arch/ppc/syslib/44x_common.c and it's used to trap the least
> > significant 32 bits of an address and set the right ERPN for io space on
> > 44x.  Something like that might be needed when 44x merges to
> > arch/powerpc.
> 
> Well, my point is that since nowadays we have 64 bits struct resource
> and 64 bits phys_addr_t passed to ioremap, do we still need that ? In
> fact, in my upcoming patch merging io.h for 32 and 64 bits in
> asm-powerpc, I've simply removed that hook and ioremap64 :-) I can add
> it back still, but so far, I yet have to be convinced there is still a
> good reason for that hook.

Hm.. that might be ok.  I'm hoping to get back to working on something
soon so I'll be able to tell more later.  Maybe Matt knows for sure.

It'll probably break out-of-tree drivers though once the merge happens
for 4xx.  Could we leave ioremap64 around for a bit with a deprecation
warning?

josh
