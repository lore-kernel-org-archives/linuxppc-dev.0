Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC0B3DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 15:47:20 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l855l4bA023881
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 15:47:04 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l855l4592957514
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 15:47:04 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l855l4sY007924
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 15:47:04 +1000
Date: Wed, 5 Sep 2007 15:46:45 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 2/6] cuimage for Bamboo board
Message-ID: <20070905054645.GA26788@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.029244000@linux.vnet.ibm.com>
	<20070903010111.GC31499@localhost.localdomain>
	<1188826931.3772.11.camel@localhost.localdomain>
	<20070905011045.GC17189@localhost.localdomain>
	<1188952819.3223.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1188952819.3223.5.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 07:40:19PM -0500, Josh Boyer wrote:
> On Wed, 2007-09-05 at 11:10 +1000, David Gibson wrote:
> > On Mon, Sep 03, 2007 at 08:42:11AM -0500, Josh Boyer wrote:
> > > On Mon, 2007-09-03 at 11:01 +1000, David Gibson wrote:
> > > > On Fri, Aug 31, 2007 at 03:04:51PM -0500, Josh Boyer wrote:
> > > > > Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
> > > > > linker declarations that have been moved into ops.h
> > > > > 
> > > > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > > 
> > > > [snip]
> > > > > --- linux-2.6.orig/arch/powerpc/boot/bamboo.c
> > > > > +++ linux-2.6/arch/powerpc/boot/bamboo.c
> > > > > @@ -24,8 +24,7 @@
> > > > >  #include "4xx.h"
> > > > >  #include "44x.h"
> > > > >  
> > > > > -extern char _dtb_start[];
> > > > > -extern char _dtb_end[];
> > > > > +static u8 *bamboo_mac0, *bamboo_mac1;
> > > > >  
> > > > >  static void bamboo_fixups(void)
> > > > >  {
> > > > > @@ -34,12 +33,16 @@ static void bamboo_fixups(void)
> > > > >  	ibm440ep_fixup_clocks(sysclk, 11059200);
> > > > >  	ibm4xx_fixup_memsize();
> > > > >  	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
> > > > > +	if (bamboo_mac0 && bamboo_mac1)
> > > > > +		dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
> > > > 
> > > > Bit ugly that you only set the MAC address for any ethernet if they're
> > > > supplied for every ethernet.
> > > 
> > > Good point.  Will fix.
> > > 
> > > > >  	simple_alloc_init(_end, avail_ram, 32, 64);
> > > > > -	bamboo_init();
> > > > > +	bamboo_init(NULL, NULL);
> > > > 
> > > > There must surely be a way to get the MAC addresses out of OpenBIOS...
> > > 
> > > Probably.  I just need to find out where they are stored.
> > 
> > It's not buried somewhere in the arch/ppc/boot code?
> 
> It's not OpenBIOS, it's PIBS.  And the arch/ppc port uses __res, which
> I'd rather avoid.  But I did find where it's stored in flash, so I can
> read it from there.  I just need to do a little more work to get it in a
> manner that can be used.

Hrm.. is that address actually guaranteed to be stable across PIBS
versions?  If arch/ppc uses __res, I think we should do that too.  It
shouldn't be any worse than what we already do fot cuboot.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
