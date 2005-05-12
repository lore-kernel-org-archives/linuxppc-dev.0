Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 83C0867A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 19:53:55 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4C9waKU026948
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 12:58:37 +0300 (EEST)
Message-ID: <428323C9.8070608@intracom.gr>
Date: Thu, 12 May 2005 12:37:13 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
	<f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
	<20050510062744.A21835@cox.net> <4280B3CB.8030007@intracom.gr>
	<20050510064702.B21835@cox.net>
In-Reply-To: <20050510064702.B21835@cox.net>
Content-Type: multipart/mixed; boundary="------------020001010402000700060002"
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020001010402000700060002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Porter wrote:
> On Tue, May 10, 2005 at 04:14:51PM +0300, Pantelis Antoniou wrote:
> 
>>Matt Porter wrote:
>>
>>>On Tue, May 10, 2005 at 08:13:48AM -0400, Dan Malek wrote:
>>>
>>>
>>>>On May 10, 2005, at 7:17 AM, Pantelis Antoniou wrote:
>>>>
>>>>
>>>>
>>>>>This patch replace iopa use with virt_to_phys.
>>>>
>>>>Not gonna work .....
>>>>
>>>>When you map uncached on 8xx you get a new vmalloc()
>>>>space.  The virt_to_xxx macros don't work on those addresses.
>>>>You need to use the dma_consistent() function, stash the
>>>>real physical address it returns and then use it where
>>>>appropriate.
>>>
>>>
>>>That and the use of virt_to_* and friends is deprecated by
>>>the DMA API. You'll never get that upstream even if it were
>>>a case where it did work.  That's a good thing to know for
>>>anybody doing other drivers...
>>>
>>>-Matt
>>>
>>>
>>
>>OK then.
>>
>>What's the recommended function to call to go from a
>>virtual -> physical address, but without doing a cache
>>flush/invalidate?
> 
> 
> There is no generic function to do that in a driver since
> no mainstream drivers in the kernel need to do it. Generally
> you can rework the driver such that you cache the DMA address
> as Dan suggested already.  I don't know your exact usage, however,
> you can allocate memory with dma_alloc_noncoherent() that is
> cached on ppc32 NOT_CACHE_COHERENT prcoessors and stash the
> dma_addr_t/void * for later use. The other way is to kmalloc and
> dma_map_single() (stashing the same way) which is basically the
> same thing.
> 
> Do you have a case where this doesn't work?
> 
> -Matt
> 
> 

Here is the final (I hope) fix.

This patch kills iopa/virt_to_phys usage by using the returned
physical address from the DMA API.

Comments?

Regards

Pantelis


--------------020001010402000700060002
Content-Type: text/x-patch;
 name="fs_enet-iopa-kill.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet-iopa-kill.patch"

Index: linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fcc.c
===================================================================
--- linux-2.6.11.7-fs_enet.orig/drivers/net/fs_enet/mac-fcc.c
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fcc.c
@@ -212,8 +212,10 @@ static void restart(struct net_device *d
 {
 	cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
 	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
 	fcc_t *fccp = fep->fcc.fccp;
 	fcc_enet_t *ep = fep->fcc.ep;
+	dma_addr_t rx_bd_base_phys, tx_bd_base_phys;
 	__u16 paddrh, paddrm, paddrl;
 	__u16 mem_addr;
 	const unsigned char *mac;
@@ -225,9 +227,13 @@ static void restart(struct net_device *d
 	for (i = 0; i < sizeof(*ep); i++)
 		__fcc_out8((char *)ep + i, 0);
 
+	/* get physical address */
+	rx_bd_base_phys = fep->ring_mem_addr;
+	tx_bd_base_phys = rx_bd_base_phys + sizeof(cbd_t) * fpi->rx_ring;
+
 	/* point to bds */
-	W32(ep, fen_genfcc.fcc_rbase, iopa((__u32)fep->rx_bd_base));
-	W32(ep, fen_genfcc.fcc_tbase, iopa((__u32)fep->tx_bd_base));
+	W32(ep, fen_genfcc.fcc_rbase, rx_bd_base_phys);
+	W32(ep, fen_genfcc.fcc_tbase, tx_bd_base_phys);
 
 	/* Set maximum bytes per receive buffer.
 	 * It must be a multiple of 32.
Index: linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
===================================================================
--- linux-2.6.11.7-fs_enet.orig/drivers/net/fs_enet/mac-fec.c
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
@@ -271,6 +271,7 @@ static void restart(struct net_device *d
 	struct fs_enet_private *fep = netdev_priv(dev);
 	fec_t *fecp = fep->fec.fecp;
 	const struct fs_platform_info *fpi = fep->fpi;
+	dma_addr_t rx_bd_base_phys, tx_bd_base_phys;
 	int r;
 	__u32 addrhi, addrlo;
 
@@ -303,11 +304,15 @@ static void restart(struct net_device *d
 	FW(fecp, r_buff_size, PKT_MAXBLR_SIZE);
 	FW(fecp, r_hash, PKT_MAXBUF_SIZE);
 
+	/* get physical address */
+	rx_bd_base_phys = fep->ring_mem_addr;
+	tx_bd_base_phys = rx_bd_base_phys + sizeof(cbd_t) * fpi->rx_ring;
+
 	/*
 	 * Set receive and transmit descriptor base. 
 	 */
-	FW(fecp, r_des_start, iopa((__u32)fep->rx_bd_base));
-	FW(fecp, x_des_start, iopa((__u32)fep->tx_bd_base));
+	FW(fecp, r_des_start, rx_bd_base_phys);
+	FW(fecp, x_des_start, tx_bd_base_phys);
 
 	fs_init_bds(dev);
 

--------------020001010402000700060002--
