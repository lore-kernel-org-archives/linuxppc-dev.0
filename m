Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A8E85B70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Feb 2011 05:28:08 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio: Fix sysfs config attribute to access 16MB of maint
	space
Date: Fri, 25 Feb 2011 13:26:25 -0500
Message-Id: <1298658385-9842-2-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1298658385-9842-1-git-send-email-alexandre.bounine@idt.com>
References: <1298658385-9842-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes sysfs config attribute to allow access to entire 16MB maintenance
space of RapidIO devices.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Thomas Moll <thomas.moll@sysgo.com>
Cc: Micha Nelissen <micha@neli.hopto.org>
---
 drivers/rapidio/rio-sysfs.c |   12 ++++++------
 include/linux/rio_regs.h    |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index e3ebfec..c04dbc7 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -78,9 +78,9 @@ rio_read_config(struct file *filp, struct kobject *kobj,
 
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN))
-		size = 0x200000;
+		size = RIO_MAINT_SPACE_SZ;
 
-	if (off > size)
+	if (off >= size)
 		return 0;
 	if (off + count > size) {
 		size -= off;
@@ -148,10 +148,10 @@ rio_write_config(struct file *filp, struct kobject *kobj,
 	loff_t init_off = off;
 	u8 *data = (u8 *) buf;
 
-	if (off > 0x200000)
+	if (off >= RIO_MAINT_SPACE_SZ)
 		return 0;
-	if (off + count > 0x200000) {
-		size = 0x200000 - off;
+	if (off + count > RIO_MAINT_SPACE_SZ) {
+		size = RIO_MAINT_SPACE_SZ - off;
 		count = size;
 	}
 
@@ -201,7 +201,7 @@ static struct bin_attribute rio_config_attr = {
 		 .name = "config",
 		 .mode = S_IRUGO | S_IWUSR,
 		 },
-	.size = 0x200000,
+	.size = RIO_MAINT_SPACE_SZ,
 	.read = rio_read_config,
 	.write = rio_write_config,
 };
diff --git a/include/linux/rio_regs.h b/include/linux/rio_regs.h
index d63dcba..9026b30 100644
--- a/include/linux/rio_regs.h
+++ b/include/linux/rio_regs.h
@@ -14,10 +14,12 @@
 #define LINUX_RIO_REGS_H
 
 /*
- * In RapidIO, each device has a 2MB configuration space that is
+ * In RapidIO, each device has a 16MB configuration space that is
  * accessed via maintenance transactions.  Portions of configuration
  * space are standardized and/or reserved.
  */
+#define RIO_MAINT_SPACE_SZ	0x1000000 /* 16MB of RapidIO mainenance space */
+
 #define RIO_DEV_ID_CAR		0x00	/* [I] Device Identity CAR */
 #define RIO_DEV_INFO_CAR	0x04	/* [I] Device Information CAR */
 #define RIO_ASM_ID_CAR		0x08	/* [I] Assembly Identity CAR */
-- 
1.7.3.1
