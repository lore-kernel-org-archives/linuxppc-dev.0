Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 58DA0DDF7E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 13:22:16 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so648309anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 20:22:15 -0700 (PDT)
Message-ID: <fa686aa40804222022p60ac75ebt27c6c4f78a039ea0@mail.gmail.com>
Date: Tue, 22 Apr 2008 21:22:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: cbouatmailru@gmail.com
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO LEDs,
	MCU, and NAND on UPM
In-Reply-To: <20080423003730.GA7589@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
	<fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
	<20080423003730.GA7589@zarina>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 6:37 PM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> On Tue, Apr 22, 2008 at 02:08:45PM -0600, Grant Likely wrote:
>
> > On Tue, Apr 22, 2008 at 1:41 PM, Anton Vorontsov
>  > <avorontsov@ru.mvista.com> wrote:
>  > > Hi all,
>  > >
>  > > Here is purposed bindings draft for the new drivers that I would like to
>  > > send for this or next merge window, depending on results of this RFC. ;-)
>  > > (The new bindings needs to be in-tree or at least Acked before I could
>  > > send the drivers.)
>  > >
>  > > Comments and suggestions are highly appreciated.
>  >
>  > Thanks for cc'ing me.  Mostly looks good, comments below.
>
>  Thanks for the comments!

np.

>  > > +    Example:
>  > > +
>  > > +       usb-pram@8b00 {
>  > > +               compatible = "fsl,mpc8360-qe-muram-usb-pram",
>  > > +                            "fsl,qe-muram-usb-pram",
>  > > +                            "fsl,cpm-muram-usb-pram";
>  > > +               reg = <0x8b00 0x100>;
>  > > +       };
>  > > +
>  > > +    t) Freescale QUICC Engine USB Controller
>  > > +
>  > > +    Required properties:
>  > > +      - compatible : should be "fsl,<chip>-qe-usb", "fsl,qe-usb",
>  > > +        "fsl,usb-fhci"
>  >
>  > Again, I'd leave out "fsl,qe-usb" and "fsl,usb-fhci".
>
>  Given that mpc8323 is the first (IIRC) chip that supports QE USB,
>  do I understand correctly that you're purposing something like this
>  (e.g. for mpc8360):
>
>        usb@6c0 {
>                compatible = "fsl,mpc8360-qe-usb", "fsl,mpc8323-qe-usb";
>
>  Or... do I have to write somthing like this in the driver itself:
>
>  static const struct of_device_id of_fhci_match[] = {
>         { .compatible = "fsl,mpc8323-qe-usb", },
>         { .compatible = "fsl,mpc8360-qe-usb", },
>         { ...new chips... }
>         {},
>  };
>
>  And specify only "fsl,mpc8360-qe-usb" (for mpc8360 case again)?
>
>  I have no objections to either of this, just want some clarity.

*Both* are perfectly valid options.  Personally, I'd choose the first
option as it keeps the size of the driver match table small.  However,
the option is always there to add entries to the match table if
somebody ships a board with wonky firmware that has a
never-before-seen value in compatible (so the system is
fault-tolerant).

>  > > +      - reg : should contain gtm registers location and length.
>  > > +      - interrupts : should contain USB interrupt.
>  > > +      - interrupt-parent : interrupt source phandle.
>  > > +      - fsl,fullspeed-clock : specifies the full speed USB clock source.
>  > > +      - fsl,lowspeed-clock : specifies the low speed USB clock source.
>  >
>  > What is the format of the clock properties?
>
>  I'll make it clear in the next revision (the format is "clk<NUM>" or
>  "brg<NUM>").

Does the clock come from another device that is represented in the
tree?  If so, should it have a phandle to that node?

>  > > +    v) Freescale MCU with MPC8349E-mITX compatible firmware
>  > > +
>  > > +    Required properties:
>  > > +      - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx",
>  > > +        "simple-bus";
>  >
>  > I don't think "simple-bus" is appropriate here.  This device doesn't
>  > have any sub nodes so is not a bus.  (I'm talking about the binding
>  > here; and I understand that simple-bus is convenient for causing
>  > subnodes to be picked up into of_platform and that you'll be putting
>  > the LED nodes as children of this one.  It just shouldn't be part of
>  > this binding documentation.)
>
>  Ok, I'll remove simple-bus from the bindings.
>
>
>  > Also, since this node describes a device+firmware instead of just a
>  > device, then "fsl,mcu-mpc8349emitx" should uniquely identify the
>  > device from all other possibilities.  It appears to be a very board
>  > specific thing.
>
>  Yes, it is board specific. For example, for MPC8377E-RDB boards I'll
>  write this:
>
>  compatible = "fsl,mc9s08qg8-mpc8377erdb", "fsl,mcu-mpc8349emitx",
>              "simple-bus";
>
>  I.e. "very-specific", "device-that-compatible", "simple-bus".
>
>  Is that ok?

Ah; okay.  I think I understand what you're doing now.  Yes, this is fine.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
