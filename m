Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0FD3DDE41
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 21:32:02 +1100 (EST)
Date: Fri, 02 Feb 2007 19:30:36 +0900 (JST)
Message-Id: <200702021030.l12AUbcI016257@toshiba.co.jp>
To: jens@de.ibm.com
Subject: [RFC/PATCH 2.6.20-rc6 2/4] spidernet: load firmaware when open
In-Reply-To: <200702011204.30526.jens@de.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, jim@jklewis.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves calling init_firmware() from spider_net_probe() to
spider_net_open() so as to use the driver by built-in.

This patch is just for a test. Please try this, if you can.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

--- org-linux-powerpc-git/drivers/net/spider_net.c	2007-02-02 14:29:17.000000000 +0900
+++ linux-powerpc-git/drivers/net/spider_net.c	2007-02-02 14:29:39.000000000 +0900
@@ -1718,6 +1718,124 @@
 }
 
 /**
+ * spider_net_download_firmware - loads firmware into the adapter
+ * @card: card structure
+ * @firmware_ptr: pointer to firmware data
+ *
+ * spider_net_download_firmware loads the firmware data into the
+ * adapter. It assumes the length etc. to be allright.
+ */
+static int
+spider_net_download_firmware(struct spider_net_card *card,
+			     const void *firmware_ptr)
+{
+	int sequencer, i;
+	const u32 *fw_ptr = firmware_ptr;
+
+	/* stop sequencers */
+	spider_net_write_reg(card, SPIDER_NET_GSINIT,
+			     SPIDER_NET_STOP_SEQ_VALUE);
+
+	for (sequencer = 0; sequencer < SPIDER_NET_FIRMWARE_SEQS;
+	     sequencer++) {
+		spider_net_write_reg(card,
+				     SPIDER_NET_GSnPRGADR + sequencer * 8, 0);
+		for (i = 0; i < SPIDER_NET_FIRMWARE_SEQWORDS; i++) {
+			spider_net_write_reg(card, SPIDER_NET_GSnPRGDAT +
+					     sequencer * 8, *fw_ptr);
+			fw_ptr++;
+		}
+	}
+
+	if (spider_net_read_reg(card, SPIDER_NET_GSINIT))
+		return -EIO;
+
+	spider_net_write_reg(card, SPIDER_NET_GSINIT,
+			     SPIDER_NET_RUN_SEQ_VALUE);
+
+	return 0;
+}
+
+/**
+ * spider_net_init_firmware - reads in firmware parts
+ * @card: card structure
+ *
+ * Returns 0 on success, <0 on failure
+ *
+ * spider_net_init_firmware opens the sequencer firmware and does some basic
+ * checks. This function opens and releases the firmware structure. A call
+ * to download the firmware is performed before the release.
+ *
+ * Firmware format
+ * ===============
+ * spider_fw.bin is expected to be a file containing 6*1024*4 bytes, 4k being
+ * the program for each sequencer. Use the command
+ *    tail -q -n +2 Seq_code1_0x088.txt Seq_code2_0x090.txt              \
+ *         Seq_code3_0x098.txt Seq_code4_0x0A0.txt Seq_code5_0x0A8.txt   \
+ *         Seq_code6_0x0B0.txt | xxd -r -p -c4 > spider_fw.bin
+ *
+ * to generate spider_fw.bin, if you have sequencer programs with something
+ * like the following contents for each sequencer:
+ *    <ONE LINE COMMENT>
+ *    <FIRST 4-BYTES-WORD FOR SEQUENCER>
+ *    <SECOND 4-BYTES-WORD FOR SEQUENCER>
+ *     ...
+ *    <1024th 4-BYTES-WORD FOR SEQUENCER>
+ */
+static int
+spider_net_init_firmware(struct spider_net_card *card)
+{
+	struct firmware *firmware = NULL;
+	struct device_node *dn;
+	const u8 *fw_prop = NULL;
+	int err = -ENOENT;
+	int fw_size;
+
+	if (request_firmware((const struct firmware **)&firmware,
+			     SPIDER_NET_FIRMWARE_NAME, &card->pdev->dev) == 0) {
+		if ( (firmware->size != SPIDER_NET_FIRMWARE_LEN) &&
+		     netif_msg_probe(card) ) {
+			pr_err("Incorrect size of spidernet firmware in " \
+			       "filesystem. Looking in host firmware...\n");
+			goto try_host_fw;
+		}
+		err = spider_net_download_firmware(card, firmware->data);
+
+		release_firmware(firmware);
+		if (err)
+			goto try_host_fw;
+
+		goto done;
+	}
+
+try_host_fw:
+	dn = pci_device_to_OF_node(card->pdev);
+	if (!dn)
+		goto out_err;
+
+	fw_prop = get_property(dn, "firmware", &fw_size);
+	if (!fw_prop)
+		goto out_err;
+
+	if ( (fw_size != SPIDER_NET_FIRMWARE_LEN) &&
+	     netif_msg_probe(card) ) {
+		pr_err("Incorrect size of spidernet firmware in " \
+		       "host firmware\n");
+		goto done;
+	}
+
+	err = spider_net_download_firmware(card, fw_prop);
+
+done:
+	return err;
+out_err:
+	if (netif_msg_probe(card))
+		pr_err("Couldn't find spidernet firmware in filesystem " \
+		       "or host firmware\n");
+	return err;
+}
+
+/**
  * spider_net_open - called upon ifonfig up
  * @netdev: interface device structure
  *
@@ -1735,6 +1853,10 @@
 
 	result = -ENOMEM;
 
+	result = spider_net_init_firmware(card);
+	if (result)
+		goto init_firmware_failed;
+
 	/* start probing with copper */
 	spider_net_setup_aneg(card);
 	if (card->phy.def->phy_id)
