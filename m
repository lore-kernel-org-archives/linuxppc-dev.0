Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 02086DDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 13:02:42 +1100 (EST)
Message-ID: <47BA38C1.6040609@pikatech.com>
Date: Mon, 18 Feb 2008 21:02:41 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] i2c-ibm_iic driver bonus patch
References: <477EF225.4070505@pikatech.com>
In-Reply-To: <477EF225.4070505@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is an optional bonus patch that cleans up most of the checkpatch 
warnings in the common code. I left in the volatiles, since I don't 
understand why they where needed. The memory always seems to be access 
with in_8 and out_8, which are declared volatile. But they could be 
there to fix a very specific bug.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
--- for-2.6.25/drivers/i2c/busses/submitted-i2c-ibm_iic.c	2008-02-18 20:44:06.000000000 -0500
+++ for-2.6.25/drivers/i2c/busses/i2c-ibm_iic.c	2008-02-18 20:53:53.000000000 -0500
@@ -76,17 +76,17 @@
 #endif
 
 #if DBG_LEVEL > 0
-#  define DBG(f,x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
+#  define DBG(f, x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
 #else
-#  define DBG(f,x...)	((void)0)
+#  define DBG(f, x...)	((void)0)
 #endif
 #if DBG_LEVEL > 1
-#  define DBG2(f,x...) 	DBG(f, ##x)
+#  define DBG2(f, x...) 	DBG(f, ##x)
 #else
-#  define DBG2(f,x...) 	((void)0)
+#  define DBG2(f, x...) 	((void)0)
 #endif
 #if DBG_LEVEL > 2
-static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
+static void dump_iic_regs(const char *header, struct ibm_iic_private *dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
@@ -98,9 +98,9 @@
 		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),
 		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
 }
-#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
+#  define DUMP_REGS(h, dev)	dump_iic_regs((h), (dev))
 #else
-#  define DUMP_REGS(h,dev)	((void)0)
+#  define DUMP_REGS(h, dev)	((void)0)
 #endif
 
 /* Bus timings (in ns) for bit-banging */
@@ -111,25 +111,26 @@
 	unsigned int high;
 	unsigned int buf;
 } timings [] = {
-/* Standard mode (100 KHz) */
-{
-	.hd_sta	= 4000,
-	.su_sto	= 4000,
-	.low	= 4700,
-	.high	= 4000,
-	.buf	= 4700,
-},
-/* Fast mode (400 KHz) */
-{
-	.hd_sta = 600,
-	.su_sto	= 600,
-	.low 	= 1300,
-	.high 	= 600,
-	.buf	= 1300,
-}};
+	/* Standard mode (100 KHz) */
+	{
+		.hd_sta	= 4000,
+		.su_sto	= 4000,
+		.low	= 4700,
+		.high	= 4000,
+		.buf	= 4700,
+	},
+	/* Fast mode (400 KHz) */
+	{
+		.hd_sta = 600,
+		.su_sto	= 600,
+		.low 	= 1300,
+		.high 	= 600,
+		.buf	= 1300,
+	}
+};
 
 /* Enable/disable interrupt generation */
-static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
+static inline void iic_interrupt_mode(struct ibm_iic_private *dev, int enable)
 {
 	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
 }
@@ -137,7 +138,7 @@
 /*
  * Initialize IIC interface.
  */
