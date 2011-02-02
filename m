Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 2D71BB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 08:57:14 +1100 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
	by duster.selinc.com (8.14.3/8.14.3) with ESMTP id p12LvCRm016275
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 13:57:12 -0800
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Question on supporting multiple HW versions with a single driver
	(warning: long post)
Message-ID: <OF8C287A2E.13F8CEBF-ON8825782B.0073FBAF-8825782B.00789868@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 2 Feb 2011 13:57:13 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So this is sort of a follow on question to one I posted a month ago about 
trying to get a PCI driver to work with OF (which I think I more or less 
understood the answer to).  I'm encountering a different sort of problem 
that I'd like to solve with OF but I'm not sure I can.  Let me lay out a 
little background first.

We build embedded systems, so we never really have hot plug events and our 
addresses (at least for HW interfaces) are pretty much static for any 
given product.  In other words for product "A" the NAND controller will 
always be at address "X", though on product "B" that same NAND controller 
may be at address "Y".  Also, the devices in the product are static, i.e., 
we'll always talk to an LXT971 as the PHY.

Currently I'm working on building a driver for an ethernet MAC we're 
putting in an FPGA.  The MAC is based on the MPC8347 TSEC and the driver 
is based on the gianfar driver.  (My previous question was how to spoof 
the OF gianfar driver into thinking it was a PCI driver because our MAC is 
going to be hanging off a PCI bus.  Ultimately I decided to just 
steal...err...borrow... the guts of the gianfar driver and make it a PCI 
driver that only deals with our MAC.)

Right in the middle of writing this driver, my HW guys came to me and said 
they wanted to use this same MAC in other products.  Great I said.  Local 
bus they said.  Which opens up a whole can of worms and leads to my 
question.  We've got a MAC in a FPGA with a nice generic interface on the 
front of it that can talk to a whole range of different busses, PCI, PCIe, 
local bus (of any variety of any processor), etc.  But the internals of 
the MAC (i.e., the register sets, the buffers, the whole buffer descriptor 
mechanism) all looks the same.  Seems to me that this is exactly the sort 
of situation OF and device trees was developed for.

What I'd like to do, and I'm sure it's possible but I have no idea how, is 
to still have this as an OF driver and have the device tree tell the 
kernel about the HW interface to use.  So on one product (currently all 
products use an MCP83xx variant) I would have a child node under a PCI 
node to describe it's interrupts, addressing (which could also come from a 
PCI probe I expect), compatibility, any attached PHYs etc, and on a second 
product do the same thing under a localbus node.

First question that comes to mind is ordering.  If I put a child node in 
the PCI node of the device tree, what happens when the device tree is 
processed?  Is it immediately going to try and find and install a driver 
for that child node?  Since the device tree is processed very early, the 
PCI bus isn't going to be set up and available yet.  Will trying to 
install a PCI driver via OF even be possible at this point?  Then I'd 
still need a PCI function to claim the device when the PCI bus gets 
probed.  If the driver is already installed via OF, what does the PCI 
function do?

Or am I all backwards.  Does having the child node to the PCI node 
actually do anything when the early OF code runs?  If not would the PCI 
probe function be the first indication to the system that the driver needs 
to be loaded?  In which case I just walk the device tree looking 
for...what?  How would I match up the PCI ID with something in the device 
tree?

Then there's the local bus side of the question?  That should truly be an 
OF driver and use struct of_platform_driver along with that whole 
mechanism.  How do I make that compatible with the version of the MAC that 
runs on PCI?

Or am I making a whole lot of work for myself and I should just make them 
separate drivers?  I'm trying to keep the code base as small and coherent 
as possible.  I don't want to have to maintain multiple copies of a driver 
that are essentially identical.

Thanks.

Bruce
