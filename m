Return-Path: <linuxuser330250@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 56EE5B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Feb 2011 07:17:28 +1100 (EST)
From: "Linux User #330250" <linuxuser330250@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Add support for PowerMac3,5 in snd-aoa ALSA sound module
Date: Thu, 17 Feb 2011 21:17:24 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VJYXNm1ZlkucSE8"
Message-Id: <201102172117.25424.linuxuser330250@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Boundary-00=_VJYXNm1ZlkucSE8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

About two years ago Johannes Berg wrote support for the PowerMac3,6 aka G4 =
MDD=20
which I was using as a desktop computer then. Johannes wrote all the code, =
and=20
I tested it.

I now have a PowerMac3,5 =E2=80=93 yes, an earlier model.

This patch makes the snd-aoa ALSA sound module support the TAS3001C codec o=
f=20
my Apple Power Mac G4 "Quicksilver" (2001 model). I suppose it will also wo=
rk=20
for the "Quicksilver 2002", since both identify as PowerMac3,5.

The patch also changes a few comments to name the exact Power Mac model mor=
e=20
accurately in sound/aoa/fabrics/layout.c.

This is my first contribution to the linux kernel ever, so I hope you will =
be=20
kind to me. I am not a programmer, but adding already supported devices was=
 a=20
task even I could accomplish.

Thanks,
Andreas  aka  Linux User #330250


--Boundary-00=_VJYXNm1ZlkucSE8
Content-Type: text/x-patch;
  charset="UTF-8";
  name="Quicksilver-aoa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Quicksilver-aoa.patch"

diff -Naur linux-2.6.38-rc5-git2/sound/aoa/fabrics/layout.c linux-2.6.38-rc5-git2-aoa-PowerMac3,5/sound/aoa/fabrics/layout.c
--- linux-2.6.38-rc5-git2/sound/aoa/fabrics/layout.c    2011-01-05 01:50:19.000000000 +0100
+++ linux-2.6.38-rc5-git2-aoa-PowerMac3,5/sound/aoa/fabrics/layout.c    2011-02-17 18:43:26.000000000 +0100
@@ -111,6 +111,7 @@
 MODULE_ALIAS("sound-layout-100");
 
 MODULE_ALIAS("aoa-device-id-14");
+MODULE_ALIAS("aoa-device-id-21");
 MODULE_ALIAS("aoa-device-id-22");
 MODULE_ALIAS("aoa-device-id-35");
 
@@ -333,14 +334,14 @@
                .connections = topaz_input,
          },
        },
-       /* Quad PowerMac (analog in, analog/digital out) */
+       /* PowerMac11,2 (G5 Dual-Core and Quad) (analog in, analog/digital out) */
        { .layout_id = 68,
          .codecs[0] = {
                .name = "onyx",
                .connections = onyx_connections_nomic,
          },
        },
-       /* Quad PowerMac (digital in) */
+       /* PowerMac11,2 (G5 Dual-Core and Quad) (digital in) */
        { .layout_id = 69,
          .codecs[0] = {
                .name = "topaz",
@@ -521,14 +522,21 @@
                .connections = onyx_connections_noheadphones,
          },
        },
-       /* PowerMac3,4 */
+       /* PowerMac3,4 (Digital Audio) */
        { .device_id = 14,
          .codecs[0] = {
                .name = "tas",
                .connections = tas_connections_noline,
          },
        },
-       /* PowerMac3,6 */
+       /* PowerMac3,5 (Quicksilver) */
+       { .device_id = 21,
+         .codecs[0] = {
+               .name = "tas",
+               .connections = tas_connections_noline,
+         },
+       },
+       /* PowerMac3,6 (Mirrored Drive Doors) */
        { .device_id = 22,
          .codecs[0] = {
                .name = "tas",
diff -Naur linux-2.6.38-rc5-git2/sound/aoa/soundbus/i2sbus/core.c linux-2.6.38-rc5-git2-aoa-PowerMac3,5/sound/aoa/soundbus/i2sbus/core.c
--- linux-2.6.38-rc5-git2/sound/aoa/soundbus/i2sbus/core.c      2011-01-05 01:50:19.000000000 +0100
+++ linux-2.6.38-rc5-git2-aoa-PowerMac3,5/sound/aoa/soundbus/i2sbus/core.c      2011-02-17 18:44:36.000000000 +0100
@@ -200,7 +200,7 @@
                         * We probably cannot handle all device-id machines,
                         * so restrict to those we do handle for now.
                         */
-                       if (id && (*id == 22 || *id == 14 || *id == 35)) {
+                       if (id && (*id == 22 || *id == 21 || *id == 14 || *id == 35)) {
                                snprintf(dev->sound.modalias, 32,
                                         "aoa-device-id-%d", *id);
                                ok = 1;

--Boundary-00=_VJYXNm1ZlkucSE8--
