Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EC0DDDD0E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:32:43 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l1LCY0rK6336758
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:34:00 -0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1L0a6fZ137610
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:36:06 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1L0Waqt003050
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:32:36 +1100
Date: Wed, 21 Feb 2007 11:24:43 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/14] Add device tree for Ebony
Message-ID: <20070221002443.GE10231@localhost.localdomain>
References: <20070220021235.DC02DDDD06@ozlabs.org>
	<1171984191.24204.84.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171984191.24204.84.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 09:09:51AM -0600, Josh Boyer wrote:
> On Tue, 2007-02-20 at 13:12 +1100, David Gibson wrote:
> > Add a device tree for the Ebony evaluation board (440GP based).  This
> > tree is not complete or finalized.  This tree needs a very recent
> > version of dtc to process.
> > 
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> > ---
> > 
> >  arch/powerpc/boot/dts/ebony.dts |  225 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 225 insertions(+)
> > 
> > Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-02-19 15:31:36.000000000 +1100
> > @@ -0,0 +1,225 @@
> > +/*
> > + * Device Tree Source for IBM Ebony
> > + *
> > + * Copyright (c) 2006, 2007 IBM Corp.
> > + * Josh Boyer <jdub@us.ibm.com>, David Gibson <dwg@au1.ibm.com>
> 
> That email address died about 2 weeks ago.  Feel free to change it to
> this one: jwboyer@linux.vnet.ibm.com

Done

[snip]
> > +	plb {
> > +		device_type = "ibm,plb";
> > +		compatible = "ibm,plb-440gp", "ibm,plb4";
> > +		#address-cells = <2>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		POB0: opb@0 {
> 
> I think you meant "OPB0:" for the label.

Not really.  The 440GP user manual refers to the bridge (as opposed to
the bus) as POB0.  The label is meant to reflect that.

> > +			device_type = "ibm,opb";
> > +			compatible = "ibm,opb-440gp", "ibm,opb";
> 
> As I pointed out in an earlier email, this breaks working with the
> current legacy_serial driver.  It's looking for a device_type of "opb".
> I'm not sure if we should fix the driver or fix this and the
> ebony_of_bus types in arch/powerpc/platforms/4xx/ebony.c

That's kind of deliberate.  The idea is to use the of_serial stuff
instead of legacy_serial.  legacy_serial was really meant for *legacy*
(i.e. ISA) serial ports, not these on chip things.

The revised version of ebony.c already scans ibm,plb and ibm,opb
busses for OF devices.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
