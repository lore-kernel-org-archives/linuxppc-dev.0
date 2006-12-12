Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 229A767BED
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 14:04:06 +1100 (EST)
Date: Tue, 12 Dec 2006 12:03:57 +0900 (JST)
Message-Id: <200612120303.kBC33vDC016599@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [1/17] cell: SPU register lock
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spu->register_lock should be held before accessing registers.

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
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
