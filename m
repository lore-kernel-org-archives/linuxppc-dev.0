Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF8A8DDECE
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 10:07:08 +1000 (EST)
Subject: Re: [PATCH 5/7] Enable MSI mappings for MPIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <0846c0d8efafe7258075826b9c869fea@bga.com>
References: <20070419073555.01990DDECB@ozlabs.org>
	<0846c0d8efafe7258075826b9c869fea@bga.com>
Content-Type: text/plain
Date: Sun, 22 Apr 2007 10:06:50 +1000
Message-Id: <1177200410.6080.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This is just begging to be written in terms of 
> pci_bus_find_ht_capability.  Well,
> we have pci_bus_find_capability, and pci_find_ht_capability, I'm sure 
> we could
> create that.   It also means this and the other nearby functions want 
> to be
> written in terms of a struct pci_bus and config accessors.

A lot of that code has to run way before the PCI config stuff is even
useable and certainly before the PCI layer data structures have been
created.... Sucks but that's how it is for now. We might be able to
tweak and delay init of the APICs etc... but I don't think I can be
bothered for now as it's a bit of a corner case.

Ben.
