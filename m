Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXkqn5N4WzDw1N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:41:25 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 3so18118394pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 17:41:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC][PATCH] powerpc/64s: use start, size rather than start,
 end for exception handlers
Date: Tue,  6 Dec 2016 11:41:12 +1000
Message-Id: <20161206014112.11201-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

start,size has the benefit of being easier to search for (start,end
usually gives you the preceeding vector from the one you want, as first
result).

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/head-64.h   | 158 ++++++++++++++--------------
 arch/powerpc/kernel/exceptions-64s.S | 195 ++++++++++++++++++-----------------
 2 files changed, 185 insertions(+), 168 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index c691fc2..a475711 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -38,8 +38,8 @@
  *     li  r10,128
  *     mv  r11,r10
 
- * FIXED_SECTION_ENTRY_BEGIN_LOCATION(section_name, label2, start_address)
- * FIXED_SECTION_ENTRY_END_LOCATION(section_name, label2, end_address)
+ * FIXED_SECTION_ENTRY_BEGIN_LOCATION(section_name, label2, start_address, size)
+ * FIXED_SECTION_ENTRY_END_LOCATION(section_name, label2, start_address, size)
  * CLOSE_FIXED_SECTION(section_name)
  *
  * ZERO_FIXED_SECTION can be used to emit zeroed data.
@@ -102,9 +102,15 @@ end_##sname:
 #define FIXED_SECTION_ENTRY_BEGIN(sname, name)			\
 	__FIXED_SECTION_ENTRY_BEGIN(sname, name, IFETCH_ALIGN_BYTES)
 
-#define FIXED_SECTION_ENTRY_BEGIN_LOCATION(sname, name, start)	\
+#define FIXED_SECTION_ENTRY_BEGIN_LOCATION(sname, name, start, size) \
 	USE_FIXED_SECTION(sname);				\
 	name##_start = (start);					\
+	.if ((start) % (size) != 0);				\
+	.error "Fixed section exception vector misalignment";	\
+	.endif;							\
+	.if ((size) != 0x20) && ((size) != 0x80) && ((size) != 0x100); \
+	.error "Fixed section exception vector bad size";	\
+	.endif;							\
 	.if (start) < sname##_start;				\
 	.error "Fixed section underflow";			\
 	.abort;							\
@@ -113,16 +119,16 @@ end_##sname:
 	.global name;						\
 name:
 
-#define FIXED_SECTION_ENTRY_END_LOCATION(sname, name, end)	\
-	.if (end) > sname##_end;				\
+#define FIXED_SECTION_ENTRY_END_LOCATION(sname, name, start, size) \
+	.if (start) + (size) > sname##_end;			\
 	.error "Fixed section overflow";			\
 	.abort;							\
 	.endif;							\
