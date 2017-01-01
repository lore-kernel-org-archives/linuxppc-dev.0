Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3trhby3RykzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jan 2017 11:56:30 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <21addf22fe807d98ea172e63ef3fdb2716a454d8.1483055859.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1483055859.git.fthain@telegraphics.com.au>
References: <cover.1483055859.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH RESEND 09/10] via-cuda: Add support for Egret system controller
Date: Sat, 31 Dec 2016 19:56:26 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Egret system controller was the predecessor to the Cuda and the
differences are minor.

On Cuda, byte acknowledgement requires one transition of the TACK
signal; on Egret two are needed. On Cuda, TIP is active low; on Egret
it is active high. And Cuda raises certain interrupts that Egret omits.

Accomodating these differences complicates the Cuda driver slightly
but avoids a lot of duplication (see next patch).

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 155 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 134 insertions(+), 21 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 57fb20d..1a742bd 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -1,10 +1,10 @@
 /*
- * Device driver for the via-cuda on Apple Powermacs.
+ * Device driver for the Cuda and Egret system controllers found on PowerMacs
+ * and 68k Macs.
  *
- * The VIA (versatile interface adapter) interfaces to the CUDA,
- * a 6805 microprocessor core which controls the ADB (Apple Desktop
- * Bus) which connects to the keyboard and mouse.  The CUDA also
- * controls system power and the RTC (real time clock) chip.
+ * The Cuda or Egret is a 6805 microcontroller interfaced to the 6522 VIA.
+ * This MCU controls system power, Parameter RAM, Real Time Clock and the
+ * Apple Desktop Bus (ADB) that connects to the keyboard and mouse.
  *
  * Copyright (C) 1996 Paul Mackerras.
  */
@@ -50,10 +50,27 @@ static DEFINE_SPINLOCK(cuda_lock);
 #define IER		(14*RS)		/* Interrupt enable register */
 #define ANH		(15*RS)		/* A-side data, no handshake */
 
-/* Bits in B data register: all active low */
-#define TREQ		0x08		/* Transfer request (input) */
-#define TACK		0x10		/* Transfer acknowledge (output) */
-#define TIP		0x20		/* Transfer in progress (output) */
+/*
+ * When the Cuda design replaced the Egret, some signal names and
+ * logic sense changed. They all serve the same purposes, however.
+ *
+ *   VIA pin       |  Egret pin
+ * ----------------+------------------------------------------
+ *   PB3 (input)   |  Transceiver session   (active low)
+ *   PB4 (output)  |  VIA full              (active high)
+ *   PB5 (output)  |  System session        (active high)
+ *
+ *   VIA pin       |  Cuda pin
+ * ----------------+------------------------------------------
+ *   PB3 (input)   |  Transfer request      (active low)
+ *   PB4 (output)  |  Byte acknowledge      (active low)
+ *   PB5 (output)  |  Transfer in progress  (active low)
+ */
+
+/* Bits in Port B data register */
+#define TREQ		0x08		/* Transfer request */
+#define TACK		0x10		/* Transfer acknowledge */
+#define TIP		0x20		/* Transfer in progress */
 
 /* Bits in ACR */
 #define SR_CTRL		0x1c		/* Shift register control bits */
@@ -65,6 +82,19 @@ static DEFINE_SPINLOCK(cuda_lock);
 #define IER_CLR		0		/* clear bits in IER */
 #define SR_INT		0x04		/* Shift register full/empty */
 
