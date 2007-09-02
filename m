Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93E4EDDF6E
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 23:39:28 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l83DdPFH012552
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:39:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l83DdPIM497258
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:39:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l83DdPlM019044
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 09:39:25 -0400
Subject: Re: [patch 3/6] Walnut DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070903010859.GD31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com> >
	<20070831200643.202414000@linux.vnet.ibm.com>
	<20070903010859.GD31499@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 02 Sep 2007 08:59:44 -0500
Message-Id: <1188741584.3772.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-09-03 at 11:08 +1000, David Gibson wrote:
> On Fri, Aug 31, 2007 at 03:04:52PM -0500, Josh Boyer wrote:
> > Device tree source file for the PPC405 Walnut evaluation board.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > 
> > ---
> >  arch/powerpc/boot/dts/walnut.dts |  183 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 183 insertions(+)
> > 
> > --- /dev/null
> > +++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
> > @@ -0,0 +1,183 @@
> > +/*
> > + * Device Tree Source for IBM Walnut
> > + *
> > + * Copyright 2007 IBM Corp.
> > + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without
> > + * any warranty of any kind, whether express or implied.
> > + */
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	model = "ibm,walnut";
> > +	compatible = "ibm,walnut";
> > +	dcr-parent = <&/cpus/PowerPC,405GP@0>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		PowerPC,405GP@0 {
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			clock-frequency = <bebc200>; /* Filled in by zImage */
> > +			timebase-frequency = <0>; /* Filled in by zImage */
> > +			i-cache-line-size = <20>;
> > +			d-cache-line-size = <20>;
> > +			i-cache-size = <4000>;
> > +			d-cache-size = <4000>;
> > +			dcr-controller;
> > +			dcr-access-method = "native";
> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0 0>; /* Filled in by zImage */
> > +	};
> > +
> > +	UIC0: interrupt-controller {
> > +		compatible = "ibm,uic";
> > +		interrupt-controller;
> > +		cell-index = <0>;
> > +		dcr-reg = <0c0 9>;
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> > +		#interrupt-cells = <2>;
> > +	};
> > +
> > +	plb {
> > +		compatible = "ibm,plb3";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +		clock-frequency = <0>; /* Filled in by zImage */
> > +
> > +		SDRAM0: memory-controller {
> > +			compatible = "ibm,sdram-405gp";
> > +			dcr-reg = <010 2>;
> > +		};
> > +
> > +		MAL: mcmal {
> > +			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
> > +			dcr-reg = <180 62>;
> > +			num-tx-chans = <2>;
> > +			num-rx-chans = <1>;
> > +			interrupt-parent = <&UIC0>;
> > +			interrupts = <a 4 b 4 c 4 d 4 e 4>;
> > +		};
> > +
> > +		POB0: opb {
> > +			compatible = "ibm,opb";
> 
> Need an opb-405gp here, too.

Yep.

> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 ef600000 a00000>;
> 
> Hrm... something we ought to clarify is the interpretation of the
> POB0_BEAR register with respect to the bridge's ranges property.  For
> 440 I think the BEAR will need to be interpreted as an OPB address,
> rather than a PLB address, but I'm not sure if that will work here
> with the limited ranges property you have.

Ok, I'll look at this.

josh
