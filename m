Return-Path: <zengzhaoxiu@163.com>
Received: from m50-134.163.com (m50-134.163.com [123.125.50.134])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qg0d845lMzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 19:23:07 +1000 (AEST)
From: zengzhaoxiu@163.com
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, oss@buserror.net, christophe.leroy@c-s.fr, duwe@lst.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH v2 07/30] Add powerpc-specific parity functions
Date: Wed,  6 Apr 2016 17:03:27 +0800
Message-Id: <1459933407-6859-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <57031D9D.801@gmail.com>
References: <57031D9D.801@gmail.com>
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
 arch/powerpc/include/asm/bitops.h |  11 ++++
 arch/powerpc/lib/Makefile         |   2 +-
 arch/powerpc/lib/parity_64.S      | 107 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/ppc_ksyms.c      |   5 ++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/parity_64.S

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 59abc62..cb92783 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -269,8 +269,19 @@ unsigned int __arch_hweight16(unsigned int w);
 unsigned int __arch_hweight32(unsigned int w);
 unsigned long __arch_hweight64(__u64 w);
 #include <asm-generic/bitops/const_hweight.h>
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	w &= 0xf;
+	return (0x6996 >> w) & 1;
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
index 0000000..f8a2771
--- /dev/null
+++ b/arch/powerpc/lib/parity_64.S
@@ -0,0 +1,107 @@
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+/* Note: This code relies on -mminimal-toc */
+
+_GLOBAL(__arch_parity8)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,0x6996
+	srd	r3,r4,r3
+	clrldi	r3,r3,64-1
+	blr
+FTR_SECTION_ELSE
+	PPC_POPCNTB(R3,R3)
+	clrldi  r3,r3,64-1
+	blr
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+
+_GLOBAL(__arch_parity16)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,8
+	xor	r3,r3,r4
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,0x6996
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
+_GLOBAL(__arch_parity32)
+BEGIN_FTR_SECTION
+	srdi	r4,r3,16
+	xor	r3,r3,r4
+	srdi	r4,r3,8
+	xor	r3,r3,r4
+	srdi	r4,r3,4
+	xor	r3,r3,r4
+	clrldi	r3,r3,64-4
+	li	r4,0x6996
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
+	li	r4,0x6996
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
2.5.0