-static void iic_dev_init(struct ibm_iic_private* dev)
+static void iic_dev_init(struct ibm_iic_private *dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 
@@ -182,7 +183,7 @@
 /*
  * Reset IIC interface
  */
-static void iic_dev_reset(struct ibm_iic_private* dev)
+static void iic_dev_reset(struct ibm_iic_private *dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 	int i;
@@ -191,19 +192,19 @@
 	DBG("%d: soft reset\n", dev->idx);
 	DUMP_REGS("reset", dev);
 
-    	/* Place chip in the reset state */
+	/* Place chip in the reset state */
 	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
 
 	/* Check if bus is free */
 	dc = in_8(&iic->directcntl);
-	if (!DIRCTNL_FREE(dc)){
+	if (!DIRCTNL_FREE(dc)) {
 		DBG("%d: trying to regain bus control\n", dev->idx);
 
 		/* Try to set bus free state */
 		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
 
 		/* Wait until we regain bus control */
-		for (i = 0; i < 100; ++i){
+		for (i = 0; i < 100; ++i) {
 			dc = in_8(&iic->directcntl);
 			if (DIRCTNL_FREE(dc))
 				break;
@@ -235,7 +236,7 @@
 static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
 {
 	unsigned long x = jiffies + HZ / 28 + 2;
-	while ((in_8(&iic->directcntl) & mask) != mask){
+	while ((in_8(&iic->directcntl) & mask) != mask) {
 		if (unlikely(time_after(jiffies, x)))
 			return -1;
 		cond_resched();
@@ -243,15 +244,15 @@
 	return 0;
 }
 
-static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
+static int iic_smbus_quick(struct ibm_iic_private *dev, const struct i2c_msg *p)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
-	const struct i2c_timings* t = &timings[dev->fast_mode ? 1 : 0];
+	const struct i2c_timings *t = &timings[dev->fast_mode ? 1 : 0];
 	u8 mask, v, sda;
 	int i, res;
 
 	/* Only 7-bit addresses are supported */
-	if (unlikely(p->flags & I2C_M_TEN)){
+	if (unlikely(p->flags & I2C_M_TEN)) {
 		DBG("%d: smbus_quick - 10 bit addresses are not supported\n",
 			dev->idx);
 		return -EINVAL;
@@ -275,7 +276,7 @@
 
 	/* Send address */
 	v = (u8)((p->addr << 1) | ((p->flags & I2C_M_RD) ? 1 : 0));
-	for (i = 0, mask = 0x80; i < 8; ++i, mask >>= 1){
+	for (i = 0, mask = 0x80; i < 8; ++i, mask >>= 1) {
 		out_8(&iic->directcntl, sda);
 		ndelay(t->low / 2);
 		sda = (v & mask) ? DIRCNTL_SDAC : 0;
@@ -330,7 +331,7 @@
  */
 static irqreturn_t iic_handler(int irq, void *dev_id)
 {
-	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
+	struct ibm_iic_private *dev = (struct ibm_iic_private *)dev_id;
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 
 	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
@@ -347,11 +348,11 @@
  * Get master transfer result and clear errors if any.
  * Returns the number of actually transferred bytes or error (<0)
  */
-static int iic_xfer_result(struct ibm_iic_private* dev)
+static int iic_xfer_result(struct ibm_iic_private *dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 
-	if (unlikely(in_8(&iic->sts) & STS_ERR)){
+	if (unlikely(in_8(&iic->sts) & STS_ERR)) {
 		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx,
 			in_8(&iic->extsts));
 
@@ -367,20 +368,19 @@
 		 * IIC interface is usually stuck in some strange
 		 * state, the only way out - soft reset.
 		 */
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE) {
 			DBG("%d: bus is stuck, resetting\n", dev->idx);
 			iic_dev_reset(dev);
 		}
 		return -EREMOTEIO;
-	}
-	else
+	} else
 		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
 }
 
 /*
  * Try to abort active transfer.
  */
-static void iic_abort_xfer(struct ibm_iic_private* dev)
+static void iic_abort_xfer(struct ibm_iic_private *dev)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 	unsigned long x;
@@ -394,8 +394,8 @@
 	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
 	 */
 	x = jiffies + 2;
-	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-		if (time_after(jiffies, x)){
+	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE) {
+		if (time_after(jiffies, x)) {
 			DBG("%d: abort timeout, resetting...\n", dev->idx);
 			iic_dev_reset(dev);
 			return;
@@ -412,19 +412,19 @@
  * It puts current process to sleep until we get interrupt or timeout expires.
  * Returns the number of transferred bytes or error (<0)
  */
-static int iic_wait_for_tc(struct ibm_iic_private* dev){
-
+static int iic_wait_for_tc(struct ibm_iic_private *dev)
+{
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 	int ret = 0;
 
-	if (dev->irq >= 0){
+	if (dev->irq >= 0) {
 		/* Interrupt mode */
 		ret = wait_event_interruptible_timeout(dev->wq,
 			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout * HZ);
 
 		if (unlikely(ret < 0))
 			DBG("%d: wait interrupted\n", dev->idx);
-		else if (unlikely(in_8(&iic->sts) & STS_PT)){
+		else if (unlikely(in_8(&iic->sts) & STS_PT)) {
 			DBG("%d: wait timeout\n", dev->idx);
 			ret = -ETIMEDOUT;
 		}
@@ -433,14 +433,14 @@
 		/* Polling mode */
 		unsigned long x = jiffies + dev->adap.timeout * HZ;
 
-		while (in_8(&iic->sts) & STS_PT){
-			if (unlikely(time_after(jiffies, x))){
+		while (in_8(&iic->sts) & STS_PT) {
+			if (unlikely(time_after(jiffies, x))) {
 				DBG("%d: poll timeout\n", dev->idx);
 				ret = -ETIMEDOUT;
 				break;
 			}
 
-			if (unlikely(signal_pending(current))){
+			if (unlikely(signal_pending(current))) {
 				DBG("%d: poll interrupted\n", dev->idx);
 				ret = -ERESTARTSYS;
 				break;
@@ -462,11 +462,11 @@
 /*
  * Low level master transfer routine
  */
-static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
+static int iic_xfer_bytes(struct ibm_iic_private *dev, struct i2c_msg *pm,
 			  int combined_xfer)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
-	char* buf = pm->buf;
+	char *buf = pm->buf;
 	int i, j, loops, ret = 0;
 	int len = pm->len;
 
@@ -475,7 +475,7 @@
 		cntl |= CNTL_RW;
 
 	loops = (len + 3) / 4;
-	for (i = 0; i < loops; ++i, len -= 4){
+	for (i = 0; i < loops; ++i, len -= 4) {
 		int count = len > 4 ? 4 : len;
 		u8 cmd = cntl | ((count - 1) << CNTL_TCT_SHIFT);
 
@@ -498,7 +498,7 @@
 
 		if (unlikely(ret < 0))
 			break;
-		else if (unlikely(ret != count)){
+		else if (unlikely(ret != count)) {
 			DBG("%d: xfer_bytes, requested %d, transfered %d\n",
 				dev->idx, count, ret);
 
@@ -521,7 +521,7 @@
 /*
  * Set target slave address for master transfer
  */
-static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg* msg)
+static inline void iic_address(struct ibm_iic_private *dev, struct i2c_msg *msg)
 {
 	volatile struct iic_regs __iomem *iic = dev->vaddr;
 	u16 addr = msg->addr;
@@ -529,24 +529,24 @@
 	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx,
 		addr, msg->flags & I2C_M_TEN ? 10 : 7);
 
-	if (msg->flags & I2C_M_TEN){
+	if (msg->flags & I2C_M_TEN) {
 	    out_8(&iic->cntl, CNTL_AMD);
 	    out_8(&iic->lmadr, addr);
 	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
-	}
-	else {
+	} else {
 	    out_8(&iic->cntl, 0);
 	    out_8(&iic->lmadr, addr << 1);
 	}
 }
 
-static inline int iic_invalid_address(const struct i2c_msg* p)
+static inline int iic_invalid_address(const struct i2c_msg *p)
 {
-	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
+	return (p->addr > 0x3ff) ||
+		(!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
 }
 
-static inline int iic_address_neq(const struct i2c_msg* p1,
-				  const struct i2c_msg* p2)
+static inline int iic_address_neq(const struct i2c_msg *p1,
+				  const struct i2c_msg *p2)
 {
 	return (p1->addr != p2->addr)
 		|| ((p1->flags & I2C_M_TEN) != (p2->flags & I2C_M_TEN));
@@ -558,9 +558,13 @@
  */
 static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
-    	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct ibm_iic_private *dev;
+	volatile struct iic_regs __iomem *iic;
 	int i, ret = 0;
+	u8 extsts;
+
+	dev = (struct ibm_iic_private *)(i2c_get_adapdata(adap));
+	iic = dev->vaddr;
 
 	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
 
@@ -570,14 +574,14 @@
 	/* Check the sanity of the passed messages.
 	 * Uhh, generic i2c layer is more suitable place for such code...
 	 */
-	if (unlikely(iic_invalid_address(&msgs[0]))){
+	if (unlikely(iic_invalid_address(&msgs[0]))) {
 		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx,
 			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
 		return -EINVAL;
 	}
-	for (i = 0; i < num; ++i){
-		if (unlikely(msgs[i].len <= 0)){
-			if (num == 1 && !msgs[0].len){
+	for (i = 0; i < num; ++i) {
+		if (unlikely(msgs[i].len <= 0)) {
+			if (num == 1 && !msgs[0].len) {
 				/* Special case for I2C_SMBUS_QUICK emulation.
 				 * IBM IIC doesn't support 0-length transactions
 				 * so we have to emulate them using bit-banging.
@@ -588,14 +592,15 @@
 				msgs[i].len, i);
 			return -EINVAL;
 		}
-		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
+		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))) {
 			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
 			return -EINVAL;
 		}
 	}
 
 	/* Check bus state */
-	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)){
+	extsts = in_8(&iic->extsts);
+	if (unlikely((extsts & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)) {
 		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
 
 		/* Usually it means something serious has happend.
@@ -608,12 +613,11 @@
 		 */
 		iic_dev_reset(dev);
 
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE) {
 			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
 			return -EREMOTEIO;
 		}
-	}
-	else {
+	} else {
 		/* Flush master data buffer (just in case) */
 		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
 	}
@@ -622,7 +626,7 @@
 	iic_address(dev, &msgs[0]);
 
 	/* Do real transfer */
-    	for (i = 0; i < num && !ret; ++i)
+	for (i = 0; i < num && !ret; ++i)
 		ret = iic_xfer_bytes(dev, &msgs[i], i < num - 1);
 
 	return ret < 0 ? ret : num;
@@ -648,7 +652,7 @@
 	 * Previous driver version used hardcoded divider value 4,
 	 * it corresponds to OPB frequency from the range (40, 50] MHz
 	 */
-	if (!opb){
+	if (!opb) {
 		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
 			" fix your board specific setup\n");
 		opb = 50000000;
@@ -657,9 +661,9 @@
 	/* Convert to MHz */
 	opb /= 1000000;
 
-	if (opb < 20 || opb > 150){
-		printk(KERN_WARNING "ibm-iic: invalid OPB clock frequency %u MHz\n",
-			opb);
+	if (opb < 20 || opb > 150) {
+		printk(KERN_WARNING "ibm-iic: "
+		       "invalid OPB clock frequency %u MHz\n", opb);
 		opb = opb < 20 ? 20 : 150;
 	}
 	return (u8)((opb + 9) / 10 - 1);
