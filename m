Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 37AD1DDF48
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 11:10:28 +1100 (EST)
Date: Fri, 7 Mar 2008 01:10:25 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080307001025.GA27321@netgate.macqel>
References: <20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204760811.21545.231.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Thu, Mar 06, 2008 at 10:46:51AM +1100, Benjamin Herrenschmidt wrote:
> 
> > >>From your .dts, I see you've been doing some swizzling of slots using
> > > interrupts 1...4 ... do that correspond to EXTIRQ 5....8 ?
> > 
> > No, those correspond to the EXT1-4 that are the other side of the #ifdef 
> > for this board in arch/ppc. :-)
> 
> Yes, that's what I was thinking. So that's what he got wrong in
> his .dts.
> 
> Philippe, you need to fix those numbers so they map your EXTIRQ.
> 
> (that is 1 -> 5, 2 -> 6, etc... )
> 
> And of course you need to make sure you have the right routing to the
> chip. it's funny the way you keep providing all sort of info but -never-
> the one we actually asked for :-)

I did not have that.  The board has been designed, and the original linux
port has been made, by a third-party, and the documentation is scarce :(

> 
> We basically, to help you, need to know for each PCI device connected to
> the SoC, or PCI slot if you have such, which address line is used for
> IDSEL, and to which MPIC interrupt inputs.

Well, i have finally an answer for IDSEL : it is connected to AD18 (18 is
decimal), but we knew that actually, because the chip appears as 0000:00:12.0,
0000:00:12.1 and 0000:00:12.2 in the kernel messages.

The pci4520 chip does not have pins labelled inta, intb, intc, or intd,
but pins labelled mfunc0, mfunc1 ... mfunc6.
The pci4520 datasheet does not seem very clear to me about the relation
between the mfunc0..6 pins and the inta..d interrupts :(
Luckily, the running linux kernel shows in /proc/interrupts :

         55:      18797   OpenPIC   Level     yenta, ide0
         54:          1   OpenPIC   Level     yenta
         55:         79   OpenPIC   Level     ohci1394

I can thus deduce that each function of the pci4520 chip uses only
one interrupt line.  With the kernel messages at startup, I also
know that the two yenta's are 12.0 and 12.1 and the ohci1394 is 12.2.
I wrote then the following in my dts file :

        pci@e0008000 {
/*
                                      f800 masks idsel address line
                                      07 masks (sub)function number
                                               7 masks INTA, INTB, INTC or INTD
*/
                interrupt-map-mask = <ff00 0 0 7>;
                interrupt-map = <
                        /* IDSEL 0x12 func 0 */
                        9000 0 0 1 &mpic 5 1
                        9000 0 0 2 &mpic 5 1
                        9000 0 0 3 &mpic 5 1
                        9000 0 0 4 &mpic 5 1

                        /* IDSEL 0x12 func 1 */
                        9100 0 0 1 &mpic 6 1
                        9100 0 0 2 &mpic 6 1
                        9100 0 0 3 &mpic 6 1
                        9100 0 0 4 &mpic 6 1

                        /* IDSEL 0x12 func 2 */
                        9200 0 0 1 &mpic 7 1
                        9200 0 0 2 &mpic 7 1
                        9200 0 0 3 &mpic 7 1
                        9200 0 0 4 &mpic 7 1
                        >;

And it works :) : my board boots and finds its compact-flash disk.  When
writing this, I realize I may simplify my interrupt-map and write
only one config line per function, thus :

                interrupt-map-mask = <ff00 0 0 0>;
                interrupt-map = <
                        /* IDSEL 0x12 func 0 */
                        9000 0 0 0 &mpic 5 1

                        /* IDSEL 0x12 func 1 */
                        9100 0 0 0 &mpic 6 1

                        /* IDSEL 0x12 func 2 */
                        9200 0 0 0 &mpic 7 1
                        >;

Maybe you should explain in booting_without_of.txt the relation between
the idsel and the pci device notation used by lspci or the kernel, and
also document the "function" part ?

> 
> Once you have given us that, we'll be able to help.
> 
> It appears that just looking at the arch/ppc code is a bit too messy and
> confusing (and not necessarily right).
> 
> In addition, you will also need to do proper interrupt routing for you
> other devices (RTC, etc...) but we can look at that separately.

That's for tomorrow.

But I already noticed that the interrupt numbers that the arch/powerpc tree
uses for the parts that do already work (compact-flash and serials) are
different from the ones I saw on the running arch/ppc tree.  e.g.,
the serial lines used irq 26 with the arch/ppc tree and now use 42 with
the powerpc tree.  For the pci4520, irqs changed from 53, 54 and 55 in the
arch/ppc kernel to 17, 18 and 19 with the arch/powerpc kernel.
That's a little bit confusing.

There must be something hidden in the sources of the openpic driver to
explain that difference.  Could it be fixed by a setting in the dts-file ?

Thanks for you help

Philippe
