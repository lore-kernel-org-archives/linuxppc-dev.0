Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 628F1DDEC9
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 05:53:15 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sat, 2 Jun 2007 21:53:08 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070602195308.GA21618@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 02, 2007 at 11:01:29AM +0200, Segher Boessenkool wrote:
> >>>>>+						i8259: i8259@4d0 {
> >>>>
> >>>>Needs "reg".  And 4d0 isn't the primary address
> >>>>I think?
> >>>
> >>>Yes, this is a standard i8259 with additional registers at 0x20 and
> >>>0xa0.  I'll fix the address and add the registers.
> >>
> >>That sounds good, thanks!
> >
> >I'd beg to differ. There are three registers area:
> >
> >- 0x20 which is the master interrupt controller
> >  (since the original 1981 IBM-PC)
> >- 0xa0 which is the slave interrupt controller, connected to
> >  IRQ2 of the master (introduced with the XT or the AT, I don't
> >  remember)
> >- 0x4d0 which was added later to allow per interrupt line setting
> >  of edge or level triggering (instead of per controller).
> >
> >By far the most important registers are the ones at 0x20 since
> >you access them at every interrupt. The registers at 0x4d0
> >are typically set by firmware and never touched later, there
> >is not a single access to them in sysdev/i8259.c.
> 
> Yes, I think we all agree -- it should be interrupt-controller@20,
> with 20, a0, 4d0 in the "reg" property.

In the current tree it is called "i8259" in mpc8641_hpcn.dts. The other
ones which have a 8259 are not usable (mpc8555 for example). I don't
even understand their reg property (19000 0 0 0 1), and the driver
has hardcoded addresses at 0x20 and 0xa0, which is reasonable 
since I've never seen an ISA bridge put the 8259 at another address.

> 
> I'm not sure what "compatible" should be for this node, someone
> else can dig that up :-)

I believe that "8259" should appear somewhere because of the 
"8259-interrupt-acknowledge" property (defined in CHRP bindings)
which you can have on the parent bridge to speed up interrupt 
vector acquisition.

	Gabriel
