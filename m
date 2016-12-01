Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTn8G0fvRzDvyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 17:15:25 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <bd15e7462f56ed3c9e475748dc57596e21fd5371.1480572271.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1480572271.git.fthain@telegraphics.com.au>
References: <cover.1480572271.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 03/10] via-cuda: Add TREQ, TIP and TACK signal helpers
Date: Thu,  1 Dec 2016 01:09:33 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce some helpers for handling the signalling between VIA and
Cuda. This abstraction will be used to add support for Egret devices,
which utilize slightly different signalling.

Don't invert the sense of the Cuda's active-low signals when storing
them in the 'status' variable. Just assert, negate and test those
signals using the helpers.

The state machine does not need to test its own output signals to
figure out what to do next: the next state depends on the Cuda's TREQ
output. Just call the TREQ_asserted() helper function to test for that.

Similarly, there is no need to store pin directions in the 'status'
variable. That was only useful for debugging messages.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 76 ++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 4eb8a884..64626d2 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -65,6 +65,36 @@ static DEFINE_SPINLOCK(cuda_lock);
 #define IER_CLR		0		/* clear bits in IER */
 #define SR_INT		0x04		/* Shift register full/empty */
 
+static inline bool TREQ_asserted(u8 portb)
+{
+	return !(portb & TREQ);
+}
+
+static inline void assert_TIP(void)
+{
+	out_8(&via[B], in_8(&via[B]) & ~TIP);
+}
+
+static inline void assert_TACK(void)
+{
+	out_8(&via[B], in_8(&via[B]) & ~TACK);
+}
+
+static inline void toggle_TACK(void)
+{
+	out_8(&via[B], in_8(&via[B]) ^ TACK);
+}
+
+static inline void negate_TACK(void)
+{
+	out_8(&via[B], in_8(&via[B]) | TACK);
+}
+
+static inline void negate_TIP_and_TACK(void)
+{
+	out_8(&via[B], in_8(&via[B]) | TIP | TACK);
+}
+
 static enum cuda_state {
     idle,
     sent_first_byte,
@@ -262,7 +292,7 @@ static int
 __init cuda_init_via(void)
 {
     out_8(&via[DIRB], (in_8(&via[DIRB]) | TACK | TIP) & ~TREQ);	/* TACK & TIP out */
-    out_8(&via[B], in_8(&via[B]) | TACK | TIP);			/* negate them */
+    negate_TIP_and_TACK();
     out_8(&via[ACR] ,(in_8(&via[ACR]) & ~SR_CTRL) | SR_EXT);	/* SR data in */
     (void)in_8(&via[SR]);						/* clear any left-over data */
 #ifdef CONFIG_PPC
@@ -278,10 +308,10 @@ __init cuda_init_via(void)
     out_8(&via[IFR], SR_INT);
 
     /* sync with the CUDA - assert TACK without TIP */
-    out_8(&via[B], in_8(&via[B]) & ~TACK);
+    assert_TACK();
 
     /* wait for the CUDA to assert TREQ in response */
-    WAIT_FOR((in_8(&via[B]) & TREQ) == 0, "CUDA response to sync");
+    WAIT_FOR(TREQ_asserted(in_8(&via[B])), "CUDA response to sync");
 
     /* wait for the interrupt and then clear it */
     WAIT_FOR(in_8(&via[IFR]) & SR_INT, "CUDA response to sync (2)");
@@ -289,14 +319,13 @@ __init cuda_init_via(void)
     out_8(&via[IFR], SR_INT);
 
     /* finish the sync by negating TACK */
-    out_8(&via[B], in_8(&via[B]) | TACK);
+    negate_TACK();
 
     /* wait for the CUDA to negate TREQ and the corresponding interrupt */
-    WAIT_FOR(in_8(&via[B]) & TREQ, "CUDA response to sync (3)");
+    WAIT_FOR(!TREQ_asserted(in_8(&via[B])), "CUDA response to sync (3)");
     WAIT_FOR(in_8(&via[IFR]) & SR_INT, "CUDA response to sync (4)");
     (void)in_8(&via[SR]);
     out_8(&via[IFR], SR_INT);
-    out_8(&via[B], in_8(&via[B]) | TIP);	/* should be unnecessary */
 
     return 0;
 }
@@ -417,13 +446,13 @@ cuda_start(void)
     /* assert cuda_state == idle */
     if (current_req == NULL)
 	return;
-    if ((in_8(&via[B]) & TREQ) == 0)
+    if (TREQ_asserted(in_8(&via[B])))
 	return;			/* a byte is coming in from the CUDA */
 
     /* set the shift register to shift out and send a byte */
     out_8(&via[ACR], in_8(&via[ACR]) | SR_OUT);
     out_8(&via[SR], current_req->data[0]);
-    out_8(&via[B], in_8(&via[B]) & ~TIP);
+    assert_TIP();
     cuda_state = sent_first_byte;
 }
 
