To: linuxppc-dev@lists.linuxppc.org
Subject: QLogic ISP1020 SCSI driver worked.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19981211002700U.roikawa@rr.iij4u.or.jp>
Date: Fri, 11 Dec 1998 00:27:00 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

Qlogic ISP1020 SCSI driver worked by applying the patch listed below.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp


--- qlogicisp.c.orig	Sun Oct 11 04:37:47 1998
+++ qlogicisp.c	Thu Dec 10 23:36:32 1998
@@ -32,6 +32,16 @@
 #include "hosts.h"
 #include "qlogicisp.h"
 
+#if defined(CONFIG_PPC)
+#if !defined(__IPS1020_MMIO)
+#define __ISP1020_MMIO  1
+#endif
+#undef  inw
+#undef  outw
+#define inw(port)               in_le16((unsigned short *)(port))
+#define outw(val, port)         out_le16((unsigned short *)(port), (val))
+#endif
+
 /* Configuration section *****************************************************/
 
 /* Set the following macro to 1 to reload the ISP1020's firmware.  This is
@@ -49,7 +59,7 @@
 /*  Macros used for debugging */
 
 #define DEBUG_ISP1020		0
-#define DEBUG_ISP1020_INT	0
+#define DEBUG_ISP1020_INTR	0
 #define DEBUG_ISP1020_SETUP	0
 #define TRACE_ISP		0
 
@@ -113,6 +123,8 @@
 #define DEBUG_INTR(x)
 #endif /* DEBUG ISP1020_INTR */
 
+#define PCI_VENDOR_ID_QLOGIC         0x1077
+#define PCI_DEVICE_ID_QLOGIC_ISP1020 0x1020
 #define ISP1020_REV_ID	1
 
 #define MAX_TARGETS	16
@@ -539,6 +551,21 @@
 	S_IFDIR | S_IRUGO | S_IXUGO, 2
 };
 
+#if defined(__BIG_ENDIAN)
+static inline unsigned long endian_reverse32(unsigned long val)
+{
+  unsigned char *p = (unsigned char *)&val;
+  return ((p[3] << 24) | (p[2] << 16) | (p[1] << 8) | (p[0] << 0));
+}
+static inline unsigned short endian_reverse16(unsigned long val)
+{
+  unsigned char *p = (unsigned char *)&val;
+  return ((p[3] << 8) | (p[2] << 0));
+}
+#else
+#define endian_reverse32(val) (val)
+#define endian_reverse16(val) (val)
+#endif
 
 static inline void isp1020_enable_irqs(struct Scsi_Host *host)
 {
@@ -598,6 +625,7 @@
 			continue;
 		}
 
+#if !defined(__ISP1020_MMIO)
 		if (check_region(host->io_port, 0xff)) {
 			printk("qlogicisp : i/o region 0x%lx-0x%lx already "
 			       "in use\n",
@@ -608,6 +636,7 @@
 		}
 
 		request_region(host->io_port, 0xff, "qlogicisp");
+#endif
 
 		outw(0x0, host->io_port + PCI_SEMAPHORE);
 		outw(HCCR_CLEAR_RISC_INTR, host->io_port + HOST_HCCR);
@@ -633,7 +662,11 @@
 	outw(0x0, host->io_port + PCI_INTF_CTL);
 	free_irq(host->irq, host);
 
+#if defined(__ISP1020_MMIO)
+	iounmap(host->io_port);
+#else
 	release_region(host->io_port, 0xff);
+#endif
 
 	LEAVE("isp1020_release");
 
@@ -730,17 +763,18 @@
 	cmd->hdr.entry_type = ENTRY_COMMAND;
 	cmd->hdr.entry_cnt = 1;
 
-	cmd->handle = (u_int) virt_to_bus(Cmnd);
+	cmd->handle =  endian_reverse32(__pa(Cmnd));
 	cmd->target_lun = Cmnd->lun;
 	cmd->target_id = Cmnd->target;
-	cmd->cdb_length = Cmnd->cmd_len;
-	cmd->control_flags = CFLAG_READ | CFLAG_WRITE;
-	cmd->time_out = 30;
+	cmd->cdb_length = endian_reverse16(Cmnd->cmd_len);
+	cmd->control_flags = endian_reverse16(CFLAG_READ | CFLAG_WRITE);
+	cmd->time_out = endian_reverse16(30);
 
 	memcpy(cmd->cdb, Cmnd->cmnd, Cmnd->cmd_len);
 
 	if (Cmnd->use_sg) {
-		cmd->segment_cnt = sg_count = Cmnd->use_sg;
+	        sg_count = Cmnd->use_sg;
+		cmd->segment_cnt = endian_reverse16(sg_count);
 		sg = (struct scatterlist *) Cmnd->request_buffer;
 		ds = cmd->dataseg;
 
@@ -749,8 +783,8 @@
 		if (n > 4)
 			n = 4;
 		for (i = 0; i < n; i++) {
-			ds[i].d_base  = (u_int) virt_to_bus(sg->address);
-			ds[i].d_count = sg->length;
+			ds[i].d_base  = endian_reverse32(__pa(sg->address));
+			ds[i].d_count = endian_reverse32(sg->length);
 			++sg;
 		}
 		sg_count -= 4;
@@ -770,24 +804,22 @@
 			cont->hdr.entry_cnt  = 0;
 			cont->hdr.sys_def_1  = 0;
 			cont->hdr.flags      = 0;
-			cont->reserved = 0;
+			cont->reserved = endian_reverse32(0);
 			ds = cont->dataseg;
 			n = sg_count;
 			if (n > 7)
 				n = 7;
 			for (i = 0; i < n; ++i) {
-				ds[i].d_base = (u_int)virt_to_bus(sg->address);
-				ds[i].d_count = sg->length;
+				ds[i].d_base = endian_reverse32(__pa(sg->address));
+				ds[i].d_count = endian_reverse32(sg->length);
 				++sg;
 			}
 			sg_count -= n;
 		}
 	} else {
-		cmd->dataseg[0].d_base =
-			(u_int) virt_to_bus(Cmnd->request_buffer);
-		cmd->dataseg[0].d_count =
-			(u_int) Cmnd->request_bufflen;
-		cmd->segment_cnt = 1;
+		cmd->dataseg[0].d_base = endian_reverse32(__pa(Cmnd->request_buffer));
+		cmd->dataseg[0].d_count = endian_reverse32(Cmnd->request_bufflen);
+		cmd->segment_cnt = endian_reverse16(1);
 	}
 
 	outw(in_ptr, host->io_port + MBOX4);
