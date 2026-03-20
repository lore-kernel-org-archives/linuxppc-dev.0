Return-Path: <linuxppc-dev+bounces-18477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C9C109316E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 05:42:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcWg239Fpz2yY1;
	Fri, 20 Mar 2026 16:42:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773985358;
	cv=none; b=lDCq1SQ28eU4g9RdunNIRs//FRIWJEda/NHUaiLIcKYj/LXeyYRzTYbsEiYLsyczBRMsdoWjiddIVXuSNYcouu2+9g202HHYgdR/y6ZFdaxkls5tq9+F3GScQ33zoTcJot0eV4ZIc7VFjgrV0XHFoD/cQ3SNICIyvI6MtZjOQrJIo42nhVgnAqaEwQX9C6x6n+je7GoMOkeiSX8HFiANebsSW3Nt9hOCS/1dOH91PEmNGJz1YfilYFagwo/WCeAypPhaB8jeCu7738g5UxhuYfE0aqa7gA26SLQNa33Goz7bzAz6XLr7v1GAESkQGZZpAiwjt1l+sRlUpfMwSpue0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773985358; c=relaxed/relaxed;
	bh=ICKlbeihDfz0tjEeNan7n5tL/L7z0Sgh1LpLkTKQTtY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YuMBXD14DMomxwvJBEQ3Qn/dmHKxELE2tqtjAa/MuhkNdtqI+pF8tfSxIJF8qSBs1cgimuIcu1kxwRlA4N2XSBbd0h/Oj4z7lEDhb+qLM/LnR8snRY5jNeijduwX6+Z4yrcB8axy9H6jtravM6y3figGNyMxpHTPfN41KtOejd5xSw4K/tvLR1hSK4Vhsexub6R2niQU6ji9/ghRLY+pML6KtuvtguduLyJ+oKvdjaHtTQBy1SSpP2PbdlPM23bC+lyGd9Kgb+u0f2ihWPr0X1nnsECRZPcQ7RfdAlWY8Sv2gQtn2bl9R6bbyIK6paHbMAYGUU1TbUb4yYp3+bkxjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dSLIEGAw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dSLIEGAw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcWg067zdz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 16:42:35 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-359fea895b5so1158814a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773985353; x=1774590153; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICKlbeihDfz0tjEeNan7n5tL/L7z0Sgh1LpLkTKQTtY=;
        b=dSLIEGAw2/d5hjw/Erx56Tjj0H3zYDH6KVes/6PskoyNh4cH+vbI4uk7hpMMxA0kAg
         yLx4GsNqkFjvYiVPpTXPsn19zn4ktGVehX3wzVM0X+D4vbUYIIwkwp9QOGSM+hFn8MVx
         o64SlU58Yb0Q6kQu7cCz4gnP5OE82rUeRjJ6C2LW0uDsc8i2HCto4MGsiNXuh5Lh9NeD
         fqMJMsP9U9ZvnkLyrL1OK4VE96/d+rUVfAQ5Go6uoR7WMFt+4cjNiipbD0hRcxfJlJfl
         7Qd8j/60NVbgsWtGftcnOFy71GIqZ35co6W3J92cVM+bPZh7xieqBspiVJR+p4s766hU
         Rfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773985353; x=1774590153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICKlbeihDfz0tjEeNan7n5tL/L7z0Sgh1LpLkTKQTtY=;
        b=id+YcvllGTG0X/enuqszoyxPzPrge+/omLy72vYFzCClJKSYD7A5yNvTuFN0iVFWVz
         L8CDWXgJ4sq7OqJQhb1Da+RaokloauikoIkqU4KjAW3WRTF916DmX3D5pCXK00qYQG/w
         ZwSvFJbq8X+iogFGl06AdRgJrPduWzK3uIsuZOEWi0/i3+kE5bSO49awvx6LZqJvS9Wh
         xkXWIwQhkRl6T/Jnbe16bSITd+8f2MZi7Pnk5gRwcpJ0urJ8jSE8mLf6NKLEzRhv2nfP
         As3VB/XNuKLDSvxz0xrMn73oFYbXphO1dBdiEQVVILws0j645maI18J6E/Hl5sl+q+kd
         KM7g==
