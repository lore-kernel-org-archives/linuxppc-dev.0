Return-Path: <guigasurf@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9B5EB7008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 23:12:14 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so4963176bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 06:12:11 -0700 (PDT)
MIME-Version: 1.0
Sender: guigasurf@gmail.com
Date: Tue, 19 Jun 2012 10:12:10 -0300
Message-ID: <CAF=5bWf_fzj2ZV8dLJFdffqQ7J5spepBi3qp7NN8SqUfkm1mMQ@mail.gmail.com>
Subject: [PATCH] USB: FHCI: Reusing the QUICC Engine USB Controller registers
 struct from immap_qe.h.
From: Guilherme Maciel Ferreira <guilherme.maciel.ferreira@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: guilherme.maciel.ferreira@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The struct fhci_regs (in fhci.h) is basically a redefinition
of the struct qe_usb_ctlr (in immap_qe.h). The later struct is
preferrable once it uses the registers names found at the
Freescale's QUICC Engine manual. Thus it is easier to map the
driver to the manual.

Also, the FHCI driver uses the USB controller registers, so
the name qe_usb_ctlr maps better to the hardware than fhci_regs.

Signed-off-by: Guilherme Maciel Ferreira <guilherme.maciel.ferreira@gmail.com>
---
 drivers/usb/host/fhci-dbg.c   |   12 ++++++------
 drivers/usb/host/fhci-hcd.c   |   32 ++++++++++++++++----------------
 drivers/usb/host/fhci-hub.c   |   16 ++++++++--------
 drivers/usb/host/fhci-sched.c |   30 +++++++++++++++---------------
 drivers/usb/host/fhci-tds.c   |   14 +++++++-------
 drivers/usb/host/fhci.h       |   22 ++--------------------
 6 files changed, 54 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/host/fhci-dbg.c b/drivers/usb/host/fhci-dbg.c
index 6fe5500..f238cb3 100644
--- a/drivers/usb/host/fhci-dbg.c
+++ b/drivers/usb/host/fhci-dbg.c
@@ -41,7 +41,7 @@ void fhci_dbg_isr(struct fhci_hcd *fhci, int usb_er)
 static int fhci_dfs_regs_show(struct seq_file *s, void *v)
 {
 	struct fhci_hcd *fhci = s->private;
-	struct fhci_regs __iomem *regs = fhci->regs;
+	struct qe_usb_ctlr __iomem *regs = fhci->regs;

 	seq_printf(s,
 		"mode: 0x%x\n" "addr: 0x%x\n"
@@ -50,11 +50,11 @@ static int fhci_dfs_regs_show(struct seq_file *s, void *v)
 		"status: 0x%x\n" "SOF timer: %d\n"
 		"frame number: %d\n"
 		"lines status: 0x%x\n",
-		in_8(&regs->usb_mod), in_8(&regs->usb_addr),
-		in_8(&regs->usb_comm), in_be16(&regs->usb_ep[0]),
-		in_be16(&regs->usb_event), in_be16(&regs->usb_mask),
-		in_8(&regs->usb_status), in_be16(&regs->usb_sof_tmr),
-		in_be16(&regs->usb_frame_num),
+		in_8(&regs->usb_usmod), in_8(&regs->usb_usadr),
+		in_8(&regs->usb_uscom), in_be16(&regs->usb_usep[0]),
+		in_be16(&regs->usb_usber), in_be16(&regs->usb_usbmr),
+		in_8(&regs->usb_usbs), in_be16(&regs->usb_ussft),
+		in_be16(&regs->usb_usfrn),
 		fhci_ioports_check_bus_state(fhci));

 	return 0;
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index d262374..7da1a26 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -40,8 +40,8 @@ void fhci_start_sof_timer(struct fhci_hcd *fhci)
 	/* clear frame_n */
 	out_be16(&fhci->pram->frame_num, 0);

-	out_be16(&fhci->regs->usb_sof_tmr, 0);
-	setbits8(&fhci->regs->usb_mod, USB_MODE_SFTE);
+	out_be16(&fhci->regs->usb_ussft, 0);
+	setbits8(&fhci->regs->usb_usmod, USB_MODE_SFTE);

 	fhci_dbg(fhci, "<- %s\n", __func__);
 }
