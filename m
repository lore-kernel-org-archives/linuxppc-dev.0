Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C882EB718B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:10:53 +1000 (EST)
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0906161756j4b701abfj2a8908b9c93ddd04@mail.gmail.com>
References: <4A37DB0F.7060801@freescale.com>
	<200906162002.12376.arnd@arndb.de> <1245197925.21602.0.camel@pasglop>
	<20090617093654B.fujita.tomonori@lab.ntt.co.jp>
	<c384c5ea0906161756j4b701abfj2a8908b9c93ddd04@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 11:08:32 +1000
Message-Id: <1245200912.21602.2.camel@pasglop>
Mime-Version: 1.0
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	scottwood@freescale.com, chris.pringle@oxtel.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-17 at 02:56 +0200, Leon Woestenberg wrote:
> I use pci_map_sg(), have the device perform either DMA master reads or
> writes to the bus address using PCIe.
> After that, I use pci_unmap_sg().
> 
> My assumption is that pci_unmap_sg() either makes the cache coherent
> or invalidated and thus I do not need to take further actions.
> This is on a MPC83xx or 85xx system.
> 
> Is this assumption correct?

It is, as far as I understand things :-) Those APIs are fun.

You should only need the explicit sync calls if you are going to peek or
poke at the DMA mapped memory before you unmap it.

Cheers,
Ben.