+/* Duration of byte acknowledgement pulse (us) */
+#define EGRET_TACK_ASSERTED_DELAY	300
+#define EGRET_TACK_NEGATED_DELAY	400
+
+/* Interval from interrupt to start of session (us) */
+#define EGRET_SESSION_DELAY		450
+
+#ifdef CONFIG_PPC
+#define mcu_is_egret	false
+#else
+static bool mcu_is_egret;
+#endif
+
 static inline bool TREQ_asserted(u8 portb)
 {
 	return !(portb & TREQ);
@@ -72,12 +102,29 @@ static inline bool TREQ_asserted(u8 portb)
 
 static inline void assert_TIP(void)
 {
-	out_8(&via[B], in_8(&via[B]) & ~TIP);
+	if (mcu_is_egret) {
+		udelay(EGRET_SESSION_DELAY);
+		out_8(&via[B], in_8(&via[B]) | TIP);
+	} else
+		out_8(&via[B], in_8(&via[B]) & ~TIP);
+}
+
+static inline void assert_TIP_and_TACK(void)
+{
+	if (mcu_is_egret) {
+		udelay(EGRET_SESSION_DELAY);
+		out_8(&via[B], in_8(&via[B]) | TIP | TACK);
+	} else
+		out_8(&via[B], in_8(&via[B]) & ~(TIP | TACK));
 }
 
 static inline void assert_TACK(void)
 {
-	out_8(&via[B], in_8(&via[B]) & ~TACK);
+	if (mcu_is_egret) {
+		udelay(EGRET_TACK_NEGATED_DELAY);
+		out_8(&via[B], in_8(&via[B]) | TACK);
+	} else
+		out_8(&via[B], in_8(&via[B]) & ~TACK);
 }
 
 static inline void toggle_TACK(void)
@@ -87,12 +134,20 @@ static inline void toggle_TACK(void)
 
 static inline void negate_TACK(void)
 {
-	out_8(&via[B], in_8(&via[B]) | TACK);
+	if (mcu_is_egret) {
+		udelay(EGRET_TACK_ASSERTED_DELAY);
+		out_8(&via[B], in_8(&via[B]) & ~TACK);
+	} else
+		out_8(&via[B], in_8(&via[B]) | TACK);
 }
 
 static inline void negate_TIP_and_TACK(void)
 {
-	out_8(&via[B], in_8(&via[B]) | TIP | TACK);
+	if (mcu_is_egret) {
+		udelay(EGRET_TACK_ASSERTED_DELAY);
+		out_8(&via[B], in_8(&via[B]) & ~(TIP | TACK));
+	} else
+		out_8(&via[B], in_8(&via[B]) | TIP | TACK);
 }
 
 static enum cuda_state {
@@ -155,6 +210,7 @@ int __init find_via_cuda(void)
 
     via = via1;
     cuda_state = idle;
+    mcu_is_egret = false;
 
     err = cuda_init_via();
     if (err) {
@@ -251,7 +307,7 @@ static int __init via_cuda_start(void)
 	return -EAGAIN;
     }
 
-    pr_info("Macintosh CUDA driver v0.5 for Unified ADB.\n");
+    pr_info("Macintosh Cuda and Egret driver.\n");
 
     cuda_fully_inited = 1;
     return 0;
@@ -276,6 +332,33 @@ cuda_probe(void)
 }
 #endif /* CONFIG_ADB */
 
+static int __init sync_egret(void)
+{
+	if (TREQ_asserted(in_8(&via[B]))) {
+		/* Complete the inbound transfer */
+		assert_TIP_and_TACK();
+		while (1) {
+			negate_TACK();
+			mdelay(1);
+			(void)in_8(&via[SR]);
+			assert_TACK();
+			if (!TREQ_asserted(in_8(&via[B])))
+				break;
+		}
+		negate_TIP_and_TACK();
+	} else if (in_8(&via[B]) & TIP) {
+		/* Terminate the outbound transfer */
+		negate_TACK();
+		assert_TACK();
+		mdelay(1);
+		negate_TIP_and_TACK();
+	}
+	/* Clear shift register interrupt */
+	if (in_8(&via[IFR]) & SR_INT)
+		(void)in_8(&via[SR]);
+	return 0;
+}
+
 #define WAIT_FOR(cond, what)					\
     do {                                                        \
     	int x;							\
@@ -291,10 +374,6 @@ cuda_probe(void)
 static int
 __init cuda_init_via(void)
 {
-    out_8(&via[DIRB], (in_8(&via[DIRB]) | TACK | TIP) & ~TREQ);	/* TACK & TIP out */
-    negate_TIP_and_TACK();
-    out_8(&via[ACR] ,(in_8(&via[ACR]) & ~SR_CTRL) | SR_EXT);	/* SR data in */
-    (void)in_8(&via[SR]);						/* clear any left-over data */
 #ifdef CONFIG_PPC
     out_8(&via[IER], 0x7f);					/* disable interrupts from VIA */
     (void)in_8(&via[IER]);
@@ -302,6 +381,15 @@ __init cuda_init_via(void)
     out_8(&via[IER], SR_INT);					/* disable SR interrupt from VIA */
 #endif
 
+    out_8(&via[DIRB], (in_8(&via[DIRB]) | TACK | TIP) & ~TREQ);	/* TACK & TIP out */
+    out_8(&via[ACR], (in_8(&via[ACR]) & ~SR_CTRL) | SR_EXT);	/* SR data in */
+    (void)in_8(&via[SR]);					/* clear any left-over data */
+
+    if (mcu_is_egret)
+	return sync_egret();
+
+    negate_TIP_and_TACK();
+
     /* delay 4ms and then clear any pending interrupt */
     mdelay(4);
     (void)in_8(&via[SR]);
@@ -453,7 +541,10 @@ cuda_start(void)
     /* set the shift register to shift out and send a byte */
     out_8(&via[ACR], in_8(&via[ACR]) | SR_OUT);
     out_8(&via[SR], current_req->data[data_index++]);
-    assert_TIP();
+    if (mcu_is_egret)
+	assert_TIP_and_TACK();
+    else
+	assert_TIP();
     cuda_state = sent_first_byte;
 }
 
@@ -500,8 +591,9 @@ cuda_interrupt(int irq, void *arg)
 
     switch (cuda_state) {
     case idle:
-	/* CUDA has sent us the first byte of data - unsolicited */
+	/* System controller has unsolicited data for us */
 	(void)in_8(&via[SR]);
+idle_state:
 	assert_TIP();
 	cuda_state = reading;
 	reply_ptr = cuda_rbuf;
@@ -509,7 +601,7 @@ cuda_interrupt(int irq, void *arg)
 	break;
 
     case awaiting_reply:
-	/* CUDA has sent us the first byte of data of a reply */
+	/* System controller has reply data for us */
 	(void)in_8(&via[SR]);
 	assert_TIP();
 	cuda_state = reading;
@@ -524,9 +616,14 @@ cuda_interrupt(int irq, void *arg)
 	    (void)in_8(&via[SR]);
 	    negate_TIP_and_TACK();
 	    cuda_state = idle;
+	    /* Egret does not raise an "aborted" interrupt */
+	    if (mcu_is_egret)
+		goto idle_state;
 	} else {
 	    out_8(&via[SR], current_req->data[data_index++]);
 	    toggle_TACK();
+	    if (mcu_is_egret)
+		assert_TACK();
 	    cuda_state = sending;
 	}
 	break;
@@ -550,6 +647,8 @@ cuda_interrupt(int irq, void *arg)
 	} else {
 	    out_8(&via[SR], req->data[data_index++]);
 	    toggle_TACK();
+	    if (mcu_is_egret)
+		assert_TACK();
 	}
 	break;
 
@@ -560,16 +659,24 @@ cuda_interrupt(int irq, void *arg)
 	else
 	    *reply_ptr++ = in_8(&via[SR]);
 	if (!TREQ_asserted(status)) {
+	    if (mcu_is_egret)
+		assert_TACK();
 	    /* that's all folks */
 	    negate_TIP_and_TACK();
 	    cuda_state = read_done;
+	    /* Egret does not raise a "read done" interrupt */
+	    if (mcu_is_egret)
+		goto read_done_state;
 	} else {
 	    toggle_TACK();
+	    if (mcu_is_egret)
+		negate_TACK();
 	}
 	break;
 
     case read_done:
 	(void)in_8(&via[SR]);
+read_done_state:
 	if (reading_reply) {
 	    req = current_req;
 	    req->reply_len = reply_ptr - req->reply;
@@ -645,6 +752,12 @@ cuda_input(unsigned char *buf, int nb)
 #endif /* CONFIG_ADB */
 	break;
 
+    case TIMER_PACKET:
+	/* Egret sends these periodically. Might be useful as a 'heartbeat'
+	 * to trigger a recovery for the VIA shift register errata.
+	 */
+	break;
+
     default:
 	print_hex_dump(KERN_INFO, "cuda_input: ", DUMP_PREFIX_NONE, 32, 1,
 	               buf, nb, false);
-- 
2.10.2
