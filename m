Return-Path: <adolnikov@ru.mvista.com>
Received: from barber.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BD4FDDF0C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 05:32:31 +1100 (EST)
Date: Mon, 3 Mar 2008 21:01:21 +0300
From: Andrei Dolnikov <adolnikov@ru.mvista.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH][MTD][NOR]Add support for the SST 36VF3203 flash chip
Message-ID: <20080303180121.GA9206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for the SST 36VF3203 flash chip. It is used on Emerson KSI8560 board.

Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvista.com>

---
 jedec_probe.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 6405938..15e061b 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -160,6 +160,7 @@
 #define SST49LF030A	0x001C
 #define SST49LF040A	0x0051
 #define SST49LF080A	0x005B
+#define SST36VF3203	0x7354
 
 /* Toshiba */
 #define TC58FVT160	0x00C2
@@ -1412,6 +1413,18 @@ static const struct amd_flash_info jedec_table[] = {
 			ERASEINFO(0x1000,256)
 		}
 	}, {
+		.mfr_id		= MANUFACTURER_SST,
+		.dev_id		= SST36VF3203,
+		.name		= "SST 36VF3203",
+		.devtypes	= CFI_DEVICETYPE_X16|CFI_DEVICETYPE_X8,
+		.uaddr		= MTD_UADDR_0x0AAA_0x0555,
+		.dev_size	= SIZE_4MiB,
+		.cmd_set	= P_ID_AMD_STD,
+		.nr_regions	= 1,
+		.regions	= {
+			ERASEINFO(0x10000,64),
+		}
+	}, {
 		.mfr_id		= MANUFACTURER_ST,
 		.dev_id		= M29F800AB,
 		.name		= "ST M29F800AB",
