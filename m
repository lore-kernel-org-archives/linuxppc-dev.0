Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DEC43DDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 11:13:22 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l851DLkL009135
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 11:13:21 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l851GtpA163106
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 11:16:55 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l851DLt4004747
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 11:13:21 +1000
Date: Wed, 5 Sep 2007 11:09:45 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 5/6] Walnut board support
Message-ID: <20070905010945.GB17189@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.514442000@linux.vnet.ibm.com>
	<20070903011112.GE31499@localhost.localdomain>
	<1188741546.3772.5.camel@localhost.localdomain>
	<20070904073741.1adab0ba@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070904073741.1adab0ba@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 07:37:41AM -0500, Josh Boyer wrote:
> On Sun, 02 Sep 2007 08:59:06 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > On Mon, 2007-09-03 at 11:11 +1000, David Gibson wrote:
> > > On Fri, Aug 31, 2007 at 03:04:54PM -0500, Josh Boyer wrote:
> > > > Board support for the PPC405 Walnut evaluation board
> > > > 
> > > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > 
> > > [snip]
> > > > --- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
> > > > +++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
> > > > @@ -53,13 +53,13 @@
> > > >  #	help
> > > >  #	  This option enables support for the IBM PPC405GPr evaluation board.
> > > >  
> > > > -#config WALNUT
> > > > -#	bool "Walnut"
> > > > -#	depends on 40x
> > > > -#	default y
> > > > -#	select 405GP
> > > > -#	help
> > > > -#	  This option enables support for the IBM PPC405GP evaluation board.
> > > > +config WALNUT
> > > > +	bool "Walnut"
> > > > +	depends on 40x
> > > > +	default y
> > > > +	select 405GP
> > > > +	help
> > > > +	  This option enables support for the IBM PPC405GP evaluation board.
> > > 
> > > Surely this needs WANT_DEVICE_TREE, too.
> > 
> > Yes, will be fixed.
> 
> Er, actually no it won't.  It doesn't need to be selected here, as 40x
> in arch/powerpc/platforms/Kconfig.cputype already selects
> WANT_DEVICE_TREE.  Same thing that ebony and bamboo do for 44x.

Oh, yes, so it does, sorry.  Though we may need to change that if
anyone goes and puts a real OF implementation on some 44x board.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
