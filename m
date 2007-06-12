Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id B6B32DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:45 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 4/6] [C67x00] Added error handling paths to lowlevel interface
	code
Date: Tue, 12 Jun 2007 17:02:19 -0600
Message-Id: <1181689350166-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11816893493783-git-send-email-grant.likely@secretlab.ca>
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix up some of the error paths in the low level code to not go into an
endless loop.  Replace the endless loops with failout code.

This patch is just a first step.  It eliminates the endless loops, but
some of the code paths don't yet have a failure path, so instead the
driver uses BUG_ON() to die with lots of noise.  The driver needs to be
refactored to add in the failure paths so the driver can fail gracefully

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/usb/c67x00/c67x00-drv.c    |    8 ++++-
 drivers/usb/c67x00/c67x00-ll-hpi.c |   57 ++++++++++++++++++++++-------------
 drivers/usb/c67x00/c67x00-ll-hpi.h |    6 ++--
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 6b38248..2737344 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -209,7 +209,11 @@ static int __devinit usb_c67x00_drv_probe(struct platform_device *pdev)
 		goto request_irq_failed;
 	}
 
-	c67x00_ll_reset(drv);
+	ret = c67x00_ll_reset(drv);
+	if (ret) {
+		dev_err(&pdev->dev, "Device reset failed\n");
+		goto reset_failed;
+	}
 
 	for (i = 0; i < C67X00_SIES; i++)
 		probe_sie(&drv->sie[i]);
@@ -218,6 +222,8 @@ static int __devinit usb_c67x00_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
+reset_failed:
+	free_irq(res2->start, drv);
 request_irq_failed:
 	iounmap(drv->hpi.base);
 map_failed:
diff --git a/drivers/usb/c67x00/c67x00-ll-hpi.c b/drivers/usb/c67x00/c67x00-ll-hpi.c
index f47ce79..868736a 100644
--- a/drivers/usb/c67x00/c67x00-ll-hpi.c
+++ b/drivers/usb/c67x00/c67x00-ll-hpi.c
@@ -243,7 +243,7 @@ static inline u16 ll_recv_msg(struct c67x00_drv *drv)
 	INIT_COMPLETION(drv->lcp.msg_received);
 	WARN_ON(!res);
 
-	return res;
+	return (res == 0) ? -EIO : 0;
 }
 
 static inline void ll_release(struct c67x00_drv *drv)
@@ -283,18 +283,22 @@ static inline void c67x00_ll_husb_sie_init(struct c67x00_sie *sie)
 {
 	struct c67x00_drv *drv = sie->drv;
 	struct lcp_int_data data;
+	int rc;
 
-	c67x00_comm_exec_int(drv, HUSB_SIE_INIT_INT(sie->sie_num), &data);
+	rc = c67x00_comm_exec_int(drv, HUSB_SIE_INIT_INT(sie->sie_num), &data);
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 }
 
 void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port)
 {
 	struct c67x00_drv *drv = sie->drv;
 	struct lcp_int_data data;
+	int rc;
 
 	data.regs[0] = 50;	/* Reset USB port for 50ms */
 	data.regs[1] = port | (sie->sie_num << 1);
-	c67x00_comm_exec_int(drv, HUSB_RESET_INT, &data);
+	rc = c67x00_comm_exec_int(drv, HUSB_RESET_INT, &data);
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 }
 
 void c67x00_ll_husb_set_current_td(struct c67x00_sie *sie, u16 addr)
