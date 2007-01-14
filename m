Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6FB51DDE3D
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 09:54:03 +1100 (EST)
Date: Sun, 14 Jan 2007 23:53:58 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] More SMU commands
Message-ID: <20070114225358.GA27834@hansmi.ch>
References: <20061224130531.GA28635@hansmi.ch>
	<1167082402.3522.8.camel@localhost.localdomain>
	<20070105001014.GA28410@hansmi.ch>
	<20070106024242.GA18395@hansmi.ch>
	<1168218731.22458.109.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <1168218731.22458.109.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2007 at 12:12:10PM +1100, Benjamin Herrenschmidt wrote:
> Meaning and use are known :-) This defines events related to powering or
> waking the machine up :-)

You were right, now it makes sense.

> (There might be others above 5 but that's the one I know about, they are
> the same on the SMU).

Yes, there are.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/include/as=
m-powerpc/smu.h linux-2.6.19.1/include/asm-powerpc/smu.h
--- linux-2.6.19.1.orig/include/asm-powerpc/smu.h	2007-01-14 12:58:26.00000=
0000 +0100
+++ linux-2.6.19.1/include/asm-powerpc/smu.h	2007-01-14 23:33:05.000000000 =
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
+/* SMU_POWER_EVENTS subcommands */
+enum {
+	SMU_PWR_GET_POWERUP_EVENTS      =3D 0x00,
+	SMU_PWR_SET_POWERUP_EVENTS      =3D 0x01,
+	SMU_PWR_CLR_POWERUP_EVENTS      =3D 0x02,
+	SMU_PWR_GET_WAKEUP_EVENTS       =3D 0x03,
+	SMU_PWR_SET_WAKEUP_EVENTS       =3D 0x04,
+	SMU_PWR_CLR_WAKEUP_EVENTS       =3D 0x05,
+
+	/*
+	 * Get last shutdown cause
+	 *
+	 * Returns:
+	 *   1 byte (signed char): Last shutdown cause. Exact meaning unknown.
+	 */
+	SMU_PWR_LAST_SHUTDOWN_CAUSE	=3D 0x07,
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
+	SMU_PWR_SERVER_ID		=3D 0x08,
+};
+
+/* Power events wakeup bits */
+enum { =20
+	SMU_PWR_WAKEUP_KEY              =3D 0x01, /* Wake on key press */
+	SMU_PWR_WAKEUP_AC_INSERT        =3D 0x02, /* Wake on AC adapter plug */
+	SMU_PWR_WAKEUP_AC_CHANGE        =3D 0x04,
+	SMU_PWR_WAKEUP_LID_OPEN         =3D 0x08,
+	SMU_PWR_WAKEUP_RING             =3D 0x10,
+};
+
=20
 /*
  * - Kernel side interface -

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFqrSG6J0saEpRu+oRAhQSAJ9cu26FC2teBMF80snOCRxRinGEGwCdHPuK
eCVKpjzRiu6hFti9d0X8VoU=
=H32f
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
