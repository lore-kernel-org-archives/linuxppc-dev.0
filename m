Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 751031A0AFE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 16:36:01 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 agraf@suse.de
Subject: [PATCH 1/5] powerpc: Move Power Macintosh drivers to generic
 byteswappers
Date: Tue,  3 Feb 2015 16:36:21 +1100
Message-Id: <1422941785-22557-2-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mdroth@us.ibm.com, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc has special instruction forms to efficiently load and store values
in non-native endianness.  These can be accessed via the arch-specific
{ld,st}_le{16,32}() inlines in arch/powerpc/include/asm/swab.h.

However, gcc is perfectly capable of generating the byte-reversing
load/store instructions when using the normal, generic cpu_to_le*() and
le*_to_cpu() functions eaning the arch-specific functions don't have much
point.

Worse the "le" in the names of the arch specific functions is now
misleading, because they always generate byte-reversing forms, but some
ppc machines can now run a little-endian kernel.

To start getting rid of the arch-specific forms, this patch removes them
from all the old Power Macintosh drivers, replacing them with the
generic byteswappers.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/dbdma.h  | 12 ++++----
 arch/powerpc/include/asm/vga.h    |  4 +--
 drivers/ata/pata_macio.c          | 10 +++----
 drivers/block/swim3.c             | 12 ++++----
 drivers/ide/pmac.c                | 10 +++----
 drivers/macintosh/rack-meter.c    | 30 ++++++++++----------
 drivers/net/ethernet/apple/bmac.c | 30 ++++++++++----------
 drivers/net/ethernet/apple/mace.c | 44 ++++++++++++++---------------
 drivers/scsi/mac53c94.c           | 10 +++----
 drivers/scsi/mesh.c               | 14 +++++-----
 drivers/video/fbdev/controlfb.c   |  2 +-
 drivers/video/fbdev/platinumfb.c  |  2 +-
 sound/ppc/pmac.c                  | 58 +++++++++++++++++++--------------------
 13 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/arch/powerpc/include/asm/dbdma.h b/arch/powerpc/include/asm/dbdma.h
index e23f07e..6c69836 100644
--- a/arch/powerpc/include/asm/dbdma.h
+++ b/arch/powerpc/include/asm/dbdma.h
@@ -42,12 +42,12 @@ struct dbdma_regs {
  * DBDMA command structure.  These fields are all little-endian!
  */
 struct dbdma_cmd {
-    unsigned short req_count;	/* requested byte transfer count */
-    unsigned short command;	/* command word (has bit-fields) */
-    unsigned int   phy_addr;	/* physical data address */
-    unsigned int   cmd_dep;	/* command-dependent field */
-    unsigned short res_count;	/* residual count after completion */
-    unsigned short xfer_status;	/* transfer status */
+	__le16 req_count;	/* requested byte transfer count */
+	__le16 command;		/* command word (has bit-fields) */
+	__le32 phy_addr;	/* physical data address */
+	__le32 cmd_dep;		/* command-dependent field */
+	__le16 res_count;	/* residual count after completion */
+	__le16 xfer_status;	/* transfer status */
 };
 
 /* DBDMA command values in command field */
diff --git a/arch/powerpc/include/asm/vga.h b/arch/powerpc/include/asm/vga.h
index e5f8dd3..ab3acd2 100644
--- a/arch/powerpc/include/asm/vga.h
+++ b/arch/powerpc/include/asm/vga.h
@@ -25,12 +25,12 @@
 
 static inline void scr_writew(u16 val, volatile u16 *addr)
 {
-    st_le16(addr, val);
+	*addr = cpu_to_le16(val);
 }
 
 static inline u16 scr_readw(volatile const u16 *addr)
 {
-    return ld_le16(addr);
+	return le16_to_cpu(*addr);
 }
 
 #define VT_BUF_HAVE_MEMCPYW
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index a02f76f..b002858 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -540,9 +540,9 @@ static void pata_macio_qc_prep(struct ata_queued_cmd *qc)
 			BUG_ON (pi++ >= MAX_DCMDS);
 
 			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
-			st_le16(&table->command, write ? OUTPUT_MORE: INPUT_MORE);
-			st_le16(&table->req_count, len);
-			st_le32(&table->phy_addr, addr);
+			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
+			table->req_count = cpu_to_le16(len);
+			table->phy_addr = cpu_to_le32(addr);
 			table->cmd_dep = 0;
 			table->xfer_status = 0;
 			table->res_count = 0;
@@ -557,12 +557,12 @@ static void pata_macio_qc_prep(struct ata_queued_cmd *qc)
 
 	/* Convert the last command to an input/output */
 	table--;
-	st_le16(&table->command, write ? OUTPUT_LAST: INPUT_LAST);
+	table->command = cpu_to_le16(write ? OUTPUT_LAST: INPUT_LAST);
 	table++;
 
 	/* Add the stop command to the end of the list */
 	memset(table, 0, sizeof(struct dbdma_cmd));
-	st_le16(&table->command, DBDMA_STOP);
+	table->command = cpu_to_le16(DBDMA_STOP);
 
 	dev_dbgdma(priv->dev, "%s: %d DMA list entries\n", __func__, pi);
 }
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 523ee8f..c264f2d 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -440,9 +440,9 @@ static inline void seek_track(struct floppy_state *fs, int n)
 static inline void init_dma(struct dbdma_cmd *cp, int cmd,
 			    void *buf, int count)
 {
-	st_le16(&cp->req_count, count);
-	st_le16(&cp->command, cmd);
-	st_le32(&cp->phy_addr, virt_to_bus(buf));
+	cp->req_count = cpu_to_le16(count);
+	cp->command = cpu_to_le16(cmd);
+	cp->phy_addr = cpu_to_le32(virt_to_bus(buf));
 	cp->xfer_status = 0;
 }
 
