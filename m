Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F3D3DDEFE
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 13:31:22 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l2A2m0HZ007546
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 13:48:00 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2A2YkTO111652
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 13:34:46 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2A2VGOW027093
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 13:31:16 +1100
Date: Sat, 10 Mar 2007 10:43:25 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/15] Early serial debug support for PPC44x
Message-ID: <20070309234325.GB18514@localhost.localdomain>
References: <20070305032453.6B56ADDF1E@ozlabs.org>
	<1173383051.4861.27.camel@zod.rchland.ibm.com>
	<1173462122.4861.46.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173462122.4861.46.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2007 at 11:42:01AM -0600, Josh Boyer wrote:
> On Thu, 2007-03-08 at 13:44 -0600, Josh Boyer wrote:
> > On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> > > 
> > > +config PPC_EARLY_DEBUG_44x_PHYSLOW
> > > +	hex
> > > +	depends PPC_EARLY_DEBUG_44x
> > > +	default "0x40000200"
> > > +
> > > +config PPC_EARLY_DEBUG_44x_PHYSHIGH
> > > +	hex
> > > +	depends PPC_EARLY_DEBUG_44x
> > > +	default "0x1"
> > > +
> > 
> > These two options need to have some kind of description string next to
> > hex otherwise Kconfig will not allow you to set them.  I noticed this
> > while playing with bamboo.  So something like:
> > 
> > config PPC_EARLY_DEBUG_44x_PHYSLOW
> > 	hex "The low 32bits of the UART address"
> > 
> > That will allow you to change the values from the default.
> 
> And here's a patch to do that.
> 
> Fix the PPC_EARLY_DEBUG_44x options to allow setting something other
> than the default.

Ta, I'll fold that in.  Incidentally the idea is that the default will
change depending on config.  So if only bamboo is configured, it
should just work.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
