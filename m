Return-Path: <chengang@emindsoft.com.cn>
Received: from out1134-241.mail.aliyun.com (out1134-241.mail.aliyun.com
 [42.120.134.241])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rxr4n1PHFzDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 13:50:16 +1000 (AEST)
From: chengang@emindsoft.com.cn
To: akpm@linux-foundation.org,
	benh@kernel.crashing.org,
	paulus@samba.org
Cc: mpe@ellerman.id.au, dave.hansen@linux.intel.com, tglx@linutronix.de,
 mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chen Gang <chengang@emindsoft.com.cn>,
 Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH v2] include: mman: Use bool instead of int for the return
 value of arch_validate_prot
Date: Sun, 24 Jul 2016 11:43:35 +0800
Message-Id: <1469331815-2026-1-git-send-email-chengang@emindsoft.com.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chen Gang <chengang@emindsoft.com.cn>

For pure bool function's return value, bool is a little better more or
less than int.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/powerpc/include/asm/mman.h | 8 ++++----
 include/linux/mman.h            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 2563c43..fc420ce 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -31,13 +31,13 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
-static inline int arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
-		return 0;
+		return false;
 	if ((prot & PROT_SAO) && !cpu_has_feature(CPU_FTR_SAO))
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 #define arch_validate_prot(prot) arch_validate_prot(prot)
 
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 33e17f6..634c4c5 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -49,7 +49,7 @@ static inline void vm_unacct_memory(long pages)
  *
  * Returns true if the prot flags are valid
  */
-static inline int arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot)
 {
 	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
 }
-- 
1.9.3
