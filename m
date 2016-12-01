Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTn8J0ZKtzDvyD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 17:15:27 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <d06cc9f68b6b84b67d1ae13e19392f3bcc972896.1480572271.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1480572271.git.fthain@telegraphics.com.au>
References: <cover.1480572271.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 06/10] via-cuda: Avoid TREQ race condition
Date: Thu,  1 Dec 2016 01:09:33 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a read transaction completes, one of several things will happen:
either a new transfer is started by the driver, a new transfer request
is raised by the Cuda (i.e. TREQ asserted), or both happen at once.

When both happen at once, there is a race condition between the TREQ test
in the read_done state and the same test in cuda_start(). Moreover, the
former test uses a stale TREQ value.

Theoretically, this can result in the undesirable outcome that the
interrupt handler completes with the state machine 'idle' when it should
instead start the next transaction.

Avoid this race by calling cuda_start() first and then confirming that it
succeeded. If not, test the current TREQ value before entering the
'reading' state.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index e65c0b6..ff9062a 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -605,12 +605,11 @@ cuda_interrupt(int irq, void *arg)
 	    memcpy(ibuf, cuda_rbuf, ibuf_len);
 	}
 	reply_ptr = cuda_rbuf;
-	if (TREQ_asserted(status)) {
+	cuda_state = idle;
+	cuda_start();
+	if (cuda_state == idle && TREQ_asserted(in_8(&via[B]))) {
 	    assert_TIP();
 	    cuda_state = reading;
-	} else {
-	    cuda_state = idle;
-	    cuda_start();
 	}
 	break;
 
-- 
2.7.3
