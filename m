Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18974B811F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:54:54 +1100 (EST)
Message-Id: <20091015085329.251578320@linutronix.de>
Date: Thu, 15 Oct 2009 08:54:46 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 3/3] powerpc: Mark init code __init in nvram_64
References: <20091015085253.295880694@linutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark all functions which are only called from nvram_init() __init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/nvram_64.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/nvram_64.c
+++ linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
@@ -184,7 +184,7 @@ static struct miscdevice nvram_dev = {
 
 
 #ifdef DEBUG_NVRAM
-static void nvram_print_partitions(char * label)
+static void __init nvram_print_partitions(char * label)
 {
 	struct list_head * p;
 	struct nvram_partition * tmp_part;
@@ -202,7 +202,7 @@ static void nvram_print_partitions(char 
 #endif
 
 
-static int nvram_write_header(struct nvram_partition * part)
+static int __init nvram_write_header(struct nvram_partition * part)
 {
 	loff_t tmp_index;
 	int rc;
@@ -214,7 +214,7 @@ static int nvram_write_header(struct nvr
 }
 
 
-static unsigned char nvram_checksum(struct nvram_header *p)
+static unsigned char __init nvram_checksum(struct nvram_header *p)
 {
 	unsigned int c_sum, c_sum2;
 	unsigned short *sp = (unsigned short *)p->name; /* assume 6 shorts */
@@ -228,7 +228,7 @@ static unsigned char nvram_checksum(stru
 	return c_sum;
 }
 
-static int nvram_remove_os_partition(void)
+static int __init nvram_remove_os_partition(void)
 {
 	struct list_head *i;
 	struct list_head *j;
@@ -294,7 +294,7 @@ static int nvram_remove_os_partition(voi
  * Will create a partition starting at the first free
  * space found if space has enough room.
  */
-static int nvram_create_os_partition(void)
+static int __init nvram_create_os_partition(void)
 {
 	struct nvram_partition *part;
 	struct nvram_partition *new_part;
@@ -397,7 +397,7 @@ static int nvram_create_os_partition(voi
  * 5.) If the max chunk cannot be allocated then try finding a chunk
  * that will satisfy the minum needed (NVRAM_MIN_REQ).
  */
-static int nvram_setup_partition(void)
+static int __init nvram_setup_partition(void)
 {
 	struct list_head * p;
 	struct nvram_partition * part;
@@ -455,7 +455,7 @@ static int nvram_setup_partition(void)
 }
 
 
-static int nvram_scan_partitions(void)
+static int __init nvram_scan_partitions(void)
 {
 	loff_t cur_index = 0;
 	struct nvram_header phead;
