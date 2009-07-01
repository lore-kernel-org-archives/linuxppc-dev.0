Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 53EB1B7107
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 08:16:12 +1000 (EST)
Subject: Re: PCI device support in Open Firmware (device tree syntax)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johnny Hung <johnny.hacking@gmail.com>
In-Reply-To: <cb9ecdfa0906300033x4dfcc315gfd67522b77f6004a@mail.gmail.com>
References: <cb9ecdfa0906290858x125b8149na037f33258c21426@mail.gmail.com>
	<20090629165133.GC1323@b07421-ec1.am.freescale.net>
	<cb9ecdfa0906291836mf74c41fn9c187e305771920a@mail.gmail.com>
	<2ea1731b0906292329t30cdc9a6q1fc36dc2273a2931@mail.gmail.com>
	<cb9ecdfa0906300033x4dfcc315gfd67522b77f6004a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:15:57 +1000
Message-Id: <1246486557.14483.16.camel@pasglop>
Mime-Version: 1.0
Cc: Marco Stornelli <marco.stornelli@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> You are right. u-boot do PCI device BAR resources assign and flat
> device tree describe PCI device interrupt-map. I use "lspci -s xxx -x"
> for the PCI device, the resources was assigned properly.

Note that the device-tree -can- contain PCI devices, but it's not
mandatory.

If your bootloader does the probing and configuration of the PCI bus, it
might be a good idea for that bootloader to also create the PCI device
nodes in the tree, since this will allow in a near future the kernel to
"instanciate" them from that tree instead of probing with config space,
which is faster and more reliably. (Currently only ppc64 does that but
it will become generic soon).

Cheers,
Ben.