@@ -50,7 +50,7 @@ void fhci_stop_sof_timer(struct fhci_hcd *fhci)
 {
 	fhci_dbg(fhci, "-> %s\n", __func__);

-	clrbits8(&fhci->regs->usb_mod, USB_MODE_SFTE);
+	clrbits8(&fhci->regs->usb_usmod, USB_MODE_SFTE);
 	gtm_stop_timer16(fhci->timer);

 	fhci_dbg(fhci, "<- %s\n", __func__);
@@ -58,7 +58,7 @@ void fhci_stop_sof_timer(struct fhci_hcd *fhci)

 u16 fhci_get_sof_timer_count(struct fhci_usb *usb)
 {
-	return be16_to_cpu(in_be16(&usb->fhci->regs->usb_sof_tmr) / 12);
+	return be16_to_cpu(in_be16(&usb->fhci->regs->usb_ussft) / 12);
 }

 /* initialize the endpoint zero */
@@ -88,8 +88,8 @@ void fhci_usb_enable_interrupt(struct fhci_usb *usb)
 		enable_irq(fhci_to_hcd(fhci)->irq);

 		/* initialize the event register and mask register */
-		out_be16(&usb->fhci->regs->usb_event, 0xffff);
-		out_be16(&usb->fhci->regs->usb_mask, usb->saved_msk);
+		out_be16(&usb->fhci->regs->usb_usber, 0xffff);
+		out_be16(&usb->fhci->regs->usb_usbmr, usb->saved_msk);

 		/* enable the timer interrupts */
 		enable_irq(fhci->timer->irq);
@@ -109,7 +109,7 @@ void fhci_usb_disable_interrupt(struct fhci_usb *usb)

 		/* disable the usb interrupt */
 		disable_irq_nosync(fhci_to_hcd(fhci)->irq);
-		out_be16(&usb->fhci->regs->usb_mask, 0);
+		out_be16(&usb->fhci->regs->usb_usbmr, 0);
 	}
 	usb->intr_nesting_cnt++;
 }
@@ -119,9 +119,9 @@ static u32 fhci_usb_enable(struct fhci_hcd *fhci)
 {
 	struct fhci_usb *usb = fhci->usb_lld;

-	out_be16(&usb->fhci->regs->usb_event, 0xffff);
-	out_be16(&usb->fhci->regs->usb_mask, usb->saved_msk);
-	setbits8(&usb->fhci->regs->usb_mod, USB_MODE_EN);
+	out_be16(&usb->fhci->regs->usb_usber, 0xffff);
+	out_be16(&usb->fhci->regs->usb_usbmr, usb->saved_msk);
+	setbits8(&usb->fhci->regs->usb_usmod, USB_MODE_EN);

 	mdelay(100);

@@ -141,7 +141,7 @@ static u32 fhci_usb_disable(struct fhci_hcd *fhci)
 			usb->port_status == FHCI_PORT_LOW)
 		fhci_device_disconnected_interrupt(fhci);

-	clrbits8(&usb->fhci->regs->usb_mod, USB_MODE_EN);
+	clrbits8(&usb->fhci->regs->usb_usmod, USB_MODE_EN);

 	return 0;
 }
@@ -285,13 +285,13 @@ static int fhci_usb_init(struct fhci_hcd *fhci)
 			  USB_E_IDLE_MASK |
 			  USB_E_RESET_MASK | USB_E_SFT_MASK | USB_E_MSF_MASK);

-	out_8(&usb->fhci->regs->usb_mod, USB_MODE_HOST | USB_MODE_EN);
+	out_8(&usb->fhci->regs->usb_usmod, USB_MODE_HOST | USB_MODE_EN);

 	/* clearing the mask register */
-	out_be16(&usb->fhci->regs->usb_mask, 0);
+	out_be16(&usb->fhci->regs->usb_usbmr, 0);

 	/* initialing the event register */
-	out_be16(&usb->fhci->regs->usb_event, 0xffff);
+	out_be16(&usb->fhci->regs->usb_usber, 0xffff);

 	if (endpoint_zero_init(usb, DEFAULT_DATA_MEM, DEFAULT_RING_LEN) != 0) {
 		fhci_usb_free(usb);
@@ -745,8 +745,8 @@ static int __devinit of_fhci_probe(struct
platform_device *ofdev)
 	}

 	/* Clear and disable any pending interrupts. */
-	out_be16(&fhci->regs->usb_event, 0xffff);
-	out_be16(&fhci->regs->usb_mask, 0);
+	out_be16(&fhci->regs->usb_usber, 0xffff);
+	out_be16(&fhci->regs->usb_usbmr, 0);

 	ret = usb_add_hcd(hcd, usb_irq, 0);
 	if (ret < 0)
