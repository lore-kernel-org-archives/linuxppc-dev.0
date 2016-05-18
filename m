Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r93mk2LwWzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 05:15:02 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id w143so15182619wmw.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 12:15:02 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: John Youn <John.Youn@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Wed, 18 May 2016 21:14:55 +0200
Message-ID: <1569777.jHIobOl9fm@debian64>
In-Reply-To: <573BAE58.1010206@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2920638.peXreEnG6d@debian64>
 <573BAE58.1010206@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, May 17, 2016 04:50:48 PM John Youn wrote:
> On 5/14/2016 6:11 AM, Christian Lamparter wrote:
> > On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
> >> On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> >>> On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> >>>> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> >>>>>>>> Detecting the endianess of the
> >>>>>>>> device is probably the best future-proof solution, but it's also
> >>>>>>>> considerably more work to do in the driver, and comes with a
> >>>>>>>> tiny runtime overhead.
> >>>>>>>
> >>>>>>> The runtime overhead is probably non-measurable compared with the cost
> >>>>>>> of the actual MMIOs.
> >>>>>>
> >>>>>> Right. The code size increase is probably measurable (but still small),
> >>>>>> the runtime overhead is not.
> >>>>>
> >>>>> Ok, so no rebuts or complains have been posted.
> >>>>>
> >>>>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> >>>>> and it works: 
> >>>>>
> >>>>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> >>>>>
> >>>>> So, how do we go from here? There is are two small issues with the
> >>>>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> >>>>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> >>>>>
> >>>>> Arnd, can you please respin and post it (cc'd stable as well)?
> >>>>> So this is can be picked up? Or what's your plan?
> >>>>
> >>>> (I just realized my reply was stuck in my outbox, so the patch
> >>>> went out first)
> >>>>
> >>>> If I recall correctly, the rough consensus was to go with your longer
> >>>> patch in the future (fixed up for the comments that BenH and
> >>>> I sent), and I'd suggest basing it on top of a fixed version of
> >>>> my patch.
> >>> Well, but it comes with the "overhead"! So this was just as I said:
> >>> "Let's look at it and see if it's any good"... And I think it isn't
> >>> since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> >>> archs etc...
> >>
> >> I slightly prefer the more general patch for future kernel versions.
> >> The overhead will probably be negligible, but we can perform some
> >> testing to make sure.
> >>
> >> Can you resubmit with all gathered feedback?
> > 
> > Yes, here are the changes.
> > 
> > I've tested it on my MyBook Live Duo. The usbotg comes right up:
> > [12610.540004] dwc2 4bff80000.usbotg: USB bus 1 deregistered
> > [12612.513934] dwc2 4bff80000.usbotg: Specified GNPTXFDEP=1024 > 256
> > [12612.518756] dwc2 4bff80000.usbotg: EPs: 3, shared fifos, 2042 entries in SPRAM
> > [12612.530112] dwc2 4bff80000.usbotg: DWC OTG Controller
> > [12612.533948] dwc2 4bff80000.usbotg: new USB bus registered, assigned bus number 1
> > [12612.540083] dwc2 4bff80000.usbotg: irq 33, io mem 0x00000000
> > 
> > John: Can you run some perf test with it?
> > 
> > I've based this on:
> > 
> > commit 6ea2fffc9057a67df1994d85a7c085d899eaa25a
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Fri May 13 15:52:27 2016 +0200
> > 
> >     usb: dwc2: fix regression on big-endian PowerPC/ARM systems
> > 
> > so naturally, it needs to be applied first.
> > Most of the conversion work was done by the attached
> > coccinelle semantic patches. 
> > 
> > I had to edit the __bic32 and __orr32 helpers by hand.
> > As well as some debugfs code and stuff in gadget.c.
> > 
> 
> Thanks Christian.
> 
> I'll keep this in our internal tree and send it to Felipe later. This
> causes a bunch of conflicts that I have to fix up and I should do a
> bit of testing as well.
> 
> And since there is a patch that fixes the regression this is can wait.
> 
> Regards,
> John
---
Hey, that's really nice of you to do that :-D. Please keep me in the
loop (Cc) for those then. 

Yes, this needs definitely testing on all the affected ARCHs. 
I've attached a diff to a updated version of the patch. It
drops the special MIPS case (as requested by Arnd).

BTW, I looked into the ioread32_rep and iowrite32_rep again. I'm
not entirely convinced that the hardware FIFOs are actually endian
neutral. But I can't verify it since my Western Digital My Book Live
only supports the host configuration (forces host mode), so I don't
know what a device in dual-mode or peripheral do here.

The reason why I think it was broken is because there's a PIO copy
to and from the HCFIFO(x) in dwc2_hc_write_packet and
dwc2_hc_read_packet access in the hcd.c file as well... And there,
the code was using the dwc2_readl and dwc2_writel to access the data.
I added special accessors for the FIFOS now:
	dwc2_readl_rep and dwc2_writel_rep.

I went all the way and implemented the helpers to do unaligned access
if necessary (not sure if adding likely branches is a good idea, as
this could be either always true or false for a specific driver the
whole time).

NB: it also fixes a "regs variable not used in dwc2_hsotg_dump" warning
if DEBUG isn't selected.

NB2: If it you need a patch against a specific tree, please
let me know.
---
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 2fa57cd..69030bb 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -42,6 +42,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/phy.h>
+#include <asm/unaligned.h>
 #include "hw.h"
 
 /*
@@ -958,50 +959,6 @@ enum dwc2_halt_status {
 	DWC2_HC_XFER_URB_DEQUEUE,
 };
 
-#ifdef CONFIG_MIPS
-/*
- * There are some MIPS machines that can run in either big-endian
- * or little-endian mode and that use the dwc2 register without
- * a byteswap in both ways.
- * Unlike other architectures, MIPS apparently does not require a
- * barrier before the __raw_writel() to synchronize with DMA but does
- * require the barrier after the __raw_writel() to serialize a set of
- * writes. This set of operations was added specifically for MIPS and
- * should only be used there.
- */
-static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
-			     ptrdiff_t reg)
-{
-	const void __iomem *addr = hsotg->regs + reg;
-	u32 value = __raw_readl(addr);
-
-	/*
-	 * In order to preserve endianness __raw_* operation is used. Therefore
-	 * a barrier is needed to ensure IO access is not re-ordered across
-	 * reads or writes
-	 */
-	mb();
-	return value;
-}
-
-static inline void dwc2_writel(struct dwc2_hsotg *hsotg, u32 value,
-			       ptrdiff_t reg)
-{
-	const void __iomem *addr = hsotg->regs + reg;
-	__raw_writel(value, addr);
-
-	/*
-	 * In order to preserve endianness __raw_* operation is used. Therefore
-	 * a barrier is needed to ensure IO access is not re-ordered across
-	 * reads or writes
-	 */
-	mb();
-#ifdef DWC2_LOG_WRITES
-	pr_info("INFO:: wrote %08x to %p\n", value, addr);
-#endif
-}
-#else
-/* Normal architectures just use readl/write_be */
 static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
 			     ptrdiff_t reg)
 {
@@ -1014,7 +971,8 @@ static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
 }
 
 
