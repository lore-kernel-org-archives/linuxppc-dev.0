Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CD4F67A67
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Apr 2005 13:52:02 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 23 Apr 2005 13:51:19 +1000
Message-Id: <1114228279.5996.44.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: [PATCH] ppc32: Fix a sleep issues on some laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Some earlier models of aluminium powerbooks and ibook G4s have a clock
chip that requires some tweaking before and after sleep. It seems that
without that magic incantation to disable and re-enable clock spreading,
RAM isn't properly refreshed during sleep. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-04-12 18:07:50.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-04-22 17:07:30.000000000 +1000
@@ -1590,6 +1590,112 @@
 	mdelay(10);
 }
 
+
+static void __pmac pmac_tweak_clock_spreading(struct macio_chip* macio, int enable)
+{
+	/* Hack for doing clock spreading on some machines PowerBooks and
+	 * iBooks. This implements the "platform-do-clockspreading" OF
+	 * property as decoded manually on various models. For safety, we also
+	 * check the product ID in the device-tree in cases we'll whack the i2c
+	 * chip to make reasonably sure we won't set wrong values in there
+	 *
+	 * Of course, ultimately, we have to implement a real parser for
+	 * the platform-do-* stuff...
+	 */
+
+	if (macio->type == macio_intrepid) {
+		if (enable)
+			UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+		else
+			UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+		mdelay(40);
+	}
+
+	while (machine_is_compatible("PowerBook5,2") ||
+	       machine_is_compatible("PowerBook5,3") ||
+	       machine_is_compatible("PowerBook6,2") ||
+	       machine_is_compatible("PowerBook6,3")) {
+		struct device_node *ui2c = of_find_node_by_type(NULL, "i2c");
+		struct device_node *dt = of_find_node_by_name(NULL, "device-tree");
+		u8 buffer[9];
+		u32 *productID;
+		int i, rc, changed = 0;
+		
+		if (dt == NULL)
+			break;
+		productID = (u32 *)get_property(dt, "pid#", NULL);
+		if (productID == NULL)
+			break;
+		while(ui2c) {
+			struct device_node *p = of_get_parent(ui2c);
+			if (p && !strcmp(p->name, "uni-n"))
+				break;
+			ui2c = of_find_node_by_type(ui2c, "i2c");
+		}
+		if (ui2c == NULL)
+			break;
+		DBG("Trying to bump clock speed for PID: %08x...\n", *productID);
+		rc = pmac_low_i2c_open(ui2c, 1);
+		if (rc != 0)
+			break;
+		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_combined);
+		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_read, 0x80, buffer, 9);
+		DBG("read result: %d,", rc);
+		if (rc != 0) {
+			pmac_low_i2c_close(ui2c);
+			break;
+		}
+		for (i=0; i<9; i++)
+			DBG(" %02x", buffer[i]);
+		DBG("\n");
+		
+		switch(*productID) {
+		case 0x1182:	/* AlBook 12" rev 2 */
+		case 0x1183:	/* iBook G4 12" */
+			buffer[0] = (buffer[0] & 0x8f) | 0x70;
+			buffer[2] = (buffer[2] & 0x7f) | 0x00;
+			buffer[5] = (buffer[5] & 0x80) | 0x31;
+			buffer[6] = (buffer[6] & 0x40) | 0xb0;
+			buffer[7] = (buffer[7] & 0x00) | (enable ? 0xc0 : 0xba);
+			buffer[8] = (buffer[8] & 0x00) | 0x30;
+			changed = 1;
+			break;
+		case 0x3142:	/* AlBook 15" (ATI M10) */
+		case 0x3143:	/* AlBook 17" (ATI M10) */
+			buffer[0] = (buffer[0] & 0xaf) | 0x50;
+			buffer[2] = (buffer[2] & 0x7f) | 0x00;
+			buffer[5] = (buffer[5] & 0x80) | 0x31;
+			buffer[6] = (buffer[6] & 0x40) | 0xb0;
+			buffer[7] = (buffer[7] & 0x00) | (enable ? 0xd0 : 0xc0);
+			buffer[8] = (buffer[8] & 0x00) | 0x30;
+			changed = 1;
+			break;
+		default:
+			DBG("i2c-hwclock: Machine model not handled\n");
+			break;
+		}
+		if (!changed) {
+			pmac_low_i2c_close(ui2c);
+			break;
+		}
+		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_stdsub);
+		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_write, 0x80, buffer, 9);
+		DBG("write result: %d,", rc);
+		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_combined);
+		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_read, 0x80, buffer, 9);
+		DBG("read result: %d,", rc);
+		if (rc != 0) {
+			pmac_low_i2c_close(ui2c);
+			break;
+		}
+		for (i=0; i<9; i++)
+			DBG(" %02x", buffer[i]);
+		pmac_low_i2c_close(ui2c);
+		break;
+	}
+}
+
+
 static int __pmac
 core99_sleep(void)
 {
@@ -1601,11 +1707,8 @@
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
-	/* The device-tree contains that in the hwclock node */
-	if (macio->type == macio_intrepid) {
-		UN_OUT(UNI_N_CLOCK_SPREADING, 0);
-		mdelay(40);
-	}
+	/* Disable clock spreading */
+	pmac_tweak_clock_spreading(macio, 0);
 
 	/* We power off the wireless slot in case it was not done
 	 * by the driver. We don't power it on automatically however
@@ -1749,11 +1852,8 @@
 	UN_OUT(UNI_N_CLOCK_CNTL, save_unin_clock_ctl);
 	udelay(100);
 
-	/* Restore clock spreading */
-	if (macio->type == macio_intrepid) {
-		UN_OUT(UNI_N_CLOCK_SPREADING, 2);
-		mdelay(40);
-	}
+	/* Enable clock spreading */
+	pmac_tweak_clock_spreading(macio, 1);
 
 	return 0;
 }
