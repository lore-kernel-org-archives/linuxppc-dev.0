From: Matthias Grimm <matthiasgrimm@users.sourceforge.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] kernel 2.6.7, fixing pmu.h
Date: Sun, 8 Aug 2004 10:06:57 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_h8dFBiACzTLbAkc"
Message-Id: <200408081006.57085.matthiasgrimm@users.sourceforge.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_h8dFBiACzTLbAkc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,
This patch fixes a PMU command for OHARE Powerbooks
and adds two flags.

This patch is against kernel 2.6.7 but works also with kernels 2.4.x

 Best Regards
   Matthias

--Boundary-00=_h8dFBiACzTLbAkc
Content-Type: text/x-chdr;
  charset="us-ascii";
  name="patch_pmu.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_pmu.h"

--- linux-2.6.7/include/linux/pmu.h	Wed Jun 16 07:18:57 2004
+++ linux-2.6.7patched/include/linux/pmu.h	Sun Aug  8 10:02:42 2004
@@ -24,6 +24,7 @@
 #define PMU_SET_VOLBUTTON	0x40	/* set volume up/down position */
 #define PMU_BACKLIGHT_BRIGHT	0x41	/* set backlight brightness */
 #define PMU_GET_VOLBUTTON	0x48	/* get volume up/down position */
+#define PMU_GET_BRIGHTBUTTON    0x49    /* report brightness up/down pos */
 #define PMU_PCEJECT		0x4c	/* eject PC-card from slot */
 #define PMU_BATTERY_STATE	0x6b	/* report battery state etc. */
 #define PMU_SMART_BATTERY_STATE	0x6f	/* report battery state (new way) */
@@ -35,7 +36,7 @@
 #define PMU_POWER_EVENTS	0x8f	/* Send power-event commands to PMU */
 #define PMU_I2C_CMD		0x9a	/* I2C operations */
 #define PMU_RESET		0xd0	/* reset CPU */
-#define PMU_GET_BRIGHTBUTTON	0xd9	/* report brightness up/down pos */
+/*#define PMU_GET_BRIGHTBUTTON	0xd9	 * reportdd brightness up/down pos */
 #define PMU_GET_COVER		0xdc	/* report cover open/closed */
 #define PMU_SYSTEM_READY	0xdf	/* tell PMU we are awake */
 #define PMU_GET_VERSION		0xea	/* read the PMU version */
@@ -69,6 +70,8 @@
 /* Bits in the environement message (either obtained via PMU_GET_COVER,
  * or via PMU_INT_ENVIRONMENT on core99 */
 #define PMU_ENV_LID_CLOSED	0x01	/* The lid is closed */
+#define PMU_ENV_AC_POWER	0x04	/* AC power is present */
+#define PMU_ENV_BATTERY_PRESENT	0x10	/* Any battery present */

 /* I2C related definitions */
 #define PMU_I2C_MODE_SIMPLE	0

--Boundary-00=_h8dFBiACzTLbAkc--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
