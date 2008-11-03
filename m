Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1922ADDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 00:48:13 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: benh@kernel.crashing.org
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Mon, 3 Nov 2008 14:45:00 +0100
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811031010.33250.matthias.fuchs@esd-electronics.com>
	<1225709863.8004.252.camel@pasglop>
In-Reply-To: <1225709863.8004.252.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811031445.00963.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 November 2008 11:57, Benjamin Herrenschmidt wrote:
> On Mon, 2008-11-03 at 10:10 +0100, Matthias Fuchs wrote:
> > 
> > Adding this interrupt to the PCI node would make (logical) sense. But
> > on PCI adapter (add-in cards) designs we typically disable the PCI node
> > of the DT to disable PCI PnP. This should not prevent us from adding the
> > interrupt to the node but it looks a little bit weird to take an interrupt
> > from a disabled node, right?
> 
> You can make a pci-endpoint node that isn't detected as a host bridge.
> In fact, I think we have some way to even tell in the DT not to activate
> host bridge function on 44x nowadays no ? I dont remember for sure but
> it's easy enough to add.
We have endpoint support for PCIe and the possibility to disable PCI through the status
attribute.
> 
> > > the actual PCI bridge, then you can stick an interrupts property in the
> > > PCI host bridge node in the DT just fine.
> > The PCI node already contains the interrupt-map for the PCI interrupts.
> 
> Only relevant for master, not endpoint.
> 
> > Doesn't adding a further interrupt property cause some trouble with the PCI interrupts?
> 
> Not for endpoint.
I see.

I will try to add endpoint support for PCI as well. I would like to have a single PCI node and
let the device_type attribute decide if we are running in hostbridge or endpoint mode.

Matthias
