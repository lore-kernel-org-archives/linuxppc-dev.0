Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXkpj5v43zDsyc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:40:29 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 3so18116151pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 17:40:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: tidy up after exception handler rework
Date: Tue,  6 Dec 2016 11:40:15 +1000
Message-Id: <20161206014015.10937-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Somewhere along the line, search/replace left some naming garbled,
and untidy alignment. Might as well fix them all up now while git
blame history doesn't extend too far.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/head-64.h   | 160 +++++++++++++++++------------------
 arch/powerpc/kernel/exceptions-64s.S |   2 +-
 2 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index fca7033..c691fc2 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -102,7 +102,7 @@ end_##sname:
 #define FIXED_SECTION_ENTRY_BEGIN(sname, name)			\
 	__FIXED_SECTION_ENTRY_BEGIN(sname, name, IFETCH_ALIGN_BYTES)
 
-#define FIXED_SECTION_ENTRY_BEGIN_LOCATION(sname, name, start)		\
+#define FIXED_SECTION_ENTRY_BEGIN_LOCATION(sname, name, start)	\
 	USE_FIXED_SECTION(sname);				\
 	name##_start = (start);					\
 	.if (start) < sname##_start;				\
@@ -113,7 +113,7 @@ end_##sname:
 	.global name;						\
 name:
 
-#define FIXED_SECTION_ENTRY_END_LOCATION(sname, name, end)		\
+#define FIXED_SECTION_ENTRY_END_LOCATION(sname, name, end)	\
 	.if (end) > sname##_end;				\
 	.error "Fixed section overflow";			\
 	.abort;							\
@@ -147,12 +147,12 @@ end_##sname:
  * Following are the BOOK3S exception handler helper macros.
  * Handlers come in a number of types, and each type has a number of varieties.
  *
- * EXC_REAL_*        - real, unrelocated exception vectors
- * EXC_VIRT_*        - virt (AIL), unrelocated exception vectors
+ * EXC_REAL_*     - real, unrelocated exception vectors
+ * EXC_VIRT_*     - virt (AIL), unrelocated exception vectors
  * TRAMP_REAL_*   - real, unrelocated helpers (virt can call these)
- * TRAMP_VIRT_*  - virt, unreloc helpers (in practice, real can use)
- * TRAMP_KVM         - KVM handlers that get put into real, unrelocated
- * EXC_COMMON_*  - virt, relocated common handlers
+ * TRAMP_VIRT_*   - virt, unreloc helpers (in practice, real can use)
+ * TRAMP_KVM      - KVM handlers that get put into real, unrelocated
+ * EXC_COMMON_*   - virt, relocated common handlers
  *
  * The EXC handlers are given a name, and branch to name_common, or the
  * appropriate KVM or masking function. Vector handler verieties are as
@@ -194,20 +194,20 @@ end_##sname:
 #define EXC_REAL_BEGIN(name, start, end)			\
 	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##name, start)
 
-#define EXC_REAL_END(name, start, end)			\
+#define EXC_REAL_END(name, start, end)				\
 	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##name, end)
 
 #define EXC_VIRT_BEGIN(name, start, end)			\
 	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##name, start)
 
-#define EXC_VIRT_END(name, start, end)			\
+#define EXC_VIRT_END(name, start, end)				\
 	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##name, end)
 
-#define EXC_COMMON_BEGIN(name)						\
-	USE_TEXT_SECTION();						\
-	.balign IFETCH_ALIGN_BYTES;					\
-	.global name;							\
-	DEFINE_FIXED_SYMBOL(name);					\
+#define EXC_COMMON_BEGIN(name)					\
+	USE_TEXT_SECTION();					\
+	.balign IFETCH_ALIGN_BYTES;				\
+	.global name;						\
+	DEFINE_FIXED_SYMBOL(name);				\
 name:
 
 #define TRAMP_REAL_BEGIN(name)					\
@@ -217,7 +217,7 @@ end_##sname:
 	FIXED_SECTION_ENTRY_BEGIN(virt_trampolines, name)
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-#define TRAMP_KVM_BEGIN(name)						\
+#define TRAMP_KVM_BEGIN(name)					\
 	TRAMP_REAL_BEGIN(name)
 #else
 #define TRAMP_KVM_BEGIN(name)
@@ -232,132 +232,132 @@ end_##sname:
 	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, end);
 
 
-#define EXC_REAL(name, start, end)				\
-	EXC_REAL_BEGIN(name, start, end);			\
+#define EXC_REAL(name, start, end)					\
+	EXC_REAL_BEGIN(name, start, end);				\
 	STD_EXCEPTION_PSERIES(start, name##_common);			\
 	EXC_REAL_END(name, start, end);
 
-#define EXC_VIRT(name, start, end, realvec)			\
-	EXC_VIRT_BEGIN(name, start, end);			\
+#define EXC_VIRT(name, start, end, realvec)				\
+	EXC_VIRT_BEGIN(name, start, end);				\
 	STD_RELON_EXCEPTION_PSERIES(start, realvec, name##_common);	\
 	EXC_VIRT_END(name, start, end);
 
-#define EXC_REAL_MASKABLE(name, start, end)			\
-	EXC_REAL_BEGIN(name, start, end);			\
+#define EXC_REAL_MASKABLE(name, start, end)				\
+	EXC_REAL_BEGIN(name, start, end);				\
 	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common);	\
 	EXC_REAL_END(name, start, end);
 
-#define EXC_VIRT_MASKABLE(name, start, end, realvec)		\
-	EXC_VIRT_BEGIN(name, start, end);			\
+#define EXC_VIRT_MASKABLE(name, start, end, realvec)			\
+	EXC_VIRT_BEGIN(name, start, end);				\
 	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common); \
 	EXC_VIRT_END(name, start, end);
 
