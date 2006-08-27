Return-Path: <marcus@mc.pp.se>
Received: from omoikane.mc.pp.se (ua-85-227-1-9.cust.bredbandsbolaget.se
	[85.227.1.9]) by ozlabs.org (Postfix) with ESMTP id E23CE67C6D
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 02:39:54 +1000 (EST)
Received: from omoikane.mc.pp.se (localhost [127.0.0.1])
	by omoikane.mc.pp.se (Postfix) with ESMTP id DD8306540
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Aug 2006 18:17:31 +0200 (CEST)
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system
From: Marcus Comstedt <marcus@mc.pp.se>
Date: Sun, 27 Aug 2006 18:17:14 +0200
Message-ID: <yf9bqq6p305.fsf@omoikane.mc.pp.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-=-=
Content-Disposition: inline


Hello.

I'm running 2.6.16.27 on an AmigaOneXE, which is a G4 based board
which has a northbridge (ArticiaS) which does not support cache
coherency.  Because of this, CONFIG_NOT_COHERENT_CACHE is set.

The problem I've been having is that the EHCI USB2 host driver causes
a kernel oops (see attachment) immediately on bootup.

First, let me outline why this oops happens:

1) The EHCI driver uses a structure called "echi_qh", which contains
   both data to be accessed by the USB hardware through DMA, and
   private housekeeping data.
2) Since part of the structure is for DMA, instances of the structre
   are allocated with dma_pool_alloc().
3) Pages allocated with dma_pool_alloc() are cache-inhibited on this
   system, due to the lack of cache coherency support.
4) The private data in this structure included a struct kref, which in
   turn contains an atomic_t.
5) Incrementing and decrementing an atom_t, and thereby a kref, is
   done with lwarx/stwcx.
6) lwarx on a cache-inhibited address is not allowed on G4 (generates
   a DSI).

Now, the problem is deciding in which of these steps the actual error
lies, since none of these facts (apart from #6) is set in stone.  In
my opinion though, it makes sense to simply say that atomic_t:s (and
therefore kref:s) are not supported in DMA memory.  This would place
the error in the EHCI driver, with two possible solutions:

A) Rewrite qh_get() and qh_put() to use something else than
   kref_get()/kref_put().  Simply using non-atomic increment and
   decrement made the Oops go away, but as I don't know the design
   decision behind using a struct kref, I can't say that atomicity
   isn't needed, so such a simple fix might lead to race conditions.

B) Break struct ehci_qh into two parts, one allcated with
   dma_pool_alloc() and one allocated with kmalloc(), where the fields
   accessed by the hardware is put into the former, and the driver
   private data (which includes the kref) in the latter.  Safe and no
   major performance hit (just one level of indirection added in some
   places, and using cache-enabled memory for the internal data might
   actually improve performance), but the change touches a rather
   large amount of lines (patch attached).

C) Basically the same as B, but only the kref (and a pointer back to
   the rest of the data, so that qh_destroy can find it) is moved to
   the kmalloced part.  This means only ehci_qh_alloc(), qh_get() and
   qh_put() need to be changed, so the changeset is much smaller.  I
   don't have a patch ready for this, but I can make one on request.

A completely different approach would be

D) Make the DSI exception handler emulate lwarx on cache-inhibited
   pages.

This seems like a more complex fix though, and I'm sure the
performance would be pretty lousy (although only NOT_COHERENT_CACHE
systems would be affected of course).

So, what do you guys think?  Which is the best way to rectify the
situation?  (Apart from changing to a better northbrige, which I don't
see happening, realistically.  :-/ )


  // Marcus




--=-=-=
Content-Disposition: inline; filename=ehci.oops
Content-Description: End of dmesg output after oops