@@ -2718,97 +2818,11 @@
 		MACIO_BIC(HEATHROW_FCR, HRW_SOUND_POWER_N);
 	}
 
-	/* Hack for bumping clock speed on the new PowerBooks and the
-	 * iBook G4. This implements the "platform-do-clockspreading" OF
-	 * property. For safety, we also check the product ID in the
-	 * device-tree to make reasonably sure we won't set wrong values
-	 * in the clock chip.
-	 *
-	 * Of course, ultimately, we have to implement a real parser for
-	 * the platform-do-* stuff...
+	/* Some machine models need the clock chip to be properly setup for
+	 * clock spreading now. This should be a platform function but we
+	 * don't do these at the moment
 	 */
-	while (machine_is_compatible("PowerBook5,2") ||
-	       machine_is_compatible("PowerBook5,3") ||
-	       machine_is_compatible("PowerBook6,2") ||
-	       machine_is_compatible("PowerBook6,3")) {
-		struct device_node *ui2c = of_find_node_by_type(NULL, "i2c");
-		struct device_node *dt = of_find_node_by_name(NULL, "device-tree");
-		u8 buffer[9];
-		u32 *productID;
-		int i, rc, changed = 0;
-		
-		if (dt == NULL)
-			break;
-		productID = (u32 *)get_property(dt, "pid#", NULL);
-		if (productID == NULL)
-			break;
-		while(ui2c) {
-			struct device_node *p = of_get_parent(ui2c);
-			if (p && !strcmp(p->name, "uni-n"))
-				break;
-			ui2c = of_find_node_by_type(ui2c, "i2c");
-		}
-		if (ui2c == NULL)
-			break;
-		DBG("Trying to bump clock speed for PID: %08x...\n", *productID);
-		rc = pmac_low_i2c_open(ui2c, 1);
-		if (rc != 0)
-			break;
-		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_combined);
-		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_read, 0x80, buffer, 9);
-		DBG("read result: %d,", rc);
-		if (rc != 0) {
-			pmac_low_i2c_close(ui2c);
-			break;
-		}
-		for (i=0; i<9; i++)
-			DBG(" %02x", buffer[i]);
-		DBG("\n");
-		
-		switch(*productID) {
-		case 0x1182:	/* AlBook 12" rev 2 */
-		case 0x1183:	/* iBook G4 12" */
-			buffer[0] = (buffer[0] & 0x8f) | 0x70;
-			buffer[2] = (buffer[2] & 0x7f) | 0x00;
-			buffer[5] = (buffer[5] & 0x80) | 0x31;
-			buffer[6] = (buffer[6] & 0x40) | 0xb0;
-			buffer[7] = (buffer[7] & 0x00) | 0xc0;
-			buffer[8] = (buffer[8] & 0x00) | 0x30;
-			changed = 1;
-			break;
-		case 0x3142:	/* AlBook 15" (ATI M10) */
-		case 0x3143:	/* AlBook 17" (ATI M10) */
-			buffer[0] = (buffer[0] & 0xaf) | 0x50;
-			buffer[2] = (buffer[2] & 0x7f) | 0x00;
-			buffer[5] = (buffer[5] & 0x80) | 0x31;
-			buffer[6] = (buffer[6] & 0x40) | 0xb0;
-			buffer[7] = (buffer[7] & 0x00) | 0xd0;
-			buffer[8] = (buffer[8] & 0x00) | 0x30;
-			changed = 1;
-			break;
-		default:
-			DBG("i2c-hwclock: Machine model not handled\n");
-			break;
-		}
-		if (!changed) {
-			pmac_low_i2c_close(ui2c);
-			break;
-		}
-		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_stdsub);
-		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_write, 0x80, buffer, 9);
-		DBG("write result: %d,", rc);
-		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_combined);
-		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_read, 0x80, buffer, 9);
-		DBG("read result: %d,", rc);
-		if (rc != 0) {
-			pmac_low_i2c_close(ui2c);
-			break;
-		}
-		for (i=0; i<9; i++)
-			DBG(" %02x", buffer[i]);
-		pmac_low_i2c_close(ui2c);
-		break;
-	}
+	pmac_tweak_clock_spreading(&macio_chips[0], 1);
 
 #endif /* CONFIG_POWER4 */
 
