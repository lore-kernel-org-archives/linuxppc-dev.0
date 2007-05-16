Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51A33DDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:21:16 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4G2LD3e009660
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 22:21:13 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4G2LAMT231136
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 20:21:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4G2LAAi027132
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 20:21:10 -0600
Date: Tue, 15 May 2007 21:29:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: dwg@au1.ibm.com
Subject: Re: [PATCH 2/3] Derive ebc ranges property from EBC registers
Message-ID: <20070516022958.GB25075@crusty.rchland.ibm.com>
References: <20070515045415.5B05ADDECE@ozlabs.org>
	<1179233998.3084.28.camel@zod.rchland.ibm.com>
	<20070515230930.GB20290@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070515230930.GB20290@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 09:09:30AM +1000, David Gibson wrote:
> > Do we want a "ranges;" here as a placeholder?  I don't see where it's
> > absolutely required, but it makes me feel better for some reason...
> 
> Absolutely not.  An empty ranges property indicates that the child bus
> address space is the same as the parent bus address space.  If we're
> using the chip-select/offset addressing form for the EBC peripherals,
> that's manifestly not the case.

Ah ok.  My lack of device tree experience showing through again.

> > So this sets the ranges for the EBC bus, but not the "regs" properties
> > of the child nodes.  Without that, the child nodes will not be mapped to
> > the correct addresses...
> 
> Well, no, the child reg properties can't be deduced from the EBC
> registers.

Right, I didn't mean to imply the could be.

> > Did you have a plan on how to fixup the child "regs" properties so that
> > when the DIP switches are flipped around, the children show up
> > correctly?
> 
> Well, on Ebony (AFAICT), the only child reg property that might need
> adjustment is the small flash.  My MTD enabling patch includes some
> code in the boot wrapper to toggle the appropriate bit in it's reg
> property.

Hm, ok.  On Bamboo, it's more complicated.  I'll have to think of something
there I suppose.

josh
