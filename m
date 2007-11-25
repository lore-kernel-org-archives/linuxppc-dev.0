Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3ACC2DDECB
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 08:34:39 +1100 (EST)
Subject: Re: Access to PCI Expansion ROMs on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711251324y5116d90pab54a1a033d024e3@mail.gmail.com>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<1196022000.7195.70.camel@pasglop>
	<9e4733910711251324y5116d90pab54a1a033d024e3@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 08:34:06 +1100
Message-Id: <1196026446.7195.76.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You can dump the PCI config block in /sys with hexdump and see if the
> PCI_COMMAND_MEMORY bit is set. I was also unable to locate where in
> the kernel PCI_COMMAND_MEMORY is being set. It could be that it is set
> by the BIOS at boot on the x86 and not on the ppc.

The kernel doesn't until somebody calls pci_enable_device(). So yes,
that's likely to be your problem.

Ben.