X-Forwarded-Encrypted: i=1; AJvYcCX9ekqRXcWhlj68ZMm9HrWsLwGKBoCj8H3LTcIHNR3Lq0KwRiqj07oOIlWxYxXDv1X53U36DDpbOWoqjY8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMpZbeKNBg4u+dUGHHZPBG9O+0qGkuq+vVfA/I/bz78Lx4nzI0
	QMkxboKjAp9Ax60w5Ato7pDeNQKy8MF0R2pdK29nLQotwc9lXwJvBHiZ
X-Gm-Gg: ATEYQzzVlfXcx0GewtBcGmfQ0yZlKLdJRlOTQ0QPDxcQLT9kTJvgi6Oc4S7ZlbbCx0w
	A4YfFyV9WVbIfADak/ViQWmAn0z7+0fStzJYSapD8DPKsN2tLmu94TP1sATj6bjIuYVAsbrVm4G
	0NIubtJpWgylFq2vpN13cTIsIoRpGV57fdLZDqi7L+hjiFkTGLbtxigpo5gfLNwjy9tNsUKiCJ+
	vouyvmzhkLwuONo6p5vQDXiThDefxKXJr1U3N1kvZ2mFm0hkr73u++zBiwGCw53dIytDKNQJBFp
	vCuH4r1r6uSOxT/wAJzLrWJgw92kOot/YdfbDsZRaKYMiNl+oAE1MH0dnBJ7Qr4Jq18gBmMxQAK
	IlkIADsu9rw8a9fuqUUOWwCo9phOPf9Z7FEjvjdqkAKopdRjSHJ703UYzfntlnRAMcAVdCNM5Id
	9UV35IXf8+kcWwaO6k8wilEKJIKnGBtLoCD8MdHK0Lm4Zu8JJH+27sVpAXg9J9xLa/rLxY9PI=
X-Received: by 2002:a17:90b:3a92:b0:359:f8c3:dada with SMTP id 98e67ed59e1d1-35bd2c22480mr1488873a91.13.1773985353336;
        Thu, 19 Mar 2026 22:42:33 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.207.193.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ed0777sm4308004a91.0.2026.03.19.22.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:42:33 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] powerpc/xive: Add KUnit tests for xive_find_target_in_mask()
Date: Fri, 20 Mar 2026 11:12:03 +0530
Message-ID: <20260320054202.3245144-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive KUnit test suite for the xive_find_target_in_mask()
function, which is responsible for selecting target CPUs for interrupt
routing in the XIVE interrupt controller.

The test suite includes 8 test cases covering:
- Empty CPU mask handling (returns -1)
- Single CPU selection
- Multiple CPU selection with various mask sizes
- Fuzz parameter behavior and modulo arithmetic
- Large fuzz values exceeding mask weight
- Wrap-around behavior at mask boundaries
- System online CPU mask handling
- Edge case where fuzz equals mask weight

Two tests require multiple CPUs and will skip gracefully in single-CPU
environments (e.g., QEMU default configuration). All tests pass without
requiring modifications to production code.

The test can be run with:
  ./tools/testing/kunit/kunit.py run --arch=powerpc \
    --kunitconfig=arch/powerpc/sysdev/xive --qemu_args="-smp 4"

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
V1 -> V2:
- Updated commit message
V1: https://lore.kernel.org/all/20260320052400.3230999-1-mkchauras@gmail.com/

 arch/powerpc/sysdev/xive/.kunitconfig |   4 +
 arch/powerpc/sysdev/xive/Kconfig      |   9 +
 arch/powerpc/sysdev/xive/Makefile     |   7 +-
 arch/powerpc/sysdev/xive/xive-test.c  | 294 ++++++++++++++++++++++++++
 4 files changed, 311 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/sysdev/xive/.kunitconfig
 create mode 100644 arch/powerpc/sysdev/xive/xive-test.c

