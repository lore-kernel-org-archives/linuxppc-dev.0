Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail127-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3B1BADDF2C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:08 +1100 (EST)
Message-ID: <47910C63.4080800@am.sony.com>
Date: Fri, 18 Jan 2008 12:30:27 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 03/16] PS3: Add ps3_repository_find_device_by_id()
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

The storage probe feature of the PS3 hypervisor returns device IDs. Add
the corresponding repository routine ps3_repository_find_device_by_id()
which can be used to retrieve the device info from the repository.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/platform.h   |    2 
 arch/powerpc/platforms/ps3/repository.c |   77 ++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -153,6 +153,8 @@ static inline struct ps3_repository_devi
 	return repo;
 }
 int ps3_repository_find_device(struct ps3_repository_device *repo);
+int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
+				     u64 bus_id, u64 dev_id);
 int ps3_repository_find_devices(enum ps3_bus_type bus_type,
 	int (*callback)(const struct ps3_repository_device *repo));
 int ps3_repository_find_bus(enum ps3_bus_type bus_type, unsigned int from,
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -389,6 +389,83 @@ int ps3_repository_find_device(struct ps
 	return 0;
 }
 
+int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
+				     u64 bus_id, u64 dev_id)
+{
+	int result = -ENODEV;
+	struct ps3_repository_device tmp;
+	unsigned int num_dev;
+
+	pr_debug(" -> %s:%u: find device by id %lu:%lu\n", __func__, __LINE__,
+		 bus_id, dev_id);
+
+	for (tmp.bus_index = 0; tmp.bus_index < 10; tmp.bus_index++) {
+		result = ps3_repository_read_bus_id(tmp.bus_index,
+						    &tmp.bus_id);
+		if (result) {
+			pr_debug("%s:%u read_bus_id(%u) failed\n", __func__,
+				 __LINE__, tmp.bus_index);
+			return result;
+		}
+
+		if (tmp.bus_id == bus_id)
+			goto found_bus;
+
+		pr_debug("%s:%u: skip, bus_id %lu\n", __func__, __LINE__,
+			 tmp.bus_id);
+	}
+	pr_debug(" <- %s:%u: bus not found\n", __func__, __LINE__);
+	return result;
+
+found_bus:
+	result = ps3_repository_read_bus_type(tmp.bus_index, &tmp.bus_type);
+	if (result) {
+		pr_debug("%s:%u read_bus_type(%u) failed\n", __func__,
+			 __LINE__, tmp.bus_index);
+		return result;
+	}
+
+	result = ps3_repository_read_bus_num_dev(tmp.bus_index, &num_dev);
+	if (result) {
+		pr_debug("%s:%u read_bus_num_dev failed\n", __func__,
+			 __LINE__);
+		return result;
+	}
+
+	for (tmp.dev_index = 0; tmp.dev_index < num_dev; tmp.dev_index++) {
+		result = ps3_repository_read_dev_id(tmp.bus_index,
+						    tmp.dev_index,
+						    &tmp.dev_id);
+		if (result) {
+			pr_debug("%s:%u read_dev_id(%u:%u) failed\n", __func__,
+				 __LINE__, tmp.bus_index, tmp.dev_index);
+			return result;
+		}
+
+		if (tmp.dev_id == dev_id)
+			goto found_dev;
+
+		pr_debug("%s:%u: skip, dev_id %lu\n", __func__, __LINE__,
+			 tmp.dev_id);
+	}
+	pr_debug(" <- %s:%u: dev not found\n", __func__, __LINE__);
+	return result;
+
+found_dev:
+	result = ps3_repository_read_dev_type(tmp.bus_index, tmp.dev_index,
+					      &tmp.dev_type);
+	if (result) {
+		pr_debug("%s:%u read_dev_type failed\n", __func__, __LINE__);
+		return result;
+	}
+
+	pr_debug(" <- %s:%u: found: type (%u:%u) index (%u:%u) id (%lu:%lu)\n",
+		 __func__, __LINE__, tmp.bus_type, tmp.dev_type, tmp.bus_index,
+		 tmp.dev_index, tmp.bus_id, tmp.dev_id);
+	*repo = tmp;
+	return 0;
+}
+
 int __devinit ps3_repository_find_devices(enum ps3_bus_type bus_type,
 	int (*callback)(const struct ps3_repository_device *repo))
 {

-- 