-	.if (. - name > end - name##_start);			\
+	.if (. - name > (start) + (size) - name##_start);	\
 	.error "Fixed entry overflow";				\
 	.abort;							\
 	.endif;							\
-	. = ((end) - sname##_start);				\
+	. = ((start) + (size) - sname##_start);			\
 
 
 /*
@@ -191,17 +197,17 @@ end_##sname:
  * and OOL handlers are implemented as types of TRAMP and TRAMP_VIRT handlers.
  */
 
-#define EXC_REAL_BEGIN(name, start, end)			\
-	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##name, start)
+#define EXC_REAL_BEGIN(name, start, size)			\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##name, start, size)
 
-#define EXC_REAL_END(name, start, end)				\
-	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##name, end)
+#define EXC_REAL_END(name, start, size)				\
+	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##name, start, size)
 
-#define EXC_VIRT_BEGIN(name, start, end)			\
-	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##name, start)
+#define EXC_VIRT_BEGIN(name, start, size)			\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##name, start, size)
 
-#define EXC_VIRT_END(name, start, end)				\
-	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##name, end)
+#define EXC_VIRT_END(name, start, size)				\
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##name, start, size)
 
 #define EXC_COMMON_BEGIN(name)					\
 	USE_TEXT_SECTION();					\
@@ -223,140 +229,140 @@ end_##sname:
 #define TRAMP_KVM_BEGIN(name)
 #endif
 
-#define EXC_REAL_NONE(start, end)				\
-	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##unused, start); \
-	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##unused, end)
+#define EXC_REAL_NONE(start, size)				\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##unused, start, size); \
+	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##unused, start, size)
 
-#define EXC_VIRT_NONE(start, end)				\
-	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##unused, start); \
-	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, end);
+#define EXC_VIRT_NONE(start, size)				\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size); \
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size);
 
 
-#define EXC_REAL(name, start, end)					\
-	EXC_REAL_BEGIN(name, start, end);				\
+#define EXC_REAL(name, start, size)					\
+	EXC_REAL_BEGIN(name, start, size);				\
 	STD_EXCEPTION_PSERIES(start, name##_common);			\
-	EXC_REAL_END(name, start, end);
+	EXC_REAL_END(name, start, size);
 
-#define EXC_VIRT(name, start, end, realvec)				\
-	EXC_VIRT_BEGIN(name, start, end);				\
+#define EXC_VIRT(name, start, size, realvec)				\
+	EXC_VIRT_BEGIN(name, start, size);				\
 	STD_RELON_EXCEPTION_PSERIES(start, realvec, name##_common);	\
-	EXC_VIRT_END(name, start, end);
+	EXC_VIRT_END(name, start, size);
 
-#define EXC_REAL_MASKABLE(name, start, end)				\
-	EXC_REAL_BEGIN(name, start, end);				\
+#define EXC_REAL_MASKABLE(name, start, size)				\
+	EXC_REAL_BEGIN(name, start, size);				\
 	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common);	\
-	EXC_REAL_END(name, start, end);
+	EXC_REAL_END(name, start, size);
 
-#define EXC_VIRT_MASKABLE(name, start, end, realvec)			\
-	EXC_VIRT_BEGIN(name, start, end);				\
+#define EXC_VIRT_MASKABLE(name, start, size, realvec)			\
+	EXC_VIRT_BEGIN(name, start, size);				\
 	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common); \
-	EXC_VIRT_END(name, start, end);
+	EXC_VIRT_END(name, start, size);
 
-#define EXC_REAL_HV(name, start, end)					\
-	EXC_REAL_BEGIN(name, start, end);				\
+#define EXC_REAL_HV(name, start, size)					\
+	EXC_REAL_BEGIN(name, start, size);				\
 	STD_EXCEPTION_HV(start, start, name##_common);			\
-	EXC_REAL_END(name, start, end);
+	EXC_REAL_END(name, start, size);
 
-#define EXC_VIRT_HV(name, start, end, realvec)				\
-	EXC_VIRT_BEGIN(name, start, end);				\
+#define EXC_VIRT_HV(name, start, size, realvec)				\
+	EXC_VIRT_BEGIN(name, start, size);				\
 	STD_RELON_EXCEPTION_HV(start, realvec, name##_common);		\
-	EXC_VIRT_END(name, start, end);
+	EXC_VIRT_END(name, start, size);
 
-#define __EXC_REAL_OOL(name, start, end)				\
-	EXC_REAL_BEGIN(name, start, end);				\
+#define __EXC_REAL_OOL(name, start, size)				\
+	EXC_REAL_BEGIN(name, start, size);				\
 	__OOL_EXCEPTION(start, label, tramp_real_##name);		\
-	EXC_REAL_END(name, start, end);
+	EXC_REAL_END(name, start, size);
 
 #define __TRAMP_REAL_OOL(name, vec)					\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_PSERIES_OOL(vec, name##_common);			\
 
-#define EXC_REAL_OOL(name, start, end)					\
-	__EXC_REAL_OOL(name, start, end);				\
+#define EXC_REAL_OOL(name, start, size)					\
+	__EXC_REAL_OOL(name, start, size);				\
 	__TRAMP_REAL_OOL(name, start);
 
-#define __EXC_REAL_OOL_MASKABLE(name, start, end)			\
-	__EXC_REAL_OOL(name, start, end);
+#define __EXC_REAL_OOL_MASKABLE(name, start, size)			\
+	__EXC_REAL_OOL(name, start, size);
 
 #define __TRAMP_REAL_OOL_MASKABLE(name, vec)				\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
 
-#define EXC_REAL_OOL_MASKABLE(name, start, end)				\
-	__EXC_REAL_OOL_MASKABLE(name, start, end);			\
+#define EXC_REAL_OOL_MASKABLE(name, start, size)			\
+	__EXC_REAL_OOL_MASKABLE(name, start, size);			\
 	__TRAMP_REAL_OOL_MASKABLE(name, start);
 
-#define __EXC_REAL_OOL_HV_DIRECT(name, start, end, handler)		\
-	EXC_REAL_BEGIN(name, start, end);				\
+#define __EXC_REAL_OOL_HV_DIRECT(name, start, size, handler)		\
+	EXC_REAL_BEGIN(name, start, size);				\
 	__OOL_EXCEPTION(start, label, handler);				\
-	EXC_REAL_END(name, start, end);
+	EXC_REAL_END(name, start, size);
 
-#define __EXC_REAL_OOL_HV(name, start, end)				\
-	__EXC_REAL_OOL(name, start, end);
+#define __EXC_REAL_OOL_HV(name, start, size)				\
+	__EXC_REAL_OOL(name, start, size);
 
 #define __TRAMP_REAL_OOL_HV(name, vec)					\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_HV_OOL(vec, name##_common);			\
 
-#define EXC_REAL_OOL_HV(name, start, end)				\
-	__EXC_REAL_OOL_HV(name, start, end);				\
+#define EXC_REAL_OOL_HV(name, start, size)				\
+	__EXC_REAL_OOL_HV(name, start, size);				\
 	__TRAMP_REAL_OOL_HV(name, start);
 
-#define __EXC_REAL_OOL_MASKABLE_HV(name, start, end)			\
-	__EXC_REAL_OOL(name, start, end);
+#define __EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
+	__EXC_REAL_OOL(name, start, size);
 
 #define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec)				\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
 
-#define EXC_REAL_OOL_MASKABLE_HV(name, start, end)			\
-	__EXC_REAL_OOL_MASKABLE_HV(name, start, end);			\
+#define EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
+	__EXC_REAL_OOL_MASKABLE_HV(name, start, size);			\
 	__TRAMP_REAL_OOL_MASKABLE_HV(name, start);
 
-#define __EXC_VIRT_OOL(name, start, end)				\
-	EXC_VIRT_BEGIN(name, start, end);				\
+#define __EXC_VIRT_OOL(name, start, size)				\
+	EXC_VIRT_BEGIN(name, start, size);				\
 	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
-	EXC_VIRT_END(name, start, end);
+	EXC_VIRT_END(name, start, size);
 
 #define __TRAMP_VIRT_OOL(name, realvec)					\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
 
-#define EXC_VIRT_OOL(name, start, end, realvec)				\
-	__EXC_VIRT_OOL(name, start, end);				\
+#define EXC_VIRT_OOL(name, start, size, realvec)			\
+	__EXC_VIRT_OOL(name, start, size);				\
 	__TRAMP_VIRT_OOL(name, realvec);
 
-#define __EXC_VIRT_OOL_MASKABLE(name, start, end)			\
-	__EXC_VIRT_OOL(name, start, end);
+#define __EXC_VIRT_OOL_MASKABLE(name, start, size)			\
+	__EXC_VIRT_OOL(name, start, size);
 
 #define __TRAMP_VIRT_OOL_MASKABLE(name, realvec)			\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
 
-#define EXC_VIRT_OOL_MASKABLE(name, start, end, realvec)		\
-	__EXC_VIRT_OOL_MASKABLE(name, start, end);			\
+#define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec)		\
+	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
 	__TRAMP_VIRT_OOL_MASKABLE(name, realvec);
 
-#define __EXC_VIRT_OOL_HV(name, start, end)				\
-	__EXC_VIRT_OOL(name, start, end);
+#define __EXC_VIRT_OOL_HV(name, start, size)				\
+	__EXC_VIRT_OOL(name, start, size);
 
 #define __TRAMP_VIRT_OOL_HV(name, realvec)				\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
 
-#define EXC_VIRT_OOL_HV(name, start, end, realvec)			\
-	__EXC_VIRT_OOL_HV(name, start, end);				\
+#define EXC_VIRT_OOL_HV(name, start, size, realvec)			\
+	__EXC_VIRT_OOL_HV(name, start, size);				\
 	__TRAMP_VIRT_OOL_HV(name, realvec);
 
-#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, end)			\
-	__EXC_VIRT_OOL(name, start, end);
+#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, size)			\
+	__EXC_VIRT_OOL(name, start, size);
 
 #define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec)			\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
 	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
 
-#define EXC_VIRT_OOL_MASKABLE_HV(name, start, end, realvec)		\
-	__EXC_VIRT_OOL_MASKABLE_HV(name, start, end);			\
+#define EXC_VIRT_OOL_MASKABLE_HV(name, start, size, realvec)		\
+	__EXC_VIRT_OOL_MASKABLE_HV(name, start, size);			\
 	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec);
 
 #define TRAMP_KVM(area, n)						\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 597c1b0..9b20bd5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -93,7 +93,7 @@ USE_FIXED_SECTION(real_vectors)
 __start_interrupts:
 
 /* No virt vectors corresponding with 0x0..0x100 */
-EXC_VIRT_NONE(0x4000, 0x4100)
+EXC_VIRT_NONE(0x4000, 0x100)
 
 
 #ifdef CONFIG_PPC_P7_NAP
@@ -114,15 +114,15 @@ EXC_VIRT_NONE(0x4000, 0x4100)
 #define IDLETEST NOTEST
 #endif
 
-EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
+EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrrdi	r13,r13,1 /* Last bit of HSPRG0 is set if waking from winkle */
 	EXCEPTION_PROLOG_PSERIES_PACA(PACA_EXGEN, system_reset_common, EXC_STD,
 				 IDLETEST, 0x100)
 
-EXC_REAL_END(system_reset, 0x100, 0x200)
-EXC_VIRT_NONE(0x4100, 0x4200)
+EXC_REAL_END(system_reset, 0x100, 0x100)
+EXC_VIRT_NONE(0x4100, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
 EXC_COMMON_BEGIN(system_reset_idle_common)
@@ -166,7 +166,7 @@ TRAMP_REAL_BEGIN(system_reset_fwnmi)
 #endif /* CONFIG_PPC_PSERIES */
 
 
-EXC_REAL_BEGIN(machine_check, 0x200, 0x300)
+EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
 	/* This is moved out of line as it can be patched by FW, but
 	 * some code path might still want to branch into the original
 	 * vector
@@ -186,8 +186,8 @@ BEGIN_FTR_SECTION
 FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-EXC_REAL_END(machine_check, 0x200, 0x300)
-EXC_VIRT_NONE(0x4200, 0x4300)
+EXC_REAL_END(machine_check, 0x200, 0x100)
+EXC_VIRT_NONE(0x4200, 0x100)
 TRAMP_REAL_BEGIN(machine_check_powernv_early)
 BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
@@ -483,8 +483,8 @@ EXC_COMMON_BEGIN(unrecover_mce)
 	b	1b
 
 
-EXC_REAL(data_access, 0x300, 0x380)
-EXC_VIRT(data_access, 0x4300, 0x4380, 0x300)
+EXC_REAL(data_access, 0x300, 0x80)
+EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 
 EXC_COMMON_BEGIN(data_access_common)
@@ -512,7 +512,7 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
-EXC_REAL_BEGIN(data_access_slb, 0x380, 0x400)
+EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
@@ -533,9 +533,9 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x400)
 	mtctr	r10
 	bctr
 #endif
-EXC_REAL_END(data_access_slb, 0x380, 0x400)
+EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
-EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
+EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
@@ -556,12 +556,12 @@ EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
 	mtctr	r10
 	bctr
 #endif
-EXC_VIRT_END(data_access_slb, 0x4380, 0x4400)
+EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
 
-EXC_REAL(instruction_access, 0x400, 0x480)
-EXC_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
+EXC_REAL(instruction_access, 0x400, 0x80)
+EXC_VIRT(instruction_access, 0x4400, 0x80, 0x400)
 TRAMP_KVM(PACA_EXGEN, 0x400)
 
 EXC_COMMON_BEGIN(instruction_access_common)
@@ -580,7 +580,7 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
-EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
+EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
@@ -596,9 +596,9 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 	mtctr	r10
 	bctr
 #endif
-EXC_REAL_END(instruction_access_slb, 0x480, 0x500)
+EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 
-EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
+EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
@@ -614,7 +614,7 @@ EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
 	mtctr	r10
 	bctr
 #endif
-EXC_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
+EXC_VIRT_END(instruction_access_slb, 0x4480, 0x80)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 
 
@@ -711,7 +711,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
 	bl	slb_miss_bad_addr
 	b	ret_from_except
 
-EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
+EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
@@ -725,9 +725,9 @@ do_kvm_H0x500:
 do_kvm_0x500:
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-EXC_REAL_END(hardware_interrupt, 0x500, 0x600)
+EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
 
-EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
+EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
@@ -735,13 +735,13 @@ hardware_interrupt_relon_hv:
 	FTR_SECTION_ELSE
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-EXC_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
+EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
 
 EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
 
-EXC_REAL(alignment, 0x600, 0x700)
-EXC_VIRT(alignment, 0x4600, 0x4700, 0x600)
+EXC_REAL(alignment, 0x600, 0x100)
+EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
 TRAMP_KVM(PACA_EXGEN, 0x600)
 EXC_COMMON_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
@@ -760,8 +760,8 @@ EXC_COMMON_BEGIN(alignment_common)
 	b	ret_from_except
 
 
-EXC_REAL(program_check, 0x700, 0x800)
-EXC_VIRT(program_check, 0x4700, 0x4800, 0x700)
+EXC_REAL(program_check, 0x700, 0x100)
+EXC_VIRT(program_check, 0x4700, 0x100, 0x700)
 TRAMP_KVM(PACA_EXGEN, 0x700)
 EXC_COMMON_BEGIN(program_check_common)
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
@@ -772,8 +772,8 @@ EXC_COMMON_BEGIN(program_check_common)
 	b	ret_from_except
 
 
-EXC_REAL(fp_unavailable, 0x800, 0x900)
-EXC_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
+EXC_REAL(fp_unavailable, 0x800, 0x100)
+EXC_VIRT(fp_unavailable, 0x4800, 0x100, 0x800)
 TRAMP_KVM(PACA_EXGEN, 0x800)
 EXC_COMMON_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
@@ -805,20 +805,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
 
-EXC_REAL_MASKABLE(decrementer, 0x900, 0x980)
-EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
+EXC_REAL_MASKABLE(decrementer, 0x900, 0x80)
+EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x80, 0x900)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
 
 
-EXC_REAL_HV(hdecrementer, 0x980, 0xa00)
-EXC_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
+EXC_REAL_HV(hdecrementer, 0x980, 0x80)
+EXC_VIRT_HV(hdecrementer, 0x4980, 0x80, 0x980)
 TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
 
-EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
-EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
+EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0x100)
+EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x100, 0xa00)
 TRAMP_KVM(PACA_EXGEN, 0xa00)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
@@ -827,8 +827,8 @@ EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 #endif
 
 
-EXC_REAL(trap_0b, 0xb00, 0xc00)
-EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
+EXC_REAL(trap_0b, 0xb00, 0x100)
+EXC_VIRT(trap_0b, 0x4b00, 0x100, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 
@@ -884,7 +884,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	b	system_call_common ;
 #endif
 
-EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
+EXC_REAL_BEGIN(system_call, 0xc00, 0x100)
 	 /*
 	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
 	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
@@ -909,25 +909,25 @@ EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_RFID
 	SYSCALL_PSERIES_3
-EXC_REAL_END(system_call, 0xc00, 0xd00)
+EXC_REAL_END(system_call, 0xc00, 0x100)
 
-EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
+EXC_VIRT_BEGIN(system_call, 0x4c00, 0x100)
 	HMT_MEDIUM
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_DIRECT
 	SYSCALL_PSERIES_3
-EXC_VIRT_END(system_call, 0x4c00, 0x4d00)
+EXC_VIRT_END(system_call, 0x4c00, 0x100)
 
 TRAMP_KVM(PACA_EXGEN, 0xc00)
 
 
-EXC_REAL(single_step, 0xd00, 0xe00)
-EXC_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
+EXC_REAL(single_step, 0xd00, 0x100)
+EXC_VIRT(single_step, 0x4d00, 0x100, 0xd00)
 TRAMP_KVM(PACA_EXGEN, 0xd00)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 
-EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-EXC_VIRT_NONE(0x4e00, 0x4e20)
+EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0x20)
+EXC_VIRT_NONE(0x4e00, 0x20)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 EXC_COMMON_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
@@ -942,14 +942,14 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 	b       ret_from_except
 
 
-EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-EXC_VIRT_NONE(0x4e20, 0x4e40)
+EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0x20)
+EXC_VIRT_NONE(0x4e20, 0x20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
 
-EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
-EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60, 0xe40)
+EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0x20)
+EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x20, 0xe40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
@@ -959,9 +959,9 @@ EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
  * first, and then eventaully from there to the trampoline to get into virtual
  * mode.
  */
-__EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
+__EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0x20, hmi_exception_early)
 __TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
-EXC_VIRT_NONE(0x4e60, 0x4e80)
+EXC_VIRT_NONE(0x4e60, 0x20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
@@ -1015,8 +1015,8 @@ hmi_exception_after_realmode:
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 
 
-EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
-EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0, 0xe80)
+EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0x20)
+EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x20, 0xe80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
@@ -1025,24 +1025,26 @@ EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
 
 
-EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
-EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0, 0xea0)
+EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0x20)
+EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x20, 0xea0)
 TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 
 
