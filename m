Message-ID: <152001c3dc2e$6b36ddb0$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
References: <20040116122756.034fc736.colin@colino.net> <20040116124158.24db8307.colin@colino.net> <Pine.GSO.4.58.0401161302570.14892@waterleaf.sonytel.be>
Subject: Re: [PATCH] therm_* drivers need i2c-keywest
Date: Fri, 16 Jan 2004 13:44:01 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_151D_01C3DC36.CCD52010"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_151D_01C3DC36.CCD52010
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

hi,

> And you want to drop the #ifdef CONFIG_KMOD, since that's already in
> <linux/kmod.h>.

Sure, here it is.
--
Colin
Ne disez pas disez, mais disez dites
------=_NextPart_000_151D_01C3DC36.CCD52010
Content-Type: application/octet-stream;
	name="therm_load_i2c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="therm_load_i2c.diff"

Index: drivers/macintosh/therm_adt7467.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linuxppc/drivers/macintosh/therm_adt7467.c,v=0A=
retrieving revision 1.1=0A=
diff -u -u -r1.1 therm_adt7467.c=0A=
--- drivers/macintosh/therm_adt7467.c	11 Jan 2004 20:21:54 -0000	1.1=0A=
+++ drivers/macintosh/therm_adt7467.c	16 Jan 2004 12:47:07 -0000=0A=
@@ -27,6 +27,7 @@=0A=
 #include <asm/system.h>=0A=
 #include <asm/sections.h>=0A=
 #include <asm/of_device.h>=0A=
+#include <linux/kmod.h>=0A=
 =0A=
 #undef DEBUG=0A=
 =0A=
@@ -424,6 +425,7 @@=0A=
 	device_create_file(&of_dev->dev, &dev_attr_gpu_limit);=0A=
 	device_create_file(&of_dev->dev, &dev_attr_fan_speed);=0A=
 	=0A=
+	request_module("i2c-keywest");=0A=
 	return i2c_add_driver(&thermostat_driver);=0A=
 }=0A=
 =0A=
Index: drivers/macintosh/therm_pm72.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linuxppc/drivers/macintosh/therm_pm72.c,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -u -r1.1.1.1 therm_pm72.c=0A=
--- drivers/macintosh/therm_pm72.c	8 Jan 2004 11:25:19 -0000	1.1.1.1=0A=
+++ drivers/macintosh/therm_pm72.c	16 Jan 2004 12:47:15 -0000=0A=
@@ -91,6 +91,7 @@=0A=
 #include <asm/system.h>=0A=
 #include <asm/sections.h>=0A=
 #include <asm/of_device.h>=0A=
+#include <linux/kmod.h>=0A=
 =0A=
 #include "therm_pm72.h"=0A=
 =0A=
@@ -1165,6 +1166,7 @@=0A=
 =0A=
 	state =3D state_detached;=0A=
 =0A=
+	request_module("i2c-keywest");=0A=
 	rc =3D i2c_add_driver(&therm_pm72_driver);=0A=
 	if (rc < 0)=0A=
 		return rc;=0A=
Index: drivers/macintosh/therm_windtunnel.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvsroot/linuxppc/drivers/macintosh/therm_windtunnel.c,v=0A=
retrieving revision 1.1=0A=
diff -u -u -r1.1 therm_windtunnel.c=0A=
--- drivers/macintosh/therm_windtunnel.c	11 Jan 2004 20:21:55 -0000	1.1=0A=
+++ drivers/macintosh/therm_windtunnel.c	16 Jan 2004 12:47:23 -0000=0A=
@@ -44,6 +44,7 @@=0A=
 #include <asm/io.h>=0A=
 #include <asm/system.h>=0A=
 #include <asm/sections.h>=0A=
+#include <linux/kmod.h>=0A=
 =0A=
 MODULE_AUTHOR("Samuel Rydh <samuel@ibrium.se>");=0A=
 MODULE_DESCRIPTION("Apple G4 (windtunnel) fan driver");=0A=
@@ -380,6 +381,7 @@=0A=
 		printk(KERN_ERR "g4fan: unsupported machine type\n");=0A=
 		return -ENODEV;=0A=
 	}=0A=
+	request_module("i2c-keywest");=0A=
 	if( (ret=3Di2c_add_driver(&g4fan_driver)) )=0A=
 		return ret;=0A=
 =0A=

------=_NextPart_000_151D_01C3DC36.CCD52010--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
