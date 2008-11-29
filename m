Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id ABED2DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 22:17:33 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so694973eyi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 03:17:31 -0800 (PST)
Message-ID: <493124C7.9030704@gmail.com>
Date: Sat, 29 Nov 2008 06:17:27 -0500
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] [POWERPC] smu_sat_get_sdb_partition() - unsigned len cannot
	be negative
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

i2c_smbus_read_word_data() returns a s32, which may be negative
but unsigned len cannot be negative.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
for i2c_smbus_read_word_data(), see
vi drivers/i2c/i2c-core.c +1663

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 7f2be4b..7847e98 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -87,11 +87,12 @@ struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id, int id,
 		return NULL;
 	}
 
-	len = i2c_smbus_read_word_data(&sat->i2c, 9);
-	if (len < 0) {
+	err = i2c_smbus_read_word_data(&sat->i2c, 9);
+	if (err < 0) {
 		printk(KERN_ERR "smu_sat_get_sdb_part rd len error\n");
 		return NULL;
 	}
+	len = err;
 	if (len == 0) {
 		printk(KERN_ERR "smu_sat_get_sdb_part no partition %x\n", id);
 		return NULL;