@@ -861,22 +893,23 @@
 
 	DEBUG_INTR(printk("qlogicisp : response queue update\n"));
 	DEBUG_INTR(printk("qlogicisp : response queue depth %d\n",
-			  QUEUE_DEPTH(in_ptr, out_ptr)));
+			  RES_QUEUE_DEPTH(in_ptr, out_ptr)));
 
 	while (out_ptr != in_ptr) {
 		sts = (struct Status_Entry *) &hostdata->res[out_ptr][0];
 		out_ptr = (out_ptr + 1) & RES_QUEUE_LEN;
 
-		Cmnd = (Scsi_Cmnd *) bus_to_virt(sts->handle);
+		Cmnd = (Scsi_Cmnd *)__va(endian_reverse32(sts->handle));
 
 		TRACE("done", out_ptr, Cmnd);
 
-		if (sts->completion_status == CS_RESET_OCCURRED
-		    || sts->completion_status == CS_ABORTED
-		    || (sts->status_flags & STF_BUS_RESET))
+		status = endian_reverse16(sts->completion_status);
+		if (status == CS_RESET_OCCURRED
+		    || status == CS_ABORTED
+		    || (endian_reverse16(sts->status_flags) & STF_BUS_RESET))
 			hostdata->send_marker = 1;
 
-		if (sts->state_flags & SF_GOT_SENSE)
+		if (endian_reverse16(sts->state_flags) & SF_GOT_SENSE)
 			memcpy(Cmnd->sense_buffer, sts->req_sense_data,
 			       sizeof(Cmnd->sense_buffer));
 
@@ -913,28 +946,29 @@
 		"DID_BAD_INTR"
 	};
 #endif /* DEBUG_ISP1020_INTR */
+	u_short state_flags = endian_reverse16(sts->state_flags);
 
 	ENTER("isp1020_return_status");
 
 	DEBUG(printk("qlogicisp : completion status = 0x%04x\n",
-		     sts->completion_status));
+		     endian_reverse16(sts->completion_status)));
 
