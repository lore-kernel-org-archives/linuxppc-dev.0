Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9816DDDF39
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 10:07:30 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l410Qjp5329108
	for <linuxppc-dev@ozlabs.org>; Tue, 1 May 2007 10:26:45 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l410Ax87170390
	for <linuxppc-dev@ozlabs.org>; Tue, 1 May 2007 10:10:59 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4107SUQ001625
	for <linuxppc-dev@ozlabs.org>; Tue, 1 May 2007 10:07:28 +1000
Date: Mon, 30 Apr 2007 21:15:51 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: powerpc: Revise PPC44x MMU code for arch/powerpc
Message-ID: <20070430111551.GC8725@localhost.localdomain>
References: <20070430040625.GD6436@localhost.localdomain>
	<20070430110107.GH23995@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070430110107.GH23995@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2007 at 06:01:08AM -0500, Josh Boyer wrote:
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

Right now it's invoked from common code in the 32-bit pgtable.h
though.  It'll need some cleanup and factorization in other places to
get rid of this; one thing at a time.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
