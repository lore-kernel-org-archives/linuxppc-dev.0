Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98014B7ECB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:53 +1100 (EST)
Message-Id: <20100218122000.504139019@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:59 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 10/15] powerpc: Convert nv_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

nv_lock needs to be a real spinlock in RT. Convert it to raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/powermac/nvram.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/nvram.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/nvram.c
@@ -80,7 +80,7 @@ static int is_core_99;
 static int core99_bank = 0;
 static int nvram_partitions[3];
 // XXX Turn that into a sem
-static DEFINE_SPINLOCK(nv_lock);
+static DEFINE_RAW_SPINLOCK(nv_lock);
 
 static int (*core99_write_bank)(int bank, u8* datas);
 static int (*core99_erase_bank)(int bank);
@@ -165,10 +165,10 @@ static unsigned char indirect_nvram_read
 	unsigned char val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&nv_lock, flags);
+	raw_spin_lock_irqsave(&nv_lock, flags);
 	out_8(nvram_addr, addr >> 5);
 	val = in_8(&nvram_data[(addr & 0x1f) << 4]);
-	spin_unlock_irqrestore(&nv_lock, flags);
+	raw_spin_unlock_irqrestore(&nv_lock, flags);
 
 	return val;
 }
@@ -177,10 +177,10 @@ static void indirect_nvram_write_byte(in
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&nv_lock, flags);
+	raw_spin_lock_irqsave(&nv_lock, flags);
 	out_8(nvram_addr, addr >> 5);
 	out_8(&nvram_data[(addr & 0x1f) << 4], val);
-	spin_unlock_irqrestore(&nv_lock, flags);
+	raw_spin_unlock_irqrestore(&nv_lock, flags);
 }
 
 
@@ -481,7 +481,7 @@ static void core99_nvram_sync(void)
 	if (!is_core_99 || !nvram_data || !nvram_image)
 		return;
 
-	spin_lock_irqsave(&nv_lock, flags);
+	raw_spin_lock_irqsave(&nv_lock, flags);
 	if (!memcmp(nvram_image, (u8*)nvram_data + core99_bank*NVRAM_SIZE,
 		NVRAM_SIZE))
 		goto bail;
@@ -503,7 +503,7 @@ static void core99_nvram_sync(void)
 		if (core99_write_bank(core99_bank, nvram_image))
 			printk("nvram: Error writing bank %d\n", core99_bank);
  bail:
-	spin_unlock_irqrestore(&nv_lock, flags);
+	raw_spin_unlock_irqrestore(&nv_lock, flags);
 
 #ifdef DEBUG
        	mdelay(2000);