-	switch(sts->completion_status) {
+	switch(endian_reverse16(sts->completion_status)) {
 	      case CS_COMPLETE:
 		host_status = DID_OK;
 		break;
 	      case CS_INCOMPLETE:
-		if (!(sts->state_flags & SF_GOT_BUS))
+		if (!(state_flags & SF_GOT_BUS))
 			host_status = DID_NO_CONNECT;
-		else if (!(sts->state_flags & SF_GOT_TARGET))
+		else if (!(state_flags & SF_GOT_TARGET))
 			host_status = DID_BAD_TARGET;
-		else if (!(sts->state_flags & SF_SENT_CDB))
+		else if (!(state_flags & SF_SENT_CDB))
 			host_status = DID_ERROR;
-		else if (!(sts->state_flags & SF_TRANSFERRED_DATA))
+		else if (!(state_flags & SF_TRANSFERRED_DATA))
 			host_status = DID_ERROR;
-		else if (!(sts->state_flags & SF_GOT_STATUS))
+		else if (!(state_flags & SF_GOT_STATUS))
 			host_status = DID_ERROR;
-		else if (!(sts->state_flags & SF_GOT_SENSE))
+		else if (!(state_flags & SF_GOT_SENSE))
 			host_status = DID_ERROR;
 		break;
 	      case CS_DMA_ERROR:
@@ -970,17 +1004,17 @@
 		break;
 	      default:
 		printk("qlogicisp : unknown completion status 0x%04x\n",
-		       sts->completion_status);
+		       endian_reverse16(sts->completion_status));
 		host_status = DID_ERROR;
 		break;
 	}
 
 	DEBUG_INTR(printk("qlogicisp : host status (%s) scsi status %x\n",
-			  reason[host_status], sts->scsi_status));
+			  reason[host_status], endian_reverse16(sts->scsi_status)));
 
 	LEAVE("isp1020_return_status");
 
-	return (sts->scsi_status & STATUS_MASK) | (host_status << 16);
+	return (endian_reverse16(sts->scsi_status) & STATUS_MASK) | (host_status << 16);
 }
 
 
@@ -990,7 +1024,7 @@
 	struct Scsi_Host *host;
 	struct isp1020_hostdata *hostdata;
 	int return_status = SCSI_ABORT_SUCCESS;
-	u_int cmdaddr = virt_to_bus(Cmnd);
+	u_int cmdaddr = __pa(Cmnd);
 
 	ENTER("isp1020_abort");
 
@@ -1184,7 +1218,18 @@
 		printk("qlogicisp : error reading PCI configuration\n");
 		return 1;
 	}
+#if defined(CONFIG_PPC)
+	command |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER
+	  | PCI_COMMAND_SPECIAL | PCI_COMMAND_INVALIDATE;
+	pci_write_config_word(pdev, PCI_COMMAND, command);
+#endif
+#if defined(__ISP1020_MMIO)
+	io_base =  (unsigned long)ioremap(pdev->base_address[1], 0x1000);
+	printk("qlogicisp: MMIO 0x%08x mapped at 0x%08x\n",
+	       pdev->base_address[1], io_base);
+#else
 	io_base = pdev->base_address[0];
+#endif
 	irq = pdev->irq;
 
 	if (pdev->vendor != PCI_VENDOR_ID_QLOGIC) {
@@ -1199,17 +1244,23 @@
 		return 1;
 	}
 
+#if !defined(__ISP1020_MMIO)
 	if (command & PCI_COMMAND_IO && (io_base & 3) == 1)
 		io_base &= PCI_BASE_ADDRESS_IO_MASK;
 	else {
 		printk("qlogicisp : i/o mapping is disabled\n");
 		return 1;
 	}
+#endif
 
+#if defined(CONFIG_PPC)
+	/* Already set PCI_COMMAND_MASTER */
+#else
 	if (!(command & PCI_COMMAND_MASTER)) {
 		printk("qlogicisp : bus mastering is disabled\n");
 		return 1;
 	}
+#endif
 
 	if (revision != ISP1020_REV_ID)
 		printk("qlogicisp : new isp1020 revision ID (%d)\n", revision);
@@ -1217,7 +1268,7 @@
 	if (inw(io_base + PCI_ID_LOW) != PCI_VENDOR_ID_QLOGIC
 	    || inw(io_base + PCI_ID_HIGH) != PCI_DEVICE_ID_QLOGIC_ISP1020)
 	{
-		printk("qlogicisp : can't decode i/o address space 0x%lx\n",
+		printk("qlogicisp : can't decode (mm)i/o address space 0x%lx\n",
 		       io_base);
 		return 1;
 	}
@@ -1582,7 +1633,7 @@
 		}
 	}
 
-	queue_addr = (u_int) virt_to_bus(&hostdata->res[0][0]);
+	queue_addr = (u_int)__pa(&hostdata->res[0][0]);
 
 	param[0] = MBOX_INIT_RES_QUEUE;
 	param[1] = RES_QUEUE_LEN + 1;
@@ -1599,7 +1650,7 @@
 		return 1;
 	}
 
-	queue_addr = (u_int) virt_to_bus(&hostdata->req[0][0]);
+	queue_addr = (u_int)__pa(&hostdata->req[0][0]);
 
 	param[0] = MBOX_INIT_REQ_QUEUE;
 	param[1] = QLOGICISP_REQ_QUEUE_LEN + 1;


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
