Return-Path: <mgreer@mvista.com>
Date: Wed, 7 Nov 2007 18:57:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc: prpmc2800 - Use new mv64x60_config_pci_windows()
	interface
Message-ID: <20071108015700.GA15174@mag.az.mvista.com>
References: <20071108015415.GA14900@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071108015415.GA14900@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Make the prpmc2800 bootwrapper code use the new interface to
mv64x60_config_pci_windows().  With that change, some minor code
rearrangement is possible to make things neater.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

---
 arch/powerpc/boot/prpmc2800.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/prpmc2800.c b/arch/powerpc/boot/prpmc2800.c
index 9614e1d..d72400d 100644
--- a/arch/powerpc/boot/prpmc2800.c
+++ b/arch/powerpc/boot/prpmc2800.c
@@ -315,7 +315,7 @@ static struct prpmc2800_board_info *prpmc2800_get_bip(void)
 	return bip;
 }
 
-static void prpmc2800_bridge_setup(u32 mem_size)
+static void prpmc2800_bridge_setup(void)
 {
 	u32 i, v[12], enables, acc_bits;
 	u32 pci_base_hi, pci_base_lo, size, buf[2];
@@ -340,8 +340,7 @@ static void prpmc2800_bridge_setup(u32 mem_size)
 			| MV64x60_PCI_ACC_CNTL_RDSIZE_256_BYTES;
 
 	mv64x60_config_ctlr_windows(bridge_base, bridge_pbase, is_coherent);
-	mv64x60_config_pci_windows(bridge_base, bridge_pbase, 0, 0, mem_size,
-			acc_bits);
+	mv64x60_config_pci_windows(bridge_base, bridge_pbase, 0, 0, acc_bits);
 
 	/* Get the cpu -> pci i/o & mem mappings from the device tree */
 	devp = finddevice("/mv64x60/pci@80000000");
@@ -397,20 +396,19 @@ static void prpmc2800_bridge_setup(u32 mem_size)
 
 static void prpmc2800_fixups(void)
 {
-	u32 v[2], l, mem_size;
+	u32 v[2], l;
 	int rc;
 	void *devp;
 	char model[BOARD_MODEL_MAX];
 	struct prpmc2800_board_info *bip;
 
-	bip = prpmc2800_get_bip(); /* Get board info based on VPD */
-
-	mem_size = (bip) ? bip->mem_size : mv64x60_get_mem_size(bridge_base);
-	prpmc2800_bridge_setup(mem_size); /* Do necessary bridge setup */
+	prpmc2800_bridge_setup(); /* Do necessary bridge setup */
 
-	/* If the VPD doesn't match what we know about, just use the
+	/*
+	 * If the VPD doesn't match what we know about, just use the
 	 * defaults already in the device tree.
 	 */
+	bip = prpmc2800_get_bip(); /* Get board info based on VPD */
 	if (!bip)
 		return;
 
@@ -439,8 +437,8 @@ static void prpmc2800_fixups(void)
 	devp = finddevice("/memory");
 	if (devp == NULL)
 		fatal("Error: Missing /memory device tree node\n\r");
-	v[0] = 0;
-	v[1] = bip->mem_size;
+	v[0] = 0; /* Take min of DT's mem size and what mem ctlr is setup for */
+	v[1] = min(mv64x60_get_mem_size(bridge_base), bip->mem_size);
 	setprop(devp, "reg", v, sizeof(v));
 
 	/* Update /mv64x60/model, if this is a mv64362 */
