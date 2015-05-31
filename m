Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 997651A0CA6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:01 +1000 (AEST)
Message-Id: <20150531010136.839498488@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:50 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 18/24] nvram: Drop nvram_* symbol exports and prototypes
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drivers now use the arch_nvram_ops calls so remove the function exports and
prototypes. nvram_check_checksum() is unused so remove it.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/m68k/atari/nvram.c |    6 +++---
 drivers/char/nvram.c    |   27 +++++----------------------
 include/linux/nvram.h   |    8 --------
 3 files changed, 8 insertions(+), 33 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:17.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:21.000000000 +1000
@@ -82,13 +82,12 @@ static ssize_t nvram_size;
  * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
  */
 
-unsigned char __nvram_read_byte(int i)
+static unsigned char __nvram_read_byte(int i)
 {
 	return CMOS_READ(NVRAM_FIRST_BYTE + i);
 }
-EXPORT_SYMBOL(__nvram_read_byte);
 
-unsigned char nvram_read_byte(int i)
+static unsigned char nvram_read_byte(int i)
 {
 	unsigned long flags;
 	unsigned char c;
@@ -98,16 +97,14 @@ unsigned char nvram_read_byte(int i)
 	spin_unlock_irqrestore(&rtc_lock, flags);
 	return c;
 }
-EXPORT_SYMBOL(nvram_read_byte);
 
 /* This races nicely with trying to read with checksum checking (nvram_read) */
-void __nvram_write_byte(unsigned char c, int i)
+static void __nvram_write_byte(unsigned char c, int i)
 {
 	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
 }
-EXPORT_SYMBOL(__nvram_write_byte);
 
-void nvram_write_byte(unsigned char c, int i)
+static void nvram_write_byte(unsigned char c, int i)
 {
 	unsigned long flags;
 
@@ -115,14 +112,13 @@ void nvram_write_byte(unsigned char c, i
 	__nvram_write_byte(c, i);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 }
-EXPORT_SYMBOL(nvram_write_byte);
 
 /* On PCs, the checksum is built only over bytes 2..31 */
 #define PC_CKS_RANGE_START	2
 #define PC_CKS_RANGE_END	31
 #define PC_CKS_LOC		32
 
-int __nvram_check_checksum(void)
+static int __nvram_check_checksum(void)
 {
 	int i;
 	unsigned short sum = 0;
@@ -134,19 +130,6 @@ int __nvram_check_checksum(void)
 	    __nvram_read_byte(PC_CKS_LOC+1);
 	return (sum & 0xffff) == expect;
 }
-EXPORT_SYMBOL(__nvram_check_checksum);
-
-int nvram_check_checksum(void)
-{
-	unsigned long flags;
-	int rv;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	rv = __nvram_check_checksum();
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return rv;
-}
-EXPORT_SYMBOL(nvram_check_checksum);
 
 static void __nvram_set_checksum(void)
 {
Index: linux/include/linux/nvram.h
===================================================================
--- linux.orig/include/linux/nvram.h	2015-05-31 11:01:17.000000000 +1000
+++ linux/include/linux/nvram.h	2015-05-31 11:01:21.000000000 +1000
@@ -3,14 +3,6 @@
 
 #include <uapi/linux/nvram.h>
 
-/* __foo is foo without grabbing the rtc_lock - get it yourself */
-extern unsigned char __nvram_read_byte(int i);
-extern unsigned char nvram_read_byte(int i);
-extern void __nvram_write_byte(unsigned char c, int i);
-extern void nvram_write_byte(unsigned char c, int i);
-extern int __nvram_check_checksum(void);
-extern int nvram_check_checksum(void);
-
 struct nvram_ops {
 	ssize_t         (*read)(char *, size_t, loff_t *);
 	ssize_t         (*write)(char *, size_t, loff_t *);
Index: linux/arch/m68k/atari/nvram.c
===================================================================
--- linux.orig/arch/m68k/atari/nvram.c	2015-05-31 11:01:11.000000000 +1000
+++ linux/arch/m68k/atari/nvram.c	2015-05-31 11:01:21.000000000 +1000
@@ -33,13 +33,13 @@
  * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
  */
 
-unsigned char __nvram_read_byte(int i)
+static unsigned char __nvram_read_byte(int i)
 {
 	return CMOS_READ(NVRAM_FIRST_BYTE + i);
 }
 
 /* This races nicely with trying to read with checksum checking */
-void __nvram_write_byte(unsigned char c, int i)
+static void __nvram_write_byte(unsigned char c, int i)
 {
 	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
 }
@@ -51,7 +51,7 @@ void __nvram_write_byte(unsigned char c,
 #define ATARI_CKS_RANGE_END	47
 #define ATARI_CKS_LOC		48
 
-int __nvram_check_checksum(void)
+static int __nvram_check_checksum(void)
 {
 	int i;
 	unsigned char sum = 0;
