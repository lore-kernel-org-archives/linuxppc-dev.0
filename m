Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Feb 2011 13:16:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bruce_Leonard@selinc.com
Subject: Re: Question on supporting multiple HW versions with a single
	driver (warning: long post)
Message-ID: <20110208021616.GO30616@yookeroo>
References: <OF8C287A2E.13F8CEBF-ON8825782B.0073FBAF-8825782B.00789868@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF8C287A2E.13F8CEBF-ON8825782B.0073FBAF-8825782B.00789868@selinc.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 02, 2011 at 01:57:13PM -0800, Bruce_Leonard@selinc.com wrote:
> So this is sort of a follow on question to one I posted a month ago about 
> trying to get a PCI driver to work with OF (which I think I more or less 
> understood the answer to).  I'm encountering a different sort of problem 
> that I'd like to solve with OF but I'm not sure I can.  Let me lay out a 
> little background first.
> 
> We build embedded systems, so we never really have hot plug events and our 
> addresses (at least for HW interfaces) are pretty much static for any 
> given product.  In other words for product "A" the NAND controller will 
> always be at address "X", though on product "B" that same NAND controller 
> may be at address "Y".  Also, the devices in the product are static, i.e., 
> we'll always talk to an LXT971 as the PHY.
> 
> Currently I'm working on building a driver for an ethernet MAC we're 
> putting in an FPGA.  The MAC is based on the MPC8347 TSEC and the driver 
> is based on the gianfar driver.  (My previous question was how to spoof 
> the OF gianfar driver into thinking it was a PCI driver because our MAC is 
> going to be hanging off a PCI bus.  Ultimately I decided to just 
> steal...err...borrow... the guts of the gianfar driver and make it a PCI 
> driver that only deals with our MAC.)
> 
> Right in the middle of writing this driver, my HW guys came to me and said 
> they wanted to use this same MAC in other products.  Great I said.  Local 
> bus they said.  Which opens up a whole can of worms and leads to my 
> question.  We've got a MAC in a FPGA with a nice generic interface on the 
> front of it that can talk to a whole range of different busses, PCI, PCIe, 
> local bus (of any variety of any processor), etc.  But the internals of 
> the MAC (i.e., the register sets, the buffers, the whole buffer descriptor 
> mechanism) all looks the same.  Seems to me that this is exactly the sort 
> of situation OF and device trees was developed for.
> 
> What I'd like to do, and I'm sure it's possible but I have no idea how, is 
> to still have this as an OF driver and have the device tree tell the 
> kernel about the HW interface to use.  So on one product (currently all 
> products use an MCP83xx variant) I would have a child node under a PCI 
> node to describe it's interrupts, addressing (which could also come from a 
> PCI probe I expect), compatibility, any attached PHYs etc, and on a second 
> product do the same thing under a localbus node.
> 
> First question that comes to mind is ordering.  If I put a child node in 
> the PCI node of the device tree, what happens when the device tree is 
> processed?  Is it immediately going to try and find and install a driver 
> for that child node?  Since the device tree is processed very early, the 
> PCI bus isn't going to be set up and available yet.  Will trying to 
> install a PCI driver via OF even be possible at this point?  Then I'd 
> still need a PCI function to claim the device when the PCI bus gets 
> probed.  If the driver is already installed via OF, what does the PCI 
> function do?
> 
> Or am I all backwards.  Does having the child node to the PCI node 
> actually do anything when the early OF code runs?  If not would the PCI 
> probe function be the first indication to the system that the driver needs 
> to be loaded?  In which case I just walk the device tree looking 
> for...what?  How would I match up the PCI ID with something in the device 
> tree?
> 
> Then there's the local bus side of the question?  That should truly be an 
> OF driver and use struct of_platform_driver along with that whole 
> mechanism.  How do I make that compatible with the version of the MAC that 
> runs on PCI?
> 
> Or am I making a whole lot of work for myself and I should just make them 
> separate drivers?  I'm trying to keep the code base as small and coherent 
> as possible.  I don't want to have to maintain multiple copies of a driver 
> that are essentially identical.

No, you shouldn't need multiple drivers.  However, what you will want
is two sets of bus binding "glue" for the one driver.  The driver
proper won't directly advertise a struct driver, but will provide some
sort of explicit init/probe function with enough information to set up
the device on either PCI or localbus.

Then you have a PCI bus binding which advertises to the driver model
as a PCI driver, and when probed does any PCI specific magic then
instantiates the core driver in the right way based on the information
obtained from the PCI system.

A second bus binding advertises as a platform[*] driver and when
probed instantiates the core driver based on the platform device
information.

There are a number of drivers which already have this sort of dual bus
binding.

[*] of_platform_driver is now deprecated - the whole concept was
based on a flawed conceptual model which causes problems in, amongst
others, exactly this case.  The new approach is to have a platform
device structure which is created automatically during device tree
scanning.  This also makes it easier to have a single driver (and
binding) which will work both on device-tree-based and non
device-tree-based platforms.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
