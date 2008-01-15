Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89093DDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:37:39 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0FFbYRf021905
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:37:35 -0600
Date: Tue, 15 Jan 2008 09:35:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] bootwrapper: Add find_node_by_alias and
	dt_fixup_mac_address_by_alias
Message-ID: <Pine.LNX.4.64.0801150934390.29314@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the ability to set the mac address given the alias for the device.
Removes the need for having a linux,network-index property.

---

in my git tree.

 arch/powerpc/boot/devtree.c |   14 ++++++++++++++
 arch/powerpc/boot/ops.h     |   14 ++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index e5dfe44..60f561e 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -88,6 +88,20 @@ void dt_fixup_clock(const char *path, u32 freq)
 	}
 }

+void dt_fixup_mac_address_by_alias(const char *alias, const u8 *addr)
+{
+	void *devp = find_node_by_alias(alias);
+
+	if (devp) {
+		printf("%s: local-mac-address <-"
+		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", alias,
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+
+		setprop(devp, "local-mac-address", addr, 6);
+	}
+}
+
 void dt_fixup_mac_address(u32 index, const u8 *addr)
 {
 	void *devp = find_node_by_prop_value(NULL, "linux,network-index",
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 6036a98..5872ef1 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -159,9 +159,23 @@ static inline void *find_node_by_devtype(const void *prev,
 	return find_node_by_prop_value_str(prev, "device_type", type);
 }

+static inline void *find_node_by_alias(const char *alias)
+{
+	void *devp = finddevice("/aliases");
+
+	if (devp) {
+		char path[MAX_PATH_LEN];
+		if (getprop(devp, alias, path, MAX_PATH_LEN) > 0)
+			return finddevice(path);
+	}
+
+	return NULL;
+}
+
 void dt_fixup_memory(u64 start, u64 size);
 void dt_fixup_cpu_clocks(u32 cpufreq, u32 tbfreq, u32 busfreq);
 void dt_fixup_clock(const char *path, u32 freq);
+void dt_fixup_mac_address_by_alias(const char *alias, const u8 *addr);
 void dt_fixup_mac_address(u32 index, const u8 *addr);
 void __dt_fixup_mac_addresses(u32 startindex, ...);
 #define dt_fixup_mac_addresses(...) \
-- 
1.5.3.7
