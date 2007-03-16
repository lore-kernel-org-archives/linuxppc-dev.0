Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 551A4DE555
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:53 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2GHSnQZ014184
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:50 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHSnox019365
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:49 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH97Y4001400
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:07 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 48B2DAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:48 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSmRa029824
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:48 -0500
Date: Fri, 16 Mar 2007 12:28:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Message-ID: <20070316172848.GG29784@ld0162-tx32.am.freescale.net>
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

This adds a library function that platforms can call to fill in the
/memory node with the specified start and size.  #address-cells and
#size-cells must be the same, but can be either 1 or 2.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   25 +++++++++++++++++++++++++
 arch/powerpc/boot/ops.h     |    2 +-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 9fee6fb..258158e 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -205,3 +205,28 @@ int xlate_reg(void *node, int res, unsigned long *addr,
 
 	return 1;
 }
+
+void dt_set_memory(u64 start, u64 size, int ncells)
+{
+	void *devp;
+	u32 mem[4];
+
+	if (ncells < 1 || ncells > 2)
+		return;
+
+	mem[ncells - 1] = (u32)start;
+	mem[ncells*2 - 1] = (u32)size;
+
+	if (ncells == 2) {
+		mem[0] = start >> 32;
+		mem[2] = size >> 32;
+	}
+
+	devp = finddevice("/memory");
+	if (!devp) {
+		devp = create_node(NULL, "memory");
+		setprop_str(devp, "device_type", "memory");
+	}
+
+	setprop(devp, "reg", mem, ncells * 8);
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 086f844..1f1cda4 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -80,7 +80,7 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
 int xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
-
+void dt_set_memory(u64 start, u64 len, int ncells);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3
