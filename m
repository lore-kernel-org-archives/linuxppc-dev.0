Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6D31A2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:28:53 +1000 (EST)
Message-ID: <1380270519.27811.10.camel@pasglop>
Subject: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2013 18:28:39 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Yinghai Lu <yinghai@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus, Yinghai !

Please consider reverting:

928bea964827d7824b548c1f8e06eccbbc4d0d7d
PCI: Delay enabling bridges until they're needed

(I'd suggest to revert now and maybe merge a better patch later)

This breaks PCI on the PowerPC "powernv" platform (which is booted via
kexec) and probably x86 as well under similar circumstances. It will
basically break PCIe if the bus master bit of the bridge isn't set at
boot (by the firmware for example, or because kexec'ing cleared it).

The reason is that the PCIe port driver will call pci_enable_device() on
the bridge (on everything under the sun actually), which will marked the
device enabled (but will not do a set_master).

Because of that, pci_enable_bridge() later on (called as a result of the
child device driver doing pci_enable_device) will see the bridge as
already enabled and will not call pci_set_master() on it.

Now, this could probably be fixed by simply doing pci_set_master() in
the PCIe port driver, but I find the whole logic very fragile (anything
that "enables" the bridge without setting master or for some reason
clears master will forever fail to re-enable it).

Maybe a better option is to unconditionally do pci_set_mater() in
pci_enable_bridge(), ie, move the call to before the enabled test.

However I am not too happy with that either. My experience with bridges
is that if bus master isn't set, they will also fail to report AER
errors and other similar upstream transactions. We might want to get
these reported properly even if no downstream device got successfully
enabled.

So I think the premises of the patches are flawed, at least on PCI
express, and we should stick to always enabling bridges (at least the
bus master bit on them).

Cheers,
Ben.
