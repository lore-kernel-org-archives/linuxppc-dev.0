Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 70D8EDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 07:45:17 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 01 Jun 2007 14:45:14 -0700
Message-Id: <1180734314.5674.49.camel@rhino>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 20:58 +0200, Segher Boessenkool wrote:
> > +		ranges = <00000000 f8000000 00100000
> > +			  80000000 80000000 20000000
> > +			  e2000000 e2000000 00100000
> > +			  a0000000 a0000000 20000000
> > +			  e3000000 e3000000 00100000>;
> >  		reg = <f8000000 00100000>;	// CCSRBAR 1M
> 
> 
> "reg" included in "ranges"?  Something is wrong here.

I think it's correct for soc nodes.  At least, it appears that all of
the dts files with soc nodes do similar things (including this one even
without this patch).

> 
> > +				pci_bridge@0 {
> 
> > +					#size-cells = <2>;
> > +					#address-cells = <3>;
> > +					ranges = <02000000 0 80000000
> > +						  02000000 0 80000000
> > +						  0 20000000
> > +						  01000000 0 00000000
> > +						  01000000 0 00000000
> > +						  0 00100000>;
> > +
> > +					isa@1e {
> > +						#size-cells = <1>;
> > +						#address-cells = <2>;
> >
> > +						ranges = <1 0 01000000 0 0
> > +							  00001000>;
> 
> You map the same range (4kB legacy I/O @ 0) for both
> bridges here.

There is a one-to-one mapping between the I/O spaces of "isa" and
"pci_bridge", so wouldn't it be reasonable that a similar range be used?

> 
> > +						i8042@60 {
> > +							reg = <1 60 1 1 64 1>;
> 
> And this address space is included in both of those.

Again, shouldn't the child's address space be in its parent's range?

> 
> > +							keyboard@0 {
> > +								compatible = "pnpPNP,303";
> > +							};
> > +
> > +							mouse@1 {
> > +								compatible = "pnpPNP,f03";
> > +							};
> 
> These need a "reg" property.

I'll add them.

> 
> > +						rtc@70 {
> > +							compatible =
> > +								"pnpPNP,b00";
> > +							reg = <1 70 2>;
> > +						};
> > +
> > +						gpio@400 {
> > +							reg = <1 400 80>;
> > +						};
> 
> Inclusive again.

See above.

> 
> > +						i8259: i8259@4d0 {
> 
> Needs "reg".  And 4d0 isn't the primary address
> I think?

Yes, this is a standard i8259 with additional registers at 0x20 and
0xa0.  I'll fix the address and add the registers.


--Wade