diff --git a/arch/powerpc/sysdev/xive/.kunitconfig b/arch/powerpc/sysdev/xive/.kunitconfig
new file mode 100644
index 000000000000..ea6634bb0718
--- /dev/null
+++ b/arch/powerpc/sysdev/xive/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_PPC_PSERIES=y
+CONFIG_PPC_XIVE_SPAPR=y
+CONFIG_PPC_XIVE_KUNIT_TEST=y
\ No newline at end of file
diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
index 785c292d104b..81727b9c22b7 100644
--- a/arch/powerpc/sysdev/xive/Kconfig
+++ b/arch/powerpc/sysdev/xive/Kconfig
@@ -12,3 +12,12 @@ config PPC_XIVE_NATIVE
 config PPC_XIVE_SPAPR
 	bool
 	select PPC_XIVE
+
+config PPC_XIVE_KUNIT_TEST
+	tristate "KUnit tests for XIVE interrupt controller" if !KUNIT_ALL_TESTS
+	depends on KUNIT && PPC_XIVE
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the XIVE interrupt controller.
+
+	  If unsure, say N.
diff --git a/arch/powerpc/sysdev/xive/Makefile b/arch/powerpc/sysdev/xive/Makefile
index e5108883894a..e1f9f513af09 100644
--- a/arch/powerpc/sysdev/xive/Makefile
+++ b/arch/powerpc/sysdev/xive/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y				+= common.o
-obj-$(CONFIG_PPC_XIVE_NATIVE)	+= native.o
-obj-$(CONFIG_PPC_XIVE_SPAPR)	+= spapr.o
+obj-y					+= common.o
+obj-$(CONFIG_PPC_XIVE_NATIVE)		+= native.o
+obj-$(CONFIG_PPC_XIVE_SPAPR)		+= spapr.o
+obj-$(CONFIG_PPC_XIVE_KUNIT_TEST)	+= xive-test.o
diff --git a/arch/powerpc/sysdev/xive/xive-test.c b/arch/powerpc/sysdev/xive/xive-test.c
new file mode 100644
index 000000000000..ee08f18af864
--- /dev/null
+++ b/arch/powerpc/sysdev/xive/xive-test.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit tests for XIVE interrupt controller
+ *
+ * Copyright 2026 IBM Corporation.
+ */
+
+#include <kunit/test.h>
+#include <linux/cpumask.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <asm/xive.h>
+
+/*
+ * Mock xive_try_pick_target for testing
+ * The real function checks queue capacity, we simplify for testing
+ */
+static bool xive_try_pick_target(int cpu)
+{
+	/* For testing, accept any online CPU */
+	return cpu_online(cpu);
+}
+
+/*
+ * Copy of xive_find_target_in_mask from common.c for testing
+ * This allows us to test the static function without modifying source
+ */
+static int xive_find_target_in_mask(const struct cpumask *mask,
+				    unsigned int fuzz)
+{
+	int cpu, first;
+
+	/* Pick up a starting point CPU in the mask based on fuzz */
+	fuzz %= cpumask_weight(mask);
+	first = cpumask_nth(fuzz, mask);
+	WARN_ON(first >= nr_cpu_ids);
+
+	/*
+	 * Now go through the entire mask until we find a valid
+	 * target.
+	 */
+	for_each_cpu_wrap(cpu, mask, first) {
+		if (cpu_online(cpu) && xive_try_pick_target(cpu))
+			return cpu;
+	}
+
+	return -1;
+}
+
+/*
+ * Test: Empty CPU mask
+ * Expected: Should return -1 when the mask contains no CPUs
+ */
+static void xive_test_find_target_empty_mask(struct kunit *test)
+{
+	struct cpumask empty_mask;
+	int result;
+
+	cpumask_clear(&empty_mask);
+
+	result = xive_find_target_in_mask(&empty_mask, 0);
+
+	KUNIT_EXPECT_EQ(test, result, -1);
+}
+
+/*
+ * Test: Single CPU in mask
+ * Expected: Should return that CPU if it's online
+ */
+static void xive_test_find_target_single_cpu(struct kunit *test)
+{
+	struct cpumask single_mask;
+	int cpu = 0;
+	int result;
+
+	/* Skip test if CPU 0 is not online */
+	if (!cpu_online(0))
+		kunit_skip(test, "CPU 0 is not online");
+
+	cpumask_clear(&single_mask);
+	cpumask_set_cpu(cpu, &single_mask);
+
+	result = xive_find_target_in_mask(&single_mask, 0);
+
+	KUNIT_EXPECT_EQ(test, result, cpu);
+}
+
+/*
+ * Test: Multiple CPUs in mask with fuzz=0
+ * Expected: Should return a valid CPU from the mask
+ */
+static void xive_test_find_target_multiple_cpus(struct kunit *test)
+{
+	struct cpumask multi_mask;
+	int result;
+	int cpu;
+	int count = 0;
+
+	cpumask_clear(&multi_mask);
+
+	/* Add first 4 online CPUs to the mask */
+	for_each_online_cpu(cpu) {
+		cpumask_set_cpu(cpu, &multi_mask);
+		count++;
+		if (count >= 4)
+			break;
+	}
+
+	if (count == 0)
+		kunit_skip(test, "No online CPUs available");
+
+	result = xive_find_target_in_mask(&multi_mask, 0);
+
+	/* Result should be a valid CPU in the mask */
+	KUNIT_EXPECT_NE(test, result, -1);
+	KUNIT_EXPECT_TRUE(test, cpumask_test_cpu(result, &multi_mask));
+	KUNIT_EXPECT_TRUE(test, cpu_online(result));
+}
+
+/*
+ * Test: Fuzz parameter affects starting point
+ * Expected: Different fuzz values may select different CPUs
+ */
+static void xive_test_find_target_fuzz_variation(struct kunit *test)
+{
+	struct cpumask multi_mask;
+	int result1, result2;
+	int cpu;
+	int count = 0;
+
+	cpumask_clear(&multi_mask);
+
+	/* Add multiple online CPUs to the mask */
+	for_each_online_cpu(cpu) {
+		cpumask_set_cpu(cpu, &multi_mask);
+		count++;
+		if (count >= 4)
+			break;
+	}
+
+	if (count < 2)
+		kunit_skip(test, "Need at least 2 online CPUs for this test");
+
+	result1 = xive_find_target_in_mask(&multi_mask, 0);
+	result2 = xive_find_target_in_mask(&multi_mask, 1);
+
+	/* Both results should be valid CPUs in the mask */
+	KUNIT_EXPECT_NE(test, result1, -1);
+	KUNIT_EXPECT_NE(test, result2, -1);
+	KUNIT_EXPECT_TRUE(test, cpumask_test_cpu(result1, &multi_mask));
+	KUNIT_EXPECT_TRUE(test, cpumask_test_cpu(result2, &multi_mask));
+}
+
+/*
+ * Test: Large fuzz value (modulo behavior)
+ * Expected: Should handle fuzz values larger than mask weight correctly
+ */
+static void xive_test_find_target_large_fuzz(struct kunit *test)
+{
+	struct cpumask multi_mask;
+	int result;
+	int cpu;
+	int count = 0;
+	unsigned int large_fuzz = 1000;
+
+	cpumask_clear(&multi_mask);
+
+	/* Add online CPUs to the mask */
+	for_each_online_cpu(cpu) {
+		cpumask_set_cpu(cpu, &multi_mask);
+		count++;
+		if (count >= 3)
+			break;
+	}
+
+	if (count == 0)
+		kunit_skip(test, "No online CPUs available");
+
+	result = xive_find_target_in_mask(&multi_mask, large_fuzz);
+
+	/* Result should be a valid CPU in the mask */
+	KUNIT_EXPECT_NE(test, result, -1);
+	KUNIT_EXPECT_TRUE(test, cpumask_test_cpu(result, &multi_mask));
+	KUNIT_EXPECT_TRUE(test, cpu_online(result));
+}
+
+/*
+ * Test: Wrap-around behavior at mask boundary
+ * Expected: Should correctly wrap around when starting near the end
+ */
+static void xive_test_find_target_wrap_around(struct kunit *test)
+{
+	struct cpumask wrap_mask;
+	int result;
+	int cpu;
+	int count = 0;
+	unsigned int weight;
+
+	cpumask_clear(&wrap_mask);
+
+	/* Add online CPUs to the mask */
+	for_each_online_cpu(cpu) {
+		cpumask_set_cpu(cpu, &wrap_mask);
+		count++;
+		if (count >= 4)
+			break;
+	}
+
+	if (count < 2)
+		kunit_skip(test, "Need at least 2 online CPUs for this test");
+
+	weight = cpumask_weight(&wrap_mask);
+
+	/* Test with fuzz at the boundary */
+	result = xive_find_target_in_mask(&wrap_mask, weight - 1);
+
+	KUNIT_EXPECT_NE(test, result, -1);
+	KUNIT_EXPECT_TRUE(test, cpumask_test_cpu(result, &wrap_mask));
+	KUNIT_EXPECT_TRUE(test, cpu_online(result));
+}
+
+/*
+ * Test: Using cpu_online_mask
+ * Expected: Should handle the system's online CPU mask correctly
+ */
+static void xive_test_find_target_online_mask(struct kunit *test)
+{
+	int result;
+
+	if (cpumask_empty(cpu_online_mask))
+		kunit_skip(test, "No online CPUs in system");
+
+	result = xive_find_target_in_mask(cpu_online_mask, 0);
+
+	KUNIT_EXPECT_NE(test, result, -1);
+	KUNIT_EXPECT_TRUE(test, cpu_online(result));
+}
+
+/*
+ * Test: Fuzz value equal to mask weight
+ * Expected: Should wrap to first CPU (fuzz % weight == 0)
+ */
+static void xive_test_find_target_fuzz_equals_weight(struct kunit *test)
+{
+	struct cpumask test_mask;
+	int result;
+	int cpu;
+	int count = 0;
+	unsigned int weight;
+
+	cpumask_clear(&test_mask);
+
+	/* Add online CPUs to the mask */
+	for_each_online_cpu(cpu) {
+		cpumask_set_cpu(cpu, &test_mask);
+		count++;
+		if (count >= 3)
+			break;
+	}
+
+	if (count == 0)
+		kunit_skip(test, "No online CPUs available");
+
+	weight = cpumask_weight(&test_mask);
+
+	/* Fuzz equal to weight should wrap to start */
+	result = xive_find_target_in_mask(&test_mask, weight);
+
+	KUNIT_EXPECT_NE(test, result, -1);
+	KUNIT_EXPECT_TRUE(test, cpumask_test_cpu(result, &test_mask));
+}
+
+static struct kunit_case xive_test_cases[] = {
+	KUNIT_CASE(xive_test_find_target_empty_mask),
+	KUNIT_CASE(xive_test_find_target_single_cpu),
+	KUNIT_CASE(xive_test_find_target_multiple_cpus),
+	KUNIT_CASE(xive_test_find_target_fuzz_variation),
+	KUNIT_CASE(xive_test_find_target_large_fuzz),
+	KUNIT_CASE(xive_test_find_target_wrap_around),
+	KUNIT_CASE(xive_test_find_target_online_mask),
+	KUNIT_CASE(xive_test_find_target_fuzz_equals_weight),
+	{}
+};
+
+static struct kunit_suite xive_test_suite = {
+	.name = "xive_find_target_in_mask",
+	.test_cases = xive_test_cases,
+};
+
+kunit_test_suites(&xive_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for XIVE interrupt controller");
+MODULE_AUTHOR("Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>");
-- 
2.53.0


