Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 275AE67C02
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:15:56 +1100 (EST)
Date: Thu, 14 Dec 2006 11:15:50 +0900 (JST)
Message-Id: <200612140215.kBE2Fp91002651@toshiba.co.jp>
Subject: [PATCH 1/19] spufs: add SPU register lock
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spu->register_lock should be held before accessing registers.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Ached-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-powerpc-git/arch/powerpc/platforms/cell/spu_base.c
diff -u linux-powerpc-git/arch/powerpc/platforms/cell/spu_base.c:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/cell/spu_base.c:1.2
--- linux-powerpc-git/arch/powerpc/platforms/cell/spu_base.c:1.1.1.1	Wed Dec  6 08:25:44 2006
+++ linux-powerpc-git/arch/powerpc/platforms/cell/spu_base.c	Thu Dec  7 16:24:53 2006
@@ -170,9 +170,11 @@
 spu_irq_class_0_bottom(struct spu *spu)
 {
 	unsigned long stat, mask;
+	unsigned long flags;
 
 	spu->class_0_pending = 0;
 
+	spin_lock_irqsave(&spu->register_lock, flags);
 	mask = spu_int_mask_get(spu, 0);
 	stat = spu_int_stat_get(spu, 0);
 
@@ -188,6 +190,7 @@
 		__spu_trap_error(spu);
 
 	spu_int_stat_clear(spu, 0, stat);
+	spin_unlock_irqrestore(&spu->register_lock, flags);
 
 	return (stat & 0x7) ? -EIO : 0;
 }
