Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 1DA15DDF03
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 09:21:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so65659anc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Nov 2007 14:21:14 -0800 (PST)
Message-ID: <fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
Date: Sun, 25 Nov 2007 15:21:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Xilinx devicetrees
In-Reply-To: <47493D4F.4070605@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<47493D4F.4070605@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/25/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> > One more point; it is also possible to bind the device tree up with
> > the kernel so you've got a single image just like old times.  :-)
> >
>     But that is not actually the same is dynamically detecting
> configuration.

nope, not at all the same as dynamic detection; just backwards
compatibility with the way we do it now for arch/ppc.

>     On an ordinary PC where the critical core configuration is somewhat
> fixed and the rest can be determined by firmware (code), this makes a
> great deal of sense.
>     In a system where the hardware itself is actually firmware and there
> is little or no startup software to query the device and build a device
> tree dynamically for you, it is of more questionable value.
>     Maybe if there is some mechanism existed to have the devicetree
> stored into the FPGA firmware where there is a natural link between the
> implimented hardware and its description. But I am not gathering things
> going in that direction and storing the device tree in the FPGA consumes
> valuable FPGA resources.

No, it doesn't make sense to store is in the FPGA fabric; but if the
design already contains BRAM then it could be placed there and
reclaimed for other purposes after booting.  Or anywhere in RAM for
that matter.  I don't know how feasible is to load a device tree into
SDRAM at FPGA config time.

If the FPGA bitstream is stored in processor accessable flash, then
the best place would be tacked onto the end of the bitstream file.  I
believe Xilinx is planning for EDK to be responsible to generate the
.dts file for the design.

>
> >
> > The board description has to live *somewhere*.
>     I have done alot of code for many purposes where the code went to a
> great deal of effort to figure out its own environment dynamically.
>     Some (relatively minimal) assumptions have to be made. And some
> balance has to be struck between code complexity and dynamic flexibility.
>     though sometimes dynamic detection can be simpler.
>     Part of what bothers me about devicetrees, is that the entire design
> seems to presume either standard hardware with minimal permutations, or
> fairly complex firmware - like boot roms to dynamically build atleast
> parts of the device tree.

Ah; I think I see the disconnect we're having.  Device trees are not
about, *and never have been about*, device detection.  The device tree
is simply the communication medium used to describe the hardware.  It
doesn't matter if you choose to use a 100% dynamically generated
device tree from intelligent firmware or a 100% static device tree
blob.  All that matters is that the kernel is able to trust the
information handed to it by firmware.

Device detection is not a problem that the device tree is designed to solve.

It is designed to solve the problem of telling the kernel what the
platform looks like (which occurs after the detection stage).

> > That being said, using the device tree does not preclude using
> > platform code to setup devices *where it makes sense to do so*.  Many
> > things are one-off board specific things that are not well described
> > with the device tree.  For example, we've been debating how to handle
> > on board sound which use common codec chips, but have custom wireup.
> > The codec chip can use a common driver, but the wireup is handled with
> > an ALSA 'fabric' driver that is pretty much a one-off for the board.
> > It probably makes more sense for the fabric driver to be instantiated
> > by the platform code rather than trying to do a full device tree
> > representation.
> >
>        So I can hard code some relatively simple stripped devicetree
> that  may do little more than specify the CPU, major elements of the
> memory map (maybe), and say the PIC, and then let the BSP, detect things
> like the UART(s), NIC, ...

If devices *are* detectable, then they don't need to be in the device
tree.  That's why we don't describe PCI devices in the FDT for
embedded boards.  (We *could* but we *don't*)  :-)

> >   In arch/powerpc
> > we're *still* data driven; it's just that the data is no longer
> > compiled into a static structure.  Plus, in the transition we've moved
> > from needed per-device platform data structures to a more expressive
> > format.  Also, per-board platform support code has become much simpler
> > (compare ml300.c in arch/ppc with platforms/40x/virtex.c)
> >
>
>     I have not pulled your tree in a while - are devicetree's in your
> current git tree ?

arch/powerpc support for Virtex is now in Linus' mainline tree which
will become 2.6.24

>
>     Thanks for the remarks.
>
>     Again, I am just trying to figure out how to keep my Pico code in
> sync and hopefully make my life better rather than worse at the same time.
>     Unfortunately, I am coming to the conclusion that DeviceTrees are
> probably not going to make it that much better,
>     but they are probably not going to make it that much worse either.

No, unfortunately they don't deal with the problem you're facing
(which I'm facing also).  But it will be solved if we figure out a
sane way to bind the device tree up with the FPGA bitstream without
consuming FPGA resources.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