@@ -1785,6 +1907,7 @@
 	spider_net_free_chain(card, &card->tx_chain);
 alloc_tx_failed:
 	del_timer_sync(&card->aneg_timer);
+init_firmware_failed:
 	return result;
 }
 
@@ -1920,124 +2043,6 @@
 }
 
 /**
- * spider_net_download_firmware - loads firmware into the adapter
- * @card: card structure
- * @firmware_ptr: pointer to firmware data
- *
- * spider_net_download_firmware loads the firmware data into the
- * adapter. It assumes the length etc. to be allright.
- */
-static int
-spider_net_download_firmware(struct spider_net_card *card,
-			     const void *firmware_ptr)
-{
-	int sequencer, i;
-	const u32 *fw_ptr = firmware_ptr;
-
-	/* stop sequencers */
-	spider_net_write_reg(card, SPIDER_NET_GSINIT,
-			     SPIDER_NET_STOP_SEQ_VALUE);
-
-	for (sequencer = 0; sequencer < SPIDER_NET_FIRMWARE_SEQS;
-	     sequencer++) {
-		spider_net_write_reg(card,
-				     SPIDER_NET_GSnPRGADR + sequencer * 8, 0);
-		for (i = 0; i < SPIDER_NET_FIRMWARE_SEQWORDS; i++) {
-			spider_net_write_reg(card, SPIDER_NET_GSnPRGDAT +
-					     sequencer * 8, *fw_ptr);
-			fw_ptr++;
-		}
-	}
-
-	if (spider_net_read_reg(card, SPIDER_NET_GSINIT))
-		return -EIO;
-
-	spider_net_write_reg(card, SPIDER_NET_GSINIT,
-			     SPIDER_NET_RUN_SEQ_VALUE);
-
-	return 0;
-}
-
-/**
- * spider_net_init_firmware - reads in firmware parts
- * @card: card structure
- *
- * Returns 0 on success, <0 on failure
- *
- * spider_net_init_firmware opens the sequencer firmware and does some basic
- * checks. This function opens and releases the firmware structure. A call
- * to download the firmware is performed before the release.
- *
- * Firmware format
- * ===============
- * spider_fw.bin is expected to be a file containing 6*1024*4 bytes, 4k being
- * the program for each sequencer. Use the command
- *    tail -q -n +2 Seq_code1_0x088.txt Seq_code2_0x090.txt              \
- *         Seq_code3_0x098.txt Seq_code4_0x0A0.txt Seq_code5_0x0A8.txt   \
- *         Seq_code6_0x0B0.txt | xxd -r -p -c4 > spider_fw.bin
- *
- * to generate spider_fw.bin, if you have sequencer programs with something
- * like the following contents for each sequencer:
- *    <ONE LINE COMMENT>
- *    <FIRST 4-BYTES-WORD FOR SEQUENCER>
- *    <SECOND 4-BYTES-WORD FOR SEQUENCER>
- *     ...
- *    <1024th 4-BYTES-WORD FOR SEQUENCER>
- */
-static int
-spider_net_init_firmware(struct spider_net_card *card)
-{
-	struct firmware *firmware = NULL;
-	struct device_node *dn;
-	const u8 *fw_prop = NULL;
-	int err = -ENOENT;
-	int fw_size;
-
-	if (request_firmware((const struct firmware **)&firmware,
-			     SPIDER_NET_FIRMWARE_NAME, &card->pdev->dev) == 0) {
-		if ( (firmware->size != SPIDER_NET_FIRMWARE_LEN) &&
-		     netif_msg_probe(card) ) {
-			pr_err("Incorrect size of spidernet firmware in " \
-			       "filesystem. Looking in host firmware...\n");
-			goto try_host_fw;
-		}
-		err = spider_net_download_firmware(card, firmware->data);
-
-		release_firmware(firmware);
-		if (err)
-			goto try_host_fw;
-
-		goto done;
-	}
-
-try_host_fw:
-	dn = pci_device_to_OF_node(card->pdev);
-	if (!dn)
-		goto out_err;
-
-	fw_prop = get_property(dn, "firmware", &fw_size);
-	if (!fw_prop)
-		goto out_err;
-
-	if ( (fw_size != SPIDER_NET_FIRMWARE_LEN) &&
-	     netif_msg_probe(card) ) {
-		pr_err("Incorrect size of spidernet firmware in " \
-		       "host firmware\n");
-		goto done;
-	}
-
-	err = spider_net_download_firmware(card, fw_prop);
-
-done:
-	return err;
-out_err:
-	if (netif_msg_probe(card))
-		pr_err("Couldn't find spidernet firmware in filesystem " \
-		       "or host firmware\n");
-	return err;
-}
-
-/**
  * spider_net_workaround_rxramfull - work around firmware bug
  * @card: card structure
  *
@@ -2138,8 +2143,6 @@
 
 	if (spider_net_setup_phy(card))
 		goto out;
-	if (spider_net_init_firmware(card))
-		goto out;
 
 	spider_net_open(netdev);
 	spider_net_kick_tx_dma(card);
@@ -2419,10 +2422,6 @@
 	if (err)
 		goto out_undo_pci;
 
-	err = spider_net_init_firmware(card);
-	if (err)
-		goto out_undo_pci;
-
 	err = spider_net_setup_netdev(card);
 	if (err)
 		goto out_undo_pci;