-EXC_REAL_NONE(0xec0, 0xf00)
-EXC_VIRT_NONE(0x4ec0, 0x4f00)
+EXC_REAL_NONE(0xec0, 0x20)
+EXC_VIRT_NONE(0x4ec0, 0x20)
+EXC_REAL_NONE(0xee0, 0x20)
+EXC_VIRT_NONE(0x4ee0, 0x20)
 
 
-EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
-EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20, 0xf00)
+EXC_REAL_OOL(performance_monitor, 0xf00, 0x20)
+EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x20, 0xf00)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 
 
-EXC_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
-EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40, 0xf20)
+EXC_REAL_OOL(altivec_unavailable, 0xf20, 0x20)
+EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x20, 0xf20)
 TRAMP_KVM(PACA_EXGEN, 0xf20)
 EXC_COMMON_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
@@ -1078,8 +1080,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	b	ret_from_except
 
 
-EXC_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
-EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60, 0xf40)
+EXC_REAL_OOL(vsx_unavailable, 0xf40, 0x20)
+EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x20, 0xf40)
 TRAMP_KVM(PACA_EXGEN, 0xf40)
 EXC_COMMON_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
@@ -1114,41 +1116,50 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 
-EXC_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
-EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80, 0xf60)
+EXC_REAL_OOL(facility_unavailable, 0xf60, 0x20)
+EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x20, 0xf60)
 TRAMP_KVM(PACA_EXGEN, 0xf60)
 EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 
 
-EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
-EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0, 0xf80)
+EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0x20)
+EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x20, 0xf80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
 EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 
-EXC_REAL_NONE(0xfa0, 0x1200)
-EXC_VIRT_NONE(0x4fa0, 0x5200)
+EXC_REAL_NONE(0xfa0, 0x20)
+EXC_VIRT_NONE(0x4fa0, 0x20)
+EXC_REAL_NONE(0xfc0, 0x20)
+EXC_VIRT_NONE(0x4fc0, 0x20)
+EXC_REAL_NONE(0xfe0, 0x20)
+EXC_VIRT_NONE(0x4fe0, 0x20)
+
+EXC_REAL_NONE(0x1000, 0x100)
+EXC_VIRT_NONE(0x5000, 0x100)
+EXC_REAL_NONE(0x1100, 0x100)
+EXC_VIRT_NONE(0x5100, 0x100)
 
 #ifdef CONFIG_CBE_RAS
-EXC_REAL_HV(cbe_system_error, 0x1200, 0x1300)
-EXC_VIRT_NONE(0x5200, 0x5300)
+EXC_REAL_HV(cbe_system_error, 0x1200, 0x100)
+EXC_VIRT_NONE(0x5200, 0x100)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
 EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 #else /* CONFIG_CBE_RAS */
