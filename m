Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2617ADDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 15:55:53 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1D5A65m173994
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 16:10:11 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1D4w4xu071468
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 15:58:05 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1D4sW8k020300
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 15:54:32 +1100
Date: Tue, 13 Feb 2007 15:30:44 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 18/19] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070213043044.GD5345@localhost.localdomain>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230145.GR3849@ld0162-tx32.am.freescale.net>
	<20070209230700.GC12035@mag.az.mvista.com>
	<45D09993.9050903@freescale.com>
	<1171314615.4003.27.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171314615.4003.27.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2007 at 03:10:15PM -0600, Josh Boyer wrote:
> On Mon, 2007-02-12 at 10:45 -0600, Scott Wood wrote:
> > Mark A. Greer wrote:
> > > On Wed, Feb 07, 2007 at 05:01:45PM -0600, Scott Wood wrote:
> > > 
> > >>xlate_reg() uses the ranges properties of a node's parentage to find the
> > >>absolute physical address of the node's registers.
> > >>
> > >>The ns16550 driver uses this when no virtual-reg property is found.
> > > 
> > > 
> > > Is this necessary?  Shouldn't there always be a virtual-reg?
> > 
> > None of the dts files in the kernel tree currently have such a property...
> 
> 4xx will use this.  The bootwrapper will use the UART mapping setup by
> the firmware to print out to the console.  At least that is why it was
> added to being with, and how I had it working on Ebony a while ago.
> David may have changed it since.

No, I'm using virtual-reg on Ebony.  In fact I think I'm using your
code for it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
