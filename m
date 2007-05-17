Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id F042EDDE45
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:03:35 +1000 (EST)
Subject: RE: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 17 May 2007 09:03:33 -0700
Message-Id: <1179417813.8132.250.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-17 at 10:50 +0800, Zhang Wei-r63237 wrote:
> Hi, 
> 
> If you add below sector to pci@8000, please remove the interrupt-map
> sector from pci@8000.

Correct me if I'm wrong, but I think if the interrupt-map for pci@8000
is removed then the pci devices on the revision 1.0 board will not get
the correct interrupts.  I don't currently have a rev 1.0 to test
though.  Can someone with a rev 1.0 HPCN board confirm this?

--Wade

> > @@ -286,6 +286,125 @@
> >  				f800 0 0 4 &i8259 0 0
> >  				>;
> >  
> > +			pci@00 {
> > +				device_type = "pci";
> > +				#interrupt-cells = <1>;
> > +				#size-cells = <2>;
> > +				#address-cells = <3>;
> > +				reg = <0000 0 0 0 0>;
> > +				bus-range = <0 fe>;
> > +				ranges = <02000000 0 80000000 80000000 0
> > +					  20000000
> > +					  01000000 0 00000000 00000000 0
> > +					  00100000>;
> > +
> > +				pci@00 {
> > +					device_type = "pci";
> > +					#interrupt-cells = <1>;
> > +					#size-cells = <2>;
> > +					#address-cells = <3>;
> > +					reg = <0000 0 0 0 0>;
> > +					bus-range = <1 fe>;
> > +					ranges = <02000000 0 
> > 80000000 80000000
> > +						  0 20000000
> > +						  01000000 0 
> > 00000000 00000000
> > +						  0 00100000>;
> > +					interrupt-map-mask = 
> > <3f800 0 0 7>;
> > +					interrupt-map = <
> > +						/* IDSEL 0x11 */
> > +						28800 0 0 1 &i8259 3 2
> > +						28800 0 0 2 &i8259 4 2
> > +						28800 0 0 3 &i8259 5 2
> > +						28800 0 0 4 &i8259 6 2
> > +
> > +						/* IDSEL 0x12 */
> > +						29000 0 0 1 &i8259 4 2
> > +						29000 0 0 2 &i8259 5 2
> > +						29000 0 0 3 &i8259 6 2
> > +						29000 0 0 4 &i8259 3 2
> > +
> > +						/* IDSEL 0x13 */
> > +						29800 0 0 1 &i8259 0 0
> > +						29800 0 0 2 &i8259 0 0
> > +						29800 0 0 3 &i8259 0 0
> > +						29800 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x14 */
> > +						2a000 0 0 1 &i8259 0 0
> > +						2a000 0 0 2 &i8259 0 0
> > +						2a000 0 0 3 &i8259 0 0
> > +						2a000 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x15 */
> > +						2a800 0 0 1 &i8259 0 0
> > +						2a800 0 0 2 &i8259 0 0
> > +						2a800 0 0 3 &i8259 0 0
> > +						2a800 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x16 */
> > +						2b000 0 0 1 &i8259 0 0
> > +						2b000 0 0 2 &i8259 0 0
> > +						2b000 0 0 3 &i8259 0 0
> > +						2b000 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x17 */
> > +						2b800 0 0 1 &i8259 0 0
> > +						2b800 0 0 2 &i8259 0 0
> > +						2b800 0 0 3 &i8259 0 0
> > +						2b800 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x18 */
> > +						2c000 0 0 1 &i8259 0 0
> > +						2c000 0 0 2 &i8259 0 0
> > +						2c000 0 0 3 &i8259 0 0
> > +						2c000 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x19 */
> > +						2c800 0 0 1 &i8259 0 0
> > +						2c800 0 0 2 &i8259 0 0
> > +						2c800 0 0 3 &i8259 0 0
> > +						2c800 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x1a */
> > +						2d000 0 0 1 &i8259 6 2
> > +						2d000 0 0 2 &i8259 3 2
> > +						2d000 0 0 3 &i8259 4 2
> > +						2d000 0 0 4 &i8259 5 2
> > +
> > +						/* IDSEL 0x1b */
> > +						2d800 0 0 1 &i8259 5 2
> > +						2d800 0 0 2 &i8259 0 0
> > +						2d800 0 0 3 &i8259 0 0
> > +						2d800 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x1c */
> > +						2e000 0 0 1 &i8259 9 2
> > +						2e000 0 0 2 &i8259 a 2
> > +						2e000 0 0 3 &i8259 b 2
> > +						2e000 0 0 4 &i8259 7 2
> > +
> > +						/* IDSEL 0x1d */
> > +						2e800 0 0 1 &i8259 9 2
> > +						2e800 0 0 2 &i8259 a 2
> > +						2e800 0 0 3 &i8259 b 2
> > +						2e800 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x1e */
> > +						2f000 0 0 1 &i8259 b 2
> > +						2f000 0 0 2 &i8259 0 0
> > +						2f000 0 0 3 &i8259 0 0
> > +						2f000 0 0 4 &i8259 0 0
> > +
> > +						/* IDSEL 0x1f */
> > +						2f800 0 0 1 &i8259 6 2
> > +						2f800 0 0 2 &i8259 0 0
> > +						2f800 0 0 3 &i8259 0 0
> > +						2f800 0 0 4 &i8259 0 0
> > +						>;
> > +					};
> > +				};
> > +
> > +
> >  			isa@f0 {
> >  				device_type = "isa";
> >  				#interrupt-cells = <2>;
> > @@ -335,7 +454,7 @@
> >  			#size-cells = <2>;
> >  			#address-cells = <3>;
> >  			reg = <9000 1000>;
> > -			bus-range = <0 ff>;
> > +			bus-range = <3 ff>;
> >  			ranges = <02000000 0 a0000000 a0000000 
> > 0 20000000
> >  				  01000000 0 00000000 e3000000 
> > 0 00100000>;
> >  			clock-frequency = <1fca055>;
> 
> Best Regards,
> Zhang Wei
