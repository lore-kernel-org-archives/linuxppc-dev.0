Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7EE51DE59D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2GHSqSK004419
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:52 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHSqfM009950
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:52 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9AQ5001410
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:10 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 31168AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:51 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSpGT029832
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:51 -0500
Date: Fri, 16 Mar 2007 12:28:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/17] bootwrapper: Add dt_set_cpu_clocks().
Message-ID: <20070316172851.GI29784@ld0162-tx32.am.freescale.net>
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

This adds a library function that platform files can call to
set clock-frequency, bus-frequency, and timebase-frequency in
each CPU node.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   11 +++++++++++
 arch/powerpc/boot/ops.h     |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 258158e..bfb7dcb 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -230,3 +230,14 @@ void dt_set_memory(u64 start, u64 size, int ncells)
 
 	setprop(devp, "reg", mem, ncells * 8);
 }
+
+void dt_set_cpu_clocks(u32 clock, u32 bus, u32 timebase)
+{
+	void *node = NULL;
+
+	while ((node = find_node_by_devtype(node, "cpu"))) {
+		setprop(node, "clock-frequency", &clock, 4);
+		setprop(node, "bus-frequency", &bus, 4);
+		setprop(node, "timebase-frequency", &timebase, 4);
+	}
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 10c8787..c739764 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -81,6 +81,7 @@ void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
 int xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 void dt_set_memory(u64 start, u64 len, int ncells);
+void dt_set_cpu_clocks(u32 clock, u32 bus, u32 timebase);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3
