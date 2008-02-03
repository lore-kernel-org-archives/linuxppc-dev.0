Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 61F4BDE1CD
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:10:24 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id D01518810
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 22:10:32 +0400 (SAMT)
Date: Sun, 3 Feb 2008 20:10:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/11] [POWERPC] qe_lib: implement qe_muram_offset
Message-ID: <20080203171014.GF28024@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080203170820.GA18520@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

qe_muram_offset is the reverse of the qe_muram_addr.

Also, move qe_muram_addr to the qe.h header.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    6 ------
 include/asm-powerpc/qe.h        |   11 ++++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 5ef844d..0757def 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
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
 
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 430dc77..df20f73 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -92,7 +92,16 @@ unsigned long qe_muram_alloc(int size, int align);
 int qe_muram_free(unsigned long offset);
 unsigned long qe_muram_alloc_fixed(unsigned long offset, int size);
 void qe_muram_dump(void);
-void *qe_muram_addr(unsigned long offset);
+
+static inline void *qe_muram_addr(unsigned long offset)
+{
+	return (void *)&qe_immr->muram[offset];
+}
+
+static inline unsigned long qe_muram_offset(void *addr)
+{
+	return addr - (void *)qe_immr->muram;
+}
 
 /* Structure that defines QE firmware binary files.
  *
-- 
1.5.2.2
