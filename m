Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3FFAC68901
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 14:57:48 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	jBK48h5m015304 for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 21:08:43 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jBK44xOY002650
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 22:05:00 -0600 (CST)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730428C473@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linux-usb-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Date: Tue, 20 Dec 2005 11:57:36 +0800
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH] MPC8349 MDS USB HOST support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Here is the patch we have in Freescale released BSP.  I post it here in case anyone may need it without the BSP.  It's for kernel 2.6.11, and won't have big problem for newer kernel, I think.  The patch is not done by myself, and maybe submitted later formally after merge with OTG and clean up.  Here goes the patch.


diff -Nur linux/drivers/usb/core/hcd.c linux-8349-2.6/drivers/usb/core/hcd.c
--- linux/drivers/usb/core/hcd.c	2005-03-02 15:38:10.000000000 +0800
+++ linux-8349-2.6/drivers/usb/core/hcd.c	2005-08-15 13:54:13.000000000 +0800
@@ -1116,13 +1116,20 @@
 	if (hcd->self.controller->dma_mask) {
 		if (usb_pipecontrol (urb->pipe)
 			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
+#ifdef CONFIG_FSL_USB20
+        		urb->setup_dma = (unsigned long)urb->setup_packet;
+#else
 			urb->setup_dma = dma_map_single (
 					hcd->self.controller,
 					urb->setup_packet,
 					sizeof (struct usb_ctrlrequest),
 					DMA_TO_DEVICE);
+#endif
 		if (urb->transfer_buffer_length != 0
 			&& !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
+#ifdef CONFIG_FSL_USB20
+            		urb->transfer_dma = (unsigned long)urb->transfer_buffer;
+#else
 			urb->transfer_dma = dma_map_single (
 					hcd->self.controller,
 					urb->transfer_buffer,
@@ -1130,6 +1137,7 @@
 					usb_pipein (urb->pipe)
 					    ? DMA_FROM_DEVICE
 					    : DMA_TO_DEVICE);
+#endif
 	}
 
 	status = hcd->driver->urb_enqueue (hcd, ep, urb, mem_flags);
@@ -1469,6 +1477,8 @@
 	// It would catch exit/unlink paths for all urbs.
 
 	/* lower level hcd code should use *_dma exclusively */
+#ifdef CONFIG_FSL_USB20
+#else
 	if (hcd->self.controller->dma_mask) {
 		if (usb_pipecontrol (urb->pipe)
 			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
@@ -1484,7 +1494,7 @@
 					    ? DMA_FROM_DEVICE
 					    : DMA_TO_DEVICE);
 	}
-
+#endif
 	/* pass ownership to the completion handler */
 	urb->complete (urb, regs);
 	atomic_dec (&urb->use_count);
diff -Nur linux/drivers/usb/core/hub.c linux-8349-2.6/drivers/usb/core/hub.c
--- linux/drivers/usb/core/hub.c	2005-03-02 15:38:08.000000000 +0800
+++ linux-8349-2.6/drivers/usb/core/hub.c	2005-08-15 13:56:05.000000000 +0800
@@ -2155,7 +2155,11 @@
 	} else if (udev->speed != USB_SPEED_HIGH
 			&& hdev->speed == USB_SPEED_HIGH) {
 		udev->tt = &hub->tt;
+#ifdef CONFIG_FSL_USB20
+		udev->ttport = port1+1;
+#else
 		udev->ttport = port1;
+#endif
 	}
  
 	/* Why interleave GET_DESCRIPTOR and SET_ADDRESS this way?
diff -Nur linux/drivers/usb/host/ehci.h linux-8349-2.6/drivers/usb/host/ehci.h
--- linux/drivers/usb/host/ehci.h	2005-03-02 15:38:25.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/ehci.h	2005-08-15 10:25:52.000000000 +0800
@@ -59,6 +59,9 @@
 #define	DEFAULT_I_TDPS		1024		/* some HCs can do less */
 	unsigned		periodic_size;
 	__le32			*periodic;	/* hw periodic table */
+#ifdef CONFIG_FSL_USB20
+	u32		        orig_periodic;
+#endif
 	dma_addr_t		periodic_dma;
 	unsigned		i_thresh;	/* uframes HC might cache */
 
@@ -70,11 +73,17 @@
 	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
 
 	/* per-HC memory pools (could be per-bus, but ...) */
+#ifdef CONFIG_FSL_USB20
+	t_MemorySegment   *qh_pool;     /* qh per active urb      */
+	t_MemorySegment   *qtd_pool;    /* one or more per qh     */
+	t_MemorySegment   *itd_pool;    /* itd per iso urb        */
+	t_MemorySegment   *sitd_pool;   /* sitd per split iso urb */
+#else
 	struct dma_pool		*qh_pool;	/* qh per active urb */
 	struct dma_pool		*qtd_pool;	/* one or more per qh */
 	struct dma_pool		*itd_pool;	/* itd per iso urb */
 	struct dma_pool		*sitd_pool;	/* sitd per split iso urb */
-
+#endif
 	struct timer_list	watchdog;
 	struct notifier_block	reboot_notifier;
 	unsigned long		actions;
@@ -230,9 +239,26 @@
 	u32		frame_list; 	/* points to periodic list */
 	/* ASYNCLISTADDR: offset 0x18 */
 	u32		async_next;	/* address of next async queue head */
-
+#ifdef CONFIG_FSL_USB20
+        /* ASYNCTTSTS: offset 0x1c */
+	u32	        async_tt_status;    /* async queue status for embedded TT */
+    	/* BURSTSIZE: offset 0x20 */
+	u32     	burst_size;         /* programmable burst size */
+    	/* TXFILLTUNING: offset 0x24 */
+	u32        	txfilltuning;       /* host transmit pre-buffer packet tuning */
+    	/* TXTTFILLTUNING: offset 0x28 */
+	u32        	txttfilltuning;     /* host TT transmit pre-buffer packet tuning */
+	u32        	reserved0;
+    	/* ULPIVIEWPORT: offset 0x30 */
+	u32        	ulpi_view_port;     /* ULPI view port */
+    	/* ENDPTNAK: offset 0x34 */
+	u32        	endpoint_nack;      /* endpoint nack */
+    	/* ENDPTNAKEN: offset 0x38 */
+	u32        	endpoint_nack_en;   /* endpoint nack enable */
+	u32        	reserved1;
+#else
 	u32		reserved [9];
-
+#endif
 	/* CONFIGFLAG: offset 0x40 */
 	u32		configured_flag;
 #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
diff -Nur linux/drivers/usb/host/ehci-hcd.c linux-8349-2.6/drivers/usb/host/ehci-hcd.c
--- linux/drivers/usb/host/ehci-hcd.c	2005-03-02 15:38:38.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/ehci-hcd.c	2005-08-15 10:40:35.000000000 +0800
@@ -16,6 +16,13 @@
  * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#ifdef CONFIG_FSL_USB20
+#ifdef CONFIG_USB_DEBUG	
+	#define DEBUG
+#else
+	#undef DEBUG
+#endif
+#else
 #include <linux/config.h>
 
 #ifdef CONFIG_USB_DEBUG
@@ -101,8 +108,17 @@
 #define DRIVER_AUTHOR "David Brownell"
 #define DRIVER_DESC "USB 2.0 'Enhanced' Host Controller (EHCI) Driver"
 
-static const char	hcd_name [] = "ehci_hcd";
+#endif
 
+#ifdef CONFIG_FSL_USB20
+#if defined (CONFIG_MPH_USB_SUPPORT)
+static const char	hcd_name [] = "fsl-usb2-mph";
+#elif defined (CONFIG_DR_USB_SUPPORT)
+static const char	hcd_name [] = "fsl-usb2-dr";
+#endif
+#else
+static const char	hcd_name [] = "ehci_hcd";
+#endif
 
 #undef EHCI_VERBOSE_DEBUG
 #undef EHCI_URB_TRACE
@@ -112,6 +128,7 @@
 #endif
 
 /* magic numbers that can affect system performance */
+
 #define	EHCI_TUNE_CERR		3	/* 0-3 qtd retries; 0 == don't stop */
 #define	EHCI_TUNE_RL_HS		4	/* nak throttle; see 4.9 */
 #define	EHCI_TUNE_RL_TT		0
@@ -126,13 +143,18 @@
 
 /* Initial IRQ latency:  faster than hw default */
 static int log2_irq_thresh = 0;		// 0 to 6
+#ifdef CONFIG_FSL_USB20
+#else
 module_param (log2_irq_thresh, int, S_IRUGO);
 MODULE_PARM_DESC (log2_irq_thresh, "log2 IRQ latency, 1-64 microframes");
-
+#endif
 /* initial park setting:  slower than hw default */
 static unsigned park = 0;
+#ifdef CONFIG_FSL_USB20
+#else
 module_param (park, uint, S_IRUGO);
 MODULE_PARM_DESC (park, "park setting; 1-3 back-to-back async packets");
+#endif
 
 #define	INTR_MASK (STS_IAA | STS_FATAL | STS_PCD | STS_ERR | STS_INT)
 
@@ -190,7 +212,27 @@
 	writel (temp, &ehci->regs->command);
 	return handshake (&ehci->regs->status, STS_HALT, STS_HALT, 16 * 125);
 }