@@ -358,10 +362,12 @@ void c67x00_ll_susb_init(struct c67x00_sie *sie)
 {
 	struct c67x00_drv *drv = sie->drv;
 	struct lcp_int_data data;
+	int rc;
 
 	data.regs[1] = 1;	/* full speed */
 	data.regs[2] = sie->sie_num + 1;
-	c67x00_comm_exec_int(drv, SUSB_INIT_INT, &data);
+	rc = c67x00_comm_exec_int(drv, SUSB_INIT_INT, &data);
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
 
 	hpi_clear_bits(drv, HPI_IRQ_ROUTING_REG,
 		       SOFEOP_TO_HPI_EN(sie->sie_num));
@@ -384,45 +390,54 @@ void c67x00_ll_irq(struct c67x00_drv *drv)
 u16 c67x00_comm_read_ctrl_reg(struct c67x00_drv * drv, u16 addr)
 {
 	unsigned long msg, res;
+	int rc;
 
 	ll_start(drv);
-	do {
-		hpi_write_word(drv, COMM_CTRL_REG_ADDR, addr);
-		hpi_send_mbox(drv, COMM_READ_CTRL_REG);
-	} while (!ll_recv_msg(drv));
+	hpi_write_word(drv, COMM_CTRL_REG_ADDR, addr);
+	hpi_send_mbox(drv, COMM_READ_CTRL_REG);
+	rc = ll_recv_msg(drv);
+
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+
 	msg = drv->lcp.last_msg;
 	if (msg != COMM_ACK) {
 		dev_warn(&drv->pdev->dev, "COMM_READ_CTRL_REG didn't ACK!\n");
 		res = 0;
-	} else
+	} else {
 		res = hpi_read_word(drv, COMM_CTRL_REG_DATA);
+	}
 	ll_release(drv);
 	return res;
 }
 
-void c67x00_comm_exec_int(struct c67x00_drv *drv, u16 nr,
+int c67x00_comm_exec_int(struct c67x00_drv *drv, u16 nr,
 			  struct lcp_int_data *data)
 {
+	int i, rc;
+
 	ll_start(drv);
-	do {
-		int i;
-		hpi_write_word(drv, COMM_INT_NUM, nr);
-		for (i = 0; i < COMM_REGS; i++)
-			hpi_write_word(drv, COMM_R(i), data->regs[i]);
-		hpi_send_mbox(drv, COMM_EXEC_INT);
-	} while (!ll_recv_msg(drv));
+	hpi_write_word(drv, COMM_INT_NUM, nr);
+	for (i = 0; i < COMM_REGS; i++)
+		hpi_write_word(drv, COMM_R(i), data->regs[i]);
+	hpi_send_mbox(drv, COMM_EXEC_INT);
+	rc = ll_recv_msg(drv);
 	ll_release(drv);
+
+	return rc;
 }
 
 /* -------------------------------------------------------------------------- */
 
-void c67x00_ll_reset(struct c67x00_drv *drv)
+int c67x00_ll_reset(struct c67x00_drv *drv)
 {
+	int rc;
+
 	ll_start(drv);
-	do {
-		hpi_send_mbox(drv, COMM_RESET);
-	} while (!ll_recv_msg(drv));
+	hpi_send_mbox(drv, COMM_RESET);
+	rc = ll_recv_msg(drv);
 	ll_release(drv);
+
+	return rc;
 }
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/c67x00/c67x00-ll-hpi.h b/drivers/usb/c67x00/c67x00-ll-hpi.h
index 118cd7d..3f84348 100644
--- a/drivers/usb/c67x00/c67x00-ll-hpi.h
+++ b/drivers/usb/c67x00/c67x00-ll-hpi.h
@@ -85,14 +85,14 @@ void c67x00_read_mem_le16(struct c67x00_drv *drv, u16 addr,
 
 u16 c67x00_comm_read_ctrl_reg(struct c67x00_drv *drv, u16 addr);
 
-void c67x00_comm_exec_int(struct c67x00_drv *drv, u16 nr,
-			  struct lcp_int_data *data);
+int c67x00_comm_exec_int(struct c67x00_drv *drv, u16 nr,
+			 struct lcp_int_data *data);
 
 /* Called by c67x00_irq to handle lcp interrupts */
 void c67x00_ll_irq(struct c67x00_drv *drv);
 
 void c67x00_ll_init(struct c67x00_drv *drv);
 void c67x00_ll_release(struct c67x00_drv *drv);
-void c67x00_ll_reset(struct c67x00_drv *drv);
+int c67x00_ll_reset(struct c67x00_drv *drv);
 
 #endif				/* _USB_C67X00_LL_HPI_H */
-- 
1.4.4.2
