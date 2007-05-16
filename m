Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55A70DDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 13:13:37 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4G3F2W74849856
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 13:15:02 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4G3H2g7015296
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 13:17:03 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4G3DUSF016564
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 13:13:30 +1000
Date: Wed, 16 May 2007 13:13:28 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] Derive ebc ranges property from EBC registers
Message-ID: <20070516031328.GA19127@localhost.localdomain>
References: <20070515045415.5B05ADDECE@ozlabs.org>
	<1179233998.3084.28.camel@zod.rchland.ibm.com>
	<20070515230930.GB20290@localhost.localdomain>
	<20070516022958.GB25075@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070516022958.GB25075@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 09:29:59PM -0500, Josh Boyer wrote:
> On Wed, May 16, 2007 at 09:09:30AM +1000, David Gibson wrote:
> > > Do we want a "ranges;" here as a placeholder?  I don't see where it's
> > > absolutely required, but it makes me feel better for some reason...
> > 
> > Absolutely not.  An empty ranges property indicates that the child bus
> > address space is the same as the parent bus address space.  If we're
> > using the chip-select/offset addressing form for the EBC peripherals,
> > that's manifestly not the case.
> 
> Ah ok.  My lack of device tree experience showing through again.
> 
> > > So this sets the ranges for the EBC bus, but not the "regs" properties
> > > of the child nodes.  Without that, the child nodes will not be mapped to
> > > the correct addresses...
> > 
> > Well, no, the child reg properties can't be deduced from the EBC
> > registers.
> 
> Right, I didn't mean to imply the could be.
> 
> > > Did you have a plan on how to fixup the child "regs" properties so that
> > > when the DIP switches are flipped around, the children show up
> > > correctly?
> > 
> > Well, on Ebony (AFAICT), the only child reg property that might need
> > adjustment is the small flash.  My MTD enabling patch includes some
> > code in the boot wrapper to toggle the appropriate bit in it's reg
> > property.
> 
> Hm, ok.  On Bamboo, it's more complicated.  I'll have to think of something
> there I suppose.

Want to send me a board manual?  I can see if any approach springs to
mind.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