+#ifdef CONFIG_FSL_USB20
+static void mpc8349_usb_reset(void);
+/* reset a non-running (STS_HALT == 1) controller */
+static int ehci_reset (struct ehci_hcd *ehci)
+{
+	int retval;
+	u32	command = readl (&ehci->regs->command);
 
+	command |= CMD_RESET;
+	dbg_cmd (ehci, "reset", command);
+	writel (command, &ehci->regs->command);
+	ehci_to_hcd(ehci)->state = USB_STATE_HALT;
+	ehci->next_statechange = jiffies;
+	retval = handshake (&ehci->regs->command, CMD_RESET, 0, 250 * 1000);
+
+	if (retval)
+		return retval;
+	mpc8349_usb_reset ();
+	return retval;
+}
+#else
 /* reset a non-running (STS_HALT == 1) controller */
 static int ehci_reset (struct ehci_hcd *ehci)
 {
@@ -203,7 +245,7 @@
 	ehci->next_statechange = jiffies;
 	return handshake (&ehci->regs->command, CMD_RESET, 0, 250 * 1000);
 }
-
+#endif
 /* idle the controller (from running) */
 static void ehci_quiesce (struct ehci_hcd *ehci)
 {
@@ -276,7 +318,7 @@
 	spin_unlock_irqrestore (&ehci->lock, flags);
 }
 
-#ifdef	CONFIG_PCI
+#if defined(CONFIG_PCI) && !defined(CONFIG_FSL_USB20)
 
 /* EHCI 0.96 (and later) section 5.1 says how to kick BIOS/SMM/...
  * off the controller (maybe it can boot from highspeed USB disks).
@@ -285,18 +327,22 @@
 {
 	if (cap & (1 << 16)) {
 		int msec = 5000;
+
 		struct pci_dev *pdev =
 				to_pci_dev(ehci_to_hcd(ehci)->self.controller);
 
 		/* request handoff to OS */
 		cap |= 1 << 24;
+
 		pci_write_config_dword(pdev, where, cap);
 
 		/* and wait a while for it to happen */
 		do {
 			msleep(10);
 			msec -= 10;
+
 			pci_read_config_dword(pdev, where, &cap);
+
 		} while ((cap & (1 << 16)) && msec);
 		if (cap & (1 << 16)) {
 			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n",
@@ -332,7 +378,10 @@
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	u32			temp;
+#ifdef CONFIG_FSL_USB20
+#else
 	unsigned		count = 256/4;
+#endif
 
 	spin_lock_init (&ehci->lock);
 
@@ -340,8 +389,14 @@
 	ehci->regs = hcd->regs + HC_LENGTH (readl (&ehci->caps->hc_capbase));
 	dbg_hcs_params (ehci, "reset");
 	dbg_hcc_params (ehci, "reset");
+	
 
-#ifdef	CONFIG_PCI
+#ifdef CONFIG_FSL_USB20
+	mpc8349_usb_reset ();
+	ehci->is_arc_rh_tt = 1;
+#endif
+
+#if defined(CONFIG_PCI) && !defined(CONFIG_FSL_USB20)
 	/* EHCI 0.96 and later may have "extended capabilities" */
 	if (hcd->self.controller->bus == &pci_bus_type) {
 		struct pci_dev	*pdev = to_pci_dev(hcd->self.controller);
@@ -395,7 +450,7 @@
 			HCS_N_PCC(ehci->hcs_params),
 			HCS_N_PORTS(ehci->hcs_params));
 
-#ifdef	CONFIG_PCI
+#if defined(CONFIG_PCI) && !defined(CONFIG_FSL_USB20)
 		if (hcd->self.controller->bus == &pci_bus_type) {
 			struct pci_dev	*pdev;
 
@@ -465,7 +520,7 @@
 	}
 	writel (ehci->periodic_dma, &ehci->regs->frame_list);
 
-#ifdef	CONFIG_PCI
+#if defined(CONFIG_PCI) && !defined(CONFIG_FSL_USB20)
 	if (hcd->self.controller->bus == &pci_bus_type) {
 		struct pci_dev		*pdev;
 		u16			port_wake;
@@ -829,7 +884,7 @@
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	u32			status;
 	int			bh;
-
+	
 	spin_lock (&ehci->lock);
 
 	status = readl (&ehci->regs->status);
@@ -1181,6 +1236,9 @@
 /*-------------------------------------------------------------------------*/
 
 /* EHCI 1.0 doesn't require PCI */
+#ifdef CONFIG_FSL_USB20
+
+#else
 
 #ifdef	CONFIG_PCI
 
@@ -1236,3 +1294,4 @@
 	pci_unregister_driver (&ehci_pci_driver);
 }
 module_exit (cleanup);
+#endif
diff -Nur linux/drivers/usb/host/ehci-mem.c linux-8349-2.6/drivers/usb/host/ehci-mem.c
--- linux/drivers/usb/host/ehci-mem.c	2005-03-02 15:38:26.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/ehci-mem.c	2005-08-15 10:46:53.000000000 +0800
@@ -49,8 +49,13 @@
 {
 	struct ehci_qtd		*qtd;
 	dma_addr_t		dma;
-
+#ifdef CONFIG_FSL_USB20
+	qtd = MEM_Get( ehci->qtd_pool);
+	dma = virt_to_phys(qtd);
+	memset(qtd, 0, sizeof(*qtd));
+#else
 	qtd = dma_pool_alloc (ehci->qtd_pool, flags, &dma);
+#endif
 	if (qtd != NULL) {
 		ehci_qtd_init (qtd, dma);
 	}
@@ -59,7 +64,11 @@
 
 static inline void ehci_qtd_free (struct ehci_hcd *ehci, struct ehci_qtd *qtd)
 {
+#ifdef CONFIG_FSL_USB20
+	MEM_Put(ehci->qtd_pool, qtd);
+#else
 	dma_pool_free (ehci->qtd_pool, qtd, qtd->qtd_dma);
+#endif
 }
 
 
@@ -75,8 +84,12 @@
 	}
 	if (qh->dummy)
 		ehci_qtd_free (ehci, qh->dummy);
+#ifdef CONFIG_FSL_USB20
+	MEM_Put(ehci->qh_pool, qh);
+#else
 	usb_put_dev (qh->dev);
 	dma_pool_free (ehci->qh_pool, qh, qh->qh_dma);
+#endif
 }
 
 static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, int flags)
