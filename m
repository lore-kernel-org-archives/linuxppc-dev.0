Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C35CEDDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 16:51:46 +1100 (EST)
Date: Thu, 13 Mar 2008 14:51:18 +0900 (JST)
Message-Id: <20080313.145118.-1300525892.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 10/11] celleb: add support for PCI Express
In-Reply-To: <200803051249.28739.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 March 2008, Ishizaki Kou wrote:
> > This patch adds support for PCI Express port on Celleb. I/O space
> > of this PCI Express port is not mapped in memory space. So we use
> > the io-workaround mechanism to make accesses indirect.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> This one looks good, but I wonder if we should make it possible to
> also use it on QS20, which the current code doesn't allow.
> 
> It's a rather hypothetical question, because QS20 has been replaced
> by QS21 as a product and it never supported PCIe cards with I/O space
> mappings, but it would be the "right" thing to do.
> 
> Since you don't have the QS20 hardware to test that, and I currently
> doubt anyone at IBM has the energy to do the work, it will probably
> never get done. If you send another version of the patch, maybe you
> can add comments to hint that this is actually possible, just hasn't
> been implemented.

Sorry, I don't know about QS20 and its chipset. However, if anyone
changes the code to work also on QS20, I'll welcome the change and
test it on Celleb.

Though I don't know it helps you, I explain a little about Celleb.

The way to access SCC PCIe I/O port is the same as the way to access
its config space.
 - Write an address to the address register.
 - Write an 'I/O port write' or 'I/O port read' command with byte
   enable bits to the command register.
 - Write or Read the data register.
That's all, and you can find this in my code.


By the way, I found a minor bug in my patch. I'll send fixed one.

> +	dummy_page_da = dma_map_single(bus->phb->parent, dummy_page_va,
> +			PAGE_SIZE, DMA_FROM_DEVICE);
> +	if (dummy_page_da == DMA_FROM_DEVICE) {

Comparing with DMA_FROM_DEVICE is wrong. We should compare with
DMA_ERROR_CODE. And using dma_mapping_error() is the right way.


Best regards,
Kou Ishizaki
