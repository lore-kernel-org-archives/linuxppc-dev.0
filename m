Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 005F1DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 12:09:59 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l782C4Oi4354176
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:12:04 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l782DAeD175502
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:13:10 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7829ajT026251
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 12:09:37 +1000
Date: Wed, 8 Aug 2007 11:18:23 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Device tree aware EMAC driver
Message-ID: <20070808011823.GA20565@localhost.localdomain>
References: <20070807062231.GB8351@localhost.localdomain>
	<20070807071539.6dbb49a5@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070807071539.6dbb49a5@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 07:15:39AM -0500, Josh Boyer wrote:
> On Tue, 7 Aug 2007 16:22:31 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > Based on BenH's earlier work, this is a new version of the EMAC driver
> > for the built-in ethernet found on PowerPC 4xx embedded CPUs.  The
> > same ASIC is also found in the Axon bridge chip.  This new version is
> > designed to work in the arch/powerpc tree, using the device tree to
> > probe the device, rather than the old and ugly arch/ppc OCP layer.
> > 
> > This driver is designed to sit alongside the old driver (it lies in
> > drivers/net/ibm_emac and this one in drivers/net/ibm_newemac).  The
> > old driver is left in place to support arch/ppc until arch/ppc itself
> > reaches its final demise (not too long now, with luck).
> > 
> > This driver still has a number of things that could do with cleaning
> > up, but I think they can be fixed up after merging.  Specifically:
> > 	- Should be adjusted to properly use the dma mapping API.
> > Axon needs this.
> > 	- Probe logic needs reworking, in conjuction with the general
> > probing code for of_platform devices.  The dependencies here between
> > EMAC, MAL, ZMII etc. make this complicated.  At present, it usually
> > works, because we initialize and register the sub-drivers before the
> > EMAC driver itself, and (being in driver code) runs after the devices
> > themselves have been instantiated from the device tree.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Hm.  Should this go through Jeff Garzik or Paul?  If it's the latter,
> I'll pull this into my git tree soon.

Through Jeff Garzik, I think.  I was planning to send it to him today
or tomorrow if there are no screams from the linuxppc-dev list.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
