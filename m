Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9C72BDE952
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 04:24:15 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id E6EA68810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:24:26 +0400 (SAMT)
Date: Tue, 11 Mar 2008 20:24:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] [POWERPC] qe_lib: implement qe_muram_offset
Message-ID: <20080311172413.GC7727@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311172106.GA4766@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

qe_muram_offset is the reverse of the qe_muram_addr, will be
used for the Freescale QE USB Host Controller driver.

This patch also moves qe_muram_addr into the qe.h header, plus
adds __iomem hints to use with sparse.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    8 +-------
 include/asm-powerpc/immap_qe.h  |    2 +-
 include/asm-powerpc/qe.h        |   11 ++++++++++-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 6efbd5e..b444b1d 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -55,7 +55,7 @@ struct qe_snum {
 /* We allocate this here because it is used almost exclusively for
  * the communication processor devices.
  */
-struct qe_immap *qe_immr = NULL;
+struct qe_immap __iomem *qe_immr;
 EXPORT_SYMBOL(qe_immr);
 
 static struct qe_snum snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
@@ -415,12 +415,6 @@ void qe_muram_dump(void)
 }
 EXPORT_SYMBOL(qe_muram_dump);
 
-void *qe_muram_addr(unsigned long offset)
-{
-	return (void *)&qe_immr->muram[offset];
-}
-EXPORT_SYMBOL(qe_muram_addr);
-
 /* The maximum number of RISCs we support */
 #define MAX_QE_RISC     2
 
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 82a4526..924aefb 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -468,7 +468,7 @@ struct qe_immap {
 	u8			res18[0xC0000];	/* 0x140000 - 0x200000 */
 } __attribute__ ((packed));
 
-extern struct qe_immap *qe_immr;
+extern struct qe_immap __iomem *qe_immr;
 extern phys_addr_t get_qe_base(void);
 
 static inline unsigned long immrbar_virt_to_phys(void *address)
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 430dc77..398534c 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -92,7 +92,16 @@ unsigned long qe_muram_alloc(int size, int align);
 int qe_muram_free(unsigned long offset);
 unsigned long qe_muram_alloc_fixed(unsigned long offset, int size);
 void qe_muram_dump(void);
-void *qe_muram_addr(unsigned long offset);
+
+static inline void __iomem *qe_muram_addr(unsigned long offset)
+{
+	return (void __iomem *)&qe_immr->muram[offset];
+}
+
+static inline unsigned long qe_muram_offset(void __iomem *addr)
+{
+	return addr - (void __iomem *)qe_immr->muram;
+}
 
 /* Structure that defines QE firmware binary files.
  *
-- 
1.5.2.2
