Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7Zp41JWxzDt4T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 02:26:36 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id i187so8947614lfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Nov 2016 08:26:36 -0700 (PDT)
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/4] ibmebus: fix device reference leaks in sysfs interface
Date: Tue,  1 Nov 2016 16:26:00 +0100
Message-Id: <1478013963-28871-1-git-send-email-johan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure to drop any reference taken by bus_find_device() in the sysfs
callbacks that are used to create and destroy devices based on
device-tree entries.

Fixes: 6bccf755ff53 ("[POWERPC] ibmebus: dynamic addition/removal...)
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/kernel/ibmebus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 6ca9a2ffaac7..c7d3ff7e101c 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -262,6 +262,7 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 				   const char *buf, size_t count)
 {
 	struct device_node *dn = NULL;
+	struct device *dev;
 	char *path;
 	ssize_t rc = 0;
 
@@ -269,8 +270,10 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 	if (!path)
 		return -ENOMEM;
 
-	if (bus_find_device(&ibmebus_bus_type, NULL, path,
-			    ibmebus_match_path)) {
+	dev = bus_find_device(&ibmebus_bus_type, NULL, path,
+			      ibmebus_match_path);
+	if (dev) {
+		put_device(dev);
 		printk(KERN_WARNING "%s: %s has already been probed\n",
 		       __func__, path);
 		rc = -EEXIST;
@@ -307,6 +310,7 @@ static ssize_t ibmebus_store_remove(struct bus_type *bus,
 	if ((dev = bus_find_device(&ibmebus_bus_type, NULL, path,
 				   ibmebus_match_path))) {
 		of_device_unregister(to_platform_device(dev));
+		put_device(dev);
 
 		kfree(path);
 		return count;
-- 
2.7.3
