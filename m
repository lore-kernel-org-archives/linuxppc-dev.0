Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3trhbw6N88zDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jan 2017 11:56:28 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <5a4f903487ce29a690d5c26573d63d1490d2d29e.1483055859.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1483055859.git.fthain@telegraphics.com.au>
References: <cover.1483055859.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH RESEND 02/10] via-cuda: Remove redundant temporary variable
Date: Sat, 31 Dec 2016 19:56:26 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no possibility that current_req can change during execution of
cuda_start(). This can be confirmed by inspection: cuda_lock is always
held whenever cuda_start() is called or current_req is modified.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 0617512..dd51df5 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -414,19 +414,15 @@ cuda_write(struct adb_request *req)
 static void
 cuda_start(void)
 {
-    struct adb_request *req;
-
     /* assert cuda_state == idle */
-    /* get the packet to send */
-    req = current_req;
-    if (req == 0)
+    if (current_req == NULL)
 	return;
     if ((in_8(&via[B]) & TREQ) == 0)
 	return;			/* a byte is coming in from the CUDA */
 
     /* set the shift register to shift out and send a byte */
     out_8(&via[ACR], in_8(&via[ACR]) | SR_OUT);
-    out_8(&via[SR], req->data[0]);
+    out_8(&via[SR], current_req->data[0]);
     out_8(&via[B], in_8(&via[B]) & ~TIP);
     cuda_state = sent_first_byte;
 }
-- 
2.10.2
