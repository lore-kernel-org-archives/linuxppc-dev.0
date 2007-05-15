Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63E67DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:47:31 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4G17UQu097120
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 11:07:30 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4G0p0Tt119144
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:51:01 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4G0lTWt024597
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:47:29 +1000
Date: Wed, 16 May 2007 09:10:26 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] Fixes to allow use of Ebony's flash chips through
	physmap_of
Message-ID: <20070515231026.GC20290@localhost.localdomain>
References: <20070515045415.98889DDED7@ozlabs.org>
	<1179234606.3084.34.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179234606.3084.34.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 08:10:06AM -0500, Josh Boyer wrote:
> On Tue, 2007-05-15 at 14:54 +1000, David Gibson wrote:
> >  void ebony_init(void *mac0, void *mac1)
> > Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:56.000000000 +1000
> > +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:45:58.000000000 +1000
> > @@ -176,6 +176,7 @@
> >  				fpga@7,0 {
> >  					compatible = "Ebony-FPGA";
> >  					reg = <7 0 10>;
> > +					virtual-reg = <e8300000>;
> 
> That's the mapping for OpenBios.  What happens if someone is using
> U-Boot?

I think U-Boot uses the same default IO mappings.

> If the mapping isn't the same, you might want to pass the address from
> the individual firmware wrapper parts to ebony_flashsel_fixup similar to
> how you've done it for dt_fixup_mac_addresses.
> 
> josh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
