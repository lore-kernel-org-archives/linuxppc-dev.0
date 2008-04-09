Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43866DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 23:23:27 +1000 (EST)
Received: from kiwi.ptxnet.pengutronix.de ([10.1.0.84])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <sha@pengutronix.de>) id 1JjZyb-0004DL-Aq
	for linuxppc-dev@ozlabs.org; Wed, 09 Apr 2008 15:04:33 +0200
Received: from sha by kiwi.ptxnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1Jja0A-0003bk-4K
	for linuxppc-dev@ozlabs.org; Wed, 09 Apr 2008 15:06:10 +0200
Date: Wed, 9 Apr 2008 15:06:10 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] FCC: fix confused base / offset
Message-ID: <20080409130610.GE10465@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

This patch fixes a mixup in struct fs_platform_info. The struct has a field
dpram_offset which really is no offset but an io pointer to the dpram
(casted to u32).
It also has a field mem_offset which is used as the offset from the dpram
to the fcc RAM but then in turn filled into fcc.mem (casted to void __iomem *)

This patch fixes this in the way that dpram_offset holds the offset to the
fcc dpram as the name suggests and the mem_offset field is renamed to mem of
type void __iomem *.

This way we get rid of some #ifdefs and type casts.


Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 2c5388c..578ced2 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -837,13 +837,13 @@ static int __init fs_enet_of_init(void)
 			int fcc_index = *id - 1;
 			const unsigned char *mdio_bb_prop;
 
-			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
+			fs_enet_data.dpram_offset = FCC_MEM_OFFSET(fcc_index);
 			fs_enet_data.rx_ring = 32;
 			fs_enet_data.tx_ring = 32;
 			fs_enet_data.rx_copybreak = 240;
 			fs_enet_data.use_napi = 0;
 			fs_enet_data.napi_weight = 17;
-			fs_enet_data.mem_offset = FCC_MEM_OFFSET(fcc_index);
+			fs_enet_data.mem = cpm_dpram_addr(0);
 			fs_enet_data.cp_page = CPM_CR_FCC_PAGE(fcc_index);
 			fs_enet_data.cp_block = CPM_CR_FCC_SBLOCK(fcc_index);
 
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index e363211..1659ac7 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -157,7 +157,7 @@ out:
 	if (fep->fcc.fcccp == NULL)
 		return -EINVAL;
 
-	fep->fcc.mem = (void __iomem *)fep->fpi->mem_offset;
+	fep->fcc.mem = fep->fpi->mem;
 	if (fep->fcc.mem == NULL)
 		return -EINVAL;
 
@@ -304,9 +304,6 @@ static void restart(struct net_device *dev)
 	fcc_enet_t __iomem *ep = fep->fcc.ep;
 	dma_addr_t rx_bd_base_phys, tx_bd_base_phys;
 	u16 paddrh, paddrm, paddrl;
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-	u16 mem_addr;
-#endif
 	const unsigned char *mac;
 	int i;
 
@@ -338,19 +335,10 @@ static void restart(struct net_device *dev)
 	 * this area.
 	 */
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 	W16(ep, fen_genfcc.fcc_riptr, fpi->dpram_offset);
 	W16(ep, fen_genfcc.fcc_tiptr, fpi->dpram_offset + 32);
 
 	W16(ep, fen_padptr, fpi->dpram_offset + 64);
-#else
-	mem_addr = (u32) fep->fcc.mem;	/* de-fixup dpram offset */
-
-	W16(ep, fen_genfcc.fcc_riptr, (mem_addr & 0xffff));
-	W16(ep, fen_genfcc.fcc_tiptr, ((mem_addr + 32) & 0xffff));
-
-	W16(ep, fen_padptr, mem_addr + 64);
-#endif
 
 	/* fill with special symbol...  */
 	memset_io(fep->fcc.mem + fpi->dpram_offset + 64, 0x88, 32);
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 9bc045b..70080a0 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -128,7 +128,7 @@ struct fs_platform_info {
 	u32 clk_route;
 	u32 clk_mask;
 
-	u32 mem_offset;
+	void __iomem *mem;
 	u32 dpram_offset;
 	u32 fcc_regs_c;
 	

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
