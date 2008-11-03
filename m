Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 46DE9DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 20:12:04 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: benh@kernel.crashing.org
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Mon, 3 Nov 2008 10:10:33 +0100
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<1225397712.8004.173.camel@pasglop>
In-Reply-To: <1225397712.8004.173.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811031010.33250.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Thursday 30 October 2008 21:15, Benjamin Herrenschmidt wrote:
> On Thu, 2008-10-30 at 11:58 +0100, Matthias Fuchs wrote:
> > I need to connect to the "PCI command write" interrupt on a 440EPx
> > platform. This is UIC0/int#5.
> > 
> > Where should I add this interrupt in the DT? To the PCI node? In this
> > case it will collide with the 
> > PCI interrupts.
> > 
> > My application is a 440EPx on a PCI addon card. So the PCI node is
> > disabled in the DT.
> > 
> > Is there a way to get an interrupt number for request_irq() without
> > querying the DT?
> 
> What is this interrupt precisely ? What emits it ? If it's coming from
The interrupt is emitted by the pci bridge when someone writes to the 
PCI_COMMAND register. We use it on PCI adapter hardware where the CPU is 
not the system CPU. In this case a "host" driver writes to the adapter's
PCI_COMMAND register to trigger a remote interrupt that is handled by a 
special pci communication driver.

Adding this interrupt to the PCI node would make (logical) sense. But
on PCI adapter (add-in cards) designs we typically disable the PCI node
of the DT to disable PCI PnP. This should not prevent us from adding the
interrupt to the node but it looks a little bit weird to take an interrupt
from a disabled node, right?
> the actual PCI bridge, then you can stick an interrupts property in the
> PCI host bridge node in the DT just fine.
The PCI node already contains the interrupt-map for the PCI interrupts.
Doesn't adding a further interrupt property cause some trouble with the PCI interrupts?

Matthias
> 
> Cheers,
> Ben.
> 
