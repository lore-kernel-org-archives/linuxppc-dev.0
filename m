Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6ADE0DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 22:42:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l84Cg55F007177
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 08:42:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l84Cg5sN331866
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 06:42:05 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l84Cg4gt012940
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Sep 2007 06:42:04 -0600
Date: Tue, 4 Sep 2007 07:42:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [patch 3/6] Walnut DTS
Message-ID: <20070904074203.748030c7@weaponx.rchland.ibm.com>
In-Reply-To: <1188741584.3772.7.camel@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.202414000@linux.vnet.ibm.com>
	<20070903010859.GD31499@localhost.localdomain>
	<1188741584.3772.7.camel@localhost.localdomain>
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

On Sun, 02 Sep 2007 08:59:44 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Mon, 2007-09-03 at 11:08 +1000, David Gibson wrote:
> > On Fri, Aug 31, 2007 at 03:04:52PM -0500, Josh Boyer wrote:
> > > Device tree source file for the PPC405 Walnut evaluation board.
> > > 
> > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > 
> > > ---
> > >  arch/powerpc/boot/dts/walnut.dts |  183 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 183 insertions(+)
> > > 
> > > --- /dev/null
> > > +++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
> > > @@ -0,0 +1,183 @@
> > > +/*
> > > + * Device Tree Source for IBM Walnut
> > > + *
> > > + * Copyright 2007 IBM Corp.
> > > + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > + *
> > > + * This file is licensed under the terms of the GNU General Public
> > > + * License version 2.  This program is licensed "as is" without
> > > + * any warranty of any kind, whether express or implied.
> > > + */
> > > +
> > > +/ {
> > > +	#address-cells = <1>;
> > > +	#size-cells = <1>;
> > > +	model = "ibm,walnut";
> > > +	compatible = "ibm,walnut";
> > > +	dcr-parent = <&/cpus/PowerPC,405GP@0>;
> > > +
> > > +	cpus {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		PowerPC,405GP@0 {
> > > +			device_type = "cpu";
> > > +			reg = <0>;
> > > +			clock-frequency = <bebc200>; /* Filled in by zImage */
> > > +			timebase-frequency = <0>; /* Filled in by zImage */
> > > +			i-cache-line-size = <20>;
> > > +			d-cache-line-size = <20>;
> > > +			i-cache-size = <4000>;
> > > +			d-cache-size = <4000>;
> > > +			dcr-controller;
> > > +			dcr-access-method = "native";
> > > +		};
> > > +	};
> > > +
> > > +	memory {
> > > +		device_type = "memory";
> > > +		reg = <0 0>; /* Filled in by zImage */
> > > +	};
> > > +
> > > +	UIC0: interrupt-controller {
> > > +		compatible = "ibm,uic";
> > > +		interrupt-controller;
> > > +		cell-index = <0>;
> > > +		dcr-reg = <0c0 9>;
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > > +		#interrupt-cells = <2>;
> > > +	};
> > > +
> > > +	plb {
> > > +		compatible = "ibm,plb3";
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		ranges;
> > > +		clock-frequency = <0>; /* Filled in by zImage */
> > > +
> > > +		SDRAM0: memory-controller {
> > > +			compatible = "ibm,sdram-405gp";
> > > +			dcr-reg = <010 2>;
> > > +		};
> > > +
> > > +		MAL: mcmal {
> > > +			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
> > > +			dcr-reg = <180 62>;
> > > +			num-tx-chans = <2>;
> > > +			num-rx-chans = <1>;
> > > +			interrupt-parent = <&UIC0>;
> > > +			interrupts = <a 4 b 4 c 4 d 4 e 4>;
> > > +		};
> > > +
> > > +		POB0: opb {
> > > +			compatible = "ibm,opb";
> > 
> > Need an opb-405gp here, too.
> 
> Yep.

Fixed.

> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			ranges = <0 ef600000 a00000>;
> > 
> > Hrm... something we ought to clarify is the interpretation of the
> > POB0_BEAR register with respect to the bridge's ranges property.  For
> > 440 I think the BEAR will need to be interpreted as an OPB address,
> > rather than a PLB address, but I'm not sure if that will work here
> > with the limited ranges property you have.
> 
> Ok, I'll look at this.

The BEAR will still be interpreted as a PLB address here as far as I
can see.  The ranges spans the entire OPB space.  Am I missing
something?

josh
