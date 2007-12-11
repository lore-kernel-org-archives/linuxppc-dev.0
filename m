Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Dec 2007 11:18:46 +1100
Subject: [PATCH] powerpc: Update smu command definitions
Message-Id: <20071211001849.38E70DDECF@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Hanselmann <linux-kernel@hansmi.ch>

This patch updates smu.h with several new commands and parameter
descriptions for existing ones.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 include/asm-powerpc/smu.h |  132 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 4 deletions(-)

Index: linux-work/include/asm-powerpc/smu.h
===================================================================
--- linux-work.orig/include/asm-powerpc/smu.h	2007-09-28 11:42:10.000000000 +1000
+++ linux-work/include/asm-powerpc/smu.h	2007-12-11 11:17:09.000000000 +1100
@@ -173,7 +173,7 @@
  * Power supply control
  *
  * The "sub" command is an ASCII string in the data, the
- * data lenght is that of the string.
+ * data length is that of the string.
  *
  * The VSLEW command can be used to get or set the voltage slewing.
  *  - lenght 5 (only "VSLEW") : it returns "DONE" and 3 bytes of
@@ -201,20 +201,90 @@
  */
 #define SMU_CMD_READ_ADC			0xd8
 
+
 /* Misc commands
  *
  * This command seem to be a grab bag of various things
+ *
+ * Parameters:
+ *   1: subcommand
  */
 #define SMU_CMD_MISC_df_COMMAND			0xdf
-#define   SMU_CMD_MISC_df_SET_DISPLAY_LIT	0x02 /* i: 1 byte */
+
+/*
+ * Sets "system ready" status
+ *
+ * I did not yet understand how it exactly works or what it does.
+ *
+ * Guessing from OF code, 0x02 activates the display backlight. Apple uses/used
+ * the same codebase for all OF versions. On PowerBooks, this command would
+ * enable the backlight. For the G5s, it only activates the front LED. However,
+ * don't take this for granted.
+ *
+ * Parameters:
+ *   2: status [0x00, 0x01 or 0x02]
+ */
+#define   SMU_CMD_MISC_df_SET_DISPLAY_LIT	0x02
+
+/*
+ * Sets mode of power switch.
+ *
+ * What this actually does is not yet known. Maybe it enables some interrupt.
+ *
+ * Parameters:
+ *   2: enable power switch? [0x00 or 0x01]
+ *   3 (optional): enable nmi? [0x00 or 0x01]
+ *
+ * Returns:
+ *   If parameter 2 is 0x00 and parameter 3 is not specified, returns wether
+ *   NMI is enabled. Otherwise unknown.
+ */
 #define   SMU_CMD_MISC_df_NMI_OPTION		0x04
 
+/* Sets LED dimm offset.
+ *
+ * The front LED dimms itself during sleep. Its brightness (or, well, the PWM
+ * frequency) depends on current time. Therefore, the SMU needs to know the
+ * timezone.
+ *
+ * Parameters:
+ *   2-8: unknown (BCD coding)
+ */
+#define   SMU_CMD_MISC_df_DIMM_OFFSET		0x99
+
+
 /*
  * Version info commands
  *
- * I haven't quite tried to figure out how these work
+ * Parameters:
+ *   1 (optional): Specifies version part to retrieve
+ *
+ * Returns:
+ *   Version value
  */
 #define SMU_CMD_VERSION_COMMAND			0xea
+#define   SMU_VERSION_RUNNING			0x00
+#define   SMU_VERSION_BASE			0x01
+#define   SMU_VERSION_UPDATE			0x02
+
+
+/*
+ * Switches
+ *
+ * These are switches whose status seems to be known to the SMU.
+ *
+ * Parameters:
+ *   none
+ *
+ * Result:
+ *   Switch bits (ORed, see below)
+ */
+#define SMU_CMD_SWITCHES			0xdc
+
+/* Switches bits */
+#define SMU_SWITCH_CASE_CLOSED			0x01
+#define SMU_SWITCH_AC_POWER			0x04
+#define SMU_SWITCH_POWER_SWITCH			0x08
 
 
 /*
@@ -243,10 +313,64 @@
  */
 #define SMU_CMD_MISC_ee_COMMAND			0xee
 #define   SMU_CMD_MISC_ee_GET_DATABLOCK_REC	0x02
-#define	  SMU_CMD_MISC_ee_LEDS_CTRL		0x04 /* i: 00 (00,01) [00] */
+
+/* Retrieves currently used watts.
+ *
+ * Parameters:
+ *   1: 0x03 (Meaning unknown)
+ */
+#define   SMU_CMD_MISC_ee_GET_WATTS		0x03
+
+#define   SMU_CMD_MISC_ee_LEDS_CTRL		0x04 /* i: 00 (00,01) [00] */
 #define   SMU_CMD_MISC_ee_GET_DATA		0x05 /* i: 00 , o: ?? */
 
 
+/*
+ * Power related commands
+ *
+ * Parameters:
+ *   1: subcommand
+ */
+#define SMU_CMD_POWER_EVENTS_COMMAND		0x8f
+
+/* SMU_POWER_EVENTS subcommands */
+enum {
+	SMU_PWR_GET_POWERUP_EVENTS      = 0x00,
+	SMU_PWR_SET_POWERUP_EVENTS      = 0x01,
+	SMU_PWR_CLR_POWERUP_EVENTS      = 0x02,
+	SMU_PWR_GET_WAKEUP_EVENTS       = 0x03,
+	SMU_PWR_SET_WAKEUP_EVENTS       = 0x04,
+	SMU_PWR_CLR_WAKEUP_EVENTS       = 0x05,
+
+	/*
+	 * Get last shutdown cause
+	 *
+	 * Returns:
+	 *   1 byte (signed char): Last shutdown cause. Exact meaning unknown.
+	 */
+	SMU_PWR_LAST_SHUTDOWN_CAUSE	= 0x07,
+
+	/*
+	 * Sets or gets server ID. Meaning or use is unknown.
+	 *
+	 * Parameters:
+	 *   2 (optional): Set server ID (1 byte)
+	 *
+	 * Returns:
+	 *   1 byte (server ID?)
+	 */
+	SMU_PWR_SERVER_ID		= 0x08,
+};
+
+/* Power events wakeup bits */
+enum {
+	SMU_PWR_WAKEUP_KEY              = 0x01, /* Wake on key press */
+	SMU_PWR_WAKEUP_AC_INSERT        = 0x02, /* Wake on AC adapter plug */
+	SMU_PWR_WAKEUP_AC_CHANGE        = 0x04,
+	SMU_PWR_WAKEUP_LID_OPEN         = 0x08,
+	SMU_PWR_WAKEUP_RING             = 0x10,
+};
+
 
 /*
  * - Kernel side interface -
