Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCq9R0QJYzDrFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 19:58:50 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id v190so2364040pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 02:58:50 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Date: Thu, 20 Jul 2017 15:28:34 +0530
Message-Id: <20170720095834.15153-1-santosh@fossix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vDSO64 implementation does not have support for coarse
clocks (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls
back to system call. Below is a benchmark of the difference in execution
time with and without vDSO support.

(Non-coarse clocks are also included just for completion)

Without vDSO support:
--------------------
clock-gettime-realtime: syscall: 1547 nsec/call
clock-gettime-realtime:    libc: 258 nsec/call
clock-gettime-realtime:    vdso: 180 nsec/call

clock-gettime-monotonic: syscall: 1399 nsec/call
clock-gettime-monotonic:    libc: 317 nsec/call
clock-gettime-monotonic:    vdso: 249 nsec/call

clock-gettime-realtime-coarse: syscall: 1228 nsec/call
clock-gettime-realtime-coarse:    libc: 1320 nsec/call
clock-gettime-realtime-coarse:    vdso: 1330 nsec/call

clock-gettime-monotonic-coarse: syscall: 1263 nsec/call
clock-gettime-monotonic-coarse:    libc: 1368 nsec/call
clock-gettime-monotonic-coarse:    vdso: 1258 nsec/call

With vDSO support:
------------------
clock-gettime-realtime: syscall: 1660 nsec/call
clock-gettime-realtime:    libc: 251 nsec/call
clock-gettime-realtime:    vdso: 180 nsec/call

clock-gettime-monotonic: syscall: 1514 nsec/call
clock-gettime-monotonic:    libc: 309 nsec/call
clock-gettime-monotonic:    vdso: 239 nsec/call

clock-gettime-realtime-coarse: syscall: 1228 nsec/call
clock-gettime-realtime-coarse:    libc: 172 nsec/call
clock-gettime-realtime-coarse:    vdso: 101 nsec/call

clock-gettime-monotonic-coarse: syscall: 1347 nsec/call
clock-gettime-monotonic-coarse:    libc: 187 nsec/call
clock-gettime-monotonic-coarse:    vdso: 125 nsec/call

Used https://github.com/nlynch-mentor/vdsotest.git for the benchmarks.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/include/asm/vdso.h           |   1 +
 arch/powerpc/kernel/vdso64/Makefile       |   2 +-
 arch/powerpc/kernel/vdso64/gettime.c      | 162 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vdso64/gettimeofday.S |  82 ++-------------
 4 files changed, 174 insertions(+), 73 deletions(-)
 create mode 100644 arch/powerpc/kernel/vdso64/gettime.c

diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index c53f5f6..721e4cf 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -23,6 +23,7 @@ extern unsigned long vdso32_sigtramp;
 extern unsigned long vdso32_rt_sigtramp;
 
 int vdso_getcpu_init(void);
+struct vdso_data *__get_datapage(void);
 
 #else /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 31107bf..8958d87 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -1,6 +1,6 @@
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
+obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o gettime.o
 
 # Build rules
 
diff --git a/arch/powerpc/kernel/vdso64/gettime.c b/arch/powerpc/kernel/vdso64/gettime.c
new file mode 100644
index 0000000..01f411f
--- /dev/null
+++ b/arch/powerpc/kernel/vdso64/gettime.c
@@ -0,0 +1,162 @@
+/*
+ * Userland implementation of gettimeofday() for 64 bits processes in a
+ * ppc64 kernel for use in the vDSO
+ *
+ * Copyright (C) 2017 Santosh Sivaraj (santosh@fossix.org), IBM.
+ *
+ * Originally implemented in assembly by:
+ *   Benjamin Herrenschmuidt (benh@kernel.crashing.org),
+ *                    IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+#include <asm/time.h>
+
+static notrace void kernel_get_tspec(struct timespec *tp,
+				     struct vdso_data *vdata, u32 *wtom_sec,
+				     u32 *wtom_nsec)
+{
+	u64 tb;
+	u32 update_count;
+
+	do {
+		/* check for update count & load values */
+		update_count = vdata->tb_update_count;
+
+		/* Get TB, offset it and scale result */
+		tb = mulhdu((get_tb() - vdata->tb_orig_stamp) << 12,
+			    vdata->tb_to_xs) + vdata->stamp_sec_fraction;
+		tp->tv_sec = vdata->stamp_xtime.tv_sec;
+		if (wtom_sec)
+			*wtom_sec = vdata->wtom_clock_sec;
+		if (wtom_nsec)
+			*wtom_nsec = vdata->wtom_clock_nsec;
+	} while (update_count != vdata->tb_update_count);
+
+	tp->tv_nsec = ((u64)mulhwu(tb, NSEC_PER_SEC) << 32) >> 32;
+	tp->tv_sec += (tb >> 32);
+}
+
+static notrace int clock_get_realtime(struct timespec *tp,
+				      struct vdso_data *vdata)
+{
+	kernel_get_tspec(tp, vdata, NULL, NULL);
+
+	return 0;
+}
+
+static notrace int clock_get_monotonic(struct timespec *tp,
+				       struct vdso_data *vdata)
+{
+	__s32 wtom_sec, wtom_nsec;
+	u64 nsec;
+
+	kernel_get_tspec(tp, vdata, &wtom_sec, &wtom_nsec);
+
+	tp->tv_sec += wtom_sec;
+
+	nsec = tp->tv_nsec;
+	tp->tv_nsec = 0;
+	timespec_add_ns(tp, nsec + wtom_nsec);
+
+	return 0;
+}
+
+static notrace int clock_realtime_coarse(struct timespec *tp,
+					 struct vdso_data *vdata)
+{
+	u32 update_count;
+
+	do {
+		/* check for update count & load values */
+		update_count = vdata->tb_update_count;
+
+		tp->tv_sec = vdata->stamp_xtime.tv_sec;
+		tp->tv_nsec = vdata->stamp_xtime.tv_nsec;
+	} while (update_count != vdata->tb_update_count);
+
+	return 0;
+}
+
+static notrace int clock_monotonic_coarse(struct timespec *tp,
+					  struct vdso_data *vdata)
+{
+	__s32 wtom_sec, wtom_nsec;
+	u64 nsec;
+	u32 update_count;
+
+	do {
+		/* check for update count & load values */
+		update_count = vdata->tb_update_count;
+
+		tp->tv_sec = vdata->stamp_xtime.tv_sec;
+		tp->tv_nsec = vdata->stamp_xtime.tv_nsec;
+		wtom_sec = vdata->wtom_clock_sec;
+		wtom_nsec = vdata->wtom_clock_nsec;
+	} while (update_count != vdata->tb_update_count);
+
+	tp->tv_sec += wtom_sec;
+	nsec = tp->tv_nsec;
+	tp->tv_nsec = 0;
+	timespec_add_ns(tp, nsec + wtom_nsec);
+
+	return 0;
+}
+
+static notrace int gettime_syscall_fallback(clockid_t clk_id,
+					     struct timespec *tp)
+{
+	register clockid_t id asm("r3") = clk_id;
+	register struct timespec *t asm("r4") = tp;
+	register int nr asm("r0") = __NR_clock_gettime;
+	register int ret asm("r3");
+
+	asm volatile("sc"
+		     : "=r" (ret)
+		     : "r"(nr), "r"(id), "r"(t)
+		     : "memory");
+
+	return ret;
+}
+
+notrace int kernel_clock_gettime(clockid_t clk_id, struct timespec *tp)
+{
+	int ret;
+	struct vdso_data *vdata = __get_datapage();
+
+	if (!tp || !vdata)
+		return -EBADR;
+
+	switch (clk_id) {
+	case CLOCK_REALTIME:
+		ret = clock_get_realtime(tp, vdata);
+		break;
+	case CLOCK_MONOTONIC:
+		ret = clock_get_monotonic(tp, vdata);
+		break;
+	case CLOCK_REALTIME_COARSE:
+		ret = clock_realtime_coarse(tp, vdata);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		ret = clock_monotonic_coarse(tp, vdata);
+		break;
+	default:
+		/* fallback to syscall */
+		ret = -1;
+		break;
+	}
+
+	if (ret)
+		ret = gettime_syscall_fallback(clk_id, tp);
+
+	return ret;
+}
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 3820213..1258009 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -16,6 +16,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 
+.global	kernel_clock_gettime
+
 	.text
 /*
  * Exact prototype of gettimeofday
@@ -51,85 +53,21 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
   .cfi_endproc
 V_FUNCTION_END(__kernel_gettimeofday)
 
-
-/*
- * Exact prototype of clock_gettime()
- *
- * int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp);
- *
- */
 V_FUNCTION_BEGIN(__kernel_clock_gettime)
   .cfi_startproc