-EXC_REAL_NONE(0x1200, 0x1300)
-EXC_VIRT_NONE(0x5200, 0x5300)
+EXC_REAL_NONE(0x1200, 0x100)
+EXC_VIRT_NONE(0x5200, 0x100)
 #endif
 
 
-EXC_REAL(instruction_breakpoint, 0x1300, 0x1400)
-EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
+EXC_REAL(instruction_breakpoint, 0x1300, 0x100)
+EXC_VIRT(instruction_breakpoint, 0x5300, 0x100, 0x1300)
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
 EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 
-EXC_REAL_NONE(0x1400, 0x1500)
-EXC_VIRT_NONE(0x5400, 0x5500)
+EXC_REAL_NONE(0x1400, 0x100)
+EXC_VIRT_NONE(0x5400, 0x100)
 
-EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
+EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
@@ -1163,14 +1174,14 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 
 	KVMTEST_PR(0x1500)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
-EXC_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
+EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
-EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
+EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x100)
 	b	exc_real_0x1500_denorm_exception_hv
-EXC_VIRT_END(denorm_exception, 0x5500, 0x5600)
+EXC_VIRT_END(denorm_exception, 0x5500, 0x100)
 #else
-EXC_VIRT_NONE(0x5500, 0x5600)
+EXC_VIRT_NONE(0x5500, 0x100)
 #endif
 
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
@@ -1243,18 +1254,18 @@ EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
 
 
 #ifdef CONFIG_CBE_RAS
