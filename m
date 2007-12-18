Return-Path: <arnd@arndb.de>
Message-Id: <20071218175105.880633000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:04 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 12/18] cell: export force_sig_info()
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Export force_sig_info to allow signals to be sent from a modular spufs.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_base.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
@@ -47,6 +47,13 @@ struct cbe_spu_info cbe_spu_info[MAX_NUM
 EXPORT_SYMBOL_GPL(cbe_spu_info);
 
 /*
+ * The spufs fault-handling code needs to call force_sig_info to raise signals
+ * on DMA errors. Export it here to avoid general kernel-wide access to this
+ * function
+ */
+EXPORT_SYMBOL_GPL(force_sig_info);
+
+/*
  * Protects cbe_spu_info and spu->number.
  */
 static DEFINE_SPINLOCK(spu_lock);

-- 
