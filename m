Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84117DDE36
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 11:10:28 +1100 (EST)
Date: Fri, 5 Jan 2007 01:10:14 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] More SMU commands
Message-ID: <20070105001014.GA28410@hansmi.ch>
References: <20061224130531.GA28635@hansmi.ch>
	<1167082402.3522.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <1167082402.3522.8.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Benjamin

Unless otherwise noted, stuff is commented or fixed in the patch below.

On Tue, Dec 26, 2006 at 08:33:22AM +1100, Benjamin Herrenschmidt wrote:
> > +/*
> > + * File server mode
> > + *
> > + * Parameters:
> > + *   2: to enable, set to 0x01, otherwise 0xff
> > + *   3: always 0xff
> > + */
> > +#define   SMU_CMD_MISC_8f_FILESERVER_MODE	0x02

> The meaning of the power events parameters is the same as for the PMU,
> you can get the actual constants there. Your constant is incorrect.

You were right. I did a mistake there. Should be fixed now and got some
more commands for 0x8f.

> > +#define   SMU_CMD_MISC_8f_SERVER_ID		0x08

> Any idea what this means ?

No, I don't. Just guessing, but maybe it's somehow related to Xserve and
clusters.

New patch below. Is this one better?

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/include/as=
m-powerpc/smu.h linux-2.6.19.1/include/asm-powerpc/smu.h
--- linux-2.6.19.1.orig/include/asm-powerpc/smu.h	2006-12-24 12:19:07.00000=
0000 +0100
+++ linux-2.6.19.1/include/asm-powerpc/smu.h	2007-01-05 01:00:41.000000000 =
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
@@ -206,16 +206,67 @@
  * This command seem to be a grab bag of various things
  */
 #define SMU_CMD_MISC_df_COMMAND			0xdf
-#define   SMU_CMD_MISC_df_SET_DISPLAY_LIT	0x02 /* i: 1 byte */
+
+/*
+ * Sets "system ready" status
+ *
+ * What this actually does is not yet known, but Apple's driver sets it at=
 some
+ * point.
+ *
+ * Parameters:
+ *   1: status [0x00, 0x01 or 0x02]
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
+ *   1: enable power switch? [0x00 or 0x01]
+ *   2: enable nmi? [0x00 or 0x01]
+ */
 #define   SMU_CMD_MISC_df_NMI_OPTION		0x04
=20
+/* Sets LED dimm offset.
+ *
+ * Parameters:
+ *   1-7: unknown (BCD coding)
+ */
+#define   SMU_CMD_MISC_df_DIMM_OFFSET		0x99
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
=20
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
 /*
  * Misc commands
@@ -243,10 +294,97 @@
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
+#define SMU_CMD_POWER_COMMAND			0x8f
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
+#define   SMU_CMD_POWER_SET_FILESERVER_MODE	0x01
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
+#define   SMU_CMD_POWER_CLR_FILESERVER_MODE	0x02
+
+/* Unknown meaning. Used during sleep preparation.
+ *
+ * Parameters:
+ *   2: unknown
+ *   3: unknown
+ *
+ * Returns:
+ *   2 bytes
+ */
+#define   SMU_CMD_POWER_UNKNOWN_04		0x04
+
+/* Unknown meaning. Used during sleep preparation.
+ *
+ * Parameters:
+ *   2: 0xff, meaning unknown
+ *   3: 0xff, meaning unknown
+ *
+ * Returns:
+ *   2 bytes
+ */
+#define   SMU_CMD_POWER_UNKNOWN_05		0x05
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
+#define   SMU_CMD_POWER_LAST_SHUTDOWN_CAUSE	0x07
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
+#define   SMU_CMD_POWER_SERVER_ID		0x08
+
=20
 /*
  * - Kernel side interface -

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFnZdm6J0saEpRu+oRAhwbAJ9bHm7GkbQh9SRHA2uPEWWoeGo+YACeKaPM
pdjdH0NebW/XQJDDl9G+QUM=
=Sh34
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