-EXC_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
-EXC_VIRT_NONE(0x5600, 0x5700)
+EXC_REAL_HV(cbe_maintenance, 0x1600, 0x100)
+EXC_VIRT_NONE(0x5600, 0x100)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
 EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 #else /* CONFIG_CBE_RAS */
-EXC_REAL_NONE(0x1600, 0x1700)
-EXC_VIRT_NONE(0x5600, 0x5700)
+EXC_REAL_NONE(0x1600, 0x100)
+EXC_VIRT_NONE(0x5600, 0x100)
 #endif
 
 
-EXC_REAL(altivec_assist, 0x1700, 0x1800)
-EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
+EXC_REAL(altivec_assist, 0x1700, 0x100)
+EXC_VIRT(altivec_assist, 0x5700, 0x100, 0x1700)
 TRAMP_KVM(PACA_EXGEN, 0x1700)
 #ifdef CONFIG_ALTIVEC
 EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
@@ -1264,13 +1275,13 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 
 
 #ifdef CONFIG_CBE_RAS
-EXC_REAL_HV(cbe_thermal, 0x1800, 0x1900)
-EXC_VIRT_NONE(0x5800, 0x5900)
+EXC_REAL_HV(cbe_thermal, 0x1800, 0x100)
+EXC_VIRT_NONE(0x5800, 0x100)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
 EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #else /* CONFIG_CBE_RAS */
-EXC_REAL_NONE(0x1800, 0x1900)
-EXC_VIRT_NONE(0x5800, 0x5900)
+EXC_REAL_NONE(0x1800, 0x100)
+EXC_VIRT_NONE(0x5800, 0x100)
 #endif
 
 
-- 
2.10.2
