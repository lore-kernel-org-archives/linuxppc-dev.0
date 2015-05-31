Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 9E4561A0CA9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010134.859507876@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:42 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 10/24] char/nvram: Use generic fixed_size_llseek()
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/char/nvram.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:09.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:11.000000000 +1000
@@ -235,21 +235,7 @@ EXPORT_SYMBOL(arch_nvram_ops);
 
 static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 {
-	switch (origin) {
-	case 0:
-		/* nothing to do */
-		break;
-	case 1:
-		offset += file->f_pos;
-		break;
-	case 2:
-		offset += NVRAM_BYTES;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return (offset >= 0) ? (file->f_pos = offset) : -EINVAL;
+	return fixed_size_llseek(file, offset, origin, nvram_size);
 }
 
 static ssize_t nvram_misc_read(struct file *file, char __user *buf,
