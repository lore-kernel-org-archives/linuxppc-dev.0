Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.TU-Cottbus.De
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id A288E67B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 18:46:04 +1000 (EST)
Message-ID: <453DCB17.6050304@s5r6.in-berlin.de>
Date: Tue, 24 Oct 2006 10:13:11 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain>
	<1161675611.10524.598.camel@localhost.localdomain>
In-Reply-To: <1161675611.10524.598.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux1394-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Recently, ohci1394 grew some "proper" error handling in its suspend
>> function, something that looks like:
>> 
>>         err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
>>         if (err)
>>                 goto out;
...
> First, it breaks some old PowerBooks where the internal OHCI has no PM
> feature exposed on PCI....

Just out of curiosity: Are these HCs actual PCI hardware or are they
glued onto an extra PCI interface? Does the startup message of ohci1394
log OHCI 1.1 or 1.0 compliance for them? Probably the latter; OHCI 1.1
was released in January 2000.

OHCI 1.1 says "PCI based 1394 Open Host Controllers /should/ implement
PCI Power Management, and implementations that support PCI Power
Management /shall/ exhibit behavior consistent with this Annex."
(Emphasis mine.) I.e. a compliant HC does either not support power
management at all or supports it including the pci_set_power_state()
triggered state transitions.

OHCI 1.00 does not have a power management specification. It points to
the PCI Local Bus Specification Revision 2.1 though (which I don't have).

We are still working on full power management support by ohci1394 and
upper IEEE 1394 layers, so I am glad to get feedback and patches.
-- 
Stefan Richter
-=====-=-==- =-=- ==---
http://arcgraph.de/sr/
