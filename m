Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7E1A67C79
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 03:45:48 +1100 (EST)
Date: Mon, 6 Nov 2006 10:45:42 -0600
From: Matt Porter <mporter@embeddedalley.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: fixup_bigphys_addr and ioremap64 question
Message-ID: <20061106164542.GA30762@gate.crashing.org>
References: <1162783045.28571.283.camel@localhost.localdomain>
	<1162784661.19697.4.camel@crusty.rchland.ibm.com>
	<1162786162.28571.286.camel@localhost.localdomain>
	<1162786580.19697.9.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162786580.19697.9.camel@crusty.rchland.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 05, 2006 at 10:16:20PM -0600, Josh Boyer wrote:
> On Mon, 2006-11-06 at 15:09 +1100, Benjamin Herrenschmidt wrote:
> > > > So why do we have both ioremap and ioremap64 knowing that the former is
> > > > defined to take a phys_addr_t argument ?
> > > > 
> > > > Currently, we have both, with the only difference being that ioremap
> > > > calls ioremap64 but also passes the argument through a
> > > > fixup_bigphys_addr() function first.
> > > > 
> > > > It took me a while to find it ... it's not defined in generic code but
> > > > in platform code (ugh !). In fact, the only version of it we have in
> > > > arch/powerpc is in the 85xx support and does:
> > > 
> > > It's in arch/ppc/syslib/44x_common.c and it's used to trap the least
> > > significant 32 bits of an address and set the right ERPN for io space on
> > > 44x.  Something like that might be needed when 44x merges to
> > > arch/powerpc.
> > 
> > Well, my point is that since nowadays we have 64 bits struct resource
> > and 64 bits phys_addr_t passed to ioremap, do we still need that ? In
> > fact, in my upcoming patch merging io.h for 32 and 64 bits in
> > asm-powerpc, I've simply removed that hook and ioremap64 :-) I can add
> > it back still, but so far, I yet have to be convinced there is still a
> > good reason for that hook.
> 
> Hm.. that might be ok.  I'm hoping to get back to working on something
> soon so I'll be able to tell more later.  Maybe Matt knows for sure.

Yes, that's the right way to go.  The history on this is that when
the 64-bit resource change came relatively recently, ioremap64 and
friends weren't killed off in arch/ppc.  ioremap64 only existed because
a long time ago several people blocked the idea of 64-bit resources
(on 32-bit platforms) and we needed a way around it plus all the
fixup garbage. Going forward, we now can handle everything through
ioremap() with no fixup stuff. There's a related issue with mmap and
64-bits but that's a separate issue yet that should now be addressed.

> It'll probably break out-of-tree drivers though once the merge happens
> for 4xx.  Could we leave ioremap64 around for a bit with a deprecation
> warning?

The kernel APIs break all the time. Every out of tree driver has to
have that built into their expectation when moving to a new kernel
so I don't see a good reason for making a special case here.

-Matt
