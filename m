Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 650B1B70E1
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 10:55:38 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o720pCrF016099
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:51:12 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o720tbL61855492
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:37 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o720tba0009209
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:37 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/11] powerpc/nvram: Move things out of asm/nvram.h
Date: Mon,  2 Aug 2010 10:55:12 +1000
Message-Id: <1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves a bunch of definitions out of asm/nvram.h to the files
that use them or just outright remove completely unused stuff.

We leave the partition signatures definitions, they will be useful

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/nvram.h       |   42 +------------------------------
 arch/powerpc/kernel/nvram_64.c         |   21 +++++++++++++++-
 arch/powerpc/platforms/chrp/time.c     |    4 +++
 arch/powerpc/platforms/pseries/nvram.c |    2 +
 4 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 850b72f..459dc09 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -10,31 +10,7 @@
 #ifndef _ASM_POWERPC_NVRAM_H
 #define _ASM_POWERPC_NVRAM_H
 
-#include <linux/errno.h>
-
-#define NVRW_CNT 0x20
-#define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
-#define NVRAM_BLOCK_LEN 16
-#define NVRAM_MAX_REQ (2080/NVRAM_BLOCK_LEN)
-#define NVRAM_MIN_REQ (1056/NVRAM_BLOCK_LEN)
-
-#define NVRAM_AS0  0x74
-#define NVRAM_AS1  0x75
-#define NVRAM_DATA 0x77
-
-
-/* RTC Offsets */
-
-#define MOTO_RTC_SECONDS	0x1FF9
-#define MOTO_RTC_MINUTES	0x1FFA
-#define MOTO_RTC_HOURS		0x1FFB
-#define MOTO_RTC_DAY_OF_WEEK	0x1FFC
-#define MOTO_RTC_DAY_OF_MONTH	0x1FFD
-#define MOTO_RTC_MONTH		0x1FFE
-#define MOTO_RTC_YEAR		0x1FFF
-#define MOTO_RTC_CONTROLA       0x1FF8
-#define MOTO_RTC_CONTROLB       0x1FF9
-
+/* Signatures for nvram partitions */
 #define NVRAM_SIG_SP	0x02	/* support processor */
 #define NVRAM_SIG_OF	0x50	/* open firmware config */
 #define NVRAM_SIG_FW	0x51	/* general firmware */
@@ -49,25 +25,11 @@
 #define NVRAM_SIG_OS	0xa0	/* OS defined */
 #define NVRAM_SIG_PANIC	0xa1	/* Apple OSX "panic" */
 
-/* If change this size, then change the size of NVNAME_LEN */
-struct nvram_header {
-	unsigned char signature;
-	unsigned char checksum;
-	unsigned short length;
-	char name[12];
-};
-
 #ifdef __KERNEL__
 
+#include <linux/errno.h>
 #include <linux/list.h>
 
-struct nvram_partition {
-	struct list_head partition;
-	struct nvram_header header;
-	unsigned int index;
-};
-
-
 extern int nvram_write_error_log(char * buff, int length,
 					 unsigned int err_type, unsigned int err_seq);
 extern int nvram_read_error_log(char * buff, int length,
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 9cf197f..a8154f1 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -34,6 +34,25 @@
 
 #undef DEBUG_NVRAM
 
+#define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
+#define NVRAM_BLOCK_LEN 16
+#define NVRAM_MAX_REQ (2080/NVRAM_BLOCK_LEN)
+#define NVRAM_MIN_REQ (1056/NVRAM_BLOCK_LEN)
+
+/* If change this size, then change the size of NVNAME_LEN */
+struct nvram_header {
+	unsigned char signature;
+	unsigned char checksum;
+	unsigned short length;
+	char name[12];
+};
+
+struct nvram_partition {
+	struct list_head partition;
+	struct nvram_header header;
+	unsigned int index;
+};
+
 static struct nvram_partition * nvram_part;
 static long nvram_error_log_index = -1;
 static long nvram_error_log_size = 0;
@@ -432,7 +451,7 @@ static int __init nvram_setup_partition(void)
 	}
 	
 	/* try creating a partition with the free space we have */
-	rc = nvram_create_os_partition();
+	rc = nvram_create_partition("ppc64,linux", );
 	if (!rc) {
 		return 0;
 	}
diff --git a/arch/powerpc/platforms/chrp/time.c b/arch/powerpc/platforms/chrp/time.c
index 054dfe5..f803f4b 100644
--- a/arch/powerpc/platforms/chrp/time.c
+++ b/arch/powerpc/platforms/chrp/time.c
@@ -29,6 +29,10 @@
 
 extern spinlock_t rtc_lock;
 
+#define NVRAM_AS0  0x74
+#define NVRAM_AS1  0x75
+#define NVRAM_DATA 0x77
+
 static int nvram_as1 = NVRAM_AS1;
 static int nvram_as0 = NVRAM_AS0;
 static int nvram_data = NVRAM_DATA;
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index bc3c7f2..f4e4c06 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -27,6 +27,8 @@ static int nvram_fetch, nvram_store;
 static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
 static DEFINE_SPINLOCK(nvram_lock);
 
+/* Max bytes to read/write in one go */
+#define NVRW_CNT 0x20
 
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
-- 
1.6.3.3