hub 4-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
hub 4-0:1.0: port 5 not reset yet, waiting 50ms
ehci_hcd 0000:00:09.2: port 5 high speed
ehci_hcd 0000:00:09.2: GetStatus port 5 status 001005 POWER sig=se0  PE CONNECT
usb 4-5: new high speed USB device using address 5
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C01490FC LR: E224A96C SP: DFE95D00 REGS: dfe95c50 TRAP: 0300    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: FC1180E0, DSISR: 04000000
TASK = dfe93980[24] 'khubd' THREAD: dfe94000Last syscall: -1 
GPR00: 00000000 DFE95D00 DFE93980 FC1180E0 00000000 00000000 FC1190BC DFE95D78 
GPR08: FC1190F8 FFFFFFFF FC119158 C01490EC 24004042 00000000 0FFD5600 00000001 
GPR16: 00800000 0FFFF220 FFFFFFFF C0320000 C0320000 C0A61A10 D142E888 C0B743E0 
GPR24: DFE95D78 800E0800 40000000 FC119098 FC119120 110A9060 FC118080 FC119060 
NIP [c01490fc] kref_get+0x10/0x24
LR [e224a96c] qh_append_tds+0x16c/0x2f0 [ehci_hcd]
Call trace:
 [e224ab64] submit_async+0x74/0xe0 [ehci_hcd]
 [e224e9d4] ehci_urb_enqueue+0x6c/0xe4 [ehci_hcd]
 [c01ec9f4] hcd_submit_urb+0x1a0/0x268
 [c01ed650] usb_submit_urb+0x24c/0x330
 [c01ed9fc] usb_start_wait_urb+0x5c/0x10c
 [c01edb20] usb_internal_control_msg+0x74/0x9c
 [c01edbe4] usb_control_msg+0x9c/0xc0
 [c01e9d34] hub_set_address+0x5c/0x94
 [c01e9f48] hub_port_init+0x1dc/0x3dc
 [c01ea4fc] hub_port_connect_change+0x1c0/0x4b4
 [c01eac10] hub_events+0x420/0x51c
 [c01ead4c] hub_thread+0x40/0xec
 [c000aec4] kernel_thread+0x44/0x60

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ehci_qh_split.patch
Content-Description: Patch to split struct ehci_qh into two parts

diff -rup -x'*.o' -x'*.ko' -x'*.cmd' -x'*~' drivers/usb/host.orig/ehci-dbg.c drivers/usb/host/ehci-dbg.c
--- drivers/usb/host.orig/ehci-dbg.c	2006-07-17 15:58:58.000000000 +0200
+++ drivers/usb/host/ehci-dbg.c	2006-08-20 21:00:09.000000000 +0200
@@ -135,9 +135,9 @@ static void __attribute__((__unused__))
 dbg_qh (const char *label, struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	ehci_dbg (ehci, "%s qh %p n%08x info %x %x qtd %x\n", label,
-		qh, qh->hw_next, qh->hw_info1, qh->hw_info2,
-		qh->hw_current);
-	dbg_qtd ("overlay", ehci, (struct ehci_qtd *) &qh->hw_qtd_next);
+		qh, qh->qh_hw->hw_next, qh->qh_hw->hw_info1, qh->qh_hw->hw_info2,
+		qh->qh_hw->hw_current);
+	dbg_qtd ("overlay", ehci, (struct ehci_qtd *) &qh->qh_hw->hw_qtd_next);
 }
 
 static void __attribute__((__unused__))