@@ -84,8 +97,14 @@
 	struct ehci_qh		*qh;
 	dma_addr_t		dma;
 
+#ifdef CONFIG_FSL_USB20
+	qh = (struct ehci_qh *) MEM_Get(ehci->qh_pool);
+	dma = virt_to_phys(qh);
+	memset(qh, 0, sizeof(*qh));
+#else
 	qh = (struct ehci_qh *)
 		dma_pool_alloc (ehci->qh_pool, flags, &dma);
+#endif
 	if (!qh)
 		return qh;
 
@@ -100,7 +119,11 @@
 	qh->dummy = ehci_qtd_alloc (ehci, flags);
 	if (qh->dummy == NULL) {
 		ehci_dbg (ehci, "no dummy td\n");
+#ifdef CONFIG_FSL_USB20
+		MEM_Put(ehci->qh_pool, qh);
+#else
 		dma_pool_free (ehci->qh_pool, qh, qh->qh_dma);
+#endif
 		qh = NULL;
 	}
 	return qh;
@@ -133,26 +156,46 @@
 
 	/* DMA consistent memory and pools */
 	if (ehci->qtd_pool)
+#ifdef CONFIG_FSL_USB20
+		MEM_Free(ehci->qtd_pool);
+#else
 		dma_pool_destroy (ehci->qtd_pool);
+#endif
 	ehci->qtd_pool = NULL;
 
 	if (ehci->qh_pool) {
+#ifdef CONFIG_FSL_USB20
+		MEM_Free(ehci->qh_pool);
+#else
 		dma_pool_destroy (ehci->qh_pool);
+#endif
 		ehci->qh_pool = NULL;
 	}
 
 	if (ehci->itd_pool)
+#ifdef CONFIG_FSL_USB20
+		MEM_Free(ehci->itd_pool);
+#else	
 		dma_pool_destroy (ehci->itd_pool);
+#endif
 	ehci->itd_pool = NULL;
 
 	if (ehci->sitd_pool)
+#ifdef CONFIG_FSL_USB20
+		MEM_Free(ehci->sitd_pool);
+#else	
 		dma_pool_destroy (ehci->sitd_pool);
+#endif
 	ehci->sitd_pool = NULL;
 
 	if (ehci->periodic)
+#ifdef CONFIG_FSL_USB20
+		kfree((void *)ehci->orig_periodic);
+#else
 		dma_free_coherent (ehci_to_hcd(ehci)->self.controller,
 			ehci->periodic_size * sizeof (u32),
 			ehci->periodic, ehci->periodic_dma);
+#endif
 	ehci->periodic = NULL;
 
 	/* shadow periodic table */
