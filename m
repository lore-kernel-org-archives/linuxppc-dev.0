Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tFlpY0T8WzDrBv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 03:33:24 +1100 (AEDT)
Date: Fri, 11 Nov 2016 16:32:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 devicetree@vger.kernel.org, marc.zyngier@arm.com,
 frowand.list@gmail.com, robh+dt@kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
Message-ID: <20161111163241.GL11945@leverpostej>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161109190457.GC837@leverpostej>
 <1478813443.2592.2.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1478813443.2592.2.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 11, 2016 at 08:30:43AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2016-11-09 at 19:04 +0000, Mark Rutland wrote:
> > 
> > If we don't have an interrupt-map on a PCI controller, why don't we
> > instead log a message regarding that being missing, and give up
> > early?
> 
> Why ? It's legit to not support LSIs.

Sure; I had envisioned a message like:

	pr_info("%s: no interrupt-map, INTx interrupts not possible\n",
		pci_controller_name);

... Which tells the user exaclty what we know, and doesn't imply either
an error or the actual absence of HW support.

> > That sounds like a more generically useful error message; it's also
> > possible that a DT author simply forgot to add the map, and the
> > platform has suitable interrupts wired up.
> 
> But it's not necessarily an error...

Sure, "error" was a misnomer.

> > > This patch introduces a different message for this specific case,
> > > and it also reduces the level of the message from error to warning.
> > > Before this patch, when an adapter was plugged in a slot without
> > Level
> > > interrupts capabilities, we saw generic error messages like this:
> > > 
> > >     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-
> > 22
> > > 
> > > Now, with this applied, we see the following specific message:
> > > 
> > >     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot
> > of this
> > >     device has no Level-triggered Interrupts capability.
> > 
> > Following my above example, this has gone from opaque to potentially
> > misleading
> 
> I'm not sure. At least for some of our platforms this is the correct
> message :-) Our Hypervisor doesn't allow LSIs on some slots.
> 
> I think it's not that misleading. It's obvious something is wrong with
> LSIs, which you can easily figure out from there.

As above, I think it's clearer to log that there's no interrupt-map for
the controller. 

Orthogonal to that, "INTx" is a more generally understood name for the
legacy wired PCI interrupts, and is probably preferable in generic code.

Thanks,
Mark.