@@ -361,29 +361,29 @@ static void qh_lines (
 	char			*next = *nextp;
 	char			mark;
 
-	if (qh->hw_qtd_next == EHCI_LIST_END)	/* NEC does this */
+	if (qh->qh_hw->hw_qtd_next == EHCI_LIST_END)	/* NEC does this */
 		mark = '@';
 	else
-		mark = token_mark (qh->hw_token);
+		mark = token_mark (qh->qh_hw->hw_token);
 	if (mark == '/') {	/* qh_alt_next controls qh advance? */
-		if ((qh->hw_alt_next & QTD_MASK) == ehci->async->hw_alt_next)
+		if ((qh->qh_hw->hw_alt_next & QTD_MASK) == ehci->async->qh_hw->hw_alt_next)
 			mark = '#';	/* blocked */
-		else if (qh->hw_alt_next == EHCI_LIST_END)
+		else if (qh->qh_hw->hw_alt_next == EHCI_LIST_END)
 			mark = '.';	/* use hw_qtd_next */
 		/* else alt_next points to some other qtd */
 	}
-	scratch = le32_to_cpup (&qh->hw_info1);
-	hw_curr = (mark == '*') ? le32_to_cpup (&qh->hw_current) : 0;
+	scratch = le32_to_cpup (&qh->qh_hw->hw_info1);
+	hw_curr = (mark == '*') ? le32_to_cpup (&qh->qh_hw->hw_current) : 0;
 	temp = scnprintf (next, size,
 			"qh/%p dev%d %cs ep%d %08x %08x (%08x%c %s nak%d)",
 			qh, scratch & 0x007f,
 			speed_char (scratch),
 			(scratch >> 8) & 0x000f,
-			scratch, le32_to_cpup (&qh->hw_info2),
-			le32_to_cpup (&qh->hw_token), mark,
-			(__constant_cpu_to_le32 (QTD_TOGGLE) & qh->hw_token)
+			  scratch, le32_to_cpup (&qh->qh_hw->hw_info2),
+			le32_to_cpup (&qh->qh_hw->hw_token), mark,
+			(__constant_cpu_to_le32 (QTD_TOGGLE) & qh->qh_hw->hw_token)
 				? "data1" : "data0",
-			(le32_to_cpup (&qh->hw_alt_next) >> 1) & 0x0f);
+			(le32_to_cpup (&qh->qh_hw->hw_alt_next) >> 1) & 0x0f);
 	size -= temp;
 	next += temp;
 
