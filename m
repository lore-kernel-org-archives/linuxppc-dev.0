Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 16980B7E7E
	for <linuxppc-dev@ozlabs.org>; Sat, 15 May 2010 00:33:49 +1000 (EST)
Date: Fri, 14 May 2010 18:33:18 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH v2] USB: FHCI: cq_get() should check kfifo_out()'s return value
Message-ID: <20100514143318.GA14034@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 7acd72eb85f1c7a15e8b5eb554994949241737f1 ("kfifo: rename
kfifo_put... into kfifo_in... and kfifo_get... into kfifo_out..."),
kfifo_out() is marked __must_check, and that causes gcc to produce
lots of warnings like this:

  CC      drivers/usb/host/fhci-mem.o
In file included from drivers/usb/host/fhci-hcd.c:34:
drivers/usb/host/fhci.h: In function 'cq_get':
drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
...

This patch fixes the issue by properly checking the return value.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

On Tue, May 04, 2010 at 12:17:19PM -0700, Greg KH wrote:
> On Sun, May 02, 2010 at 09:30:25PM +0400, Anton Vorontsov wrote:
> > Since commit 7acd72eb85f1c7a15e8b5eb554994949241737f1 ("kfifo: rename
> > kfifo_put... into kfifo_in... and kfifo_get... into kfifo_out..."),
> > kfifo_out() is marked __must_check, and that causes gcc to produce
> > lots of warnings like this:
> > 
> >   CC      drivers/usb/host/fhci-mem.o
> > In file included from drivers/usb/host/fhci-hcd.c:34:
> > drivers/usb/host/fhci.h: In function 'cq_get':
> > drivers/usb/host/fhci.h:520: warning: ignoring return value of 'kfifo_out', declared with attribute warn_unused_result
> > ...
> > 
> > Fix it with BUG_ON() check. We could just forcibly ignore return
> > value, but it's better to check if we really got a whole pointer.
> 
> No, you don't want to crash the whole machine for something like this.
> 
> Please just handle the error normally and pass it up to the upper levels
> if possible.

OK, here it is. Thanks!

 drivers/usb/host/fhci.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 72dae1c..3b6e864 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/bug.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/kfifo.h>
@@ -515,9 +516,13 @@ static inline int cq_put(struct kfifo *kfifo, void *p)
 
 static inline void *cq_get(struct kfifo *kfifo)
 {
-	void *p = NULL;
+	unsigned int sz;
+	void *p;
+
+	sz = kfifo_out(kfifo, (void *)&p, sizeof(p));
+	if (sz != sizeof(p))
+		return NULL;
 
-	kfifo_out(kfifo, (void *)&p, sizeof(p));
 	return p;
 }
 
-- 
1.7.0.5