diff --git a/drivers/usb/host/fhci-hub.c b/drivers/usb/host/fhci-hub.c
index 348fe62..6af2512 100644
--- a/drivers/usb/host/fhci-hub.c
+++ b/drivers/usb/host/fhci-hub.c
@@ -97,7 +97,7 @@ void fhci_port_disable(struct fhci_hcd *fhci)

 	/* Enable IDLE since we want to know if something comes along */
 	usb->saved_msk |= USB_E_IDLE_MASK;
-	out_be16(&usb->fhci->regs->usb_mask, usb->saved_msk);
+	out_be16(&usb->fhci->regs->usb_usbmr, usb->saved_msk);

 	/* check if during the disconnection process attached new device */
 	if (port_status == FHCI_PORT_WAITING)
@@ -158,21 +158,21 @@ void fhci_port_reset(void *lld)

 	fhci_stop_sof_timer(fhci);
 	/* disable the USB controller */
-	mode = in_8(&fhci->regs->usb_mod);
-	out_8(&fhci->regs->usb_mod, mode & (~USB_MODE_EN));
+	mode = in_8(&fhci->regs->usb_usmod);
+	out_8(&fhci->regs->usb_usmod, mode & (~USB_MODE_EN));

 	/* disable idle interrupts */
-	mask = in_be16(&fhci->regs->usb_mask);
-	out_be16(&fhci->regs->usb_mask, mask & (~USB_E_IDLE_MASK));
+	mask = in_be16(&fhci->regs->usb_usbmr);
+	out_be16(&fhci->regs->usb_usbmr, mask & (~USB_E_IDLE_MASK));

 	fhci_io_port_generate_reset(fhci);

 	/* enable interrupt on this endpoint */
-	out_be16(&fhci->regs->usb_mask, mask);
+	out_be16(&fhci->regs->usb_usbmr, mask);

 	/* enable the USB controller */
-	mode = in_8(&fhci->regs->usb_mod);
-	out_8(&fhci->regs->usb_mod, mode | USB_MODE_EN);
+	mode = in_8(&fhci->regs->usb_usmod);
+	out_8(&fhci->regs->usb_usmod, mode | USB_MODE_EN);
 	fhci_start_sof_timer(fhci);

 	fhci_dbg(fhci, "<- %s\n", __func__);
diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
index 2df851b..2dc8a40 100644
--- a/drivers/usb/host/fhci-sched.c
+++ b/drivers/usb/host/fhci-sched.c
@@ -132,8 +132,8 @@ void fhci_flush_all_transmissions(struct fhci_usb *usb)
 	u8 mode;
 	struct td *td;

-	mode = in_8(&usb->fhci->regs->usb_mod);
-	clrbits8(&usb->fhci->regs->usb_mod, USB_MODE_EN);
+	mode = in_8(&usb->fhci->regs->usb_usmod);
+	clrbits8(&usb->fhci->regs->usb_usmod, USB_MODE_EN);

 	fhci_flush_bds(usb);

@@ -147,9 +147,9 @@ void fhci_flush_all_transmissions(struct fhci_usb *usb)
 	usb->actual_frame->frame_status = FRAME_END_TRANSMISSION;

 	/* reset the event register */
-	out_be16(&usb->fhci->regs->usb_event, 0xffff);
+	out_be16(&usb->fhci->regs->usb_usber, 0xffff);
 	/* enable the USB controller */
-	out_8(&usb->fhci->regs->usb_mod, mode | USB_MODE_EN);
+	out_8(&usb->fhci->regs->usb_usmod, mode | USB_MODE_EN);
 }

 /*
@@ -414,7 +414,7 @@ static void sof_interrupt(struct fhci_hcd *fhci)
 			usb->port_status = FHCI_PORT_FULL;
 		/* Disable IDLE */
 		usb->saved_msk &= ~USB_E_IDLE_MASK;
-		out_be16(&usb->fhci->regs->usb_mask, usb->saved_msk);
+		out_be16(&usb->fhci->regs->usb_usbmr, usb->saved_msk);
 	}

 	gtm_set_exact_timer16(fhci->timer, usb->max_frame_usage, false);
@@ -433,14 +433,14 @@ void fhci_device_disconnected_interrupt(struct
fhci_hcd *fhci)
 	fhci_dbg(fhci, "-> %s\n", __func__);

 	fhci_usb_disable_interrupt(usb);
