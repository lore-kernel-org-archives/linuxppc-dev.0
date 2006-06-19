Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D2C467B1B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 08:22:09 +1000 (EST)
In-Reply-To: <EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Interrupt mapping documentation
Date: Tue, 20 Jun 2006 00:22:02 +0200
To: Becky Bruce <Becky.Bruce@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Wow, you've been busy!  This mostly looks good to me - just a few
> *minor* comments below. I've snipped out parts I'm not commenting on,
> to shrink this email down.....

Yeah.  I've got some nits too, although mostly spelling.  Will get to
those later, if I find the time :-)

> One concern is this stated requirement that a tree have an interrupt-
> controller node.  It's not uncommon (in fact, I'm doing it right
> now...) for FSL and some of our customers to build and run the kernel
> on a simulator that has only a processor core, memory, and a memory-
> mapped pseudo-terminal.  The terminal does not generate interrupts,
> but is polled from the Decrementer interrupt.  So I do not have an
> interrupt controller in the "system" at all.
>
> How are you planning to enforce this requirement?  I believe the dtc
> I have right now warns me about no interrupt-controller node, but it
> builds the tree anyway, and I can boot my kernel just fine.  If all
> I'll need to do to get this working in the new world order is to add
> an "interrupt-controller" property to my soc node, I can deal with
> that.  I just don't want the kernel to konk out and refuse to boot if
> it doesn't find any interrupts.

If there's any interrupt in the dev tree, there should be an interrupt
controller.  If the requirement is more strict than that, that's a  
bug :-)

> I'm curious about why you chose to rename the pic node here - now we
> have interrupt-controller as a device name, as well as an interrupt-
> controller property inside the device.  Reading the rest of this doc,
> the latter should be sufficient.  Is this just a stylistic decision?

Most "real" device trees (on a "real" OF) do not have "interrupt- 
controller"
as the name of their main interrupt controller nodes.  This sounds  
like a
spec bug.

> "In general, the format of an address for a device is defined by the
> parent bus type, based on the #address-cells and #size-cells
> property. In the absence of such a property, the parent's parent
> values are used, etc..."

Bad already; #size-cells has nothing to do with addresses (it's
important for address _ranges_ though).

> The additions in the patch specify new requirements that don't seem
> to match up with the statement above.  In the new patch, #address-
> cells is listed as a required node for interrupt-controller nodes,
> there's no mention of inheritance from a parent,

Inheritance from the parent does not exist, in real OF.  Absence of
#address-cells means "default to 2".  This needs to be fixed in DTC.

> and in one place in
> the Nexus section, it's stated that if there's no #address-cells node
> the kernel assumes it's 0.

Also wrong.  Although I think that's what the IMAP thing says as well...

> I think the doc needs a bit of clarification in this area.

Yeah.

Just *require* #address-cells for everything with addressable sub-nodes,
at least in DTC.  Doesn't cost much, and no confusion anymore.


Segher
