Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTn8J1lykzDvyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 17:15:28 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <3a8cccfeef6fd5d1ff452dfb537751c02f7bb3e2.1480572271.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1480572271.git.fthain@telegraphics.com.au>
References: <cover.1480572271.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 08/10] via-cuda: Initialize data_index early and increment
 consistently
Date: Thu,  1 Dec 2016 01:09:34 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initialize data_index where appropriate to improve readability and
assist debugging. This change doesn't affect driver behaviour.

I prefer to see
	current_req->data[data_index++]
in place of
	current_req->data[0]
or
	current_req->data[1]
inasmuchas it becomes obvious what the data_index variable does.

Moreover, the actual value of data_index when examined at any given moment
tells me something about prior events, which did prove helpful.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index b801c67..f1b2c5b 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -446,12 +446,13 @@ cuda_start(void)
     /* assert cuda_state == idle */
     if (current_req == NULL)
 	return;
+    data_index = 0;
     if (TREQ_asserted(in_8(&via[B])))
 	return;			/* a byte is coming in from the CUDA */
 
     /* set the shift register to shift out and send a byte */
     out_8(&via[ACR], in_8(&via[ACR]) | SR_OUT);
-    out_8(&via[SR], current_req->data[0]);
+    out_8(&via[SR], current_req->data[data_index++]);
     assert_TIP();
     cuda_state = sent_first_byte;
 }
@@ -524,9 +525,8 @@ cuda_interrupt(int irq, void *arg)
 	    negate_TIP_and_TACK();
 	    cuda_state = idle;
 	} else {
-	    out_8(&via[SR], current_req->data[1]);
+	    out_8(&via[SR], current_req->data[data_index++]);
 	    toggle_TACK();
-	    data_index = 2;
 	    cuda_state = sending;
 	}
 	break;
-- 
2.7.3