-	clrbits8(&usb->fhci->regs->usb_mod, USB_MODE_LSS);
+	clrbits8(&usb->fhci->regs->usb_usmod, USB_MODE_LSS);
 	usb->port_status = FHCI_PORT_DISABLED;

 	fhci_stop_sof_timer(fhci);

 	/* Enable IDLE since we want to know if something comes along */
 	usb->saved_msk |= USB_E_IDLE_MASK;
-	out_be16(&usb->fhci->regs->usb_mask, usb->saved_msk);
+	out_be16(&usb->fhci->regs->usb_usbmr, usb->saved_msk);

 	usb->vroot_hub->port.wPortStatus &= ~USB_PORT_STAT_CONNECTION;
 	usb->vroot_hub->port.wPortChange |= USB_PORT_STAT_C_CONNECTION;
@@ -473,7 +473,7 @@ void fhci_device_connected_interrupt(struct fhci_hcd *fhci)
 		}

 		usb->port_status = FHCI_PORT_LOW;
-		setbits8(&usb->fhci->regs->usb_mod, USB_MODE_LSS);
+		setbits8(&usb->fhci->regs->usb_usmod, USB_MODE_LSS);
 		usb->vroot_hub->port.wPortStatus |=
 		    (USB_PORT_STAT_LOW_SPEED |
 		     USB_PORT_STAT_CONNECTION);
@@ -491,7 +491,7 @@ void fhci_device_connected_interrupt(struct fhci_hcd *fhci)
 		}

 		usb->port_status = FHCI_PORT_FULL;
-		clrbits8(&usb->fhci->regs->usb_mod, USB_MODE_LSS);
+		clrbits8(&usb->fhci->regs->usb_usmod, USB_MODE_LSS);
 		usb->vroot_hub->port.wPortStatus &=
 		    ~USB_PORT_STAT_LOW_SPEED;
 		usb->vroot_hub->port.wPortStatus |=
@@ -535,7 +535,7 @@ static void abort_transmission(struct fhci_usb *usb)
 	/* issue stop Tx command */
 	qe_issue_cmd(QE_USB_STOP_TX, QE_CR_SUBBLOCK_USB, EP_ZERO, 0);
 	/* flush Tx FIFOs */
-	out_8(&usb->fhci->regs->usb_comm, USB_CMD_FLUSH_FIFO | EP_ZERO);
+	out_8(&usb->fhci->regs->usb_uscom, USB_CMD_FLUSH_FIFO | EP_ZERO);
 	udelay(1000);
 	/* reset Tx BDs */
 	fhci_flush_bds(usb);
@@ -555,11 +555,11 @@ irqreturn_t fhci_irq(struct usb_hcd *hcd)

 	usb = fhci->usb_lld;

-	usb_er |= in_be16(&usb->fhci->regs->usb_event) &
-		  in_be16(&usb->fhci->regs->usb_mask);
+	usb_er |= in_be16(&usb->fhci->regs->usb_usber) &
+		  in_be16(&usb->fhci->regs->usb_usbmr);

 	/* clear event bits for next time */
-	out_be16(&usb->fhci->regs->usb_event, usb_er);
+	out_be16(&usb->fhci->regs->usb_usber, usb_er);

 	fhci_dbg_isr(fhci, usb_er);

@@ -573,7 +573,7 @@ irqreturn_t fhci_irq(struct usb_hcd *hcd)

 			/* Turn on IDLE since we want to disconnect */
 			usb->saved_msk |= USB_E_IDLE_MASK;
