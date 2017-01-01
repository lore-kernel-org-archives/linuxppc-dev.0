Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3trhbw6BrMzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jan 2017 11:56:28 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <f0e5117608ea57a64ed60562ec29203a46234b64.1483055859.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1483055859.git.fthain@telegraphics.com.au>
References: <cover.1483055859.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH RESEND 01/10] via-cuda: Cleanup printk calls
Date: Sat, 31 Dec 2016 19:56:26 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing log message severity, remove old debug messages and
replace printk() loop with print_hex_dump() call.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 2088e23..0617512 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -221,7 +221,7 @@ static int __init via_cuda_start(void)
 	return -EAGAIN;
     }
 
-    printk("Macintosh CUDA driver v0.5 for Unified ADB.\n");
+    pr_info("Macintosh CUDA driver v0.5 for Unified ADB.\n");
 
     cuda_fully_inited = 1;
     return 0;
@@ -251,7 +251,7 @@ cuda_probe(void)
     	int x;							\
 	for (x = 1000; !(cond); --x) {				\
 	    if (x == 0) {					\
-		printk("Timeout waiting for " what "\n");	\
+		pr_err("Timeout waiting for " what "\n");	\
 		return -ENXIO;					\
 	    }							\
 	    udelay(100);					\
@@ -357,6 +357,7 @@ cuda_reset_adb_bus(void)
     return 0;
 }
 #endif /* CONFIG_ADB */
+
 /* Construct and send a cuda request */
 int
 cuda_request(struct adb_request *req, void (*done)(struct adb_request *),
@@ -474,12 +475,9 @@ cuda_interrupt(int irq, void *arg)
     }
     
     status = (~in_8(&via[B]) & (TIP|TREQ)) | (in_8(&via[ACR]) & SR_OUT);
-    /* printk("cuda_interrupt: state=%d status=%x\n", cuda_state, status); */
     switch (cuda_state) {
     case idle:
 	/* CUDA has sent us the first byte of data - unsolicited */
-	if (status != TREQ)
-	    printk("cuda: state=idle, status=%x\n", status);
 	(void)in_8(&via[SR]);
 	out_8(&via[B], in_8(&via[B]) & ~TIP);
 	cuda_state = reading;
@@ -489,8 +487,6 @@ cuda_interrupt(int irq, void *arg)
 
     case awaiting_reply:
 	/* CUDA has sent us the first byte of data of a reply */
-	if (status != TREQ)
-	    printk("cuda: state=awaiting_reply, status=%x\n", status);
 	(void)in_8(&via[SR]);
 	out_8(&via[B], in_8(&via[B]) & ~TIP);
 	cuda_state = reading;
@@ -506,9 +502,6 @@ cuda_interrupt(int irq, void *arg)
 	    out_8(&via[B], in_8(&via[B]) | TIP | TACK);
 	    cuda_state = idle;
 	} else {
-	    /* assert status == TIP + SR_OUT */
-	    if (status != TIP + SR_OUT)
-		printk("cuda: state=sent_first_byte status=%x\n", status);
 	    out_8(&via[SR], current_req->data[1]);
 	    out_8(&via[B], in_8(&via[B]) ^ TACK);
 	    data_index = 2;
@@ -545,9 +538,6 @@ cuda_interrupt(int irq, void *arg)
 	    out_8(&via[B], in_8(&via[B]) | TACK | TIP);
 	    cuda_state = read_done;
 	} else {
-	    /* assert status == TIP | TREQ */
-	    if (status != TIP + TREQ)
-		printk("cuda: state=reading status=%x\n", status);
 	    out_8(&via[B], in_8(&via[B]) ^ TACK);
 	}
 	break;
@@ -593,7 +583,7 @@ cuda_interrupt(int irq, void *arg)
 	break;
 
     default:
-	printk("cuda_interrupt: unknown cuda_state %d?\n", cuda_state);
+	pr_err("cuda_interrupt: unknown cuda_state %d?\n", cuda_state);
     }
     spin_unlock(&cuda_lock);
     if (complete && req) {
@@ -614,8 +604,6 @@ cuda_interrupt(int irq, void *arg)
 static void
 cuda_input(unsigned char *buf, int nb)
 {
-    int i;
-
     switch (buf[0]) {
     case ADB_PACKET:
 #ifdef CONFIG_XMON
@@ -633,9 +621,7 @@ cuda_input(unsigned char *buf, int nb)
 	break;
 
     default:
-	printk("data from cuda (%d bytes):", nb);
-	for (i = 0; i < nb; ++i)
-	    printk(" %.2x", buf[i]);
-	printk("\n");
+	print_hex_dump(KERN_INFO, "cuda_input: ", DUMP_PREFIX_NONE, 32, 1,
+	               buf, nb, false);
     }
 }
-- 
2.10.2
