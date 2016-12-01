Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTn8J0ZLRzDvyF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 17:15:27 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <a37515307234712df62487e79a4eacb53cee59ed.1480572271.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1480572271.git.fthain@telegraphics.com.au>
References: <cover.1480572271.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 05/10] via-cuda: Fix re-initialization of reply_ptr and
 reading_reply
Date: Thu,  1 Dec 2016 01:09:33 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When reading_reply is set, reply_ptr points into an adb_request struct.

Hence, when reply_ptr instead points into the global cuda_rbuf,
it must be the case that reading_reply is not set.

Unfortunately, this rule can be violated because re-initialization
of reply_ptr and reading_reply presently depends on the TREQ input.

Fix this by re-initializing reply_ptr and reading_reply as soon as they
are known to be invalid.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index acf3a95..e65c0b6 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -592,6 +592,7 @@ cuda_interrupt(int irq, void *arg)
 	    }
 	    current_req = req->next;
 	    complete = 1;
+	    reading_reply = 0;
 	} else {
 	    /* This is tricky. We must break the spinlock to call
 	     * cuda_input. However, doing so means we might get
@@ -603,11 +604,10 @@ cuda_interrupt(int irq, void *arg)
 	    ibuf_len = reply_ptr - cuda_rbuf;
 	    memcpy(ibuf, cuda_rbuf, ibuf_len);
 	}
+	reply_ptr = cuda_rbuf;
 	if (TREQ_asserted(status)) {
 	    assert_TIP();
 	    cuda_state = reading;
-	    reply_ptr = cuda_rbuf;
-	    reading_reply = 0;
 	} else {
 	    cuda_state = idle;
 	    cuda_start();
-- 
2.7.3
