Return-Path: <linuxuser330250@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 0135DB7185
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 08:38:34 +1100 (EST)
From: "Linux User #330250" <linuxuser330250@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Add support for PowerMac3,5 in snd-aoa ALSA sound module
Date: Sun, 20 Feb 2011 22:38:28 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201102202238.28517.linuxuser330250@gmx.net>
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello again!

Sorry for sending the patch three times. (This is the fourth...)

About the sign-off: I use the name I've been using since I started
participating. The document $LINUX/Documentation/SubmittingPatches clearly
states that one has to use real names. I'm breaking this rule, but I'm not
ready to reveal my real name here or at any other place at this time. Sorry.
If this patch is not accepted due to this, well=E2=80=A6 that's life. BTW m=
y real
given name is Andreas.


So, here's the patch, this time with a (pseudonym) sign-off:

This patch makes the snd-aoa ALSA sound module support the TAS3001C codec o=
f=20
my Apple Power Mac G4 "Quicksilver" (2001 model). I suppose it will also wo=
rk=20
for the "Quicksilver 2002", since both identify as PowerMac3,5.

The patch also changes a few comments to name the exact Power Mac model mor=
e=20
accurately in sound/aoa/fabrics/layout.c.

Signed-off-by: Andreas  aka  Linux User #330250 <linuxuser330250@gmx.net>

=2D--

diff -Naur linux-2.6.38-rc5-git2/sound/aoa/fabrics/layout.c linux-2.6.38-rc=
5-git2-aoa-PowerMac3,5/sound/aoa/fabrics/layout.c
=2D-- linux-2.6.38-rc5-git2/sound/aoa/fabrics/layout.c    2011-01-05 01:50:=
19.000000000 +0100
+++ linux-2.6.38-rc5-git2-aoa-PowerMac3,5/sound/aoa/fabrics/layout.c    201=
1-02-17 18:43:26.000000000 +0100
@@ -111,6 +111,7 @@
 MODULE_ALIAS("sound-layout-100");
=20
 MODULE_ALIAS("aoa-device-id-14");
+MODULE_ALIAS("aoa-device-id-21");
 MODULE_ALIAS("aoa-device-id-22");
 MODULE_ALIAS("aoa-device-id-35");
=20
@@ -333,14 +334,14 @@
                .connections =3D topaz_input,
          },
        },
=2D       /* Quad PowerMac (analog in, analog/digital out) */
+       /* PowerMac11,2 (G5 Dual-Core and Quad) (analog in, analog/digital =
out) */
        { .layout_id =3D 68,
          .codecs[0] =3D {
                .name =3D "onyx",
                .connections =3D onyx_connections_nomic,
          },
        },
=2D       /* Quad PowerMac (digital in) */
+       /* PowerMac11,2 (G5 Dual-Core and Quad) (digital in) */
        { .layout_id =3D 69,
          .codecs[0] =3D {
                .name =3D "topaz",
@@ -521,14 +522,21 @@
                .connections =3D onyx_connections_noheadphones,
          },
        },---
=2D       /* PowerMac3,4 */
+       /* PowerMac3,4 (Digital Audio) */
        { .device_id =3D 14,
          .codecs[0] =3D {
                .name =3D "tas",
                .connections =3D tas_connections_noline,
          },
        },
=2D       /* PowerMac3,6 */
+       /* PowerMac3,5 (Quicksilver) */
+       { .device_id =3D 21,
+         .codecs[0] =3D {
+               .name =3D "tas",
+               .connections =3D tas_connections_noline,
+         },
+       },
+       /* PowerMac3,6 (Mirrored Drive Doors) */
        { .device_id =3D 22,
          .codecs[0] =3D {
                .name =3D "tas",
diff -Naur linux-2.6.38-rc5-git2/sound/aoa/soundbus/i2sbus/core.c linux-2.6=
=2E38-rc5-git2-aoa-PowerMac3,5/sound/aoa/soundbus/i2sbus/core.c
=2D-- linux-2.6.38-rc5-git2/sound/aoa/soundbus/i2sbus/core.c      2011-01-0=
5 01:50:19.000000000 +0100
+++ linux-2.6.38-rc5-git2-aoa-PowerMac3,5/sound/aoa/soundbus/i2sbus/core.c =
     2011-02-17 18:44:36.000000000 +0100
@@ -200,7 +200,7 @@
                         * We probably cannot handle all device-id machines,
                         * so restrict to those we do handle for now.
                         */
=2D                       if (id && (*id =3D=3D 22 || *id =3D=3D 14 || *id =
=3D=3D 35)) {
+                       if (id && (*id =3D=3D 22 || *id =3D=3D 21 || *id =
=3D=3D 14 || *id =3D=3D 35)) {
                                snprintf(dev->sound.modalias, 32,
                                         "aoa-device-id-%d", *id);
                                ok =3D 1;
