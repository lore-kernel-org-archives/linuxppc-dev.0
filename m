Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 548BCDDEDD
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Dec 2006 00:05:39 +1100 (EST)
Date: Sun, 24 Dec 2006 14:05:31 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: benh@kernel.crashing.org
Subject: [PATCH] More SMU commands
Message-ID: <20061224130531.GA28635@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates smu.h with several new commands and parameter
descriptions for existing ones.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/include/asm-powerpc/smu.h linux-2.6.19.1/include/asm-powerpc/smu.h
--- linux-2.6.19.1.orig/include/asm-powerpc/smu.h	2006-12-24 12:19:07.000000000 +0100
+++ linux-2.6.19.1/include/asm-powerpc/smu.h	2006-12-24 13:53:46.000000000 +0100
@@ -173,7 +173,7 @@
  * Power supply control
  *
  * The "sub" command is an ASCII string in the data, the
- * data lenght is that of the string.
+ * data length is that of the string.
  *
  * The VSLEW command can be used to get or set the voltage slewing.
  *  - lenght 5 (only "VSLEW") : it returns "DONE" and 3 bytes of
@@ -206,16 +206,52 @@
  * This command seem to be a grab bag of various things
  */
 #define SMU_CMD_MISC_df_COMMAND			0xdf
-#define   SMU_CMD_MISC_df_SET_DISPLAY_LIT	0x02 /* i: 1 byte */
+
+/*
+ * Sets "system ready" status
+ *
+ * Parameters:
+ *   1: status [0x00, 0x01 or 0x02]
+ */
+#define   SMU_CMD_MISC_df_SET_DISPLAY_LIT	0x02
+
+/*
+ * Sets mode of power switch
+ *
+ * Parameters:
+ *   1: enable power switch? [0x00 or 0x01]
+ *   2: enable nmi? [0x00 or 0x01]
+ */
 #define   SMU_CMD_MISC_df_NMI_OPTION		0x04
 
 /*
  * Version info commands
  *
- * I haven't quite tried to figure out how these work
+ * Parameters:
+ *   1 (optional): version type
+ *
+ * Returns:
+ *   Version value
  */
 #define SMU_CMD_VERSION_COMMAND			0xea
+#define   SMU_VERSION_RUNNING			0x00
+#define   SMU_VERSION_BASE			0x01
+#define   SMU_VERSION_UPDATE			0x02
+
+/*
+ * Switches
+ *
+ * These are switches whose status seems to be known to the SMU.
+ *
+ * Parameters:
+ *   none
+ */
+#define SMU_CMD_SWITCHES			0xdc
 
+/* Switches bits */
+#define SMU_SWITCH_CASE_CLOSED			0x01
+#define SMU_SWITCH_AC_POWER			0x04
+#define SMU_SWITCH_POWER_SWITCH			0x08
 
 /*
  * Misc commands
@@ -246,6 +282,44 @@
 #define	  SMU_CMD_MISC_ee_LEDS_CTRL		0x04 /* i: 00 (00,01) [00] */
 #define   SMU_CMD_MISC_ee_GET_DATA		0x05 /* i: 00 , o: ?? */
 
+/*
+ * Misc commands 2
+ *
+ * Parameters:
+ *   1: subcommand
+ */
+#define SMU_CMD_MISC_8f_COMMAND			0x8f
+
+/*
+ * File server mode
+ *
+ * Parameters:
+ *   2: to enable, set to 0x01, otherwise 0xff
+ *   3: always 0xff
+ */
+#define   SMU_CMD_MISC_8f_FILESERVER_MODE	0x02
+
+/*
+ * Retrieves last shutdown cause
+ *
+ * Parameters:
+ *   none
+ *
+ * Returns:
+ *   Last shutdown cause
+ */
+#define   SMU_CMD_MISC_8f_LAST_SHUTDOWN_CAUSE	0x07
+
+/*
+ * Sets or gets server ID
+ *
+ * Parameters:
+ *   2 (optional): Set server ID to this value
+ *
+ * Returns:
+ *   Current server ID
+ */
+#define   SMU_CMD_MISC_8f_SERVER_ID		0x08
 
 
 /*
