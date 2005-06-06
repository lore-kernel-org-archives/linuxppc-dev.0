Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 90FB0679F8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 09:52:27 +1000 (EST)
In-Reply-To: <11181019441461@foobar.com>
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019442715@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: akpm@osdl.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: sysfs config space fixes
Reply-To: Matt Porter <mporter@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix sysfs config space access similar to the recent PCI sysfs changes.=20

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit 2a28743938495ab6055db2e29f3e0721bba022cc
tree 09d592a46eff8592327b20c609595eb8b7d5e333
parent d45c2d2fedcafd50a860267ff1d517c3071ab585
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 14:50:28 =
-0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 14:50:=
28 -0700

 drivers/rio/rio-sysfs.c |   82 +++++++++++++++++++++++++++++++++----------=
----
 1 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/rio/rio-sysfs.c b/drivers/rio/rio-sysfs.c
--- a/drivers/rio/rio-sysfs.c
+++ b/drivers/rio/rio-sysfs.c
@@ -74,10 +74,11 @@ rio_read_config(struct kobject *kobj, ch
 	    to_rio_dev(container_of(kobj, struct device, kobj));
 	unsigned int size =3D 0x100;
 	loff_t init_off =3D off;
+	u8 *data =3D (u8 *) buf;
=20
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN))
-		size =3D 0x80000;
+		size =3D 0x200000;
=20
 	if (off > size)
 		return 0;
@@ -88,30 +89,47 @@ rio_read_config(struct kobject *kobj, ch
 		size =3D count;
 	}
=20
-	while (off & 3) {
-		unsigned char val;
+	if ((off & 1) && size) {
+		u8 val;
 		rio_read_config_8(dev, off, &val);
-		buf[off - init_off] =3D val;
+		data[off - init_off] =3D val;
 		off++;
-		if (--size =3D=3D 0)
-			break;
+		size--;
+	}
+
+	if ((off & 3) && size > 2) {
+		u16 val;
+		rio_read_config_16(dev, off, &val);
+		data[off - init_off] =3D (val >> 8) & 0xff;
+		data[off - init_off + 1] =3D val & 0xff;
+		off +=3D 2;
+		size -=3D 2;
 	}
=20
 	while (size > 3) {
-		unsigned int val;
+		u32 val;
 		rio_read_config_32(dev, off, &val);
-		buf[off - init_off] =3D (val >> 24) & 0xff;
-		buf[off - init_off + 1] =3D (val >> 16) & 0xff;
-		buf[off - init_off + 2] =3D (val >> 8) & 0xff;
-		buf[off - init_off + 3] =3D val & 0xff;
+		data[off - init_off] =3D (val >> 24) & 0xff;
+		data[off - init_off + 1] =3D (val >> 16) & 0xff;
+		data[off - init_off + 2] =3D (val >> 8) & 0xff;
+		data[off - init_off + 3] =3D val & 0xff;
 		off +=3D 4;
 		size -=3D 4;
 	}
=20
-	while (size > 0) {
-		unsigned char val;
+	if (size >=3D 2) {
+		u16 val;
+		rio_read_config_16(dev, off, &val);
+		data[off - init_off] =3D (val >> 8) & 0xff;
+		data[off - init_off + 1] =3D val & 0xff;
+		off +=3D 2;
+		size -=3D 2;
+	}
+
+	if (size > 0) {
+		u8 val;
 		rio_read_config_8(dev, off, &val);
-		buf[off - init_off] =3D val;
+		data[off - init_off] =3D val;
 		off++;
 		--size;
 	}
@@ -126,6 +144,7 @@ rio_write_config(struct kobject *kobj, c
 	    to_rio_dev(container_of(kobj, struct device, kobj));
 	unsigned int size =3D count;
 	loff_t init_off =3D off;
+	u8 *data =3D (u8 *) buf;
=20
 	if (off > 0x200000)
 		return 0;
@@ -134,25 +153,40 @@ rio_write_config(struct kobject *kobj, c
 		count =3D size;
 	}
=20
-	while (off & 3) {
-		rio_write_config_8(dev, off, buf[off - init_off]);
+	if ((off & 1) && size) {
+		rio_write_config_8(dev, off, data[off - init_off]);
 		off++;
-		if (--size =3D=3D 0)
-			break;
+		size--;
+	}
+
+	if ((off & 3) && (size > 2)) {
+		u16 val =3D data[off - init_off + 1];
+		val |=3D (u16) data[off - init_off] << 8;
+		rio_write_config_16(dev, off, val);
+		off +=3D 2;
+		size -=3D 2;
 	}
=20
 	while (size > 3) {
-		unsigned int val =3D buf[off - init_off + 3];
-		val |=3D (unsigned int)buf[off - init_off + 2] << 8;
-		val |=3D (unsigned int)buf[off - init_off + 1] << 16;
-		val |=3D (unsigned int)buf[off - init_off] << 24;
+		u32 val =3D data[off - init_off + 3];
+		val |=3D (u32) data[off - init_off + 2] << 8;
+		val |=3D (u32) data[off - init_off + 1] << 16;
+		val |=3D (u32) data[off - init_off] << 24;
 		rio_write_config_32(dev, off, val);
 		off +=3D 4;
 		size -=3D 4;
 	}
=20
-	while (size > 0) {
-		rio_write_config_8(dev, off, buf[off - init_off]);
+	if (size >=3D 2) {
+		u16 val =3D data[off - init_off + 1];
+		val |=3D (u16) data[off - init_off] << 8;
+		rio_write_config_16(dev, off, val);
+		off +=3D 2;
+		size -=3D 2;
+	}
+
+	if (size) {
+		rio_write_config_8(dev, off, data[off - init_off]);
 		off++;
 		--size;
 	}
