Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57767DDDE6
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:15:19 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KFFOC024579
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:15:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KFFip268146
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:15:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KFFo2032021
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:15:15 -0600
Date: Thu, 2 Aug 2007 15:15:13 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070802151513.12e9caf7@weaponx.rchland.ibm.com>
In-Reply-To: <20070801020836.GB31391@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2007 12:08:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jul 30, 2007 at 07:06:48PM +0400, Valentine Barshak wrote:
> > AMCC Sequoia board DTS
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > ---
> >  arch/powerpc/boot/dts/sequoia.dts |  292
> > ++++++++++++++++++++++++++++++++++++++ 1 files changed, 292
> > insertions(+)
> > 
> > diff -ruN linux.orig/arch/powerpc/boot/dts/sequoia.dts
> > linux/arch/powerpc/boot/dts/sequoia.dts ---
> > linux.orig/arch/powerpc/boot/dts/sequoia.dts	1970-01-01
> > 03:00:00.000000000 +0300 +++
> > linux/arch/powerpc/boot/dts/sequoia.dts	2007-07-27
> > 20:44:26.000000000 +0400 @@ -0,0 +1,292 @@ +/*
> > + * Device Tree Source for AMCC Sequoia
> > + *
> > + * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > + * Copyright (c) 2006, 2007 IBM Corp.
> > + *
> > + * FIXME: Draft only!
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without
> > + * any warranty of any kind, whether express or implied.
> > + *
> > + * To build:
> > + *   dtc -I dts -O asm -o bamboo.S -b 0 sequoia.dts
> > + *   dtc -I dts -O dtb -o bamboo.dtb -b 0 sequoia.dts
> 
> Needs updating to remove the bamboo references.  In fact we can
> probably get rid of this "To build" comment that's been copied to just
> about every dts ever.
> 
> > + */
> > +
> > +/ {
> > +	#address-cells = <2>;
> > +	#size-cells = <1>;
> > +	model = "amcc,sequoia";
> > +	compatible = "amcc,sequoia";
> > +	dcr-parent = <&/cpus/PowerPC,440EPx@0>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		PowerPC,440EPx@0 {
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			clock-frequency = <0>; /* Filled in by
> > zImage */
> > +			timebase-frequency = <0>; /* Filled in by
> > zImage */
> > +			i-cache-line-size = <20>;
> > +			d-cache-line-size = <20>;
> > +			i-cache-size = <8000>;
> > +			d-cache-size = <8000>;
> > +			dcr-controller;
> > +			dcr-access-method = "native";
> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0 0 0>; /* Filled in by zImage */
> > +	};
> > +
> > +	UIC0: interrupt-controller0 {
> > +		compatible = "ibm,uic-440gp","ibm,uic";
> 
> The first compatible entry should always be the precise model, so in
> this case "ibm,uic-440epx".  If it is (supposed to be) identical to
> the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry, but
> since I believe all the UICs are supposed to operate the same, I think
> that's implicit in the "ibm,uic" entry.

Most UICs are the same.  There are some oddball chips that either hide
particular registers because they are unused, or they change the
addressing stride.  I'm not sure that is a common enough case to worry
about now though.

josh
