Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CCA65B7172
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 02:51:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5TGpYcu010742 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 09:51:34 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n5TGpX3T024096
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 11:51:33 -0500 (CDT)
Date: Mon, 29 Jun 2009 11:51:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: PCI device support in Open Firmware (device tree syntax)
Message-ID: <20090629165133.GC1323@b07421-ec1.am.freescale.net>
References: <cb9ecdfa0906290858x125b8149na037f33258c21426@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cb9ecdfa0906290858x125b8149na037f33258c21426@mail.gmail.com>
Cc: kernelnewbies@nl.linux.org, linuxppc-dev@lists.ozlabs.org,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 29, 2009 at 11:58:22PM +0800, Johnny Hung wrote:
> Hi all,
>     I am working in customized Freescale MPC8313 board. There are two
> PCI devices (Broadcom Switch) in PCI bus.
> Each PCI device has its configuration space. It contains
> vendor/product ID (RO)..., and important information, likes BARs
> (Base Address), INT line and IRQ(RW). These resources (BAR, INT, IRQ)
> is assigned from BIOS in x86 arch.
>     My problem is how to assign PCI device resources in device tree. I
> can't find exist dts file as an example. I have read the
> http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
> file. It's described detailed about device tree
> except PCI device. So, anyone give me a hint or sany tuff is appreciated.
>    I think Linux Kernel parses device tree and get the PCI device
> resources information then write into PCI configuration space.
> So PCI device driver do pci_register_driver (get resource) and do
> itself probe for PCI device. Is it right? CMIIAW

With flat device trees, PCI devices are not typically included as they
can be probed instead.  Interrupt mapping is conveyed by the
interrupt-map property in the PCI controller node.

-Scott
