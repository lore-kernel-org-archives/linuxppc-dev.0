Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH] Mark platform device data as const
Message-ID: <1152667363.15190.01@pokey>
In-Reply-To: <17581.40865.169428.154793@cargo.ozlabs.ibm.com>
Date: Wed, 12 Jul 2006 13:56:59 +1000 (EST)
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
resend: Include the platform_device.h change this time.

 drivers/base/platform.c         |    3 ++-
 include/linux/platform_device.h |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
 
Index: linux-2.6/include/linux/platform_device.h
===================================================================
--- linux-2.6.orig/include/linux/platform_device.h
+++ linux-2.6/include/linux/platform_device.h
@@ -39,7 +39,8 @@ extern struct platform_device *platform_
 
 extern struct platform_device *platform_device_alloc(const char *name, unsigned int id);
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);
-extern int platform_device_add_data(struct platform_device *pdev, void *data, size_t size);
+extern int platform_device_add_data(struct platform_device *pdev,
+		const void *data, size_t size);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