@@ -165,23 +208,31 @@
 static int ehci_mem_init (struct ehci_hcd *ehci, int flags)
 {
 	int i;
+	int err;
 
 	/* QTDs for control/bulk/intr transfers */
+#ifdef CONFIG_FSL_USB20
+	err = MEM_Init("ehci_qtd_pool", (void **)&ehci->qtd_pool, 128, sizeof(struct ehci_qtd), 0, 0, 32);
+#else
 	ehci->qtd_pool = dma_pool_create ("ehci_qtd", 
 			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_qtd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
+#endif
 	if (!ehci->qtd_pool) {
 		goto fail;
 	}
-
+#ifdef CONFIG_FSL_USB20
+	err = MEM_Init("ehci_qh_pool", (void **)&ehci->qh_pool, 128, sizeof(struct ehci_qh), 0, 0, 64);
+#else
 	/* QHs for control/bulk/intr transfers */
 	ehci->qh_pool = dma_pool_create ("ehci_qh", 
 			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_qh),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
+#endif
 	if (!ehci->qh_pool) {
 		goto fail;
 	}
@@ -191,30 +242,47 @@
 	}
 
 	/* ITD for high speed ISO transfers */
+#ifdef CONFIG_FSL_USB20
+	err = MEM_Init("ehci_itd_pool", (void **)&ehci->itd_pool, 128, sizeof(struct ehci_itd), 0, 0, 32);
+#else
 	ehci->itd_pool = dma_pool_create ("ehci_itd", 
 			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_itd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
+#endif
 	if (!ehci->itd_pool) {
 		goto fail;
 	}
 
 	/* SITD for full/low speed split ISO transfers */
+#ifdef CONFIG_FSL_USB20
+        err = MEM_Init("ehci_sitd_pool", (void**)&ehci->sitd_pool, 128, sizeof(struct ehci_sitd), 0, 0, 32);
+#else
 	ehci->sitd_pool = dma_pool_create ("ehci_sitd", 
 			ehci_to_hcd(ehci)->self.controller,
 			sizeof (struct ehci_sitd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
+#endif
 	if (!ehci->sitd_pool) {
 		goto fail;
 	}
 
 	/* Hardware periodic table */
+#ifdef CONFIG_FSL_USB20
+	ehci->orig_periodic =(u32)kmalloc((int)(ehci->periodic_size * sizeof (u32))+0x1000,GFP_KERNEL);
+	if(ehci->orig_periodic%0x1000)
+		ehci->periodic = (__le32 *)(((ehci->orig_periodic>>12)<<12)+0x1000);
+    	else
+		ehci->periodic = (__le32 *)ehci->orig_periodic;
+	ehci->periodic_dma = virt_to_phys(ehci->periodic);
+#else
 	ehci->periodic = (__le32 *)
 		dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
 			ehci->periodic_size * sizeof(__le32),
 			&ehci->periodic_dma, 0);
+#endif
 	if (ehci->periodic == NULL) {
 		goto fail;
 	}
diff -Nur linux/drivers/usb/host/ehci-q.c linux-8349-2.6/drivers/usb/host/ehci-q.c
--- linux/drivers/usb/host/ehci-q.c	2005-03-02 15:38:19.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/ehci-q.c	2005-08-15 10:50:13.000000000 +0800
@@ -500,7 +500,11 @@
 	is_input = usb_pipein (urb->pipe);
 	if (usb_pipecontrol (urb->pipe)) {
 		/* SETUP pid */
+#ifdef CONFIG_FSL_USB20
+		qtd_fill (qtd, virt_to_phys(urb->setup_packet), sizeof (struct usb_ctrlrequest),
+#else
 		qtd_fill (qtd, urb->setup_dma, sizeof (struct usb_ctrlrequest),
+#endif
 			token | (2 /* "setup" */ << 8), 8);
 
 		/* ... and always at least one more pid */
@@ -518,7 +522,11 @@
 	 * data transfer stage:  buffer setup
 	 */
 	if (likely (len > 0))
+#ifdef CONFIG_FSL_USB20
+		buf = virt_to_phys(urb->transfer_buffer);
+#else
 		buf = urb->transfer_dma;
+#endif
 	else
 		buf = 0;
 
@@ -712,8 +720,11 @@
 		info1 |= maxp << 16;
 
 		info2 |= (EHCI_TUNE_MULT_TT << 30);
+#ifdef CONFIG_FSL_USB20
+		info2 |= (urb->dev->ttport-1) << 23;
+#else
 		info2 |= urb->dev->ttport << 23;
-
+#endif
 		/* set the address of the TT; for ARC's integrated
 		 * root hub tt, leave it zeroed.
 		 */
@@ -863,7 +874,11 @@
 			dummy = qh->dummy;
 
 			dma = dummy->qtd_dma;
+#ifdef CONFIG_FSL_USB20
+			memcpy(dummy,qtd,sizeof(struct ehci_qtd));
+#else
 			*dummy = *qtd;
+#endif
 			dummy->qtd_dma = dma;
 
 			list_del (&qtd->qtd_list);
@@ -925,6 +940,7 @@
 	if (likely (qh != NULL)) {
 		if (likely (qh->qh_state == QH_STATE_IDLE))
 			qh_link_async (ehci, qh_get (qh));
+		
 	}
 	spin_unlock_irqrestore (&ehci->lock, flags);
 	if (unlikely (qh == NULL)) {
diff -Nur linux/drivers/usb/host/ehci-sched.c linux-8349-2.6/drivers/usb/host/ehci-sched.c
--- linux/drivers/usb/host/ehci-sched.c	2005-03-02 15:37:53.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/ehci-sched.c	2005-08-15 10:53:16.000000000 +0800
@@ -699,8 +699,11 @@
 
 	} else {
 		u32		addr;
-
+#ifdef CONFIG_FSL_USB20
+		addr = (u32)((dev->ttport-1) << 24);
+#else
 		addr = dev->ttport << 24;
+#endif
 		addr |= dev->tt->hub->devnum << 16;
 		addr |= epnum << 8;
 		addr |= dev->devnum;
@@ -759,15 +762,23 @@
 
 				itd = list_entry (entry, struct ehci_itd,
 						itd_list);
+#ifdef CONFIG_FSL_USB20
+				MEM_Put(ehci->itd_pool, itd);
+#else
 				dma_pool_free (ehci->itd_pool, itd,
 						itd->itd_dma);
+#endif
 			} else {
 				struct ehci_sitd	*sitd;
 
 				sitd = list_entry (entry, struct ehci_sitd,
 						sitd_list);
+#ifdef CONFIG_FSL_USB20
+   		                MEM_Put(ehci->sitd_pool, sitd);
+#else
 				dma_pool_free (ehci->sitd_pool, sitd,
 						sitd->sitd_dma);
+#endif
 			}
 		}
 
@@ -865,8 +876,11 @@
 )
 {
 	unsigned	i;
+#ifdef CONFIG_FSL_USB20
+	dma_addr_t      dma = virt_to_phys(urb->transfer_buffer);
+#else
 	dma_addr_t	dma = urb->transfer_dma;
-
+#endif
 	/* how many uframes are needed for these transfers */
 	iso_sched->span = urb->number_of_packets * stream->interval;
 
@@ -956,8 +970,14 @@
 
 		if (!itd) {
 			spin_unlock_irqrestore (&ehci->lock, flags);
+#ifdef CONFIG_FSL_USB20
+			itd = MEM_Get(ehci->itd_pool);
+			itd_dma = virt_to_phys(itd);
+
+#else
 			itd = dma_pool_alloc (ehci->itd_pool, mem_flags,
 					&itd_dma);
+#endif
 			spin_lock_irqsave (&ehci->lock, flags);
 		}
 
@@ -1559,8 +1579,13 @@
 
 		if (!sitd) {
 			spin_unlock_irqrestore (&ehci->lock, flags);
+#ifdef CONFIG_FSL_USB20
+			sitd = MEM_Get (ehci->sitd_pool);
+			sitd_dma = virt_to_phys(sitd);
+#else
 			sitd = dma_pool_alloc (ehci->sitd_pool, mem_flags,
 					&sitd_dma);
+#endif
 			spin_lock_irqsave (&ehci->lock, flags);
 		}
 
diff -Nur linux/drivers/usb/host/fsl-usb.c linux-8349-2.6/drivers/usb/host/fsl-usb.c
--- linux/drivers/usb/host/fsl-usb.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/fsl-usb.c	2005-08-25 11:50:08.000000000 +0800
@@ -0,0 +1,303 @@
+/* 
+ * Copyright (c) 2005 freescale semiconductor
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/reboot.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include <asm/unaligned.h>
+
+#include "../core/hcd.h"
+#include "fsl-usb.h"
+
+#define DRIVER_VERSION "$Revision: 1.11 $"
+#define DRIVER_AUTHOR "Hunter Wu"
+#define DRIVER_DESC "USB 2.0 Freescale EHCI Driver"
+#define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
+
+MODULE_DESCRIPTION("MPC8249 USB Host Controller Driver");
+
+#include "ehci-hcd.c"
+
+void mpc8349_board_init(void)
+{
+	volatile unsigned char *bcsr5_p;
+
+	/* if SYS board is plug into PIB board, force to use the PHY on SYS board */
+	bcsr5_p = (volatile unsigned char *)(CFG_BCSR_BASE + 0x00000005); 
+	if ( (*bcsr5_p & BCSR5_INT_USB) == 0 ) 
+		*bcsr5_p = (*bcsr5_p | BCSR5_INT_USB);
+}
+
+void mpc8349_usb_clk_cfg(void)
+{
+	unsigned long sccr;
+	volatile unsigned long *p;
+	
+	p = (volatile unsigned long *)(CFG_IMMR_BASE + SCCR_OFFS); /* SCCR */
+	sccr = *p;
+		
+#if defined(CONFIG_MPH_USB_SUPPORT)
+	sccr &= ~SCCR_USB_MPHCM_11;
+	sccr |= SCCR_USB_MPHCM_11;  /* USB CLK 1:3 CSB CLK */
+	*p = sccr;
+#elif defined(CONFIG_DR_USB_SUPPORT)
+	sccr &= ~SCCR_USB_DRCM_11;
+	sccr |= SCCR_USB_DRCM_11;  /* USB CLK 1:3 CSB CLK */
+	*p = sccr;
+#endif
+
+}
+
+void mpc8349_usb_pin_cfg(void)
+{
+	unsigned long sicrl;
+	volatile unsigned long *p;
+	
+	p = (volatile unsigned long *)(CFG_IMMR_BASE + SICRL_OFFS); /* SCCR */
+	sicrl = *p;
+	
+#if defined(CONFIG_MPH_USB_SUPPORT)
+#ifdef CONFIG_MPH0_USB_ENABLE 
+	sicrl &= ~SICRL_USB0;
+	*p = sicrl;
+#endif
+
+#ifdef CONFIG_MPH1_USB_ENABLE
+	sicrl &= ~SICRL_USB1;
+	*p = sicrl;
+#endif
+#elif defined(CONFIG_DR_USB_SUPPORT)
+	sicrl &= ~SICRL_USB0;
+	sicrl |= SICRL_USB1 ;
+	*p = sicrl;
+#if defined(CONFIG_DR_UTMI)
+	sicrl &= ~SICRL_USB0;
+	sicrl |= SICRL_USB0;
+	*p = sicrl;
+#endif
+
+#endif
+}
+
+static void mpc8349_usb_reset(void)
+{
+	u32      portsc;
+    
+#if defined(CONFIG_MPH_USB_SUPPORT)    
+	t_USB_MPH_MAP *p_MphMemMap;
+	/* Enable PHY interface in the control reg. */
+	p_MphMemMap = (t_USB_MPH_MAP *)MPC83xx_USB_MPH_BASE;
+	p_MphMemMap->control = 0x00000004;
+	p_MphMemMap->snoop1 = 0x0000001b;
+#ifdef CONFIG_MPH0_USB_ENABLE
+	portsc = readl(&p_MphMemMap->port_status[0]);
+	portsc &= ~PORT_TS;
+#if defined(CONFIG_MPH0_ULPI)       
+	portsc |= PORT_TS_ULPI; 
+#elif defined (CONFIG_MPH0_SERIAL)
+	portsc |= PORT_TS_SERIAL;
+#endif	
+	writel(portsc,&p_MphMemMap->port_status[0]);
+#endif
+	
+#ifdef CONFIG_MPH1_USB_ENABLE
+	portsc = readl(&p_MphMemMap->port_status[1]);
+	portsc &= ~PORT_TS;
+#if defined(CONFIG_MPH1_ULPI)       
+	portsc |= PORT_TS_ULPI; 
+#elif defined (CONFIG_MPH1_SERIAL)
+	portsc |= PORT_TS_SERIAL;
+#endif	
+	writel(portsc,&p_MphMemMap->port_status[1]);
+#endif
+        
+	p_MphMemMap->pri_ctrl = 0x0000000c;
+	p_MphMemMap->age_cnt_thresh = 0x00000040;
+	p_MphMemMap->si_ctrl= 0x00000001;
+
+#elif defined(CONFIG_DR_USB_SUPPORT)
+	t_USB_DR_MAP *p_DrMemMap;
+	p_DrMemMap = (t_USB_DR_MAP *)MPC83xx_USB_DR_BASE;
+	p_DrMemMap->control = 0x00000004;
+	p_DrMemMap->snoop1 = 0x0000001b;
+	portsc = readl(&p_DrMemMap->port_status[0]);
+	portsc &= ~PORT_TS;
+#if defined(CONFIG_DR_ULPI)     
+	portsc |= PORT_TS_ULPI;
+#elif defined(CONFIG_DR_SERIAL)
+	portsc |= PORT_TS_SERIAL;
+#elif defined(CONFIG_DR_UTMI)
+	portsc |= PORT_TS_ULPI;
+#endif
+           
+	writel(portsc,&p_DrMemMap->port_status[0]);
+	writel(0x00000003,&p_DrMemMap->usbmode);
+	p_DrMemMap->pri_ctrl = 0x0000000c;
+	p_DrMemMap->age_cnt_thresh = 0x00000040;
+	p_DrMemMap->si_ctrl= 0x00000001;
+#endif
+}
+
+
+static int __init
+fsl_usb20_probe(struct device *dev)
+{
+	struct usb_hcd		*hcd;
+	struct ehci_hcd         *ehci;
+	int 			retval;
+#if defined (CONFIG_MPH_USB_SUPPORT)
+	t_USB_MPH_MAP 		*p_MphMemMap;
+#elif defined (CONFIG_DR_USB_SUPPORT)
+    	t_USB_DR_MAP 		*p_DrMemMap;
+#endif	
+	mpc8349_board_init();
+	mpc8349_usb_clk_cfg();
+	mpc8349_usb_pin_cfg();
+	
+	hcd = usb_create_hcd(&ehci_driver);
+	if (!hcd) {
+		retval = 0;
+		goto err1;
+	}
+
+	ehci = hcd_to_ehci(hcd);
+	dev_set_drvdata(dev, ehci);
+	
+#if defined(CONFIG_MPH_USB_SUPPORT)
+	p_MphMemMap = (t_USB_MPH_MAP *)MPC83xx_USB_MPH_BASE;
+        
+        hcd->regs = (void *)(&p_MphMemMap->hc_capbase);
+        hcd->irq = MPC83xx_USB_MPH_IVEC;
+
+#elif defined (CONFIG_DR_USB_SUPPORT)
+	/* Enable PHY interface in the control reg. */
+        p_DrMemMap = (t_USB_DR_MAP *)MPC83xx_USB_DR_BASE;
+    	hcd->regs = (void *)(&p_DrMemMap->hc_capbase);/* Set the interrupt that is called for this USB. */
+        hcd->irq = MPC83xx_USB_DR_IVEC;
+
+#endif
+
+	hcd->self.controller = dev;
+	hcd->self.bus_name = dev->bus_id;
+	hcd->product_desc ="fsl usb20";
+
+	retval = request_irq(hcd->irq, usb_hcd_irq, SA_INTERRUPT,hcd->driver->description, hcd);
+	if (retval != 0)
+		goto err2;
+	retval = usb_register_bus(&hcd->self);
+	if (retval < 0)
+		goto err3;
+
+	retval=ehci_hc_reset(hcd);
+
+	if (retval < 0)
+		goto err4;
+
+	if ((retval = ehci_start (hcd)) < 0) {
+		goto err4;
+	}
+
+	return 0;
+err4:
+	usb_deregister_bus(&hcd->self);
+err3:
+	free_irq(hcd->irq, hcd);
+err2:
+	usb_put_hcd(hcd);
+err1:
+	printk("init error, %d\n", retval);
+	return retval;	
+}
+
+static int __init_or_module
+fsl_usb20_remove(struct device *dev)
+{
+	struct ehci_hcd		*ehci = dev_get_drvdata(dev);
+	struct usb_hcd		*hcd = ehci_to_hcd(ehci);
+	
+
+	if (HCD_IS_RUNNING(hcd->state))
+		hcd->state = USB_STATE_QUIESCING;
+
+	usb_disconnect(&hcd->self.root_hub);
+	
+	hcd->driver->stop (hcd);
+	
+	usb_deregister_bus(&hcd->self);
+
+	free_irq(hcd->irq, hcd);
+
+	usb_put_hcd(hcd);
+	return 0;
+}
+	
+#define	fsl_usb20_suspend	NULL
+#define	fsl_usb20_resume	NULL
+
+static struct device_driver fsl_usb20_driver = {
+	.name =		(char *) hcd_name,
+	.bus =		&platform_bus_type,
+
+	.probe =	fsl_usb20_probe,
+	.remove =	fsl_usb20_remove,
+
+	.suspend =	fsl_usb20_suspend,
+	.resume =	fsl_usb20_resume,
+};
+
+/*-------------------------------------------------------------------------*/
+ 
+static int __init mpc8349_usb_hc_init(void) 
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	printk(KERN_INFO"driver %s, %s\n", hcd_name, DRIVER_VERSION);
+	return driver_register(&fsl_usb20_driver);
+}
+
+
+static void __exit mpc8349_usb_hc_deinit(void) 
+{	
+	driver_unregister(&fsl_usb20_driver);
+}
+MODULE_DESCRIPTION (DRIVER_INFO);
+MODULE_AUTHOR (DRIVER_AUTHOR);
+MODULE_LICENSE ("GPL");
+module_init(mpc8349_usb_hc_init);
+module_exit(mpc8349_usb_hc_deinit);
diff -Nur linux/drivers/usb/host/fsl-usb.h linux-8349-2.6/drivers/usb/host/fsl-usb.h
--- linux/drivers/usb/host/fsl-usb.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/fsl-usb.h	2005-08-25 11:49:00.000000000 +0800
@@ -0,0 +1,406 @@
+/* Copyright (c) 2005 freescale semiconductor
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _MPC8349_USB_EHCI_H
+#define _MPC8349_USB_EHCI_H
+
+/**************************************************************************/
+/*@Description   t_USB_MPH_MAP - USB Multi-Port-Host internal memory map.*/
+/***************************************************************************/
+typedef   struct{
+	volatile u32    id;			/* Identification register */
+	volatile u32    hwgeneral;
+	volatile u32    hwhost;
+	volatile u8     RESERVED01[0x004];	/* Reserved area           */
+	volatile u32    hwtxbuf;
+	volatile u32    hwrxbuf;
+	volatile u8     RESERVED02[0x0e8];	/* Reserved area           */
+    
+	/* Capability Registers */
+	volatile u32    hc_capbase;
+	volatile u32    hcs_params;		/* HCSPARAMS - offset 0x4 */
+	volatile u32    hcc_params;		/* HCCPARAMS - offset 0x8 */
+	volatile u8     portroute [8];		/* nibbles for routing - offset 0xC */
+	volatile u8     RESERVED03[0x02c];	/* Reserved area           */
+
+	/* Operational Registers */
+	volatile u32    command;
+	volatile u32    status;
+	volatile u32    intr_enable;
+	volatile u32    frame_index;		/* current microframe number */
+	volatile u32    segment;		/* address bits 63:32 if needed */
+	volatile u32    frame_list;		/* points to periodic list */
+	volatile u32    async_next;		/* address of next async queue head */
+	volatile u32    async_tt_status;	/* async queue status for embedded TT */
+	volatile u32    burst_size;		/* programmable burst size */
+	volatile u32    txfilltuning;		/* host transmit pre-buffer packet tuning */
+	volatile u32    txttfilltuning;		/* host TT transmit pre-buffer packet tuning */
+	volatile u8     RESERVED04[4];
+	volatile u32    ulpi_view_port;		/* ULPI view port */
+	volatile u32    endpoint_nack;		/* endpoint nack */
+	volatile u32    endpoint_nack_en;	/* endpoint nack enable */
+	volatile u8     RESERVED05[4];
+	volatile u32    configured_flag;
+	volatile u32    port_status [2];	/* up to N_PORTS */
+   
+	volatile u8     RESERVED06[0x01c];	/* Reserved area           */
+	volatile u32    usbmode;
+	volatile u8     RESERVED07[0x254];	/* Reserved area           */
+	volatile u32    snoop1;
+	volatile u32    snoop2;
+	volatile u32    age_cnt_thresh;
+	volatile u32    si_ctrl;
+	volatile u32    pri_ctrl;
+	volatile u8     RESERVED08[0x0ec];	/* Reserved area           */
+	volatile u32    control;
+	volatile u8     RESERVED09[0xaf8];	/* Reserved area           */
+} t_USB_MPH_MAP;
+
+/**************************************************************************/
+/** @Description   t_USB_DR_MAP - USB Dual-Role internal memory map.      */
+/***************************************************************************/
+typedef   struct{
+	volatile u32    id;			/* Identification register */
+	volatile u32    hwgeneral;
+	volatile u32    hwhost;
+	volatile u32    hwdevice;
+	volatile u32    hwtxbuf;
+	volatile u32    hwrxbuf;
+	volatile u8     RESERVED01[0x0e8];	/* Reserved area           */
+   
+	/* Capability Registers */
+	volatile u32    hc_capbase;
+	volatile u32    hcs_params;		/* HCSPARAMS - offset 0x4 */
+	volatile u32    hcc_params;		/* HCCPARAMS - offset 0x8 */
+	volatile u8     portroute [8];		/* nibbles for routing - offset 0xC */
+	volatile u8     RESERVED02[0x00c];	/* Reserved area           */
+	volatile u32    dciversion;
+	volatile u32    dccparms;
+	volatile u8     RESERVED03[0x018];	/* Reserved area           */
+	   
+	/* Operational Registers */
+	volatile u32    command;
+	volatile u32    status;
+	volatile u32    intr_enable;
+	volatile u32    frame_index;		/* current microframe number */
+	union    t_host_slave_regs {
+		struct         t_ehci_regs 
+		{
+			volatile u32    segment;	/* address bits 63:32 if needed */
+			volatile u32    frame_list;	/* points to periodic list */
+			volatile u32    async_next;	/* address of next async queue head */
+		} host_regs;
+		struct         t_slave_regs {
+			volatile u8     RESERVED04 [0x04];
+			volatile u32    deviceaddr;
+			volatile u32    endpoint_list_addr;	/* points to periodic list */
+		} slave_regs;
+	} host_slave_regs;
+	volatile u32    async_tt_status;	/* async queue status for embedded TT */
+	volatile u32    burst_size;		/* programmable burst size */
+	volatile u32    txfilltuning;		/* host transmit pre-buffer packet tuning */
+	volatile u32    txttfilltuning;		/* host TT transmit pre-buffer packet tuning */
+	volatile u8     RESERVED04[4];
+	volatile u32    ulpi_view_port;		/* ULPI view port */
+	volatile u32    endpoint_nack;		/* endpoint nack */
+	volatile u32    endpoint_nack_en;	/* endpoint nack enable */
+	volatile u8     RESERVED05[4];
+	volatile u32    configured_flag;
+	volatile u32    port_status [1];	/* up to N_PORTS */
+	   
+	volatile u8     RESERVED06[0x01c];	/* Reserved area           */
+	volatile u32    otgsc;
+	volatile u32    usbmode;
+	volatile u32    endptsetupstat;
+	volatile u32    endptprime;
+	volatile u32    endptflush;
+	volatile u32    endptstatus;
+	volatile u32    endptcomplete;
+	volatile u32    endptctrl[6];
+	volatile u8     RESERVED07[0x228];	/* Reserved area           */
+	volatile u32    snoop1;
+	volatile u32    snoop2;
+	volatile u32    age_cnt_thresh;
+	volatile u32    si_ctrl;
+	volatile u32    pri_ctrl;
+	volatile u8     RESERVED08[0x0ec];	/* Reserved area           */
+	volatile u32    control;
+	volatile u8     RESERVED09[0xaf8];	/* Reserved area           */
+} __attribute__ ((packed)) t_USB_DR_MAP, * t_pUSB_DR_MAP;
+
+
+
+#define PORT_OFF        0
+#define PORT_ULPI       1
+#define PORT_UTMI       2
+#define PORT_SERIAL     3
+#define PORT_SERIAL_OTG 4
+
+
+#define PORT_TS          0xc0000000
+#define PORT_TS_UTMI     0x00000000
+#define PORT_TS_ULPI     0x80000000
+#define PORT_TS_SERIAL   0xc0000000
+#define PORT_TW          0x10000000
+#define PORT_SPD         0x0c000000
+#define PORT_FSC         0x01000000
+#define PORT_PP          0x00001000
+
+
+
+#define CFG_IMMR_BASE	        (0xfe000000)
+#define MPC83xx_USB_MPH_BASE    (CFG_IMMR_BASE + 0x22000)
+#define MPC83xx_USB_DR_BASE     (CFG_IMMR_BASE + 0x23000)
+#define MPC83xx_USB_DR_IVEC	(38)
+#define MPC83xx_USB_MPH_IVEC	(39)
+#define CFG_BCSR_BASE 		(0xfe100000)
+#define BCSR5_INT_USB		(0x02)
+
+#define e_USB_MPH 0
+#define e_USB_DR 1
+#define e_ULPI          0
+#define e_UTMI_8BIT     1 
+#define e_UTMI_16BIT    2
+#define e_SERIAL        3
+
+#define SCCR_OFFS          0xA08
+#define SCCR_USB_MPHCM_11  0x00c00000
+#define SCCR_USB_MPHCM_01  0x00400000
+#define SCCR_USB_MPHCM_10  0x00800000
+#define SCCR_USB_DRCM_11   0x00300000
+#define SCCR_USB_DRCM_01   0x00100000
+#define SCCR_USB_DRCM_10   0x00200000
+
+#define SICRL_OFFS         0x114
+#define SICRL_USB1         0x40000000
+#define SICRL_USB0         0x20000000
+
+#define SICRH_OFFS         0x118
+#define SICRH_USB_UTMI     0x00020000
+
+#define SPCR_OFFS          0x00000110
+#define SPCR_TBEN          0x00400000
+
+#define POWER_OF_2(n)           (!(n & (n-1)))
+
+/*------------------------------------------------------*/
+
+typedef struct
+{
+	char		Name[4];	/* this segment's name          */
+	spinlock_t	lock;
+	u16		Num;	/* number of blocks in segment  */
+	int         Size;	/* size of blocks in segment    */
+				/* in case of TMP_DEF -         */
+				/* only the data                */
+	u32    	GetFailures;	/* number of times get failed   */
+	int	LocallyAllocated;	/* TRUE if memory was allocated */
+	/* at MEM_Init.	  */
+	u8   	*p_Base;	/* base address of segment      */
+	void  	**p_First;	/* first block in segment       */
+	void  	**p_Last;	/* last block in segment        */
+	int 	(*f_MemPut)(void* Handle, void *p_Block );
+				/* a routine for returning a memory block */
+
+	u16    	PrefixSize;	/* replaces B_OFFSET - how many     */
+				/* bytes to reserve before the data     */
+	u16    	PostfixSize ;	/* replaces B_TRAILER - how many   */
+				/* bytes to reserve after the data     */
+				/* Trailer also includes a pad needed for */
+				/* padding the entire block to 4 byte     */
+				/* alignment for faster access to the     */
+				/* control field                          */
+	u16    	Alignment;	/* requested alignment for the data field */
+	u16	AlignPad;	/* pad the offset field so that the data  */
+				/* field shall have the proper alignment  */
+	u16    	EndPad;		/* Pad to make entire block size a */
+				/* multiple of Alignment	*/
+} t_MemorySegment;
+
+#define PAD_ALIGNMENT( align, x ) ( ((x)%(align)) ? ((align)-((x)%(align))) : 0 )
+
+
+void *MEM_Get( void* Handle )
+{
+	unsigned long    	flags;	
+	u8            	*p_F;
+	t_MemorySegment 	*p ;
+	
+	p = (t_MemorySegment *)Handle;
+  
+	spin_lock_irqsave(&p->lock,flags);
+
+	/* check if the chain is not empty */
+	if( !(*(p->p_First)) )
+	{
+		p->GetFailures++;
+		spin_unlock_irqrestore(p->lock,flags);
+		return 0;
+	}
+	/* advance first pointer and return the old head of chain */
+	p_F = ((u8 *)p->p_First) + ( 4 + p->AlignPad + p->PrefixSize );   
+	p->p_First = (void **) *(p->p_First); /* skip the next pointer */
+
+	spin_unlock_irqrestore(&p->lock,flags);
+
+	return (void *)p_F;
+}
+
+
+int MEM_Put_Default( void * Handle, void *p_Block )
+{
+	unsigned long	flags;	
+	t_MemorySegment 	*p = (t_MemorySegment *)Handle;
+	u8            	*p_B = (u8 *)p_Block;
+   
+	/* if handle is NULL, use user's free routine */
+	if( Handle == 0 )
+	{
+		kfree( p_Block );
+		return 0;
+	}
+
+	spin_lock_irqsave(&p->lock,flags);
+
+	/* get the pointer to the start of the memory */
+	p_B -= ( 4 + p->AlignPad + p->PrefixSize );    /* skip back over next pointer */ 
+	/* chain to end and advance last pointer */
+	*((void **)p_B) = 0;
+	*(p->p_Last) = (void *)p_B;
+	p->p_Last = (void **)p_B;
+
+	spin_unlock_irqrestore(&p->lock,flags);
+	return 0;
+}
+
+int MEM_Init( char Name[], 
+	void* *p_Handle, 
+	u16 Num, 
+	u16 Size , 
+	u16 PrefixSize, 
+	u16 PostfixSize, 
+	u16 Alignment )
+{
+	t_MemorySegment 	*p;
+	u8            	*p_Blocks;
+	int              	i ;
+	int		     	blockSize;
+
+	/* always allocate a dummy block at the end */
+	Num++;
+
+	/* make sure size is always a multiple of 4 */
+	if( Size & 3 )
+	{
+		Size &= ~3;
+		Size += 4;
+	}
+
+	if (Alignment < 4 ) 
+		Alignment = 4;
+
+	/** make sure that the alignment is a power of two */
+	if( !POWER_OF_2(Alignment) ) 
+	{
+		printk("MEM_Init: requested alignment is not a power of two.\n");
+		return -EINVAL;
+	}                          
+
+	/* prepare in case of error */
+	*p_Handle = 0;
+
+	/* first allocate the segment descriptor */
+	p = (t_MemorySegment *)kmalloc( sizeof(t_MemorySegment),GFP_KERNEL );
+
+	if( !p )
+		return -ENOMEM;
+	/* calculate blockSize */
+  
+	/* store info about this segment */
+	spin_lock_init (&p->lock);
+	p->Num = (u16)(Num - 1);  
+	p->Size = Size;
+	p->GetFailures = 0L;
+	p->f_MemPut = MEM_Put_Default;
+	p->LocallyAllocated = 1;
+	p->PrefixSize = PrefixSize;
+	p->Alignment = Alignment; 
+	p->AlignPad  = (u16)PAD_ALIGNMENT((u16)4, (u16)PrefixSize+4); 
+	p->PostfixSize = PostfixSize;
+	/* Make sure the entire size is a multiple of Alignment */
+	p->EndPad = (u16)PAD_ALIGNMENT((u16)Alignment, 4 + p->AlignPad + PrefixSize + Size + PostfixSize); 
+
+	blockSize = 4 + p->AlignPad + PrefixSize + Size + PostfixSize + p->EndPad;
+
+	p_Blocks = (u8 *)kmalloc(( Alignment +  Num * blockSize ),GFP_KERNEL);
+
+	if( !p_Blocks )
+	{
+		kfree( p );
+		return -ENOMEM;
+	}
+	/* store the memory segment address */
+	p->p_Base = p_Blocks;
+	
+	p_Blocks += (PrefixSize+4);
+	p_Blocks += (PAD_ALIGNMENT( Alignment, (u32)p_Blocks)); 
+	p_Blocks -= (PrefixSize+4+p->AlignPad);
+
+	/* store name */
+	strncpy( p->Name, Name, 4 );
+
+	/* finally, initialize the blocks */
+	p->p_Last = p->p_First = (void **)p_Blocks;
+	for(i = 0; i < (Num-1); i++)
+	{
+	/* get next block */
+		p_Blocks += blockSize;
+
+	/* attach to end of chain */
+		if( p->p_Last )
+			*(p->p_Last) = (void *)p_Blocks;
+
+	/* advance last pointer */
+		p->p_Last = (void **)p_Blocks;
+	}
+
+	/* zero next pointer in last block */
+	*(p->p_Last) = 0;
+
+	/* return handle to caller */
+	*p_Handle = (void *)p;
+
+	return 0;
+}
+
+
+
+void  MEM_Free( void* p_Handle)
+{
+	t_MemorySegment *p = (t_MemorySegment*)p_Handle;
+
+	if ( p && p->LocallyAllocated)
+		kfree (p->p_Base);
+	kfree(p);
+}
+
+#define MEM_Put(Handle, p_Block)    \
+	((t_MemorySegment *)Handle)->f_MemPut( Handle, p_Block)
+
+
+
+
+#endif /* __STD_EXT_H */
diff -Nur linux/drivers/usb/host/Kconfig linux-8349-2.6/drivers/usb/host/Kconfig
--- linux/drivers/usb/host/Kconfig	2004-12-25 05:35:29.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/Kconfig	2005-08-16 14:58:56.000000000 +0800
@@ -5,6 +5,7 @@
 	boolean
 	default y if USB_ARCH_HAS_OHCI
 	default y if ARM				# SL-811
+	default y if FSL_USB20				# MPC83xx SYS
 	default PCI
 
 # many non-PCI hcds implement OHCI
@@ -24,7 +25,7 @@
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
-	depends on USB && PCI
+	depends on (USB && PCI) || (USB && FSL_USB20)
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
diff -Nur linux/drivers/usb/host/Makefile linux-8349-2.6/drivers/usb/host/Makefile
--- linux/drivers/usb/host/Makefile	2004-12-25 05:35:39.000000000 +0800
+++ linux-8349-2.6/drivers/usb/host/Makefile	2005-08-15 13:41:35.000000000 +0800
@@ -2,8 +2,11 @@
 # Makefile for USB Host Controller Driver
 # framework and drivers
 #
-
+ifeq ($(CONFIG_FSL_USB20),y)
+obj-$(CONFIG_USB_EHCI_HCD)	+= fsl-usb.o
+else
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
+endif
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_SL811_HCD)	+= sl811-hcd.o
diff -Nur linux/arch/ppc/platforms/83xx/Kconfig linux-8349-2.6/arch/ppc/platforms/83xx/Kconfig
--- linux/arch/ppc/platforms/83xx/Kconfig	2005-03-03 01:46:54.000000000 +0800
+++ linux-8349-2.6/arch/ppc/platforms/83xx/Kconfig	2005-08-25 11:44:57.000000000 +0800
@@ -27,4 +27,78 @@
 	depends on 83xx
 	default y
 
+config FSL_USB20
+	bool "MPC834x USB20 Host Support"
+	depends on MPC834x_SYS
+
+
+menu "USB20 Host Configuration"
+	depends on FSL_USB20 
+
+choice
+	prompt "MPC83xx USB20 host Mode"
+	depends on FSL_USB20 
+	default MPH_USB_SUPPORT
+
+config MPH_USB_SUPPORT
+	bool "MPH_MODE"
+		
+config DR_USB_SUPPORT
+	bool "DR_MODE"
+
+endchoice
+
+config MPH0_USB_ENABLE
+	bool "MPH0 USB HOST Enable"
+	depends on MPH_USB_SUPPORT
+
+choice
+	prompt "MPH0 PHY Interface Selection"
+	depends on MPH0_USB_ENABLE
+	default MPH0_ULPI
+
+config MPH0_ULPI
+	bool "ULPI"
+
+config MPH0_SERIAL
+	bool "Serial"
+
+endchoice
+
+config MPH1_USB_ENABLE
+	bool "MPH1 USB HOST Enable"
+	depends on MPH_USB_SUPPORT
+
+choice
+	prompt "MPH1 PHY Interface Selection"
+	depends on MPH1_USB_ENABLE
+	default MPH1_ULPI
+
+config MPH1_ULPI
+	bool "ULPI"
+
+config MPH1_SERIAL
+	bool "Serial"
+
+endchoice
+
+
+choice
+	prompt "DR PHY Interface Selection"
+	depends on DR_USB_SUPPORT
+	default DR_ULPI
+
+config DR_ULPI
+	bool "ULPI"
+
+config DR_SERIAL
+	bool "Serial"
+
+config DR_UTMI
+	bool "UTMI"
+
+endchoice
+
+endmenu
+
 endmenu


--
Leo Li
Freescale Semiconductor
 
LeoLi@freescale.com 
 