@@ -771,8 +771,8 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 		}
 		/* turn off DMA */
 		out_le32(&dr->control, (RUN | PAUSE) << 16);
-		stat = ld_le16(&cp->xfer_status);
-		resid = ld_le16(&cp->res_count);
+		stat = le16_to_cpu(cp->xfer_status);
+		resid = le16_to_cpu(cp->res_count);
 		if (intr & ERROR_INTR) {
 			n = fs->scount - 1 - resid / 512;
 			if (n > 0) {
@@ -1170,7 +1170,7 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 
 	fs->dma_cmd = (struct dbdma_cmd *) DBDMA_ALIGN(fs->dbdma_cmd_space);
 	memset(fs->dma_cmd, 0, 2 * sizeof(struct dbdma_cmd));
-	st_le16(&fs->dma_cmd[1].command, DBDMA_STOP);
+	fs->dma_cmd[1].command = cpu_to_le16(DBDMA_STOP);
 
 	if (mdev->media_bay == NULL || check_media_bay(mdev->media_bay) == MB_FD)
 		swim3_mb_event(mdev, MB_FD);
diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 2db803c..d24a3f8 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1497,9 +1497,9 @@ static int pmac_ide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 				       drive->name);
 				return 0;
 			}
-			st_le16(&table->command, wr? OUTPUT_MORE: INPUT_MORE);
-			st_le16(&table->req_count, tc);
-			st_le32(&table->phy_addr, cur_addr);
+			table->command = cpu_to_le16(wr? OUTPUT_MORE: INPUT_MORE);
+			table->req_count = cpu_to_le16(tc);
+			table->phy_addr = cpu_to_le32(cur_addr);
 			table->cmd_dep = 0;
 			table->xfer_status = 0;
 			table->res_count = 0;
