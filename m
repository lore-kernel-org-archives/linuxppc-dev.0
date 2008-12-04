Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80191DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 09:54:12 +1100 (EST)
Subject: Re: PCI Resource allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepak Pandian <peerlessdeepaks@gmail.com>
In-Reply-To: <cbaa36330812041036u751ea939qc0aea60002655d07@mail.gmail.com>
References: <cbaa36330812041036u751ea939qc0aea60002655d07@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 05 Dec 2008 09:54:04 +1100
Message-Id: <1228431244.10722.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-12-05 at 00:06 +0530, Deepak Pandian wrote:
> Hi,
> 
> In ppc4xx_pci i see the pci size to be declared as
>  u32 lah, lal, pciah, pcial, sa;

I think the 4xx code is pretty much ok at this stage no ?

> Also at many other places I see the pci region is not capable of
> handling resources > 4GB. I am planning to work on this arch specific
> code to make it handle pci resource of width greater than 4 GB.

Which "many other places" ?

> But before that i wanted to clarify whether the core kernel will be
> able to handle pci regions with width greater than  4GB.

There's at least one place in the generic PCI code, in
pci_read_bridge_bases(), that needs fixing in a similar way as we
already fixed __pci_read_base(), ie by testing the resource_size_t size
rather than whether the platform is 64-bit.

There might be a few more.

Cheers,
Ben.
