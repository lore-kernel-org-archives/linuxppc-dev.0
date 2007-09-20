Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8922EDE029
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 08:06:52 +1000 (EST)
Date: Thu, 20 Sep 2007 17:06:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/2] bootwrapper: Factor out dt_set_mac_address().
Message-ID: <20070920220615.GA28860@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows callers to set addresses one at a time when that would be more
convenient.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   31 +++++++++++++++++--------------
 arch/powerpc/boot/ops.h     |    1 +
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 549463b..d78e8b4 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -88,29 +88,32 @@ void dt_fixup_clock(const char *path, u32 freq)
 	}
 }
 
+void dt_set_mac_address(u32 index, const u8 *addr)
+{
+	void *devp = find_node_by_prop_value(NULL, "linux,network-index",
+	                                     (void*)&index, sizeof(index));
+
+	if (devp) {
+		printf("ENET%d: local-mac-address <-"
+		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+
+		setprop(devp, "local-mac-address", addr, 6);
+	}
+}
+
 void __dt_fixup_mac_addresses(u32 startindex, ...)
 {
 	va_list ap;
 	u32 index = startindex;
-	void *devp;
 	const u8 *addr;
 
 	va_start(ap, startindex);
-	while ((addr = va_arg(ap, const u8 *))) {
-		devp = find_node_by_prop_value(NULL, "linux,network-index",
-					       (void*)&index, sizeof(index));
 
-		if (devp) {
-			printf("ENET%d: local-mac-address <-"
-			       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
-			       addr[0], addr[1], addr[2],
-			       addr[3], addr[4], addr[5]);
+	while ((addr = va_arg(ap, const u8 *)))
+		dt_set_mac_address(index++, addr);
 
-			setprop(devp, "local-mac-address", addr, 6);
-		}
-
-		index++;
-	}
 	va_end(ap);
 }
 
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 703255b..d7a9a28 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -160,6 +160,7 @@ static inline void *find_node_by_devtype(const void *prev,
 void dt_fixup_memory(u64 start, u64 size);
 void dt_fixup_cpu_clocks(u32 cpufreq, u32 tbfreq, u32 busfreq);
 void dt_fixup_clock(const char *path, u32 freq);
+void dt_set_mac_address(u32 index, const u8 *addr);
 void __dt_fixup_mac_addresses(u32 startindex, ...);
 #define dt_fixup_mac_addresses(...) \
 	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
-- 
1.5.3.1