@@ -1513,10 +1513,10 @@ static int pmac_ide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 
 	/* convert the last command to an input/output last command */
 	if (count) {
-		st_le16(&table[-1].command, wr? OUTPUT_LAST: INPUT_LAST);
+		table[-1].command = cpu_to_le16(wr? OUTPUT_LAST: INPUT_LAST);
 		/* add the stop command to the end of the list */
 		memset(table, 0, sizeof(struct dbdma_cmd));
-		st_le16(&table->command, DBDMA_STOP);
+		table->command = cpu_to_le16(DBDMA_STOP);
 		mb();
 		writel(hwif->dmatable_dma, &dma->cmdptr);
 		return 1;
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 4192901..048901a 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -182,31 +182,31 @@ static void rackmeter_setup_dbdma(struct rackmeter *rm)
 
 	/* Prepare 4 dbdma commands for the 2 buffers */
 	memset(cmd, 0, 4 * sizeof(struct dbdma_cmd));
-	st_le16(&cmd->req_count, 4);
-	st_le16(&cmd->command, STORE_WORD | INTR_ALWAYS | KEY_SYSTEM);
-	st_le32(&cmd->phy_addr, rm->dma_buf_p +
+	cmd->req_count = cpu_to_le16(4);
+	cmd->command = cpu_to_le16(STORE_WORD | INTR_ALWAYS | KEY_SYSTEM);
+	cmd->phy_addr = cpu_to_le32(rm->dma_buf_p +
 		offsetof(struct rackmeter_dma, mark));
-	st_le32(&cmd->cmd_dep, 0x02000000);
+	cmd->cmd_dep = cpu_to_le32(0x02000000);
 	cmd++;
 
-	st_le16(&cmd->req_count, SAMPLE_COUNT * 4);
-	st_le16(&cmd->command, OUTPUT_MORE);
-	st_le32(&cmd->phy_addr, rm->dma_buf_p +
+	cmd->req_count = cpu_to_le16(SAMPLE_COUNT * 4);
+	cmd->command = cpu_to_le16(OUTPUT_MORE);
+	cmd->phy_addr = cpu_to_le32(rm->dma_buf_p +
 		offsetof(struct rackmeter_dma, buf1));
 	cmd++;
 
-	st_le16(&cmd->req_count, 4);
-	st_le16(&cmd->command, STORE_WORD | INTR_ALWAYS | KEY_SYSTEM);
-	st_le32(&cmd->phy_addr, rm->dma_buf_p +
+	cmd->req_count = cpu_to_le16(4);
+	cmd->command = cpu_to_le16(STORE_WORD | INTR_ALWAYS | KEY_SYSTEM);
+	cmd->phy_addr = cpu_to_le32(rm->dma_buf_p +
 		offsetof(struct rackmeter_dma, mark));
-	st_le32(&cmd->cmd_dep, 0x01000000);
+	cmd->cmd_dep = cpu_to_le32(0x01000000);
 	cmd++;
 
-	st_le16(&cmd->req_count, SAMPLE_COUNT * 4);
-	st_le16(&cmd->command, OUTPUT_MORE | BR_ALWAYS);
-	st_le32(&cmd->phy_addr, rm->dma_buf_p +
+	cmd->req_count = cpu_to_le16(SAMPLE_COUNT * 4);
+	cmd->command = cpu_to_le16(OUTPUT_MORE | BR_ALWAYS);
+	cmd->phy_addr = cpu_to_le32(rm->dma_buf_p +
 		offsetof(struct rackmeter_dma, buf2));
-	st_le32(&cmd->cmd_dep, rm->dma_buf_p);
+	cmd->cmd_dep = cpu_to_le32(rm->dma_buf_p);
 
 	rackmeter_do_pause(rm, 0);
 }
diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index daae0e0..c0bd638 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -483,8 +483,8 @@ static int bmac_suspend(struct macio_dev *mdev, pm_message_t state)
        		bmwrite(dev, TXCFG, (config & ~TxMACEnable));
 		bmwrite(dev, INTDISABLE, DisableAll); /* disable all intrs */
        		/* disable rx and tx dma */
-       		st_le32(&rd->control, DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
-       		st_le32(&td->control, DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
+		rd->control = cpu_to_le32(DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
+		td->control = cpu_to_le32(DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
        		/* free some skb's */
        		for (i=0; i<N_RX_RING; i++) {
        			if (bp->rx_bufs[i] != NULL) {
@@ -699,8 +699,8 @@ static irqreturn_t bmac_rxdma_intr(int irq, void *dev_id)
 
 	while (1) {
 		cp = &bp->rx_cmds[i];
-		stat = ld_le16(&cp->xfer_status);
-		residual = ld_le16(&cp->res_count);
+		stat = le16_to_cpu(cp->xfer_status);
+		residual = le16_to_cpu(cp->res_count);
 		if ((stat & ACTIVE) == 0)
 			break;
 		nb = RX_BUFLEN - residual - 2;
@@ -728,8 +728,8 @@ static irqreturn_t bmac_rxdma_intr(int irq, void *dev_id)
 				skb_reserve(bp->rx_bufs[i], 2);
 		}
 		bmac_construct_rxbuff(skb, &bp->rx_cmds[i]);
-		st_le16(&cp->res_count, 0);
-		st_le16(&cp->xfer_status, 0);
+		cp->res_count = cpu_to_le16(0);
+		cp->xfer_status = cpu_to_le16(0);
 		last = i;
 		if (++i >= N_RX_RING) i = 0;
 	}
@@ -769,7 +769,7 @@ static irqreturn_t bmac_txdma_intr(int irq, void *dev_id)
 
 	while (1) {
 		cp = &bp->tx_cmds[bp->tx_empty];
-		stat = ld_le16(&cp->xfer_status);
+		stat = le16_to_cpu(cp->xfer_status);
 		if (txintcount < 10) {
 			XXDEBUG(("bmac_txdma_xfer_stat=%#0x\n", stat));
 		}
@@ -1411,8 +1411,8 @@ static int bmac_close(struct net_device *dev)
 	bmwrite(dev, INTDISABLE, DisableAll); /* disable all intrs */
 
 	/* disable rx and tx dma */
-	st_le32(&rd->control, DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
-	st_le32(&td->control, DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
+	rd->control = cpu_to_le32(DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
+	td->control = cpu_to_le32(DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE));	/* clear run bit */
 
 	/* free some skb's */
 	XXDEBUG(("bmac: free rx bufs\n"));
@@ -1493,7 +1493,7 @@ static void bmac_tx_timeout(unsigned long data)
 
 	cp = &bp->tx_cmds[bp->tx_empty];
 /*	XXDEBUG((KERN_DEBUG "bmac: tx dmastat=%x %x runt=%d pr=%x fs=%x fc=%x\n", */
-/* 	   ld_le32(&td->status), ld_le16(&cp->xfer_status), bp->tx_bad_runt, */
+/* 	   le32_to_cpu(td->status), le16_to_cpu(cp->xfer_status), bp->tx_bad_runt, */
 /* 	   mb->pr, mb->xmtfs, mb->fifofc)); */
 
 	/* turn off both tx and rx and reset the chip */
@@ -1506,7 +1506,7 @@ static void bmac_tx_timeout(unsigned long data)
 	bmac_enable_and_reset_chip(dev);
 
 	/* restart rx dma */
-	cp = bus_to_virt(ld_le32(&rd->cmdptr));
+	cp = bus_to_virt(le32_to_cpu(rd->cmdptr));
 	out_le32(&rd->control, DBDMA_CLEAR(RUN|PAUSE|FLUSH|WAKE|ACTIVE|DEAD));
 	out_le16(&cp->xfer_status, 0);
 	out_le32(&rd->cmdptr, virt_to_bus(cp));
@@ -1553,10 +1553,10 @@ static void dump_dbdma(volatile struct dbdma_cmd *cp,int count)
 		ip = (int*)(cp+i);
 
 		printk("dbdma req 0x%x addr 0x%x baddr 0x%x xfer/res 0x%x\n",
-		       ld_le32(ip+0),
-		       ld_le32(ip+1),
-		       ld_le32(ip+2),
-		       ld_le32(ip+3));
+		       le32_to_cpup(ip+0),
+		       le32_to_cpup(ip+1),
+		       le32_to_cpup(ip+2),
+		       le32_to_cpup(ip+3));
 	}
 
 }
diff --git a/drivers/net/ethernet/apple/mace.c b/drivers/net/ethernet/apple/mace.c
index 842fe76..73afe49 100644
--- a/drivers/net/ethernet/apple/mace.c
+++ b/drivers/net/ethernet/apple/mace.c
@@ -310,7 +310,7 @@ static void dbdma_reset(volatile struct dbdma_regs __iomem *dma)
      * way on some machines.
      */
     for (i = 200; i > 0; --i)
-	if (ld_le32(&dma->control) & RUN)
+	if (le32_to_cpu(dma->control) & RUN)
 	    udelay(1);
 }
 
@@ -452,21 +452,21 @@ static int mace_open(struct net_device *dev)
 	    data = skb->data;
 	}
 	mp->rx_bufs[i] = skb;
-	st_le16(&cp->req_count, RX_BUFLEN);
-	st_le16(&cp->command, INPUT_LAST + INTR_ALWAYS);
-	st_le32(&cp->phy_addr, virt_to_bus(data));
+	cp->req_count = cpu_to_le16(RX_BUFLEN);
+	cp->command = cpu_to_le16(INPUT_LAST + INTR_ALWAYS);
+	cp->phy_addr = cpu_to_le32(virt_to_bus(data));
 	cp->xfer_status = 0;
 	++cp;
     }
     mp->rx_bufs[i] = NULL;
-    st_le16(&cp->command, DBDMA_STOP);
+    cp->command = cpu_to_le16(DBDMA_STOP);
     mp->rx_fill = i;
     mp->rx_empty = 0;
 
     /* Put a branch back to the beginning of the receive command list */
     ++cp;
-    st_le16(&cp->command, DBDMA_NOP + BR_ALWAYS);
-    st_le32(&cp->cmd_dep, virt_to_bus(mp->rx_cmds));
+    cp->command = cpu_to_le16(DBDMA_NOP + BR_ALWAYS);
+    cp->cmd_dep = cpu_to_le32(virt_to_bus(mp->rx_cmds));
 
     /* start rx dma */
     out_le32(&rd->control, (RUN|PAUSE|FLUSH|WAKE) << 16); /* clear run bit */
@@ -475,8 +475,8 @@ static int mace_open(struct net_device *dev)
 
     /* put a branch at the end of the tx command list */
     cp = mp->tx_cmds + NCMDS_TX * N_TX_RING;
-    st_le16(&cp->command, DBDMA_NOP + BR_ALWAYS);
-    st_le32(&cp->cmd_dep, virt_to_bus(mp->tx_cmds));
+    cp->command = cpu_to_le16(DBDMA_NOP + BR_ALWAYS);
+    cp->cmd_dep = cpu_to_le32(virt_to_bus(mp->tx_cmds));
 
     /* reset tx dma */
     out_le32(&td->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
@@ -507,8 +507,8 @@ static int mace_close(struct net_device *dev)
     out_8(&mb->imr, 0xff);		/* disable all intrs */
 
     /* disable rx and tx dma */
-    st_le32(&rd->control, (RUN|PAUSE|FLUSH|WAKE) << 16); /* clear run bit */
-    st_le32(&td->control, (RUN|PAUSE|FLUSH|WAKE) << 16); /* clear run bit */
+    rd->control = cpu_to_le32((RUN|PAUSE|FLUSH|WAKE) << 16); /* clear run bit */
+    td->control = cpu_to_le32((RUN|PAUSE|FLUSH|WAKE) << 16); /* clear run bit */
 
     mace_clean_rings(mp);
 
@@ -558,8 +558,8 @@ static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
     }
     mp->tx_bufs[fill] = skb;
     cp = mp->tx_cmds + NCMDS_TX * fill;
-    st_le16(&cp->req_count, len);
-    st_le32(&cp->phy_addr, virt_to_bus(skb->data));
+    cp->req_count = cpu_to_le16(len);
+    cp->phy_addr = cpu_to_le32(virt_to_bus(skb->data));
 
     np = mp->tx_cmds + NCMDS_TX * next;
     out_le16(&np->command, DBDMA_STOP);
@@ -691,7 +691,7 @@ static irqreturn_t mace_interrupt(int irq, void *dev_id)
 	    out_8(&mb->xmtfc, AUTO_PAD_XMIT);
 	    continue;
 	}
-	dstat = ld_le32(&td->status);
+	dstat = le32_to_cpu(td->status);
 	/* stop DMA controller */
 	out_le32(&td->control, RUN << 16);
 	/*
@@ -724,7 +724,7 @@ static irqreturn_t mace_interrupt(int irq, void *dev_id)
 		 */
 	}
 	cp = mp->tx_cmds + NCMDS_TX * i;
-	stat = ld_le16(&cp->xfer_status);
+	stat = le16_to_cpu(cp->xfer_status);
 	if ((fs & (UFLO|LCOL|LCAR|RTRY)) || (dstat & DEAD) || xcount == 0) {
 	    /*
 	     * Check whether there were in fact 2 bytes written to
@@ -830,7 +830,7 @@ static void mace_tx_timeout(unsigned long data)
     mace_reset(dev);
 
     /* restart rx dma */
-    cp = bus_to_virt(ld_le32(&rd->cmdptr));
+    cp = bus_to_virt(le32_to_cpu(rd->cmdptr));
     dbdma_reset(rd);
     out_le16(&cp->xfer_status, 0);
     out_le32(&rd->cmdptr, virt_to_bus(cp));
@@ -889,20 +889,20 @@ static irqreturn_t mace_rxdma_intr(int irq, void *dev_id)
     spin_lock_irqsave(&mp->lock, flags);
     for (i = mp->rx_empty; i != mp->rx_fill; ) {
 	cp = mp->rx_cmds + i;
-	stat = ld_le16(&cp->xfer_status);
+	stat = le16_to_cpu(cp->xfer_status);
 	if ((stat & ACTIVE) == 0) {
 	    next = i + 1;
 	    if (next >= N_RX_RING)
 		next = 0;
 	    np = mp->rx_cmds + next;
 	    if (next != mp->rx_fill &&
-		(ld_le16(&np->xfer_status) & ACTIVE) != 0) {
+		(le16_to_cpu(np->xfer_status) & ACTIVE) != 0) {
 		printk(KERN_DEBUG "mace: lost a status word\n");
 		++mace_lost_status;
 	    } else
 		break;
 	}
-	nb = ld_le16(&cp->req_count) - ld_le16(&cp->res_count);
+	nb = le16_to_cpu(cp->req_count) - le16_to_cpu(cp->res_count);
 	out_le16(&cp->command, DBDMA_STOP);
 	/* got a packet, have a look at it */
 	skb = mp->rx_bufs[i];
@@ -962,13 +962,13 @@ static irqreturn_t mace_rxdma_intr(int irq, void *dev_id)
 		mp->rx_bufs[i] = skb;
 	    }
 	}
-	st_le16(&cp->req_count, RX_BUFLEN);
+	cp->req_count = cpu_to_le16(RX_BUFLEN);
 	data = skb? skb->data: dummy_buf;
-	st_le32(&cp->phy_addr, virt_to_bus(data));
+	cp->phy_addr = cpu_to_le32(virt_to_bus(data));
 	out_le16(&cp->xfer_status, 0);
 	out_le16(&cp->command, INPUT_LAST + INTR_ALWAYS);
 #if 0
-	if ((ld_le32(&rd->status) & ACTIVE) != 0) {
+	if ((le32_to_cpu(rd->status) & ACTIVE) != 0) {
 	    out_le32(&rd->control, (PAUSE << 16) | PAUSE);
 	    while ((in_le32(&rd->status) & ACTIVE) != 0)
 		;
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index e5cd8d8..0adb2e0 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -382,16 +382,16 @@ static void set_dma_cmds(struct fsc_state *state, struct scsi_cmnd *cmd)
 		if (dma_len > 0xffff)
 			panic("mac53c94: scatterlist element >= 64k");
 		total += dma_len;
-		st_le16(&dcmds->req_count, dma_len);
-		st_le16(&dcmds->command, dma_cmd);
-		st_le32(&dcmds->phy_addr, dma_addr);
+		dcmds->req_count = cpu_to_le16(dma_len);
+		dcmds->command = cpu_to_le16(dma_cmd);
+		dcmds->phy_addr = cpu_to_le32(dma_addr);
 		dcmds->xfer_status = 0;
 		++dcmds;
 	}
 
 	dma_cmd += OUTPUT_LAST - OUTPUT_MORE;
-	st_le16(&dcmds[-1].command, dma_cmd);
-	st_le16(&dcmds->command, DBDMA_STOP);
+	dcmds[-1].command = cpu_to_le16(dma_cmd);
+	dcmds->command = cpu_to_le16(DBDMA_STOP);
 	cmd->SCp.this_residual = total;
 }
 
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 57a95e2..555367f 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1287,9 +1287,9 @@ static void set_dma_cmds(struct mesh_state *ms, struct scsi_cmnd *cmd)
 				}
 				if (dma_len > 0xffff)
 					panic("mesh: scatterlist element >= 64k");
-				st_le16(&dcmds->req_count, dma_len - off);
-				st_le16(&dcmds->command, dma_cmd);
-				st_le32(&dcmds->phy_addr, dma_addr + off);
+				dcmds->req_count = cpu_to_le16(dma_len - off);
+				dcmds->command = cpu_to_le16(dma_cmd);
+				dcmds->phy_addr = cpu_to_le32(dma_addr + off);
 				dcmds->xfer_status = 0;
 				++dcmds;
 				dtot += dma_len - off;
@@ -1303,15 +1303,15 @@ static void set_dma_cmds(struct mesh_state *ms, struct scsi_cmnd *cmd)
 		static char mesh_extra_buf[64];
 
 		dtot = sizeof(mesh_extra_buf);
-		st_le16(&dcmds->req_count, dtot);
-		st_le32(&dcmds->phy_addr, virt_to_phys(mesh_extra_buf));
+		dcmds->req_count = cpu_to_le16(dtot);
+		dcmds->phy_addr = cpu_to_le32(virt_to_phys(mesh_extra_buf));
 		dcmds->xfer_status = 0;
 		++dcmds;
 	}
 	dma_cmd += OUTPUT_LAST - OUTPUT_MORE;
-	st_le16(&dcmds[-1].command, dma_cmd);
+	dcmds[-1].command = cpu_to_le16(dma_cmd);
 	memset(dcmds, 0, sizeof(*dcmds));
-	st_le16(&dcmds->command, DBDMA_STOP);
+	dcmds->command = cpu_to_le16(DBDMA_STOP);
 	ms->dma_count = dtot;
 }
 
diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 080fdd2..8d14b29 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -315,7 +315,7 @@ static int controlfb_blank(int blank_mode, struct fb_info *info)
 		container_of(info, struct fb_info_control, info);
 	unsigned ctrl;
 
-	ctrl = ld_le32(CNTRL_REG(p,ctrl));
+	ctrl = le32_to_cpup(CNTRL_REG(p,ctrl));
 	if (blank_mode > 0)
 		switch (blank_mode) {
 		case FB_BLANK_VSYNC_SUSPEND:
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 518d1fd..377d339 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -168,7 +168,7 @@ static int platinumfb_blank(int blank,  struct fb_info *fb)
 	struct fb_info_platinum *info = (struct fb_info_platinum *) fb;
 	int	ctrl;
 
-	ctrl = ld_le32(&info->platinum_regs->ctrl.r) | 0x33;
+	ctrl = le32_to_cpup(&info->platinum_regs->ctrl.r) | 0x33;
 	if (blank)
 		--blank_mode;
 	if (blank & VESA_VSYNC_SUSPEND)
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 5a13b22..1b90be5 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -240,7 +240,7 @@ static int snd_pmac_pcm_prepare(struct snd_pmac *chip, struct pmac_stream *rec,
 	 */
 	spin_lock_irq(&chip->reg_lock);
 	snd_pmac_dma_stop(rec);
-	st_le16(&chip->extra_dma.cmds->command, DBDMA_STOP);
+	chip->extra_dma.cmds->command = cpu_to_le16(DBDMA_STOP);
 	snd_pmac_dma_set_command(rec, &chip->extra_dma);
 	snd_pmac_dma_run(rec, RUN);
 	spin_unlock_irq(&chip->reg_lock);
@@ -251,15 +251,15 @@ static int snd_pmac_pcm_prepare(struct snd_pmac *chip, struct pmac_stream *rec,
 	 */
 	offset = runtime->dma_addr;
 	for (i = 0, cp = rec->cmd.cmds; i < rec->nperiods; i++, cp++) {
-		st_le32(&cp->phy_addr, offset);
-		st_le16(&cp->req_count, rec->period_size);
-		/*st_le16(&cp->res_count, 0);*/
-		st_le16(&cp->xfer_status, 0);
+		cp->phy_addr = cpu_to_le32(offset);
+		cp->req_count = cpu_to_le16(rec->period_size);
+		/*cp->res_count = cpu_to_le16(0);*/
+		cp->xfer_status = cpu_to_le16(0);
 		offset += rec->period_size;
 	}
 	/* make loop */
-	st_le16(&cp->command, DBDMA_NOP + BR_ALWAYS);
-	st_le32(&cp->cmd_dep, rec->cmd.addr);
+	cp->command = cpu_to_le16(DBDMA_NOP + BR_ALWAYS);
+	cp->cmd_dep = cpu_to_le32(rec->cmd.addr);
 
 	snd_pmac_dma_stop(rec);
 	snd_pmac_dma_set_command(rec, &rec->cmd);
@@ -328,7 +328,7 @@ static snd_pcm_uframes_t snd_pmac_pcm_pointer(struct snd_pmac *chip,
 #if 1 /* hmm.. how can we get the current dma pointer?? */
 	int stat;
 	volatile struct dbdma_cmd __iomem *cp = &rec->cmd.cmds[rec->cur_period];
-	stat = ld_le16(&cp->xfer_status);
+	stat = le16_to_cpu(cp->xfer_status);
 	if (stat & (ACTIVE|DEAD)) {
 		count = in_le16(&cp->res_count);
 		if (count)
@@ -427,26 +427,26 @@ static inline void snd_pmac_pcm_dead_xfer(struct pmac_stream *rec,
 		memcpy((void *)emergency_dbdma.cmds, (void *)cp,
 		       sizeof(struct dbdma_cmd));
 		emergency_in_use = 1;
-		st_le16(&cp->xfer_status, 0);
-		st_le16(&cp->req_count, rec->period_size);
+		cp->xfer_status = cpu_to_le16(0);
+		cp->req_count = cpu_to_le16(rec->period_size);
 		cp = emergency_dbdma.cmds;
 	}
 
 	/* now bump the values to reflect the amount
 	   we haven't yet shifted */
-	req = ld_le16(&cp->req_count);
-	res = ld_le16(&cp->res_count);
-	phy = ld_le32(&cp->phy_addr);
+	req = le16_to_cpu(cp->req_count);
+	res = le16_to_cpu(cp->res_count);
+	phy = le32_to_cpu(cp->phy_addr);
 	phy += (req - res);
-	st_le16(&cp->req_count, res);
-	st_le16(&cp->res_count, 0);
-	st_le16(&cp->xfer_status, 0);
-	st_le32(&cp->phy_addr, phy);
+	cp->req_count = cpu_to_le16(res);
+	cp->res_count = cpu_to_le16(0);
+	cp->xfer_status = cpu_to_le16(0);
+	cp->phy_addr = cpu_to_le32(phy);
 
-	st_le32(&cp->cmd_dep, rec->cmd.addr
+	cp->cmd_dep = cpu_to_le32(rec->cmd.addr
 		+ sizeof(struct dbdma_cmd)*((rec->cur_period+1)%rec->nperiods));
 
-	st_le16(&cp->command, OUTPUT_MORE | BR_ALWAYS | INTR_ALWAYS);
+	cp->command = cpu_to_le16(OUTPUT_MORE | BR_ALWAYS | INTR_ALWAYS);
 
 	/* point at our patched up command block */
 	out_le32(&rec->dma->cmdptr, emergency_dbdma.addr);
@@ -475,7 +475,7 @@ static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
 			else
 				cp = &rec->cmd.cmds[rec->cur_period];
 
-			stat = ld_le16(&cp->xfer_status);
+			stat = le16_to_cpu(cp->xfer_status);
 
 			if (stat & DEAD) {
 				snd_pmac_pcm_dead_xfer(rec, cp);
@@ -489,9 +489,9 @@ static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
 				break;
 
 			/*printk(KERN_DEBUG "update frag %d\n", rec->cur_period);*/
-			st_le16(&cp->xfer_status, 0);
-			st_le16(&cp->req_count, rec->period_size);
-			/*st_le16(&cp->res_count, 0);*/
+			cp->xfer_status = cpu_to_le16(0);
+			cp->req_count = cpu_to_le16(rec->period_size);
+			/*cp->res_count = cpu_to_le16(0);*/
 			rec->cur_period++;
 			if (rec->cur_period >= rec->nperiods) {
 				rec->cur_period = 0;
@@ -760,11 +760,11 @@ void snd_pmac_beep_dma_start(struct snd_pmac *chip, int bytes, unsigned long add
 	struct pmac_stream *rec = &chip->playback;
 
 	snd_pmac_dma_stop(rec);
-	st_le16(&chip->extra_dma.cmds->req_count, bytes);
-	st_le16(&chip->extra_dma.cmds->xfer_status, 0);
-	st_le32(&chip->extra_dma.cmds->cmd_dep, chip->extra_dma.addr);
-	st_le32(&chip->extra_dma.cmds->phy_addr, addr);
-	st_le16(&chip->extra_dma.cmds->command, OUTPUT_MORE + BR_ALWAYS);
+	chip->extra_dma.cmds->req_count = cpu_to_le16(bytes);
+	chip->extra_dma.cmds->xfer_status = cpu_to_le16(0);
+	chip->extra_dma.cmds->cmd_dep = cpu_to_le32(chip->extra_dma.addr);
+	chip->extra_dma.cmds->phy_addr = cpu_to_le32(addr);
+	chip->extra_dma.cmds->command = cpu_to_le16(OUTPUT_MORE + BR_ALWAYS);
 	out_le32(&chip->awacs->control,
 		 (in_le32(&chip->awacs->control) & ~0x1f00)
 		 | (speed << 8));
@@ -776,7 +776,7 @@ void snd_pmac_beep_dma_start(struct snd_pmac *chip, int bytes, unsigned long add
 void snd_pmac_beep_dma_stop(struct snd_pmac *chip)
 {
 	snd_pmac_dma_stop(&chip->playback);
-	st_le16(&chip->extra_dma.cmds->command, DBDMA_STOP);
+	chip->extra_dma.cmds->command = cpu_to_le16(DBDMA_STOP);
 	snd_pmac_pcm_set_format(chip); /* reset format */
 }
 
-- 
2.1.0
