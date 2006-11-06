Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5843F67C6E
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 15:10:17 +1100 (EST)
Subject: Re: fixup_bigphys_addr and ioremap64 question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1162784661.19697.4.camel@crusty.rchland.ibm.com>
References: <1162783045.28571.283.camel@localhost.localdomain>
	<1162784661.19697.4.camel@crusty.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 15:09:21 +1100
Message-Id: <1162786162.28571.286.camel@localhost.localdomain>
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


> > So why do we have both ioremap and ioremap64 knowing that the former is
> > defined to take a phys_addr_t argument ?
> > 
> > Currently, we have both, with the only difference being that ioremap
> > calls ioremap64 but also passes the argument through a
> > fixup_bigphys_addr() function first.
> > 
> > It took me a while to find it ... it's not defined in generic code but
> > in platform code (ugh !). In fact, the only version of it we have in
> > arch/powerpc is in the 85xx support and does:
> 
> It's in arch/ppc/syslib/44x_common.c and it's used to trap the least
> significant 32 bits of an address and set the right ERPN for io space on
> 44x.  Something like that might be needed when 44x merges to
> arch/powerpc.

Well, my point is that since nowadays we have 64 bits struct resource
and 64 bits phys_addr_t passed to ioremap, do we still need that ? In
fact, in my upcoming patch merging io.h for 32 and 64 bits in
asm-powerpc, I've simply removed that hook and ioremap64 :-) I can add
it back still, but so far, I yet have to be convinced there is still a
good reason for that hook.

Ben.
