Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id DB76FDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:54:06 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sat, 2 Jun 2007 10:53:59 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070602085359.GA10333@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 02, 2007 at 10:22:59AM +0200, Segher Boessenkool wrote:
> >> "reg" included in "ranges"?  Something is wrong here.
> >
> > I think it's correct for soc nodes.
> 
> It is not.  "ranges" is the address space translation
> between the parent and child busses; "reg" is the stuff
> that's on the bridge device itself.
> 
> > At least, it appears that all of
> > the dts files with soc nodes do similar things (including this one even
> > without this patch).
> 
> Yes, but that doesn't make it right.
> 
> >>> +				pci_bridge@0 {
> >>
> >>> +					#size-cells = <2>;
> >>> +					#address-cells = <3>;
> >>> +					ranges = <02000000 0 80000000
> >>> +						  02000000 0 80000000
> >>> +						  0 20000000
> >>> +						  01000000 0 00000000
> >>> +						  01000000 0 00000000
> >>> +						  0 00100000>;
> >>> +
> >>> +					isa@1e {
> >>> +						#size-cells = <1>;
> >>> +						#address-cells = <2>;
> >>>
> >>> +						ranges = <1 0 01000000 0 0
> >>> +							  00001000>;
> >>
> >> You map the same range (4kB legacy I/O @ 0) for both
> >> bridges here.
> >
> > There is a one-to-one mapping between the I/O spaces of "isa" and
> > "pci_bridge", so wouldn't it be reasonable that a similar range be 
> > used?
> 
> Oh wait, the ISA bridge is a child of the PCI bridge here.
> It is obviously fine then.
> 
> >>> +						i8042@60 {
> >>> +							reg = <1 60 1 1 64 1>;
> >>
> >> And this address space is included in both of those.
> >
> > Again, shouldn't the child's address space be in its parent's range?
> 
> Yes of course, I'm simply losing track of the nesting
> here.  Sigh.
> 
> >>> +						i8259: i8259@4d0 {
> >>
> >> Needs "reg".  And 4d0 isn't the primary address
> >> I think?
> >
> > Yes, this is a standard i8259 with additional registers at 0x20 and
> > 0xa0.  I'll fix the address and add the registers.
> 
> That sounds good, thanks!
> 

I'd beg to differ. There are three registers area:

- 0x20 which is the master interrupt controller
  (since the original 1981 IBM-PC)
- 0xa0 which is the slave interrupt controller, connected to
  IRQ2 of the master (introduced with the XT or the AT, I don't
  remember)
- 0x4d0 which was added later to allow per interrupt line setting
  of edge or level triggering (instead of per controller).

By far the most important registers are the ones at 0x20 since
you access them at every interrupt. The registers at 0x4d0
are typically set by firmware and never touched later, there
is not a single access to them in sysdev/i8259.c.

I have vague memories of a node named i8259@20 one a board 
who had OF in 1997 (a Motorola MVME but they switched to 
PPCBUG just after :-().

	Gabriel


> 
> Segher
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
