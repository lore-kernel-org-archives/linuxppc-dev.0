Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92D71B6F0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 09:58:20 +1000 (EST)
Subject: Re: [RFC/PATCH] of: Match PCI devices to OF nodes generically
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <BANLkTimBD=NfFKGpy0ZTnT9Dcu=dkTHxZg@mail.gmail.com>
References: <1301882694.2549.53.camel@pasglop>
	<1301887630.2549.71.camel@pasglop> <1301902664.2549.76.camel@pasglop>
	<BANLkTimBD=NfFKGpy0ZTnT9Dcu=dkTHxZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 09:58:08 +1000
Message-ID: <1301961488.2549.105.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-04 at 09:25 -0600, Bjorn Helgaas wrote:
> Some of this is reminiscent of the ACPI/PCI binding we do on x86/ia64,
> e.g., acpi_get_pci_dev() and the stuff in drivers/acpi/glue.c.  Have
> you looked at that to see if there's any hope of covering both OF and
> ACPI with something more generic?

Hrm, the ACPI stuff is quite different (to some extent akin to what
power used to do) form what I can tell. You basically traverse the ACPI
tree do perform a matching after the fact.

The idea with my patch is really to populate things as they get
discovered, which makes the code much simpler. Since we have the pointer
to the OF device node in the generic struct device nowadays, if we
populate things that way, by the time we discover a device we already
have at hand the OF device node of the parent bus, so it's a
single/simpler one level search to locate the device itself and populate
it's node as well, done once for all.

I suppose you could do something similar for ACPI, but I wouldn't try to
make a "common infrastructure" at that point, especially since there is
the possibility on x86 to have both OF device-trees and ACPI :-)

Note that I don't really provide a direct/good equivalent of your
acpi_get_pci_dev() ... the matching is mostly used the other way around,
ie a driver for a pci_dev wanting to peek a some properties in the
corresponding OF device_node. ppc32 has some reverse mapping stuff but
it's pretty crappy (and on my to-fixup list for after that patch goes
in) and in fact it would be reasonably easy from now on to implement it
as well, but so far there is no real demand.

Cheers,
Ben.
