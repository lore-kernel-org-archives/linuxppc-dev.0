Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7D0AEDE0ED
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:58 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2GHSs82014211
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:55 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2GHSssn021751
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:54 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9CaF001418
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:12 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 58150AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:53 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSraY029836
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:53 -0500
Date: Fri, 16 Mar 2007 12:28:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Message-ID: <20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a library function that platform code can call to set the mac
addresses of network devices with a linux,network-index property,
according to a caller-provided table of mac address pointers.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   28 ++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h     |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index bfb7dcb..ae2d26b 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -241,3 +241,31 @@ void dt_set_cpu_clocks(u32 clock, u32 bus, u32 timebase)
 		setprop(node, "timebase-frequency", &timebase, 4);
 	}
 }
+
+/* mac_table points to a table of mac addresses, where the index
+ * into the table for a given device corresponds to the
+ * linux,network-index property of its device node.  Network
+ * device nodes without such a property will not be assigned
+ * addresses by this function.
+ */
+void dt_set_mac_addresses(u8 **mac_table, int num_addrs)
+{
+	void *node = NULL;
+
+	while ((node = find_node_by_devtype(node, "network"))) {
+		u32 index;
+		u8 dummy[6];
+
+		if (getprop(node, "linux,network-index",
+		            &index, sizeof(index)) != sizeof(index))
+			continue;
+
+		if (index >= num_addrs)
+			continue;
+
+		if (getprop(node, "mac-address", dummy, 6) == 6)
+			setprop(node, "mac-address", mac_table[index], 6);
+
+		setprop(node, "local-mac-address", mac_table[index], 6);
+	}
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index c739764..64e5472 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -82,6 +82,7 @@ void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 int xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 void dt_set_memory(u64 start, u64 len, int ncells);
 void dt_set_cpu_clocks(u32 clock, u32 bus, u32 timebase);
+void dt_set_mac_addresses(u8 **mac_table, int num_addrs);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3