@@ -394,10 +394,10 @@ static void qh_lines (
 		mark = ' ';
 		if (hw_curr == td->qtd_dma)
 			mark = '*';
-		else if (qh->hw_qtd_next == cpu_to_le32(td->qtd_dma))
+		else if (qh->qh_hw->hw_qtd_next == cpu_to_le32(td->qtd_dma))
 			mark = '+';
 		else if (QTD_LENGTH (scratch)) {
-			if (td->hw_alt_next == ehci->async->hw_alt_next)
+			if (td->hw_alt_next == ehci->async->qh_hw->hw_alt_next)
 				mark = '#';
 			else if (td->hw_alt_next != EHCI_LIST_END)
 				mark = '/';
@@ -525,7 +525,7 @@ show_periodic (struct class_device *clas
 			case Q_TYPE_QH:
 				temp = scnprintf (next, size, " qh%d-%04x/%p",
 						p.qh->period,
-						le32_to_cpup (&p.qh->hw_info2)
+						le32_to_cpup (&p.qh->qh_hw->hw_info2)
 							/* uframe masks */
 							& (QH_CMASK | QH_SMASK),
 						p.qh);
@@ -544,7 +544,7 @@ show_periodic (struct class_device *clas
 				/* show more info the first time around */
 				if (temp == seen_count && p.ptr) {
 					u32	scratch = le32_to_cpup (
-							&p.qh->hw_info1);
+							&p.qh->qh_hw->hw_info1);
 					struct ehci_qtd	*qtd;
 					char		*type = "";
 
@@ -576,7 +576,7 @@ show_periodic (struct class_device *clas
 				} else
 					temp = 0;
 				if (p.qh) {
-					tag = Q_NEXT_TYPE (p.qh->hw_next);
+					tag = Q_NEXT_TYPE (p.qh->qh_hw->hw_next);
 					p = p.qh->qh_next;
 				}
 				break;
diff -rup -x'*.o' -x'*.ko' -x'*.cmd' -x'*~' drivers/usb/host.orig/ehci-hcd.c drivers/usb/host/ehci-hcd.c
--- drivers/usb/host.orig/ehci-hcd.c	2006-07-17 15:58:58.000000000 +0200
+++ drivers/usb/host/ehci-hcd.c	2006-08-20 15:51:33.000000000 +0200
@@ -445,12 +445,12 @@ static int ehci_init(struct usb_hcd *hcd
 	 * from automatically advancing to the next td after short reads.
 	 */
 	ehci->async->qh_next.qh = NULL;
-	ehci->async->hw_next = QH_NEXT(ehci->async->qh_dma);
-	ehci->async->hw_info1 = cpu_to_le32(QH_HEAD);
-	ehci->async->hw_token = cpu_to_le32(QTD_STS_HALT);
-	ehci->async->hw_qtd_next = EHCI_LIST_END;
+	ehci->async->qh_hw->hw_next = QH_NEXT(ehci->async->qh_dma);
+	ehci->async->qh_hw->hw_info1 = cpu_to_le32(QH_HEAD);
+	ehci->async->qh_hw->hw_token = cpu_to_le32(QTD_STS_HALT);
+	ehci->async->qh_hw->hw_qtd_next = EHCI_LIST_END;
 	ehci->async->qh_state = QH_STATE_LINKED;
-	ehci->async->hw_alt_next = QTD_NEXT(ehci->async->dummy->qtd_dma);
+	ehci->async->qh_hw->hw_alt_next = QTD_NEXT(ehci->async->dummy->qtd_dma);
 
 	/* clear interrupt enables, set irq latency */
 	if (log2_irq_thresh < 0 || log2_irq_thresh > 6)
@@ -828,7 +828,7 @@ rescan:
 	/* endpoints can be iso streams.  for now, we don't
 	 * accelerate iso completions ... so spin a while.
 	 */
-	if (qh->hw_info1 == 0) {
+	if (qh->qh_hw->hw_info1 == 0) {
 		ehci_vdbg (ehci, "iso delay\n");
 		goto idle_timeout;
 	}
diff -rup -x'*.o' -x'*.ko' -x'*.cmd' -x'*~' drivers/usb/host.orig/ehci-mem.c drivers/usb/host/ehci-mem.c
--- drivers/usb/host.orig/ehci-mem.c	2006-07-17 15:58:58.000000000 +0200
+++ drivers/usb/host/ehci-mem.c	2006-08-20 15:54:05.000000000 +0200
@@ -76,23 +76,31 @@ static void qh_destroy (struct kref *kre
 	if (qh->dummy)
 		ehci_qtd_free (ehci, qh->dummy);
 	usb_put_dev (qh->dev);
-	dma_pool_free (ehci->qh_pool, qh, qh->qh_dma);
+	dma_pool_free (ehci->qh_pool, qh->qh_hw, qh->qh_dma);
+	kfree (qh);
 }
 
 static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, gfp_t flags)
 {
 	struct ehci_qh		*qh;
+	struct ehci_qh_hw	*qh_hw;
 	dma_addr_t		dma;
 
-	qh = (struct ehci_qh *)
+	qh_hw = (struct ehci_qh_hw *)
 		dma_pool_alloc (ehci->qh_pool, flags, &dma);
-	if (!qh)
+	if (!qh_hw)
+		return NULL;
+	qh = (struct ehci_qh *)
+		kmalloc (sizeof (struct ehci_qh), GFP_KERNEL);
+	if (!qh) {
+		dma_pool_free (ehci->qh_pool, qh_hw, dma);
 		return qh;
-
+	}
 	memset (qh, 0, sizeof *qh);
 	kref_init(&qh->kref);
 	qh->ehci = ehci;
 	qh->qh_dma = dma;
+	qh->qh_hw = qh_hw;
 	// INIT_LIST_HEAD (&qh->qh_list);
 	INIT_LIST_HEAD (&qh->qtd_list);
 
@@ -100,7 +108,8 @@ static struct ehci_qh *ehci_qh_alloc (st
 	qh->dummy = ehci_qtd_alloc (ehci, flags);
 	if (qh->dummy == NULL) {
 		ehci_dbg (ehci, "no dummy td\n");
-		dma_pool_free (ehci->qh_pool, qh, qh->qh_dma);
+		dma_pool_free (ehci->qh_pool, qh_hw, dma);
+		kfree (qh);
 		qh = NULL;
 	}
 	return qh;
@@ -178,7 +187,7 @@ static int ehci_mem_init (struct ehci_hc
 	/* QHs for control/bulk/intr transfers */
 	ehci->qh_pool = dma_pool_create ("ehci_qh", 
 			ehci_to_hcd(ehci)->self.controller,
-			sizeof (struct ehci_qh),
+			sizeof (struct ehci_qh_hw),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
 	if (!ehci->qh_pool) {
diff -rup -x'*.o' -x'*.ko' -x'*.cmd' -x'*~' drivers/usb/host.orig/ehci-q.c drivers/usb/host/ehci-q.c
--- drivers/usb/host.orig/ehci-q.c	2006-07-17 15:58:58.000000000 +0200
+++ drivers/usb/host/ehci-q.c	2006-08-20 21:26:54.000000000 +0200
@@ -89,28 +89,28 @@ qh_update (struct ehci_hcd *ehci, struct
 	/* writes to an active overlay are unsafe */
 	BUG_ON(qh->qh_state != QH_STATE_IDLE);
 
-	qh->hw_qtd_next = QTD_NEXT (qtd->qtd_dma);
-	qh->hw_alt_next = EHCI_LIST_END;
+	qh->qh_hw->hw_qtd_next = QTD_NEXT (qtd->qtd_dma);
+	qh->qh_hw->hw_alt_next = EHCI_LIST_END;
 
 	/* Except for control endpoints, we make hardware maintain data
 	 * toggle (like OHCI) ... here (re)initialize the toggle in the QH,
 	 * and set the pseudo-toggle in udev. Only usb_clear_halt() will
 	 * ever clear it.
 	 */
-	if (!(qh->hw_info1 & cpu_to_le32(1 << 14))) {
+	if (!(qh->qh_hw->hw_info1 & cpu_to_le32(1 << 14))) {
 		unsigned	is_out, epnum;
 
 		is_out = !(qtd->hw_token & cpu_to_le32(1 << 8));
-		epnum = (le32_to_cpup(&qh->hw_info1) >> 8) & 0x0f;
+		epnum = (le32_to_cpup(&qh->qh_hw->hw_info1) >> 8) & 0x0f;
 		if (unlikely (!usb_gettoggle (qh->dev, epnum, is_out))) {
-			qh->hw_token &= ~__constant_cpu_to_le32 (QTD_TOGGLE);
+			qh->qh_hw->hw_token &= ~__constant_cpu_to_le32 (QTD_TOGGLE);
 			usb_settoggle (qh->dev, epnum, is_out, 1);
 		}
 	}
 
 	/* HC must see latest qtd and qh data before we clear ACTIVE+HALT */
 	wmb ();
-	qh->hw_token &= __constant_cpu_to_le32 (QTD_TOGGLE | QTD_STS_PING);
+	qh->qh_hw->hw_token &= __constant_cpu_to_le32 (QTD_TOGGLE | QTD_STS_PING);
 }
 
 /* if it weren't for a common silicon quirk (writing the dummy into the qh
@@ -128,7 +128,7 @@ qh_refresh (struct ehci_hcd *ehci, struc
 		qtd = list_entry (qh->qtd_list.next,
 				struct ehci_qtd, qtd_list);
 		/* first qtd may already be partially processed */
-		if (cpu_to_le32 (qtd->qtd_dma) == qh->hw_current)
+		if (cpu_to_le32 (qtd->qtd_dma) == qh->qh_hw->hw_current)
 			qtd = NULL;
 	}
 
@@ -222,7 +222,7 @@ __acquires(ehci->lock)
 		struct ehci_qh	*qh = (struct ehci_qh *) urb->hcpriv;
 
 		/* S-mask in a QH means it's an interrupt urb */
-		if ((qh->hw_info2 & __constant_cpu_to_le32 (QH_SMASK)) != 0) {
+		if ((qh->qh_hw->hw_info2 & __constant_cpu_to_le32 (QH_SMASK)) != 0) {
 
 			/* ... update hc-wide periodic stats (for usbfs) */
 			ehci_to_hcd(ehci)->self.bandwidth_int_reqs--;
@@ -375,16 +375,16 @@ qh_completions (struct ehci_hcd *ehci, s
 			/* token in overlay may be most current */
 			if (state == QH_STATE_IDLE
 					&& cpu_to_le32 (qtd->qtd_dma)
-						== qh->hw_current)
-				token = le32_to_cpu (qh->hw_token);
+						== qh->qh_hw->hw_current)
+				token = le32_to_cpu (qh->qh_hw->hw_token);
 
 			/* force halt for unlinked or blocked qh, so we'll
 			 * patch the qh later and so that completions can't
 			 * activate it while we "know" it's stopped.
 			 */
-			if ((HALT_BIT & qh->hw_token) == 0) {
+			if ((HALT_BIT & qh->qh_hw->hw_token) == 0) {
 halt:
-				qh->hw_token |= HALT_BIT;
+				qh->qh_hw->hw_token |= HALT_BIT;
 				wmb ();
 			}
 		}
@@ -419,7 +419,7 @@ halt:
 	 * it after fault cleanup, or recovering from silicon wrongly
 	 * overlaying the dummy qtd (which reduces DMA chatter).
 	 */
-	if (stopped != 0 || qh->hw_qtd_next == EHCI_LIST_END) {
+	if (stopped != 0 || qh->qh_hw->hw_qtd_next == EHCI_LIST_END) {
 		switch (state) {
 		case QH_STATE_IDLE:
 			qh_refresh(ehci, qh);
@@ -429,7 +429,7 @@ halt:
 			 * except maybe high bandwidth ...
 			 */
 			if ((__constant_cpu_to_le32 (QH_SMASK)
-					& qh->hw_info2) != 0) {
+					& qh->qh_hw->hw_info2) != 0) {
 				intr_deschedule (ehci, qh);
 				(void) qh_schedule (ehci, qh);
 			} else
@@ -543,7 +543,7 @@ qh_urb_transaction (
 		len -= this_qtd_len;
 		buf += this_qtd_len;
 		if (is_input)
-			qtd->hw_alt_next = ehci->async->hw_alt_next;
+			qtd->hw_alt_next = ehci->async->qh_hw->hw_alt_next;
 
 		/* qh makes control packets use qtd toggle; maybe switch it */
 		if ((maxpacket & (this_qtd_len + (maxpacket - 1))) == 0)
@@ -762,8 +762,8 @@ done:
 
 	/* init as live, toggle clear, advance to dummy */
 	qh->qh_state = QH_STATE_IDLE;
-	qh->hw_info1 = cpu_to_le32 (info1);
-	qh->hw_info2 = cpu_to_le32 (info2);
+	qh->qh_hw->hw_info1 = cpu_to_le32 (info1);
+	qh->qh_hw->hw_info2 = cpu_to_le32 (info2);
 	usb_settoggle (urb->dev, usb_pipeendpoint (urb->pipe), !is_input, 1);
 	qh_refresh (ehci, qh);
 	return qh;
@@ -800,11 +800,11 @@ static void qh_link_async (struct ehci_h
 
 	/* splice right after start */
 	qh->qh_next = head->qh_next;
-	qh->hw_next = head->hw_next;
+	qh->qh_hw->hw_next = head->qh_hw->hw_next;
 	wmb ();
 
 	head->qh_next.qh = qh;
-	head->hw_next = dma;
+	head->qh_hw->hw_next = dma;
 
 	qh->qh_state = QH_STATE_LINKED;
 	/* qtd completions reported later by interrupt */
@@ -850,7 +850,7 @@ static struct ehci_qh *qh_append_tds (
 
                         /* usb_reset_device() briefly reverts to address 0 */
                         if (usb_pipedevice (urb->pipe) == 0)
-                                qh->hw_info1 &= ~QH_ADDR_MASK;
+                                qh->qh_hw->hw_info1 &= ~QH_ADDR_MASK;
 		}
 
 		/* just one way to queue requests: swap with the dummy qtd.
@@ -1031,7 +1031,7 @@ static void start_unlink_async (struct e
 	while (prev->qh_next.qh != qh)
 		prev = prev->qh_next.qh;
 
-	prev->hw_next = qh->hw_next;
+	prev->qh_hw->hw_next = qh->qh_hw->hw_next;
 	prev->qh_next = qh->qh_next;
 	wmb ();
 
diff -rup -x'*.o' -x'*.ko' -x'*.cmd' -x'*~' drivers/usb/host.orig/ehci-sched.c drivers/usb/host/ehci-sched.c
--- drivers/usb/host.orig/ehci-sched.c	2006-07-17 15:58:58.000000000 +0200
+++ drivers/usb/host/ehci-sched.c	2006-08-20 21:55:02.000000000 +0200
@@ -95,12 +95,12 @@ periodic_usecs (struct ehci_hcd *ehci, u
 		switch (Q_NEXT_TYPE (*hw_p)) {
 		case Q_TYPE_QH:
 			/* is it in the S-mask? */
-			if (q->qh->hw_info2 & cpu_to_le32 (1 << uframe))
+			if (q->qh->qh_hw->hw_info2 & cpu_to_le32 (1 << uframe))
 				usecs += q->qh->usecs;
 			/* ... or C-mask? */
-			if (q->qh->hw_info2 & cpu_to_le32 (1 << (8 + uframe)))
+			if (q->qh->qh_hw->hw_info2 & cpu_to_le32 (1 << (8 + uframe)))
 				usecs += q->qh->c_usecs;
-			hw_p = &q->qh->hw_next;
+			hw_p = &q->qh->qh_hw->hw_next;
 			q = &q->qh->qh_next;
 			break;
 		// case Q_TYPE_FSTN:
@@ -198,13 +198,13 @@ static int tt_no_collision (
 				if (same_tt (dev, here.qh->dev)) {
 					u32		mask;
 
-					mask = le32_to_cpu (here.qh->hw_info2);
+					mask = le32_to_cpu (here.qh->qh_hw->hw_info2);
 					/* "knows" no gap is needed */
 					mask |= mask >> 8;
 					if (mask & uf_mask)
 						break;
 				}
-				type = Q_NEXT_TYPE (here.qh->hw_next);
+				type = Q_NEXT_TYPE (here.qh->qh_hw->hw_next);
 				here = here.qh->qh_next;
 				continue;
 			case Q_TYPE_SITD:
@@ -301,7 +301,7 @@ static int qh_link_periodic (struct ehci
 
 	dev_dbg (&qh->dev->dev,
 		"link qh%d-%04x/%p start %d [%d/%d us]\n",
-		period, le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
+		period, le32_to_cpup (&qh->qh_hw->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* high bandwidth, or otherwise every microframe */
@@ -320,7 +320,7 @@ static int qh_link_periodic (struct ehci
 			if (type == Q_TYPE_QH)
 				break;
 			prev = periodic_next_shadow (prev, type);
-			hw_p = &here.qh->hw_next;
+			hw_p = &here.qh->qh_hw->hw_next;
 			here = *prev;
 		}
 
@@ -331,14 +331,14 @@ static int qh_link_periodic (struct ehci
 			if (qh->period > here.qh->period)
 				break;
 			prev = &here.qh->qh_next;
-			hw_p = &here.qh->hw_next;
+			hw_p = &here.qh->qh_hw->hw_next;
 			here = *prev;
 		}
 		/* link in this qh, unless some earlier pass did that */
 		if (qh != here.qh) {
 			qh->qh_next = here;
 			if (here.qh)
-				qh->hw_next = *hw_p;
+				qh->qh_hw->hw_next = *hw_p;
 			wmb ();
 			prev->qh = qh;
 			*hw_p = QH_NEXT (qh->qh_dma);
@@ -386,7 +386,7 @@ static void qh_unlink_periodic (struct e
 	dev_dbg (&qh->dev->dev,
 		"unlink qh%d-%04x/%p start %d [%d/%d us]\n",
 		qh->period,
-		le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
+		le32_to_cpup (&qh->qh_hw->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* qh->qh_next still "live" to HC */
@@ -413,14 +413,14 @@ static void intr_deschedule (struct ehci
 	 */
 	if (list_empty (&qh->qtd_list)
 			|| (__constant_cpu_to_le32 (QH_CMASK)
-					& qh->hw_info2) != 0)
+					& qh->qh_hw->hw_info2) != 0)
 		wait = 2;
 	else
 		wait = 55;	/* worst case: 3 * 1024 */
 
 	udelay (wait);
 	qh->qh_state = QH_STATE_IDLE;
-	qh->hw_next = EHCI_LIST_END;
+	qh->qh_hw->hw_next = EHCI_LIST_END;
 	wmb ();
 }
 
@@ -529,12 +529,12 @@ static int qh_schedule (struct ehci_hcd 
 	unsigned	frame;		/* 0..(qh->period - 1), or NO_FRAME */
 
 	qh_refresh(ehci, qh);
-	qh->hw_next = EHCI_LIST_END;
+	qh->qh_hw->hw_next = EHCI_LIST_END;
 	frame = qh->start;
 
 	/* reuse the previous schedule slots, if we can */
 	if (frame < qh->period) {
-		uframe = ffs (le32_to_cpup (&qh->hw_info2) & QH_SMASK);
+		uframe = ffs (le32_to_cpup (&qh->qh_hw->hw_info2) & QH_SMASK);
 		status = check_intr_schedule (ehci, frame, --uframe,
 				qh, &c_mask);
 	} else {
@@ -570,11 +570,11 @@ static int qh_schedule (struct ehci_hcd 
 		qh->start = frame;
 
 		/* reset S-frame and (maybe) C-frame masks */
-		qh->hw_info2 &= __constant_cpu_to_le32(~(QH_CMASK | QH_SMASK));
-		qh->hw_info2 |= qh->period
+		qh->qh_hw->hw_info2 &= __constant_cpu_to_le32(~(QH_CMASK | QH_SMASK));
+		qh->qh_hw->hw_info2 |= qh->period
 			? cpu_to_le32 (1 << uframe)
 			: __constant_cpu_to_le32 (QH_SMASK);
-		qh->hw_info2 |= c_mask;
+		qh->qh_hw->hw_info2 |= c_mask;
 	} else
 		ehci_dbg (ehci, "reused qh %p schedule\n", qh);
 
@@ -1918,7 +1918,7 @@ restart:
 			case Q_TYPE_QH:
 				/* handle any completions */
 				temp.qh = qh_get (q.qh);
-				type = Q_NEXT_TYPE (q.qh->hw_next);
+				type = Q_NEXT_TYPE (q.qh->qh_hw->hw_next);
 				q = q.qh->qh_next;
 				modified = qh_completions (ehci, temp.qh, regs);
 				if (unlikely (list_empty (&temp.qh->qtd_list)))
diff -rup -x'*.o' -x'*.ko' -x'*.cmd' -x'*~' drivers/usb/host.orig/ehci.h drivers/usb/host/ehci.h
--- drivers/usb/host.orig/ehci.h	2006-07-17 15:58:58.000000000 +0200
+++ drivers/usb/host/ehci.h	2006-08-20 15:46:12.000000000 +0200
@@ -381,7 +381,7 @@ union ehci_shadow {
  * These appear in both the async and (for interrupt) periodic schedules.
  */
 
-struct ehci_qh {
+struct ehci_qh_hw {
 	/* first part defined by EHCI spec */
 	__le32			hw_next;	 /* see EHCI 3.6.1 */
 	__le32			hw_info1;        /* see EHCI 3.6.2 */
@@ -402,6 +402,10 @@ struct ehci_qh {
 	__le32			hw_buf_hi [5];
 
 	/* the rest is HCD-private */
+};
+
+struct ehci_qh {
+	struct ehci_qh_hw	*qh_hw;
 	dma_addr_t		qh_dma;		/* address of qh */
 	union ehci_shadow	qh_next;	/* ptr to qh; or periodic */
 	struct list_head	qtd_list;	/* sw qtd list */

--=-=-=--