@@ -444,7 +473,7 @@ EXPORT_SYMBOL(cuda_poll);
 static irqreturn_t
 cuda_interrupt(int irq, void *arg)
 {
-    int status;
+    u8 status;
     struct adb_request *req = NULL;
     unsigned char ibuf[16];
     int ibuf_len = 0;
@@ -469,13 +498,14 @@ cuda_interrupt(int irq, void *arg)
             out_8(&via[IFR], SR_INT);
         }
     }
-    
-    status = (~in_8(&via[B]) & (TIP|TREQ)) | (in_8(&via[ACR]) & SR_OUT);
+
+    status = in_8(&via[B]) & (TIP | TACK | TREQ);
+
     switch (cuda_state) {
     case idle:
 	/* CUDA has sent us the first byte of data - unsolicited */
 	(void)in_8(&via[SR]);
-	out_8(&via[B], in_8(&via[B]) & ~TIP);
+	assert_TIP();
 	cuda_state = reading;
 	reply_ptr = cuda_rbuf;
 	reading_reply = 0;
@@ -484,22 +514,22 @@ cuda_interrupt(int irq, void *arg)
     case awaiting_reply:
 	/* CUDA has sent us the first byte of data of a reply */
 	(void)in_8(&via[SR]);
-	out_8(&via[B], in_8(&via[B]) & ~TIP);
+	assert_TIP();
 	cuda_state = reading;
 	reply_ptr = current_req->reply;
 	reading_reply = 1;
 	break;
 
     case sent_first_byte:
-	if (status == TREQ + TIP + SR_OUT) {
+	if (TREQ_asserted(status)) {
 	    /* collision */
 	    out_8(&via[ACR], in_8(&via[ACR]) & ~SR_OUT);
 	    (void)in_8(&via[SR]);
-	    out_8(&via[B], in_8(&via[B]) | TIP | TACK);
+	    negate_TIP_and_TACK();
 	    cuda_state = idle;
 	} else {
 	    out_8(&via[SR], current_req->data[1]);
-	    out_8(&via[B], in_8(&via[B]) ^ TACK);
+	    toggle_TACK();
 	    data_index = 2;
 	    cuda_state = sending;
 	}
@@ -510,7 +540,7 @@ cuda_interrupt(int irq, void *arg)
 	if (data_index >= req->nbytes) {
 	    out_8(&via[ACR], in_8(&via[ACR]) & ~SR_OUT);
 	    (void)in_8(&via[SR]);
-	    out_8(&via[B], in_8(&via[B]) | TACK | TIP);
+	    negate_TIP_and_TACK();
 	    req->sent = 1;
 	    if (req->reply_expected) {
 		cuda_state = awaiting_reply;
@@ -523,18 +553,18 @@ cuda_interrupt(int irq, void *arg)
 	    }
 	} else {
 	    out_8(&via[SR], req->data[data_index++]);
-	    out_8(&via[B], in_8(&via[B]) ^ TACK);
+	    toggle_TACK();
 	}
 	break;
 
     case reading:
 	*reply_ptr++ = in_8(&via[SR]);
-	if (status == TIP) {
+	if (!TREQ_asserted(status)) {
 	    /* that's all folks */
-	    out_8(&via[B], in_8(&via[B]) | TACK | TIP);
+	    negate_TIP_and_TACK();
 	    cuda_state = read_done;
 	} else {
-	    out_8(&via[B], in_8(&via[B]) ^ TACK);
+	    toggle_TACK();
 	}
 	break;
 
@@ -567,8 +597,8 @@ cuda_interrupt(int irq, void *arg)
 	    ibuf_len = reply_ptr - cuda_rbuf;
 	    memcpy(ibuf, cuda_rbuf, ibuf_len);
 	}
-	if (status == TREQ) {
-	    out_8(&via[B], in_8(&via[B]) & ~TIP);
+	if (TREQ_asserted(status)) {
+	    assert_TIP();
 	    cuda_state = reading;
 	    reply_ptr = cuda_rbuf;
 	    reading_reply = 0;
-- 
2.7.3