-#define EXC_REAL_HV(name, start, end)			\
-	EXC_REAL_BEGIN(name, start, end);			\
+#define EXC_REAL_HV(name, start, end)					\
+	EXC_REAL_BEGIN(name, start, end);				\
 	STD_EXCEPTION_HV(start, start, name##_common);			\
 	EXC_REAL_END(name, start, end);
 
-#define EXC_VIRT_HV(name, start, end, realvec)		\
-	EXC_VIRT_BEGIN(name, start, end);			\
+#define EXC_VIRT_HV(name, start, end, realvec)				\
+	EXC_VIRT_BEGIN(name, start, end);				\
 	STD_RELON_EXCEPTION_HV(start, realvec, name##_common);		\
 	EXC_VIRT_END(name, start, end);
 
-#define __EXC_REAL_OOL(name, start, end)			\
-	EXC_REAL_BEGIN(name, start, end);			\
+#define __EXC_REAL_OOL(name, start, end)				\
+	EXC_REAL_BEGIN(name, start, end);				\
 	__OOL_EXCEPTION(start, label, tramp_real_##name);		\
 	EXC_REAL_END(name, start, end);
 
-#define __TRAMP_REAL_REAL_OOL(name, vec)				\
+#define __TRAMP_REAL_OOL(name, vec)					\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_PSERIES_OOL(vec, name##_common);			\
 
-#define EXC_REAL_OOL(name, start, end)			\
-	__EXC_REAL_OOL(name, start, end);			\
-	__TRAMP_REAL_REAL_OOL(name, start);
+#define EXC_REAL_OOL(name, start, end)					\
+	__EXC_REAL_OOL(name, start, end);				\
+	__TRAMP_REAL_OOL(name, start);
 
-#define __EXC_REAL_OOL_MASKABLE(name, start, end)		\
+#define __EXC_REAL_OOL_MASKABLE(name, start, end)			\
 	__EXC_REAL_OOL(name, start, end);
 
-#define __TRAMP_REAL_REAL_OOL_MASKABLE(name, vec)			\
+#define __TRAMP_REAL_OOL_MASKABLE(name, vec)				\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
 
-#define EXC_REAL_OOL_MASKABLE(name, start, end)		\
-	__EXC_REAL_OOL_MASKABLE(name, start, end);		\
-	__TRAMP_REAL_REAL_OOL_MASKABLE(name, start);
+#define EXC_REAL_OOL_MASKABLE(name, start, end)				\
+	__EXC_REAL_OOL_MASKABLE(name, start, end);			\
+	__TRAMP_REAL_OOL_MASKABLE(name, start);
 
-#define __EXC_REAL_OOL_HV_DIRECT(name, start, end, handler)	\
-	EXC_REAL_BEGIN(name, start, end);			\
+#define __EXC_REAL_OOL_HV_DIRECT(name, start, end, handler)		\
+	EXC_REAL_BEGIN(name, start, end);				\
 	__OOL_EXCEPTION(start, label, handler);				\
 	EXC_REAL_END(name, start, end);
 
-#define __EXC_REAL_OOL_HV(name, start, end)			\
+#define __EXC_REAL_OOL_HV(name, start, end)				\
 	__EXC_REAL_OOL(name, start, end);
 
-#define __TRAMP_REAL_REAL_OOL_HV(name, vec)				\
+#define __TRAMP_REAL_OOL_HV(name, vec)					\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_HV_OOL(vec, name##_common);			\
 
-#define EXC_REAL_OOL_HV(name, start, end)			\
-	__EXC_REAL_OOL_HV(name, start, end);			\
-	__TRAMP_REAL_REAL_OOL_HV(name, start);
+#define EXC_REAL_OOL_HV(name, start, end)				\
+	__EXC_REAL_OOL_HV(name, start, end);				\
+	__TRAMP_REAL_OOL_HV(name, start);
 
-#define __EXC_REAL_OOL_MASKABLE_HV(name, start, end)		\
+#define __EXC_REAL_OOL_MASKABLE_HV(name, start, end)			\
 	__EXC_REAL_OOL(name, start, end);
 
-#define __TRAMP_REAL_REAL_OOL_MASKABLE_HV(name, vec)			\
+#define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec)				\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
 
-#define EXC_REAL_OOL_MASKABLE_HV(name, start, end)		\
-	__EXC_REAL_OOL_MASKABLE_HV(name, start, end);	\
-	__TRAMP_REAL_REAL_OOL_MASKABLE_HV(name, start);
+#define EXC_REAL_OOL_MASKABLE_HV(name, start, end)			\
+	__EXC_REAL_OOL_MASKABLE_HV(name, start, end);			\
+	__TRAMP_REAL_OOL_MASKABLE_HV(name, start);
 
-#define __EXC_VIRT_OOL(name, start, end)			\
-	EXC_VIRT_BEGIN(name, start, end);			\
+#define __EXC_VIRT_OOL(name, start, end)				\
+	EXC_VIRT_BEGIN(name, start, end);				\
 	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
 	EXC_VIRT_END(name, start, end);
 
-#define __TRAMP_REAL_VIRT_OOL(name, realvec)				\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
+#define __TRAMP_VIRT_OOL(name, realvec)					\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
 
-#define EXC_VIRT_OOL(name, start, end, realvec)		\
-	__EXC_VIRT_OOL(name, start, end);			\
-	__TRAMP_REAL_VIRT_OOL(name, realvec);
+#define EXC_VIRT_OOL(name, start, end, realvec)				\
+	__EXC_VIRT_OOL(name, start, end);				\
+	__TRAMP_VIRT_OOL(name, realvec);
 
-#define __EXC_VIRT_OOL_MASKABLE(name, start, end)		\
+#define __EXC_VIRT_OOL_MASKABLE(name, start, end)			\
 	__EXC_VIRT_OOL(name, start, end);
 
-#define __TRAMP_REAL_VIRT_OOL_MASKABLE(name, realvec)		\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
+#define __TRAMP_VIRT_OOL_MASKABLE(name, realvec)			\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
 
-#define EXC_VIRT_OOL_MASKABLE(name, start, end, realvec)	\
-	__EXC_VIRT_OOL_MASKABLE(name, start, end);		\
-	__TRAMP_REAL_VIRT_OOL_MASKABLE(name, realvec);
+#define EXC_VIRT_OOL_MASKABLE(name, start, end, realvec)		\
+	__EXC_VIRT_OOL_MASKABLE(name, start, end);			\
+	__TRAMP_VIRT_OOL_MASKABLE(name, realvec);
 
-#define __EXC_VIRT_OOL_HV(name, start, end)			\
+#define __EXC_VIRT_OOL_HV(name, start, end)				\
 	__EXC_VIRT_OOL(name, start, end);
 
-#define __TRAMP_REAL_VIRT_OOL_HV(name, realvec)			\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
+#define __TRAMP_VIRT_OOL_HV(name, realvec)				\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
 
-#define EXC_VIRT_OOL_HV(name, start, end, realvec)		\
-	__EXC_VIRT_OOL_HV(name, start, end);			\
-	__TRAMP_REAL_VIRT_OOL_HV(name, realvec);
+#define EXC_VIRT_OOL_HV(name, start, end, realvec)			\
+	__EXC_VIRT_OOL_HV(name, start, end);				\
+	__TRAMP_VIRT_OOL_HV(name, realvec);
 
-#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, end)		\
+#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, end)			\
 	__EXC_VIRT_OOL(name, start, end);
 
-#define __TRAMP_REAL_VIRT_OOL_MASKABLE_HV(name, realvec)		\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
+#define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec)			\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
 
-#define EXC_VIRT_OOL_MASKABLE_HV(name, start, end, realvec)	\
-	__EXC_VIRT_OOL_MASKABLE_HV(name, start, end);	\
-	__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(name, realvec);
+#define EXC_VIRT_OOL_MASKABLE_HV(name, start, end, realvec)		\
+	__EXC_VIRT_OOL_MASKABLE_HV(name, start, end);			\
+	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec);
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
@@ -378,16 +378,16 @@ end_##sname:
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
 	KVM_HANDLER_SKIP(area, EXC_HV, n + 0x2);			\
 
-#define EXC_COMMON(name, realvec, hdlr)				\
-	EXC_COMMON_BEGIN(name);					\
+#define EXC_COMMON(name, realvec, hdlr)					\
+	EXC_COMMON_BEGIN(name);						\
 	STD_EXCEPTION_COMMON(realvec, name, hdlr);			\
 
-#define EXC_COMMON_ASYNC(name, realvec, hdlr)			\
-	EXC_COMMON_BEGIN(name);					\
+#define EXC_COMMON_ASYNC(name, realvec, hdlr)				\
+	EXC_COMMON_BEGIN(name);						\
 	STD_EXCEPTION_COMMON_ASYNC(realvec, name, hdlr);		\
 
 #define EXC_COMMON_HV(name, realvec, hdlr)				\
-	EXC_COMMON_BEGIN(name);					\
+	EXC_COMMON_BEGIN(name);						\
 	STD_EXCEPTION_COMMON(realvec + 0x2, name, hdlr);		\
 
 #endif	/* _ASM_POWERPC_HEAD_64_H */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d39d611..597c1b0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -960,7 +960,7 @@ EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
  * mode.
  */
 __EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
-__TRAMP_REAL_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
+__TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
 EXC_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
-- 
2.10.2
