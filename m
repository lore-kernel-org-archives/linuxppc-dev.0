Return-Path: <jwboyer@jdub.homelinux.org>
Subject: RE: [PATCH 15/16] Add device tree for Ebony
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 10:32:34 -0600
Message-Id: <1171470754.4003.101.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-14 at 09:14 -0700, Yoder Stuart-B08248 wrote:
> I realize the dts is preliminary, but saw some stuff and 
> thought I would comment.
> 
> > -----Original Message-----
> > From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org 
> > [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org] 
> > On Behalf Of David Gibson
> 
> [snip]
> 
> > +	UIC0: interrupt-controller { /* UIC0 */
> > +		device_type = "interrupt-controller";
> > +		compatible = "ibm,uic440gp", "ibm,uic";
> > +		interrupt-controller;
> > +		cell-index = <0>;
> > +		dcr-reg = <0c0 009>;
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> > +		#interrupt-cells = <2>;
> > +
> > +		UIC1: interrupt-controller@1 { /* UIC1 */
> > +			device_type = "interrupt-controller";
> > +			compatible = "ibm,uic440gp", "ibm,uic";
> > +			interrupt-controller;
> > +			cell-index = <1>;
> > +			dcr-reg = <0d0 009>;
> > +			#address-cells = <0>;
> > +			#size-cells = <0>;
> > +			#interrupt-cells = <2>;
> > +			interrupts = <1e 4 1f 4>; /* cascade */
> > +		};
> > +	};
> 
> Did you mean to have UIC1 nested under UIC0 or should
> they be at the same level?

No, they are cascaded in hardware.  I think having UIC1 under UCI0 is a
correct representation.

> 
> > +	plb {
> > +		device_type = "soc";
> > +		compatible = "ibm,plb-440gp", "ibm,plb4";
> > +		ranges;
> > +
> > +		POB0: opb@0 {
> > +			device_type = "soc";
> > +			compatible = "ibm,opb-440gp", "ibm,opb";
> > +			ranges;
> > +			dcr-reg = <090 00b>;
> > +			interrupt-parent = <&UIC1>;
> > +			interrupts = <7 4>;
> > +			clock-frequency = <3ef1480>; // FIXME: 66MHz
> 
> Hmm.  There are two "soc" devices here, one nested under the
> first??
> 
> I'm assuming these are two levels of busses the opb bus is attached
> to the plb bus.  Is the "soc" device_type the right way to 
> do this?

Right, OPB hangs off of PLB in this case.  I dunno if "soc" is the right
device type for them though.

josh
