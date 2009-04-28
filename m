Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id A1A71DDF09
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:58:30 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1802604rvb.1
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:58:28 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] of: make of_(un)register_platform_driver common code.
To: akpm@linux-foundation.org, sparclinux@vger.kernel.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com,
	smaclennan@pikatech.com, monstr@monstr.eu, john.williams@petalogix.com
Date: Tue, 28 Apr 2009 07:58:26 -0600
Message-ID: <20090428135821.8530.85153.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Some drivers using of_register_platform_driver() wrapper break on sparc
because the wrapper isn't in the header file.  This patch moves it from
Microblaze and PowerPC implementations and makes it common code.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: David S. Miller <davem@davemloft.net>
---

 arch/microblaze/include/asm/of_platform.h |   10 ----------
 arch/powerpc/include/asm/of_platform.h    |   10 ----------
 include/linux/of_platform.h               |   10 ++++++++++
 3 files changed, 10 insertions(+), 20 deletions(-)


diff --git a/arch/microblaze/include/asm/of_platform.h b/arch/microblaze/include/asm/of_platform.h
index 187c0ee..3749127 100644
--- a/arch/microblaze/include/asm/of_platform.h
+++ b/arch/microblaze/include/asm/of_platform.h
@@ -36,16 +36,6 @@ static const struct of_device_id of_default_bus_ids[] = {
 	{},
 };
 
-/* Platform drivers register/unregister */
-static inline int of_register_platform_driver(struct of_platform_driver *drv)
-{
-	return of_register_driver(drv, &of_platform_bus_type);
-}
-static inline void of_unregister_platform_driver(struct of_platform_driver *drv)
-{
-	of_unregister_driver(drv);
-}
-
 /* Platform devices and busses creation */
 extern struct of_device *of_platform_device_create(struct device_node *np,
 						const char *bus_id,
diff --git a/arch/powerpc/include/asm/of_platform.h b/arch/powerpc/include/asm/of_platform.h
index 53b4650..d4aaa34 100644
--- a/arch/powerpc/include/asm/of_platform.h
+++ b/arch/powerpc/include/asm/of_platform.h
@@ -11,16 +11,6 @@
  *
  */
 
-/* Platform drivers register/unregister */
-static inline int of_register_platform_driver(struct of_platform_driver *drv)
-{
-	return of_register_driver(drv, &of_platform_bus_type);
-}
-static inline void of_unregister_platform_driver(struct of_platform_driver *drv)
-{
-	of_unregister_driver(drv);
-}
-
 /* Platform devices and busses creation */
 extern struct of_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 3d327b6..9084066 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -51,6 +51,16 @@ extern int of_register_driver(struct of_platform_driver *drv,
 			      struct bus_type *bus);
 extern void of_unregister_driver(struct of_platform_driver *drv);
 
+/* Platform drivers register/unregister */
+static inline int of_register_platform_driver(struct of_platform_driver *drv)
+{
+	return of_register_driver(drv, &of_platform_bus_type);
+}
+static inline void of_unregister_platform_driver(struct of_platform_driver *drv)
+{
+	of_unregister_driver(drv);
+}
+
 #include <asm/of_platform.h>
 
 extern struct of_device *of_find_device_by_node(struct device_node *np);
