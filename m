Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7EE5DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:07:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8537REE016969
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 23:07:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8537RO0213198
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 21:07:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8537Rxx027079
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 21:07:27 -0600
Subject: Re: [patch 2/6] cuimage for Bamboo board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070905011045.GC17189@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.029244000@linux.vnet.ibm.com>
	<20070903010111.GC31499@localhost.localdomain>
	<1188826931.3772.11.camel@localhost.localdomain>
	<20070905011045.GC17189@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 19:40:19 -0500
Message-Id: <1188952819.3223.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-05 at 11:10 +1000, David Gibson wrote:
> On Mon, Sep 03, 2007 at 08:42:11AM -0500, Josh Boyer wrote:
> > On Mon, 2007-09-03 at 11:01 +1000, David Gibson wrote:
> > > On Fri, Aug 31, 2007 at 03:04:51PM -0500, Josh Boyer wrote:
> > > > Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
> > > > linker declarations that have been moved into ops.h
> > > > 
> > > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > 
> > > [snip]
> > > > --- linux-2.6.orig/arch/powerpc/boot/bamboo.c
> > > > +++ linux-2.6/arch/powerpc/boot/bamboo.c
> > > > @@ -24,8 +24,7 @@
> > > >  #include "4xx.h"
> > > >  #include "44x.h"
> > > >  
> > > > -extern char _dtb_start[];
> > > > -extern char _dtb_end[];
> > > > +static u8 *bamboo_mac0, *bamboo_mac1;
> > > >  
> > > >  static void bamboo_fixups(void)
> > > >  {
> > > > @@ -34,12 +33,16 @@ static void bamboo_fixups(void)
> > > >  	ibm440ep_fixup_clocks(sysclk, 11059200);
> > > >  	ibm4xx_fixup_memsize();
> > > >  	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
> > > > +	if (bamboo_mac0 && bamboo_mac1)
> > > > +		dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
> > > 
> > > Bit ugly that you only set the MAC address for any ethernet if they're
> > > supplied for every ethernet.
> > 
> > Good point.  Will fix.
> > 
> > > >  	simple_alloc_init(_end, avail_ram, 32, 64);
> > > > -	bamboo_init();
> > > > +	bamboo_init(NULL, NULL);
> > > 
> > > There must surely be a way to get the MAC addresses out of OpenBIOS...
> > 
> > Probably.  I just need to find out where they are stored.
> 
> It's not buried somewhere in the arch/ppc/boot code?

It's not OpenBIOS, it's PIBS.  And the arch/ppc port uses __res, which
I'd rather avoid.  But I did find where it's stored in flash, so I can
read it from there.  I just need to do a little more work to get it in a
manner that can be used.

josh
