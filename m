Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 51059B7EB8
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 01:09:35 +1100 (EST)
Date: Wed, 27 Jan 2010 17:09:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] kfifo: Make kfifo_initialized work after kfifo_free
Message-ID: <20100127140934.GA31608@oksana.dev.rtsoft.ru>
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

After kfifo rework it's no longer possible to reliably know if kfifo is
usable, since after kfifo_free(), kfifo_initialized() would still return
true. The correct behaviour is needed for at least FHCI USB driver.

This patch fixes the issue by resetting the kfifo to zero values (the
same approach is used in kfifo_alloc() if allocation failed).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 kernel/kfifo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/kfifo.c b/kernel/kfifo.c
index 32c5c15..3b00bf8 100644
--- a/kernel/kfifo.c
+++ b/kernel/kfifo.c
@@ -97,6 +97,7 @@ EXPORT_SYMBOL(kfifo_alloc);
 void kfifo_free(struct kfifo *fifo)
 {
 	kfree(fifo->buffer);
+	_kfifo_init(fifo, NULL, 0);
 }
 EXPORT_SYMBOL(kfifo_free);
 
-- 
1.6.5.7