-	/* Check for supported clock IDs */
-	cmpwi	cr0,r3,CLOCK_REALTIME
-	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-	bne	cr0,99f
-
-	mflr	r12			/* r12 saves lr */
-  .cfi_register lr,r12
-	mr	r11,r4			/* r11 saves tp */
-	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
-	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
-	ori	r7,r7,NSEC_PER_SEC@l
-50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
-	bne	cr1,80f			/* if not monotonic, all done */
-
-	/*
-	 * CLOCK_MONOTONIC
-	 */
-
-	/* now we must fixup using wall to monotonic. We need to snapshot
-	 * that value and do the counter trick again. Fortunately, we still
-	 * have the counter value in r8 that was returned by __do_get_tspec.
-	 * At this point, r4,r5 contain our sec/nsec values.
-	 */
-
-	lwa	r6,WTOM_CLOCK_SEC(r3)
-	lwa	r9,WTOM_CLOCK_NSEC(r3)
-
-	/* We now have our result in r6,r9. We create a fake dependency
-	 * on that result and re-check the counter
-	 */
-	or	r0,r6,r9
-	xor	r0,r0,r0
-	add	r3,r3,r0
-	ld	r0,CFG_TB_UPDATE_COUNT(r3)
-        cmpld   cr0,r0,r8		/* check if updated */
-	bne-	50b
-
-	/* Add wall->monotonic offset and check for overflow or underflow.
-	 */
-	add	r4,r4,r6
-	add	r5,r5,r9
-	cmpd	cr0,r5,r7
-	cmpdi	cr1,r5,0
-	blt	1f
-	subf	r5,r7,r5
-	addi	r4,r4,1
-1:	bge	cr1,80f
-	addi	r4,r4,-1
-	add	r5,r5,r7
-
-80:	std	r4,TSPC64_TV_SEC(r11)
-	std	r5,TSPC64_TV_NSEC(r11)
-
-	mtlr	r12
+	mflr	r6			/* r12 saves lr */
+	stwu	r1,-112(r1)
+  .cfi_register lr,r6
+	std	r6,24(r1)
+	bl	V_LOCAL_FUNC(kernel_clock_gettime)
 	crclr	cr0*4+so
-	li	r3,0
-	blr
-
-	/*
-	 * syscall fallback
-	 */
-99:
-	li	r0,__NR_clock_gettime
-	sc
+	ld	r6,24(r1)
+	addi	r1,r1,112
+	mtlr	r6
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_clock_gettime)
 
-
 /*
  * Exact prototype of clock_getres()
  *
-- 
2.9.4
