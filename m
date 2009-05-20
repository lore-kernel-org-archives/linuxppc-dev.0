Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1837DE172
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 13:01:43 +1000 (EST)
Subject: Re: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 13:01:30 +1000
Message-Id: <1242788490.16901.133.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>,
	John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-19 at 09:28 -0600, Grant Likely wrote:

> 1) Probe the host controller in an of_platform driver.  This has the
> advantage of simplicity.  The probe routine will get automatically
> called when the PCI host controller device tree node is registered
> with the of_platform bus.  The bus parenthood also gets reflected in
> the device model and sysfs.  The disadvantage is that it defers PCI
> bus probing until after the of_platform bus is probed (maybe this is
> okay; maybe this already happens anyway).

We are doing that on Cell as mentioned by Arnd. However, there are a
few issues with that approach. One is that it relies on PCI-hotplug
related bits that currently only exist in 64-bit land. Another is
that doing so tends to expose various hidden issues or subtle
dependencies to the PCI stuff being setup early and probed early.

For example, some of the OF parsing bits may fail to convert memory
addresses to IO addresses if the PCI host bridges have not been
discovered yet, potentially causing issues with matching of resources
between the early serial stuff and the generic serial driver (if you
use an IO driven UART, the PCI 8250 driver may not properly figure out
that what it's finding in its IO BARs is actually the same port as
what it gets from the platform code as the later will end up with
memory addresses rather than IO ones). That's one example.

At this stage, I much prefer if we stick to doing the PHB discovery
at setup_arch() time, especially since there's other WIP in the area
of PCI coming from Kumar and I don't want to mixup multiple source of
problems in that area at the same time.

We can revisit that later but we'll have to be very careful.

Cheers,
Ben.