-			out_be16(&usb->fhci->regs->usb_event,
+			out_be16(&usb->fhci->regs->usb_usber,
 				 usb->saved_msk);
 		} else if (usb->port_status == FHCI_PORT_DISABLED) {
 			if (fhci_ioports_check_bus_state(fhci) == 1)
@@ -611,7 +611,7 @@ irqreturn_t fhci_irq(struct usb_hcd *hcd)
 			/* XXX usb->port_status = FHCI_PORT_WAITING; */
 			/* Disable IDLE */
 			usb->saved_msk &= ~USB_E_IDLE_MASK;
-			out_be16(&usb->fhci->regs->usb_mask,
+			out_be16(&usb->fhci->regs->usb_usbmr,
 				 usb->saved_msk);
 		} else {
 			fhci_dbg_isr(fhci, -1);
diff --git a/drivers/usb/host/fhci-tds.c b/drivers/usb/host/fhci-tds.c
index c5ed881..1498061 100644
--- a/drivers/usb/host/fhci-tds.c
+++ b/drivers/usb/host/fhci-tds.c
@@ -249,7 +249,7 @@ void fhci_init_ep_registers(struct fhci_usb *usb,
struct endpoint *ep,
 	u8 rt;

 	/* set the endpoint registers according to the endpoint */
-	out_be16(&usb->fhci->regs->usb_ep[0],
+	out_be16(&usb->fhci->regs->usb_usep[0],
 		 USB_TRANS_CTR | USB_EP_MF | USB_EP_RTE);
 	out_be16(&usb->fhci->pram->ep_ptr[0],
 		 cpm_muram_offset(ep->ep_pram_ptr));
@@ -463,7 +463,7 @@ u32 fhci_host_transaction(struct fhci_usb *usb,
 	cq_put(&ep->conf_frame_Q, pkt);

 	if (cq_howmany(&ep->conf_frame_Q) == 1)
-		out_8(&usb->fhci->regs->usb_comm, USB_CMD_STR_FIFO);
+		out_8(&usb->fhci->regs->usb_uscom, USB_CMD_STR_FIFO);

 	return 0;
 }
@@ -535,8 +535,8 @@ void fhci_flush_actual_frame(struct fhci_usb *usb)
 	struct endpoint *ep = usb->ep0;

 	/* disable the USB controller */
-	mode = in_8(&usb->fhci->regs->usb_mod);
-	out_8(&usb->fhci->regs->usb_mod, mode & ~USB_MODE_EN);
+	mode = in_8(&usb->fhci->regs->usb_usmod);
+	out_8(&usb->fhci->regs->usb_usmod, mode & ~USB_MODE_EN);

 	tb_ptr = in_be16(&ep->ep_pram_ptr->tx_bd_ptr);
 	td = cpm_muram_addr(tb_ptr);
@@ -571,9 +571,9 @@ void fhci_flush_actual_frame(struct fhci_usb *usb)
 	usb->actual_frame->frame_status = FRAME_TIMER_END_TRANSMISSION;

 	/* reset the event register */
-	out_be16(&usb->fhci->regs->usb_event, 0xffff);
+	out_be16(&usb->fhci->regs->usb_usber, 0xffff);
 	/* enable the USB controller */
-	out_8(&usb->fhci->regs->usb_mod, mode | USB_MODE_EN);
+	out_8(&usb->fhci->regs->usb_usmod, mode | USB_MODE_EN);
 }

 /* handles Tx confirm and Tx error interrupt */
@@ -613,7 +613,7 @@ void fhci_host_transmit_actual_frame(struct fhci_usb *usb)

 		/* start transmit only if we have something in the TDs */
 		if (in_be16(&td->status) & TD_R)
-			out_8(&usb->fhci->regs->usb_comm, USB_CMD_STR_FIFO);
+			out_8(&usb->fhci->regs->usb_uscom, USB_CMD_STR_FIFO);

 		if (in_be32(&ep->conf_td->buf_ptr) == DUMMY_BD_BUFFER) {
 			out_be32(&old_td->buf_ptr, 0);
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index dc6939a..8a4cb8b74 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -28,6 +28,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <asm/qe.h>
+#include <asm/immap_qe.h>

 #define USB_CLOCK	48000000

@@ -173,25 +174,6 @@
 #define USB_E_TXB_MASK		0x0002
 #define USB_E_RXB_MASK		0x0001

-/* Freescale USB Host controller registers */
-struct fhci_regs {
-	u8 usb_mod;		/* mode register */
-	u8 usb_addr;		/* address register */
-	u8 usb_comm;		/* command register */
-	u8 reserved1[1];
-	__be16 usb_ep[4];	/* endpoint register */
-	u8 reserved2[4];
-	__be16 usb_event;	/* event register */
-	u8 reserved3[2];
-	__be16 usb_mask;	/* mask register */
-	u8 reserved4[1];
-	u8 usb_status;		/* status register */
-	__be16 usb_sof_tmr;	/* Start Of Frame timer */
-	u8 reserved5[2];
-	__be16 usb_frame_num;	/* frame number register */
-	u8 reserved6[1];
-};
-
 /* Freescale USB HOST */
 struct fhci_pram {
 	__be16 ep_ptr[4];	/* Endpoint porter reg */
@@ -267,7 +249,7 @@ struct fhci_hcd {
 	int gpios[NUM_GPIOS];
 	bool alow_gpios[NUM_GPIOS];

-	struct fhci_regs __iomem *regs;	/* I/O memory used to communicate */
+	struct qe_usb_ctlr __iomem *regs;	/* I/O memory used to communicate */
 	struct fhci_pram __iomem *pram;	/* Parameter RAM */
 	struct gtm_timer *timer;

-- 
1.7.5.4
