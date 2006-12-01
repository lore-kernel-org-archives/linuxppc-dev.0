Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7A9667BD5
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 09:19:52 +1100 (EST)
Subject: Re: pata_sl82c105 can not reserve IO region
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061201221525.7a741062@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de> <20061201183355.GA9701@aepfle.de>
	<45707CF8.3090106@ru.mvista.com>
	<1165010029.22108.10.camel@localhost.localdomain>
	<20061201221525.7a741062@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 09:19:43 +1100
Message-Id: <1165011583.22108.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I don't think that is the problem. pci_request_regions() handles all
> this internally. It is incorrect for me to not request BAR 5
> if present as nobody else should use that resource with my driver loaded.
>
> The underlying problem appears to be that PPC64 isn't setting up the
> resources properly (at least as viewed by the pci core code). If a
> resource is not set up then pci_request_resource() correctly handles
> it .. except on PPC64. You have a resource at zero with a length and
> type. PPC64 is not reporting to the upper layers that the resource was
> not allocated. It is reporting that the resource *was* allocated, and at a
> bogus address of zero.
> 
> If you trust the firmware that is fine, but you need to report the truth,
> at which point pci_request_resources() will work correctly.

We don't have a choice but to trust the firmware on those machines. We
can't assign things ourselves on most of them for various reasons (in
many cases, the hypervisor won't let us).

So you suggest that I clear resource->flags in that case ?

I think part of the problem is a firmware bug in that the firmware data
actually decodes to BAR 5 is assigned to address 0 ... I suppose we can
consider that address 0 is never valid on those machines and consider
that as unassigned but it's a bit dodgy.. Or maybe a PCI quirk in the
pSeries code would be best.

Ben.
