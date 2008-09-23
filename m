Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 68B41DDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 04:32:17 +1000 (EST)
Date: Tue, 23 Sep 2008 22:32:15 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] USB: Protect hcd.h from multiple inclusions
Message-ID: <20080923183215.GA25629@oksana.dev.rtsoft.ru>
References: <20080923183129.GA19024@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080923183129.GA19024@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will let us use this header in other header files.
Will be needed for the FHCI USB Host driver.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/core/hcd.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index e710ce0..66b64d7 100644
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -16,6 +16,8 @@
  * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#ifndef __USB_CORE_HCD_H
+#define __USB_CORE_HCD_H
 
 #ifdef __KERNEL__
 
@@ -483,3 +485,5 @@ static inline void usbmon_urb_complete(struct usb_bus *bus, struct urb *urb,
 extern struct rw_semaphore ehci_cf_port_reset_rwsem;
 
 #endif /* __KERNEL__ */
+
+#endif /* __USB_CORE_HCD_H */
-- 
1.5.6.3
