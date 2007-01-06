Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6D16DDDF6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jan 2007 13:42:56 +1100 (EST)
Date: Sat, 6 Jan 2007 03:42:42 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] More SMU commands
Message-ID: <20070106024242.GA18395@hansmi.ch>
References: <20061224130531.GA28635@hansmi.ch>
	<1167082402.3522.8.camel@localhost.localdomain>
	<20070105001014.GA28410@hansmi.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
In-Reply-To: <20070105001014.GA28410@hansmi.ch>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2007 at 01:10:14AM +0100, Michael Hanselmann wrote:
> New patch below. Is this one better?

Unfortuntely, there was a naming conflict. Here's a better patch with
even more comments.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
--- linux-2.6.19.1.orig/include/asm-powerpc/smu.h	2006-12-24 12:19:07.00000=
0000 +0100
+++ linux-2.6.19.1/include/asm-powerpc/smu.h	2007-01-06 03:32:23.000000000 =
+0100
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
=20
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
+ * Guessing from OF code, 0x02 activates the display backlight. Apple uses=
/used
+ * the same codebase for all OF versions. On PowerBooks, this command would
+ * enable the backlight. For the G5s, it only activates the front LED. How=
ever,
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
+ * What this actually does is not yet known. Maybe it enables some interru=
pt.
+ *
+ * Parameters:
+ *   2: enable power switch? [0x00 or 0x01]
+ *   3 (optional): enable nmi? [0x00 or 0x01]
+ *
+ * Returns:
+ *   If parameter 2 is 0x00 and parameter 3 is not specified, returns weth=
er
+ *   NMI is enabled. Otherwise unknown.
+ */
 #define   SMU_CMD_MISC_df_NMI_OPTION		0x04
=20
+/* Sets LED dimm offset.
+ *
+ * The front LED dimms itself during sleep. Its brightness (or, well, the =
PWM
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
=20
=20
 /*
@@ -243,10 +313,99 @@
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
=20
=20
+/*
+ * Power related commands
+ *
+ * Parameters:
+ *   1: subcommand
+ */
+#define SMU_CMD_POWER_EVENTS_COMMAND		0x8f
+
+/*
+ * Enables file server mode
+ *
+ * Meaning or use is unknown. Maybe this allows the machine to power up af=
ter
+ * AC loss.
+ *
+ * Parameters:
+ *   2: always 0x00, meaning unknown
+ *   3: always 0x02, meaning unknown
+ *
+ * Returns:
+ *   2 bytes
+ */
+#define   SMU_CMD_POWER_EVENTS_SET_FILESERVER_MODE	0x01
+
+/*
+ * Disables file server mode
+ *
+ * Parameters:
+ *   2: always 0xff, meaning unknown
+ *   3: always 0xff, meaning unknown
+ *
+ * Returns:
+ *   2 bytes
+ */
+#define   SMU_CMD_POWER_EVENTS_CLR_FILESERVER_MODE	0x02
+
+/*
+ * Unknown meaning. Used during sleep preparation.
+ *
+ * Parameters:
+ *   2: unknown
+ *   3: unknown
+ *
+ * Returns:
+ *   2 bytes
+ */
+#define   SMU_CMD_POWER_EVENTS_UNKNOWN_04		0x04
+
+/*
+ * Unknown meaning. Used during sleep preparation.
+ *
+ * Parameters:
+ *   2: 0xff, meaning unknown
+ *   3: 0xff, meaning unknown
+ *
+ * Returns:
+ *   2 bytes
+ */
+#define   SMU_CMD_POWER_EVENTS_UNKNOWN_05		0x05
+
+/*
+ * Get last shutdown cause
+ *
+ * Parameters:
+ *   none
+ *
+ * Returns:
+ *   1 byte (signed char): Last shutdown cause. Exact meaning unknown.
+ */
+#define   SMU_CMD_POWER_EVENTS_LAST_SHUTDOWN_CAUSE	0x07
+
+/*
+ * Sets or gets server ID. Meaning or use is unknown.
+ *
+ * Parameters:
+ *   2 (optional): Set server ID (1 byte)
+ *
+ * Returns:
+ *   1 byte (server ID?)
+ */
+#define   SMU_CMD_POWER_EVENTS_SERVER_ID		0x08
+
=20
 /*
  * - Kernel side interface -

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFnwyi6J0saEpRu+oRAlCoAKCQd1gjc3lufM798BD3YV2kpVMBXgCcCPwN
yXlujlHmywpfotIsD0OaGbA=
=FSyZ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
