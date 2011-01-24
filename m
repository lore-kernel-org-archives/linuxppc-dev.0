Return-Path: <scottwood@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 957B4B7126
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2011 09:44:36 +1100 (EST)
Date: Mon, 24 Jan 2011 16:44:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: FSL DMA engine transfer to PCI memory
Message-ID: <20110124164423.24d2fbc1@udp111988uds.am.freescale.net>
In-Reply-To: <4D3DF36A.5050609@embedded-sol.com>
References: <4D3DF36A.5050609@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Jan 2011 23:47:22 +0200
Felix Radensky <felix@embedded-sol.com> wrote:

> static int dma_transfer(struct dma_chan *chan, void *dst, void *src, 
> size_t len)
> {
>      int rc = 0;
>      dma_addr_t dma_src;
>      dma_addr_t dma_dst;
>      dma_cookie_t cookie;
>      struct completion cmp;
>      enum dma_status status;
>      enum dma_ctrl_flags flags = 0;
>      struct dma_device *dev = chan->device;
>      struct dma_async_tx_descriptor *tx = NULL;
>      unsigned long tmo = msecs_to_jiffies(FPGA_DMA_TIMEOUT_MS);
> 
>      dma_src = dma_map_single(dev->dev, src, len, DMA_TO_DEVICE);
>      if (dma_mapping_error(dev->dev, dma_src)) {
>          printk(KERN_ERR "Failed to map src for DMA\n");
>          return -EIO;
>      }
> 
>      dma_dst = (dma_addr_t)dst;

Why are you casting a virtual address to dma_addr_t?

> The destination address is PCI memory address returned by 
> pci_ioremap_bar().

You need the physical address.

-Scott
