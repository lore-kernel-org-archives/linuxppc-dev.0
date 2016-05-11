Return-Path: <zengzhaoxiu@163.com>
Received: from m50-133.163.com (m50-133.163.com [123.125.50.133])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r4W5l208JzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 19:28:58 +1000 (AEST)
From: zengzhaoxiu@163.com
To: linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Scott Wood <oss@buserror.net>,
 Torsten Duwe <duwe@lst.de>, Christophe Leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org
Subject: [patch V4 07/31] bitops: Add powerpc-specific parity functions
Date: Wed, 11 May 2016 17:11:07 +0800
Message-Id: <1462957897-24593-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Use runtime patching for ppc64, lifted from hweight_64

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 arch/powerpc/include/asm/bitops.h |  11 +++
 arch/powerpc/lib/Makefile         |   2 +-
 arch/powerpc/lib/parity_64.S      | 143 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/ppc_ksyms.c      |   5 ++
 4 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/parity_64.S

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc62..cd34030 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -269,8 +269,19 @@ unsigned int __arch_hweight16(unsigned int w);
 unsigned int __arch_hweight32(unsigned int w);
 unsigned long __arch_hweight64(__u64 w);
 #include <asm-generic/bitops/const_hweight.h>
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	w &= 0xf;
+	return ((PARITY_MAGIC) >> w) & 1;
+}
+unsigned int __arch_parity8(unsigned int w);
+unsigned int __arch_parity16(unsigned int w);
+unsigned int __arch_parity32(unsigned int w);
+unsigned int __arch_parity64(__u64 w);
+#include <asm-generic/bitops/const_parity.h>
 #else
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #endif
 
 #include <asm-generic/bitops/find.h>
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index ba21be1..cae2e7f 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
 obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
 	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
-	   memcpy_64.o memcmp_64.o
+	   memcpy_64.o memcmp_64.o parity_64.o
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
diff --git a/arch/powerpc/lib/parity_64.S b/arch/powerpc/lib/parity_64.S
new file mode 100644
index 0000000..3586a39
--- /dev/null
+++ b/arch/powerpc/lib/parity_64.S
@@ -0,0 +1,143 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+/*
+ * This file contains the generic code to calculate the parity
+ * of N-bits number, and the POPCNT feature sections.
+ *
+ * Note: This code relies on -mminimal-toc
+ */
+
+#define PARITY_MAGIC 0x6996
+
+/*
+ * unsigned int __arch_parity8(unsigned int w)
+ */
+_GLOBAL(__arch_parity8)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,PARITY_MAGIC
+	srd	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+FTR_SECTION_ELSE
+	PPC_POPCNTB(R3,R3)
+	clrldi  r3,r3,64-1
+	blr
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+/*
+ * unsigned int __arch_parity16(unsigned int w)
+ */
+_GLOBAL(__arch_parity16)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,8
+	xor	r3,r3,r4
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,PARITY_MAGIC
+	srd	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+FTR_SECTION_ELSE
+  BEGIN_FTR_SECTION_NESTED(50)
+	PPC_POPCNTB(R3,R3)
+	srdi	r4,r3,8
+	add	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+  FTR_SECTION_ELSE_NESTED(50)
+	clrlwi  r3,r3,16
+	PPC_POPCNTW(R3,R3)
+	clrldi	r3,r3,64-1
+	blr
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 50)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+/*
+ * unsigned int __arch_parity32(unsigned int w)
+ */
+_GLOBAL(__arch_parity32)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,16
+	xor	r3,r3,r4
+	srdi	r4,r3,8
+	xor	r3,r3,r4
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,PARITY_MAGIC
+	srd	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+FTR_SECTION_ELSE
+  BEGIN_FTR_SECTION_NESTED(51)
+	PPC_POPCNTB(R3,R3)
+	srdi	r4,r3,16
+	add	r3,r4,r3
+	srdi	r4,r3,8
+	add	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+  FTR_SECTION_ELSE_NESTED(51)
+	PPC_POPCNTW(R3,R3)
+	clrldi	r3,r3,64-1
+	blr
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 51)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+/*
+ * unsigned int __arch_parity64(__u64 w)
+ */
+_GLOBAL(__arch_parity64)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,32
+	xor	r3,r3,r4
+	srdi	r4,r3,16
+	xor	r3,r3,r4
+	srdi	r4,r3,8
+	xor	r3,r3,r4
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,PARITY_MAGIC
+	srd	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+FTR_SECTION_ELSE
+  BEGIN_FTR_SECTION_NESTED(52)
+	PPC_POPCNTB(R3,R3)
+	srdi	r4,r3,32
+	add	r3,r4,r3
+	srdi	r4,r3,16
+	add	r3,r4,r3
+	srdi	r4,r3,8
+	add	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+  FTR_SECTION_ELSE_NESTED(52)
+	PPC_POPCNTD(R3,R3)
+	clrldi	r3,r3,64-1
+	blr
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 52)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
diff --git a/arch/powerpc/lib/ppc_ksyms.c b/arch/powerpc/lib/ppc_ksyms.c
index c422812..1ccfc29 100644
--- a/arch/powerpc/lib/ppc_ksyms.c
+++ b/arch/powerpc/lib/ppc_ksyms.c
@@ -30,4 +30,9 @@ EXPORT_SYMBOL(__arch_hweight8);
 EXPORT_SYMBOL(__arch_hweight16);
 EXPORT_SYMBOL(__arch_hweight32);
 EXPORT_SYMBOL(__arch_hweight64);
+
+EXPORT_SYMBOL(__arch_parity8);
+EXPORT_SYMBOL(__arch_parity16);
+EXPORT_SYMBOL(__arch_parity32);
+EXPORT_SYMBOL(__arch_parity64);
 #endif
-- 
2.7.4
