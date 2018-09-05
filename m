Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4253B11d7mzF37V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:37:13 +1000 (AEST)
Message-Id: <d539ba8d2e9cf7eb6bc92b00b1d3d803a7542b6c.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 09/17] powerpc/mm: move __P and __S tables in the
 common pgtable.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:37:09 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__P and __S flags are the same for all platform and should remain
as is in the future, so avoid duplication.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 20 --------------------
 arch/powerpc/include/asm/pgtable.h           | 19 +++++++++++++++++++
 arch/powerpc/include/asm/pte-common.h        | 20 --------------------
 3 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 23299e1a2c08..ecb831400291 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -151,8 +151,6 @@
  * Write permissions imply read permissions for now (we could make write-only
  * pages on BookE but we don't bother for now). Execute permission control is
  * possible on platforms that define _PAGE_EXEC
- *
- * Note due to the way vm flags are laid out, the bits are XWR
  */
 #define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_PRIVILEGED)
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
@@ -162,24 +160,6 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
-
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 14c79a7dc855..fb4b85bba110 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,6 +20,25 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
+/* Note due to the way vm flags are laid out, the bits are XWR */
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READONLY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY_X
+#define __P101	PAGE_READONLY_X
+#define __P110	PAGE_COPY_X
+#define __P111	PAGE_COPY_X
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READONLY
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY_X
+#define __S101	PAGE_READONLY_X
+#define __S110	PAGE_SHARED_X
+#define __S111	PAGE_SHARED_X
+
 #ifndef __ASSEMBLY__
 
 #include <asm/tlbflush.h>
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 5a5ba43bdf98..4860dae76dae 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -139,8 +139,6 @@ static inline bool pte_user(pte_t pte)
  * Write permissions imply read permissions for now (we could make write-only
  * pages on BookE but we don't bother for now). Execute permission control is
  * possible on platforms that define _PAGE_EXEC
- *
- * Note due to the way vm flags are laid out, the bits are XWR
  */
 #define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_NA)
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
@@ -153,24 +151,6 @@ static inline bool pte_user(pte_t pte)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RO | \
 				 _PAGE_EXEC)
 
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
-
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-- 
2.13.3
