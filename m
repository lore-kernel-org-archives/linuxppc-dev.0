Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFFFF67A2C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 21:26:43 +1100 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.2/8.13.2) id j0KAQXrP010627
	for linuxppc-dev@ozlabs.org; Thu, 20 Jan 2005 11:26:33 +0100
Date: Thu, 20 Jan 2005 11:26:33 +0100
From: Joerg Dorchain <joerg@dorchain.net>
Cc: linuxppc-dev@ozlabs.org
Message-ID: <20050120102633.GA8862@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Subject: [PATCH] sysrq for ibook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am somehow missing the sysrq-feature with the iBook keyboard. As there
is no F13=3Dsysrq on it, IMHO it might be an idea to emulate it via Fn+esc.

Bye,

Joerg

--- adbhid.c.sysrq	2005-01-19 18:57:30.000000000 +0100
+++ adbhid.c	2005-01-19 20:09:15.873421184 +0100
@@ -67,13 +67,16 @@
=20
 /* Some special keys */
 #define ADB_KEY_DEL		0x33
+#define ADB_KEY_ESC		0x35
 #define ADB_KEY_CMD		0x37
 #define ADB_KEY_CAPSLOCK	0x39
 #define ADB_KEY_FN		0x3f
+#define ADB_KEY_SYSRQ		0x69
 #define ADB_KEY_FWDEL		0x75
 #define ADB_KEY_POWER_OLD	0x7e
 #define ADB_KEY_POWER		0x7f
=20
+
 u8 adb_to_linux_keycodes[128] =3D {
 	/* 0x00 */ KEY_A, 		/*  30 */
 	/* 0x01 */ KEY_S, 		/*  31 */
@@ -221,6 +224,7 @@
 #define FLAG_FN_KEY_PRESSED	0x00000001
 #define FLAG_POWER_FROM_FN	0x00000002
 #define FLAG_EMU_FWDEL_DOWN	0x00000004
+#define FLAG_EMU_SYSRQ_DOWN	0x00000008
=20
 static struct adbhid *adbhid[16];
=20
@@ -329,6 +333,12 @@
 				keycode =3D ADB_KEY_FWDEL;
 				break;
 			}
+			/* Emulate Fn+esc =3D sysreq */
+			if (ahid->flags & FLAG_EMU_SYSRQ_DOWN) {
+				ahid->flags &=3D ~FLAG_EMU_SYSRQ_DOWN;
+				keycode =3D ADB_KEY_SYSRQ;
+				break;
+			}
 		} else
 			ahid->flags |=3D FLAG_FN_KEY_PRESSED;
 		/* Swallow the key press */
@@ -343,6 +353,23 @@
 				ahid->flags |=3D FLAG_EMU_FWDEL_DOWN;
 		}
 		break;
+	case ADB_KEY_ESC:
+		/* Emulate Fn+esc =3D left alt+sysreq */
+		if (ahid->flags & FLAG_FN_KEY_PRESSED) {
+			keycode =3D ADB_KEY_SYSRQ;
+			input_regs(&ahid->input, regs);
+			if (up_flag) {
+				ahid->flags &=3D ~FLAG_EMU_SYSRQ_DOWN;
+				/* Warning: Hack to avoid twisted fingers ...*/
+				input_report_key(&ahid->input, KEY_LEFTALT, 0);
+			} else {
+				ahid->flags |=3D FLAG_EMU_SYSRQ_DOWN;
+				/* Warning: Hack to avoid twisted fingers ...*/
+				input_report_key(&ahid->input, KEY_LEFTALT, 1);
+			}
+			input_sync(&ahid->input);
+		}
+		break;
 #endif /* CONFIG_PPC_PMAC */
 	}
=20

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB74dZjY4+4PdzvOARAiIKAJ42MncsuGmAWt++GQsbRjeZ25SyrACdEcdi
Rtv5Jx3CasCyPA/FAmhhnNE=
=Fiqi
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
