Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EE3BDDEF3
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 18:07:27 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l468Qw3p297388
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 18:26:58 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l468AvBm138890
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 18:10:57 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4687PRZ015701
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 18:07:25 +1000
Date: Sun, 6 May 2007 10:40:44 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Message-ID: <20070506004044.GG11303@localhost.localdomain>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1d22829fe3f12509018791541073706@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 05, 2007 at 07:21:33PM +0200, Segher Boessenkool wrote:
[snip]
> > +	compatible = "ppc750-tsi";
> 
> The needs to be more specific as well; "ibm,holly"
> or something.

Or perhaps just include something more specific, compatible can have
the general version as well.

[snip]
> > +	chosen {
> > +		linux,platform = <0>;
> > +		linux,initrd-start = <0>;
> > +		linux,initrd-end = <0>;
> 
> Do you need to set those zero properties?

linux,platform is obsolete and should definitely go.  With the recent
bootloader updates the initrd properties can also go (the bootloader
will add them correctly).  I had them in the Ebony device tree until
very recently because until some of the recent flatdevtree.c fixes,
the bootloader could replace the value of the properties, but it
couldn't add new properties (or at least not properties with new
names).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
