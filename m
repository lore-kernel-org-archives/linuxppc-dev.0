Return-Path: <vbendeb@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 423AEDE8DA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 12:29:35 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so147721yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 19:29:34 -0700 (PDT)
Message-ID: <f608b67d0808211929g3ae2cf7dm2ba2d65b0043d306@mail.gmail.com>
Date: Thu, 21 Aug 2008 19:29:33 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: TLB programming in powerpc tree. Was: Accessing peripheral bus
	devices on 460GT
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gentlemen, I am back to this puzzling problem, must be missing
something obvious...

Again, I'm trying to bring up a 460GT based system in 2.6.25 kernel.
The problem is I can't gain access to the peripheral devices. The call
to ioremap_nocache() returns a valid pointer, but dereferencing that
pointer causes memory access error.

Naturally, right before the kernel starts up, the device is available
(u-boot configures access to it, both CS and TLB) and uses it. A
closer look shows that the CS registers are left intact, but all TLBs
are wiped out when the kernel starts up. Then just three TLB entries
are created for 3 256M blocks od SDRAM (even though the hardware has
1G of SDRAM, I wonder what's the deal with the last quarter of the
memory is.

But the main problem is that the kernel never sets up TLBs for neither
the peripheral device, nor the onboard flash. I don't seem to be able
to find the place where this is supposed to happen. I assumed that
ioremap_nocache would take care of that, but this is not the case.

So, something which should cause setting up the TLBs for these regions
is missing, can any one let me know what it is? Is this supposed to be
described in the flat device tree? Which part of the kernel code is
responsible for setting up these TLBs?

Any hints will be highly appreciated,

TIA,
vadim

On Wed, Aug 6, 2008 at 7:52 PM, vb <vb@vsbe.com> wrote:
> I am trying to bring up a 2.6.25 based system on a 460GT platform. I
> am using the OF tree cloned off canyonblands.dts, and I am not sure if
> something is missing in the tree, or in the kernel, or I am doing
> something stupid.
>
> The problem is that I don't seem to be able to access any peripheral
> device activated by cs1, 2, 3 (I have not tried touching the NOR flash
> (cs0) just yet). If I don't touch any peripherals the system can
> netbboot or diskboot all the way to the linux prompt.
>
> But unfortunately, the damn peripherals have to be touched :-)
>
> I do invoke ioremap_nocache(<phys addr>, <addr range size>), and it
> returns a virtual address. The thing is that as soon as I try
> accessing the device off this pointer an exception is thrown. From
> u-boot  I can access the <phys addr>..+<addr range size> space no
> problem.
>
>  I see that the dts file mentions that u-boot is supposed to supply
> the "ranges" property in the /plb/opb/ebc section; examining the
> u-boot code for different amcc platforms shows that only the NOR flash
> size is supplied there.
>
> I guess the real question is how do I gain access to the EBC mapped
> hardware configured by u-boot?
>
> can someone please shed any light on this,
>
> thanks a lot in advance,
>
> Vadim
>
