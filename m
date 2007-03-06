Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 518EADDF17
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 11:21:28 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l260bvoG211264
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 11:37:57 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l260Ndkb100796
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 11:23:40 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l260K9tr019132
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 11:20:09 +1100
Date: Tue, 6 Mar 2007 11:04:13 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/15] Add device tree for Ebony
Message-ID: <20070306000413.GB4728@localhost.localdomain>
References: <20070305032452.B8CC0DDF1B@ozlabs.org>
	<1173104584.6561.5.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173104584.6561.5.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2007 at 08:23:04AM -0600, Josh Boyer wrote:
> On Mon, 2007-03-05 at 14:24 +1100, David Gibson wrote:
> > Add a device tree for the Ebony evaluation board (440GP based).  This
> > tree is not complete or finalized.  This tree needs a very recent
> > version of dtc to process.
> > 
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> > ---
> > +
> > +	chosen {
> > +		linux,stdout-path = "/plb/opb@0/serial@140000200";
> > +		linux,initrd-start = <0>; /* FIXME */
> > +		linux,initrd-end = <0>;
> 
> Could we add a bootargs property here?  It needs to be present to allow
> set_cmdline in the wrapper to actually function.  Without it, the
> console ops allow you to specify on at the
> 
> Linux/PowerPC load:
> 
> line, but it doesn't actually get set in the DT.  In my testing, having
> 
> bootargs = "";
> 
> was sufficient to allow the cmdline editing (or inserting in this case)
> to work.

Ah, yes, I can do that.  In the interim, at least, until I get libfdt
going properly which can add new properties without difficulty.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
