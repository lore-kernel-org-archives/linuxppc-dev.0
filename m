Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 4/20] Mark platform device data as const
Message-ID: 1151993427.2210.05@pokey
Date: Tue,  4 Jul 2006 16:47:17 +1000 (EST)
Cc: greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

platform_device_add_data()'s data argument can be qualified as const -
the function just copies it to another buffer.

This neatens-up storing other const-ed data there.

Built for powerpc and i386

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 paulus - pending Greg KH's ack, please apply

 platform.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/base/platform.c
===================================================================
--- linux-2.6.orig/drivers/base/platform.c
+++ linux-2.6/drivers/base/platform.c
@@ -212,7 +212,8 @@ EXPORT_SYMBOL_GPL(platform_device_add_re
  *	pointer.  The memory associated with the platform data will be freed
  *	when the platform device is released.
  */
-int platform_device_add_data(struct platform_device *pdev, void *data, size_t size)
+int platform_device_add_data(struct platform_device *pdev, const void *data,
+		size_t size)
 {
	void *d;
 
