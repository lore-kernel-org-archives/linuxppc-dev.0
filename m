Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DC13DE167
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 04:51:11 +1000 (EST)
Date: Mon, 7 Apr 2008 11:50:54 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407185054.GF7438@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407183228.GA7438@farnsworth.org>
Subject: [PATCH 5/9 v2] powerpc: mv64x60: remove device tree absolute path
	references
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Replace several device node absolute path lookups in the mv64x60
bootwrapper code with lookups by compatible or device_type
properties.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>

---
 arch/powerpc/boot/mv64x60.c     |    4 ++--
 arch/powerpc/boot/mv64x60_i2c.c |    2 +-
 arch/powerpc/boot/prpmc2800.c   |   23 ++++++++++++-----------
 3 files changed, 15 insertions(+), 14 deletions(-)

--- a/arch/powerpc/boot/mv64x60.c
+++ b/arch/powerpc/boot/mv64x60.c
@@ -535,7 +535,7 @@ u8 *mv64x60_get_bridge_pbase(void)
 	u32 v[2];
 	void *devp;
 
-	devp = finddevice("/mv64x60");
+	devp = find_node_by_compatible(NULL, "mrvl,mv64360");
 	if (devp == NULL)
 		goto err_out;
 	if (getprop(devp, "reg", v, sizeof(v)) != sizeof(v))
@@ -553,7 +553,7 @@ u8 *mv64x60_get_bridge_base(void)
 	u32 v;
 	void *devp;
 
-	devp = finddevice("/mv64x60");
+	devp = find_node_by_compatible(NULL, "mrvl,mv64360");
 	if (devp == NULL)
 		goto err_out;
 	if (getprop(devp, "virtual-reg", &v, sizeof(v)) != sizeof(v))
diff --git a/arch/powerpc/boot/mv64x60_i2c.c b/arch/powerpc/boot/mv64x60_i2c.c
index d085377..a69cd7a 100644
--- a/arch/powerpc/boot/mv64x60_i2c.c
+++ b/arch/powerpc/boot/mv64x60_i2c.c
@@ -185,7 +185,7 @@ int mv64x60_i2c_open(void)
 	u32 v;
 	void *devp;
 
-	devp = finddevice("/mv64x60/i2c");
+	devp = find_node_by_compatible(NULL, "mrvl,mv64360-i2c");
 	if (devp == NULL)
 		goto err_out;
 	if (getprop(devp, "virtual-reg", &v, sizeof(v)) != sizeof(v))
diff --git a/arch/powerpc/boot/prpmc2800.c b/arch/powerpc/boot/prpmc2800.c
index 05c3245..f74b2cf 100644
--- a/arch/powerpc/boot/prpmc2800.c
+++ b/arch/powerpc/boot/prpmc2800.c
@@ -344,20 +344,20 @@ static void prpmc2800_bridge_setup(u32 mem_size)
 			acc_bits);
 
 	/* Get the cpu -> pci i/o & mem mappings from the device tree */
-	devp = finddevice("/mv64x60/pci@80000000");
+	devp = find_node_by_compatible(NULL, "mrvl,mv64360-pci");
 	if (devp == NULL)
-		fatal("Error: Missing /mv64x60/pci@80000000"
+		fatal("Error: Missing mrvl,mv64360-pci"
 				" device tree node\n\r");
 
 	rc = getprop(devp, "ranges", v, sizeof(v));
 	if (rc != sizeof(v))
-		fatal("Error: Can't find /mv64x60/pci@80000000/ranges"
+		fatal("Error: Can't find mrvl,mv64360-pci ranges"
 				" property\n\r");
 
 	/* Get the cpu -> pci i/o & mem mappings from the device tree */
-	devp = finddevice("/mv64x60");
+	devp = find_node_by_compatible(NULL, "mrvl,mv64360");
 	if (devp == NULL)
-		fatal("Error: Missing /mv64x60 device tree node\n\r");
+		fatal("Error: Missing mrvl,mv64360 device tree node\n\r");
 
 	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE));
 	enables |= 0x0007fe00; /* Disable all cpu->pci windows */
@@ -429,9 +429,9 @@ static void prpmc2800_fixups(void)
 	setprop(devp, "model", model, l);
 
 	/* Set /cpus/PowerPC,7447/clock-frequency */
-	devp = finddevice("/cpus/PowerPC,7447");
+	devp = find_node_by_prop_value_str(NULL, "device_type", "cpu");
 	if (devp == NULL)
-		fatal("Error: Missing proper /cpus device tree node\n\r");
+		fatal("Error: Missing proper cpu device tree node\n\r");
 	v[0] = bip->core_speed;
 	setprop(devp, "clock-frequency", &v[0], sizeof(v[0]));
 
@@ -443,16 +443,17 @@ static void prpmc2800_fixups(void)
 	v[1] = bip->mem_size;
 	setprop(devp, "reg", v, sizeof(v));
 
-	/* Update /mv64x60/model, if this is a mv64362 */
+	/* Update model, if this is a mv64362 */
 	if (bip->bridge_type == BRIDGE_TYPE_MV64362) {
-		devp = finddevice("/mv64x60");
+		devp = find_node_by_compatible(NULL, "mrvl,mv64360");
 		if (devp == NULL)
-			fatal("Error: Missing /mv64x60 device tree node\n\r");
+			fatal("Error: Missing mrvl,mv64360"
+					" device tree node\n\r");
 		setprop(devp, "model", "mv64362", strlen("mv64362") + 1);
 	}
 
 	/* Set User FLASH size */
-	devp = finddevice("/mv64x60/flash@a0000000");
+	devp = find_node_by_compatible(NULL, "direct-mapped");
 	if (devp == NULL)
 		fatal("Error: Missing User FLASH device tree node\n\r");
 	rc = getprop(devp, "reg", v, sizeof(v));
