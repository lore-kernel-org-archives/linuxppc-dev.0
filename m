Message-ID: <14de01c3dc1a$70830140$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <valvoline@vrlteam.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org> <125601c3db40$50b11bc0$3cc8a8c0@ANOSP> <20040115071604.GR2658@adapter.n0skillz.org> <12b901c3db4a$81d1f7b0$3cc8a8c0@ANOSP> <20040116070249.GT2658@adapter.n0skillz.org>
Subject: Re: temp.c and cputable.c issues
Date: Fri, 16 Jan 2004 11:21:00 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_14DB_01C3DC22.D21C88B0"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_14DB_01C3DC22.D21C88B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> i gotta it! :)
> for some strange reason i need to modprobe manually the i2c_west,
> first of all...next if i modprobe:


Can you try the attached patch (apply against
drivers/macintosh/therm_adt7467.c).
Then, try to modprobe therm_adt7467 without i2c-core and i2c-keywest
loaded.

Tell me if this works.

Thanks,
--
Colin
Ne disez pas disez, mais disez dites

------=_NextPart_000_14DB_01C3DC22.D21C88B0
Content-Type: application/octet-stream;
	name="therm_adt7467.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="therm_adt7467.diff"

--- therm_adt7467.c.orig	2004-01-16 11:10:49.000000000 +0100=0A=
+++ therm_adt7467.c	2004-01-16 11:14:38.000000000 +0100=0A=
@@ -27,6 +27,7 @@=0A=
 #include <asm/system.h>=0A=
 #include <asm/sections.h>=0A=
 #include <asm/of_device.h>=0A=
+#include <linux/kmod.h>=0A=
 =0A=
 #undef DEBUG=0A=
 =0A=
@@ -421,6 +422,9 @@=0A=
 	device_create_file(&of_dev->dev, &dev_attr_gpu_limit);=0A=
 	device_create_file(&of_dev->dev, &dev_attr_fan_speed);=0A=
 	=0A=
+#ifdef CONFIG_KMOD	=0A=
+	request_module("i2c-keywest");=0A=
+#endif=0A=
 	return i2c_add_driver(&thermostat_driver);=0A=
 }=0A=
 =0A=

------=_NextPart_000_14DB_01C3DC22.D21C88B0--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