-static inline void dwc2_writel(struct dwc2_hsotg *hsotg, u32 value,
+static inline void dwc2_writel(struct dwc2_hsotg *hsotg,
+			       const u32 value,
 			       ptrdiff_t reg)
 {
 	void __iomem *addr = hsotg->regs + reg;
@@ -1028,7 +986,103 @@ static inline void dwc2_writel(struct dwc2_hsotg *hsotg, u32 value,
 	pr_info("info:: wrote %08x to %p\n", value, addr);
 #endif
 }
-#endif
+
+static inline void dwc2_readl_rep(struct dwc2_hsotg *hsotg,
+				  ptrdiff_t reg,
+				  u32 *buf, const size_t len)
+{
+	void __iomem *addr = hsotg->regs + reg;
+	size_t i, remaining = len & ~4;
+
+	if (hsotg->is_big_endian) {
+		if (likely(IS_ALIGNED(*buf, 0x4))) {
+			for (i = len >> 2; i > 0; i--)
+				*buf++ = ioread32be(addr);
+		} else {
+			/* xfer_buf is not DWORD aligned */
+			for (i = len >> 2; i > 0; i--) {
+				u32 data = ioread32be(addr);
+
+				put_unaligned(data, buf);
+				buf++;
+			}
+		}
+	} else {
+		/* little-endian accessors */
+		if (likely(IS_ALIGNED(*buf, 0x4))) {
+			for (i = len >> 2; i > 0; i--)
+				*buf++ = ioread32(addr);
+
+		} else {
+			/* xfer_buf is not DWORD aligned */
+			for (i = len >> 2; i > 0; i--) {
+				u32 data = ioread32be(addr);
+
+				put_unaligned(data, buf);
+				buf++;
+			}
+		}
+	}
+
+	if (unlikely(remaining)) {
+		u32 data_u32;
+		u8 *buf_u8 = (u8 *) buf;
+		u8 *data_u8 = (u8 *) &data_u32;
+
+		data_u32 = dwc2_readl(hsotg, reg);
+
+		while (remaining--)
+			*buf_u8++ = *data_u8++;
+	}
+}
+
+static inline void dwc2_writel_rep(struct dwc2_hsotg *hsotg,
+				   const ptrdiff_t reg,
+				   const u32 *buf, const size_t len)
+{
+	void __iomem *addr = hsotg->regs + reg;
+	size_t i, remaining = len & ~4;
+
+	if (hsotg->is_big_endian) {
+		if (likely(IS_ALIGNED(*buf, 0x4))) {
+			for (i = len >> 2; i > 0; i--)
+				iowrite32be(*buf++, addr);
+		} else {
+			/* xfer_buf is not DWORD aligned */
+			for (i = len >> 2; i > 0; i--) {
+				u32 data = get_unaligned(buf);
+
+				iowrite32be(data, addr);
+				buf++;
+			}
+		}
+	} else {
+		/* little-endian accessors */
+		if (likely(IS_ALIGNED(*buf, 0x4))) {
+			for (i = len >> 2; i > 0; i--)
+				iowrite32(*buf++, addr);
+		} else {
+			/* xfer_buf is not DWORD aligned */
+			for (i = len >> 2; i > 0; i--) {
+				u32 data = get_unaligned(buf);
+
+				iowrite32(data, addr);
+				buf++;
+			}
+		}
+	}
+
+	if (unlikely(remaining)) {
+		u32 data_u32;
+		u8 *buf_u8 = (u8 *) buf;
+		u8 *data_u8 = (u8 *) &data_u32;
+
+		while (remaining--)
+			*data_u8++ = *buf_u8++;
+
+		dwc2_writel(hsotg, data_u32, reg);
+	}
+}
 
 extern int dwc2_detect_endiannes(struct dwc2_hsotg *hsotg);
 
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 2c687d9..531b30f 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -317,7 +317,7 @@ static int dwc2_hsotg_write_fifo(struct dwc2_hsotg *hsotg,
 	u32 gnptxsts = dwc2_readl(hsotg, GNPTXSTS);
 	int buf_pos = hs_req->req.actual;
 	int to_write = hs_ep->size_loaded;
-	void *data;
+	u32 *data;
 	int can_write;
 	int pkt_round;
 	int max_transfer;
@@ -457,10 +457,9 @@ static int dwc2_hsotg_write_fifo(struct dwc2_hsotg *hsotg,
 	if (periodic)
 		hs_ep->fifo_load += to_write;
 
-	to_write = DIV_ROUND_UP(to_write, 4);
 	data = hs_req->req.buf + buf_pos;
 
-	iowrite32_rep(hsotg->regs + EPFIFO(hs_ep->index), data, to_write);
+	dwc2_writel_rep(hsotg, EPFIFO(hs_ep->index), data, to_write);
 
 	return (to_write >= can_write) ? -ENOSPC : 0;
 }
@@ -1439,12 +1438,11 @@ static void dwc2_hsotg_rx_data(struct dwc2_hsotg *hsotg, int ep_idx, int size)
 {
 	struct dwc2_hsotg_ep *hs_ep = hsotg->eps_out[ep_idx];
 	struct dwc2_hsotg_req *hs_req = hs_ep->req;
-	void __iomem *fifo = hsotg->regs + EPFIFO(ep_idx);
+	u32 *data;
 	int to_read;
 	int max_req;
 	int read_ptr;
 
-
 	if (!hs_req) {
 		u32 epctl = dwc2_readl(hsotg, DOEPCTL(ep_idx));
 		int ptr;
@@ -1455,7 +1453,7 @@ static void dwc2_hsotg_rx_data(struct dwc2_hsotg *hsotg, int ep_idx, int size)
 
 		/* dump the data from the FIFO, we've nothing we can do */
 		for (ptr = 0; ptr < size; ptr += 4)
-			(void)dwc2_readl(hsotg, EPFIFO(ep_idx));
+			(void)__raw_readl(hsotg->regs + EPFIFO(ep_idx));
 
 		return;
 	}
@@ -1479,13 +1477,14 @@ static void dwc2_hsotg_rx_data(struct dwc2_hsotg *hsotg, int ep_idx, int size)
 
 	hs_ep->total_data += to_read;
 	hs_req->req.actual += to_read;
-	to_read = DIV_ROUND_UP(to_read, 4);
 
 	/*
 	 * note, we might over-write the buffer end by 3 bytes depending on
 	 * alignment of the data.
 	 */
-	ioread32_rep(fifo, hs_req->req.buf + read_ptr, to_read);
+	data = hs_req->req.buf + read_ptr;
+
+	dwc2_readl_rep(hsotg, EPFIFO(ep_idx), data, to_read);
 }
 
 /**
@@ -3411,7 +3416,6 @@ static void dwc2_hsotg_dump(struct dwc2_hsotg *hsotg)
 {
 #ifdef DEBUG
 	struct device *dev = hsotg->dev;
-	void __iomem *regs = hsotg->regs;
 	u32 val;
 	int idx;
 
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dcd6338..8568ff4 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -567,19 +567,10 @@ u32 dwc2_calc_frame_interval(struct dwc2_hsotg *hsotg)
 void dwc2_read_packet(struct dwc2_hsotg *hsotg, u8 *dest, u16 bytes)
 {
 	u32 *data_buf = (u32 *)dest;
-	int word_count = (bytes + 3) / 4;
-	int i;
-
-	/*
-	 * Todo: Account for the case where dest is not dword aligned. This
-	 * requires reading data from the FIFO into a u32 temp buffer, then
-	 * moving it into the data buffer.
-	 */
 
 	dev_vdbg(hsotg->dev, "%s(%p,%p,%d)\n", __func__, hsotg, dest, bytes);
 
-	for (i = 0; i < word_count; i++, data_buf++)
-		*data_buf = dwc2_readl(hsotg, HCFIFO(0));
+	dwc2_readl_rep(hsotg, HCFIFO(0), data_buf, bytes);
 }
 
 /**
@@ -1236,10 +1227,8 @@ static void dwc2_set_pid_isoc(struct dwc2_host_chan *chan)
 static void dwc2_hc_write_packet(struct dwc2_hsotg *hsotg,
 				 struct dwc2_host_chan *chan)
 {
-	u32 i;
 	u32 remaining_count;
 	u32 byte_count;
-	u32 dword_count;
 	u32 *data_buf = (u32 *)chan->xfer_buf;
 
 	if (dbg_hc(chan))
@@ -1251,20 +1240,7 @@ static void dwc2_hc_write_packet(struct dwc2_hsotg *hsotg,
 	else
 		byte_count = remaining_count;
 
-	dword_count = (byte_count + 3) / 4;
-
-	if (((unsigned long)data_buf & 0x3) == 0) {
-		/* xfer_buf is DWORD aligned */
-		for (i = 0; i < dword_count; i++, data_buf++)
-			dwc2_writel(hsotg, *data_buf, HCFIFO(chan->hc_num));
-	} else {
-		/* xfer_buf is not DWORD aligned */
-		for (i = 0; i < dword_count; i++, data_buf++) {
-			u32 data = data_buf[0] | data_buf[1] << 8 |
-				   data_buf[2] << 16 | data_buf[3] << 24;
-			dwc2_writel(hsotg, data, HCFIFO(chan->hc_num));
-		}
-	}
+	dwc2_writel_rep(hsotg, HCFIFO(chan->hc_num), data_buf, byte_count);
 
 	chan->xfer_count += byte_count;
 	chan->xfer_buf += byte_count;
