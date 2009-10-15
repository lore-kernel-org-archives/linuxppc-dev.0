Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6837FB7CAB
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:54:45 +1100 (EST)
Message-Id: <20091015085329.156698728@linutronix.de>
Date: Thu, 15 Oct 2009 08:54:36 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 1/3] powerpc: Remove unused code
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

nvram_find_partition() has no user. The call site was removed in the
arch/powerpc move, but the function stayed. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/include/asm/nvram.h |    1 -
 arch/powerpc/kernel/nvram_64.c   |   25 -------------------------
 2 files changed, 26 deletions(-)

Index: linux-2.6-tip/arch/powerpc/include/asm/nvram.h
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/include/asm/nvram.h
+++ linux-2.6-tip/arch/powerpc/include/asm/nvram.h
@@ -73,7 +73,6 @@ extern int nvram_write_error_log(char * 
 extern int nvram_read_error_log(char * buff, int length,
 					 unsigned int * err_type, unsigned int *err_seq);
 extern int nvram_clear_error_log(void);
-extern struct nvram_partition *nvram_find_partition(int sig, const char *name);
 
 extern int pSeries_nvram_init(void);
 
Index: linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/nvram_64.c
+++ linux-2.6-tip/arch/powerpc/kernel/nvram_64.c
@@ -228,31 +228,6 @@ static unsigned char nvram_checksum(stru
 	return c_sum;
 }
 
-
-/*
- * Find an nvram partition, sig can be 0 for any
- * partition or name can be NULL for any name, else
- * tries to match both
- */
-struct nvram_partition *nvram_find_partition(int sig, const char *name)
-{
-	struct nvram_partition * part;
-	struct list_head * p;
-
-	list_for_each(p, &nvram_part->partition) {
-		part = list_entry(p, struct nvram_partition, partition);
-
-		if (sig && part->header.signature != sig)
-			continue;
-		if (name && 0 != strncmp(name, part->header.name, 12))
-			continue;
-		return part; 
-	}
-	return NULL;
-}
-EXPORT_SYMBOL(nvram_find_partition);
-
-
 static int nvram_remove_os_partition(void)
 {
 	struct list_head *i;
