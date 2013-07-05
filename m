Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA5252C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 08:37:02 +1000 (EST)
Message-ID: <1373063807.4446.10.camel@pasglop>
Subject: Re: [PATCH 1/8] PCI: Add pcibios_stop_dev()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 06 Jul 2013 08:36:47 +1000
In-Reply-To: <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
 <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-05 at 12:49 -0600, Bjorn Helgaas wrote:
> We already have pcibios_release_device() (just merged for v3.11).
> Would that work for you?  I haven't seen your whole series, so I can't
> tell whether you need something different.

Maybe... Gavin's original hook applies when the device is removed
from the tree, your new hook when the refcount expires and the
structure is about to be freed...

I *suspect* that's fine but I'll need to have a closer look (or wait
for Gavin to be back from vacation :-)

BTW. One thing we do in EEH is that if we get an error and the driver
for the device doesn't implement recovery, we simulate a hotplug.

IE. We unplug the device (currently removing it), reset it (or the
bus it's on, whatever applies, which lifts the fence established by
the EEH hardware), and re-plug it.

The current method really removes the device from the PCI subsystem,
and "plugs" it back. IE. We rescan the slot, and might even end up
re-assigning resources, which I'm not too fan about. It's also unclear
what quirks gets called in that re-plug case, etc...

I'm wondering whether it might be better to keep the pci_dev around,
just mark it blocked for user access, unbind the driver, reset, restore
the BARs to their original values, unblock and re-bind.

What's your take on this ?

Cheers,
Ben.
