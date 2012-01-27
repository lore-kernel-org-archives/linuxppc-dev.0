Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2217BB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2012 01:24:45 +1100 (EST)
Received: by pbaa7 with SMTP id a7so1767767pba.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 06:24:44 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] powerpc: use string library
Date: Fri, 27 Jan 2012 23:24:48 +0900
Message-Id: <1327674295-3700-1-git-send-email-akinobu.mita@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Use memchr_inv to check if the data contains all 0xFF bytes.
  It is faster than looping for each byte.

- Use memcmp to compare memory areas

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/powermac/nvram.c |   42 ++++++++++++++-----------------
 1 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index 54d2271..da18b26 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -279,7 +279,7 @@ static u32 core99_check(u8* datas)
 
 static int sm_erase_bank(int bank)
 {
-	int stat, i;
+	int stat;
 	unsigned long timeout;
 
 	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
@@ -301,11 +301,10 @@ static int sm_erase_bank(int bank)
 	out_8(base, SM_FLASH_CMD_CLEAR_STATUS);
 	out_8(base, SM_FLASH_CMD_RESET);
 
-	for (i=0; i<NVRAM_SIZE; i++)
-		if (base[i] != 0xff) {
-			printk(KERN_ERR "nvram: Sharp/Micron flash erase failed !\n");
-			return -ENXIO;
-		}
+	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
+		printk(KERN_ERR "nvram: Sharp/Micron flash erase failed !\n");
+		return -ENXIO;
+	}
 	return 0;
 }
 
@@ -336,17 +335,16 @@ static int sm_write_bank(int bank, u8* datas)
 	}
 	out_8(base, SM_FLASH_CMD_CLEAR_STATUS);
 	out_8(base, SM_FLASH_CMD_RESET);
-	for (i=0; i<NVRAM_SIZE; i++)
-		if (base[i] != datas[i]) {
-			printk(KERN_ERR "nvram: Sharp/Micron flash write failed !\n");
-			return -ENXIO;
-		}
+	if (memcmp(base, datas, NVRAM_SIZE)) {
+		printk(KERN_ERR "nvram: Sharp/Micron flash write failed !\n");
+		return -ENXIO;
+	}
 	return 0;
 }
 
 static int amd_erase_bank(int bank)
 {
-	int i, stat = 0;
+	int stat = 0;
 	unsigned long timeout;
 
 	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
@@ -382,12 +380,11 @@ static int amd_erase_bank(int bank)
 	/* Reset */
 	out_8(base, 0xf0);
 	udelay(1);
-	
-	for (i=0; i<NVRAM_SIZE; i++)
-		if (base[i] != 0xff) {
-			printk(KERN_ERR "nvram: AMD flash erase failed !\n");
-			return -ENXIO;
-		}
+
+	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
+		printk(KERN_ERR "nvram: AMD flash erase failed !\n");
+		return -ENXIO;
+	}
 	return 0;
 }
 
@@ -429,11 +426,10 @@ static int amd_write_bank(int bank, u8* datas)
 	out_8(base, 0xf0);
 	udelay(1);
 
-	for (i=0; i<NVRAM_SIZE; i++)
-		if (base[i] != datas[i]) {
-			printk(KERN_ERR "nvram: AMD flash write failed !\n");
-			return -ENXIO;
-		}
+	if (memcmp(base, datas, NVRAM_SIZE)) {
+		printk(KERN_ERR "nvram: AMD flash write failed !\n");
+		return -ENXIO;
+	}
 	return 0;
 }
 
-- 
1.7.4.4
