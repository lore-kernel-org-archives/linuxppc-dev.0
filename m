Return-Path: <minyard@acm.org>
Received: from vms173019pub.verizon.net (vms173019pub.verizon.net
	[206.46.173.19]) by ozlabs.org (Postfix) with ESMTP id 9206DB7D3A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jan 2010 12:04:36 +1100 (EST)
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
	by vms173019.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0KX100B339IW4R51@vms173019.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Fri, 29 Jan 2010 18:04:08 -0600 (CST)
Received: from i2 (i2.minyard.local [192.168.27.126])
	by wf-rch.minyard.local (Postfix) with ESMTP id 096BF1F843	for
	<linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 18:04:08 -0600 (CST)
Date: Fri, 29 Jan 2010 18:04:07 -0600
From: Corey Minyard <minyard@acm.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add DMA mask to MPSC serial and network and UART
	device to serial
Message-id: <20100130000407.GA16156@minyard.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Corey Minyard <cminyard@mvista.com>

The MPSC drivers that use DMA need to set coherent_dma_mask to allow
dma_alloc_xxx routines to work properly.  Also, the mpsc serial driver
needed to set pi->port.dev to register properly.  With these fixes,
the MPSC drivers seem to work again.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I'm not really sure about where to set the coherent_dma_mask, it seems
like a more general place would be better but I couldn't find it.

Without these, the console stops working after the switchover and
the network driver fails to allocate buffers.  With these, my board
boots up and works fine.

Index: linux-2.6.31/drivers/serial/mpsc.c
===================================================================
--- linux-2.6.31.orig/drivers/serial/mpsc.c
+++ linux-2.6.31/drivers/serial/mpsc.c
@@ -2071,6 +2071,9 @@ static int mpsc_drv_probe(struct platfor
 		if (!(rc = mpsc_drv_map_regs(pi, dev))) {
 			mpsc_drv_get_platform_data(pi, dev, dev->id);
 
+			dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+			pi->port.dev = &dev->dev;
+
 			if (!(rc = mpsc_make_ready(pi))) {
 				spin_lock_init(&pi->tx_lock);
 				if (!(rc = uart_add_one_port(&mpsc_reg,
Index: linux-2.6.31/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6.31.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6.31/drivers/net/mv643xx_eth.c
@@ -2916,7 +2916,7 @@ static int mv643xx_eth_probe(struct plat
 	mp->shared = platform_get_drvdata(pd->shared);
 	mp->base = mp->shared->base + 0x0400 + (pd->port_number << 10);
 	mp->port_num = pd->port_number;
-
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	mp->dev = dev;
 
 	set_params(mp, pd);
