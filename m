Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4865DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:46:07 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8H2k77K027542
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:46:07 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8H2ndbd276682
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:49:39 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8H2jnIb007758
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 12:45:49 +1000
Date: Mon, 17 Sep 2007 12:02:17 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
Message-ID: <20070917020217.GE32725@localhost.localdomain>
References: <1189866379.17593.2.camel@localhost.localdomain>
	<20070915150901.AC712247CE@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070915150901.AC712247CE@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 15, 2007 at 05:09:01PM +0200, Wolfgang Denk wrote:
> In message <1189866379.17593.2.camel@localhost.localdomain> Josh Boyer wrote:
> > On Sat, 2007-09-15 at 05:23 +0200, Stefan Roese wrote:
> ...
> > > There are not only Bamboo board running PIBS, but running U-Boot too. How 
> > > should we handle this different FLASH partitioning? Same goes for Ebony too 
> > > btw.
> > 
> > That's a good question.  I'm working on making the NOR flash show up for
> > Bamboo right now, and I had intended to just leave the partition
> > subnodes missing.
> 
> Maybe we can have  U-Boot  add  the  partition  information  if  it's
> missing in the device tree, and extend the mtdparts command in U-Boot
> to add / adjust settings so they match what is defined in U-Boot.
> 
> Stefan, what do you think?

If U-Boot is supplying a device tree, it should certainly make the
partition information match its own idea of the partitions.

For older non-device-tree away u-boot, I guess we'll have to make the
cuboot and treeboot wrappers mangle the device tree differently to
correct the partition information.

I suspect the easiest way to do this will be for the dts to contain
both treeboot and u-boot partition info, and have the wrapper delete
or nop the nodes for the other firmware.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
