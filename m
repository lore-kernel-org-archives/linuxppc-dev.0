Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1C95DDF46
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 07:20:39 +1000 (EST)
Subject: Re: powerpc: Revise PPC44x MMU code for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20070430110107.GH23995@crusty.rchland.ibm.com>
References: <20070430040625.GD6436@localhost.localdomain>
	<20070430110107.GH23995@crusty.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 01 May 2007 07:20:24 +1000
Message-Id: <1177968025.14873.377.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-30 at 06:01 -0500, Josh Boyer wrote:
> On Mon, Apr 30, 2007 at 02:06:25PM +1000, David Gibson wrote:
> > Index: working-2.6/include/asm-powerpc/mmu-44x.h
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ working-2.6/include/asm-powerpc/mmu-44x.h	2007-04-30 14:05:35.000000000 +1000
> 
> <snip>
> 
> > +#ifndef __ASSEMBLY__
> > +
> > +typedef unsigned long long phys_addr_t;
> > +
> > +extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
> 
> This function can likely get removed entirely in arch/powerpc.  ioremap can
> already take a 64 bit address and do the correct thing, so I'm not sure it's
> even needed anymore.

Yeah, the bigphys fixup should'nt be necessary now that resources can be
64 bits. There is -one- thing for which that remapping could still
potentially be useful is... the X server. That bloody POS currently
doesn't deal with PCI very well and will do horrible things to your
system if you try to make it grok 64 bits resources (when it's 32 bits
binary). But then, if you want that working, you need both the above
sort of remapping, but you also need to fix /dev/mem to take it into
account (which the current arch/ppc code doesn't do).

Cheers,
Ben.
