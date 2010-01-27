Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id D0AEFB7F65
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 01:09:40 +1100 (EST)
Date: Wed, 27 Jan 2010 17:09:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] kfifo: Don't use integer as NULL pointer
Message-ID: <20100127140938.GC31608@oksana.dev.rtsoft.ru>
References: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
Cc: linux-usb@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes following sparse warnings:

include/linux/kfifo.h:127:25: warning: Using plain integer as NULL pointer
kernel/kfifo.c:83:21: warning: Using plain integer as NULL pointer

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/linux/kfifo.h |    2 +-
 kernel/kfifo.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 6f6c5f3..bc0fc79 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -124,7 +124,7 @@ extern __must_check unsigned int kfifo_out_peek(struct kfifo *fifo,
  */
 static inline bool kfifo_initialized(struct kfifo *fifo)
 {
-	return fifo->buffer != 0;
+	return fifo->buffer != NULL;
 }
 
 /**
diff --git a/kernel/kfifo.c b/kernel/kfifo.c
index 3b00bf8..6d58e1a 100644
--- a/kernel/kfifo.c
+++ b/kernel/kfifo.c
@@ -80,7 +80,7 @@ int kfifo_alloc(struct kfifo *fifo, unsigned int size, gfp_t gfp_mask)
 
 	buffer = kmalloc(size, gfp_mask);
 	if (!buffer) {
-		_kfifo_init(fifo, 0, 0);
+		_kfifo_init(fifo, NULL, 0);
 		return -ENOMEM;
 	}
 
-- 
1.6.5.7
