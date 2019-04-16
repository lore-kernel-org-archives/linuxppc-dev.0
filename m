Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C52C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:26:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B35320868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B35320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k9jz2fHDzDqKD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:26:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44k9SX4kMGzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 02:15:07 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D111515A2;
 Tue, 16 Apr 2019 09:15:06 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86733F59C;
 Tue, 16 Apr 2019 09:15:03 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
Date: Tue, 16 Apr 2019 17:14:34 +0100
Message-Id: <20190416161434.32691-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416161434.32691-1-vincenzo.frascino@arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The current version of the multiarch vDSO selftest verifies only
gettimeofday.

Extend the vDSO selftest to clock_getres, to verify that the
syscall and the vDSO library function return the same information.

The extension has been used to verify the hrtimer_resoltion fix.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_clock_getres.c        | 108 ++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..d5c5bfdf1ac1 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -5,6 +5,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+TEST_GEN_PROGS += $(OUTPUT)/vdso_clock_getres
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -18,6 +19,7 @@ endif
 
 all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_clock_getres: vdso_clock_getres.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_clock_getres.c b/tools/testing/selftests/vDSO/vdso_clock_getres.c
new file mode 100644
index 000000000000..b1b9652972eb
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_clock_getres.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vdso_clock_getres.c: Sample code to test clock_getres.
+ * Copyright (c) 2019 Arm Ltd.
+ *
+ * Compile with:
+ * gcc -std=gnu99 vdso_clock_getres.c
+ *
+ * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
+ * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
+ * Might work on other architectures.
+ */
+
+#define _GNU_SOURCE
+#include <elf.h>
+#include <err.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
+{
+	long ret;
+
+	ret = syscall(SYS_clock_getres, _clkid, _ts);
+
+	return ret;
+}
+
+const char *vdso_clock_name[12] = {
+	"CLOCK_REALTIME",
+	"CLOCK_MONOTONIC",
+	"CLOCK_PROCESS_CPUTIME_ID",
+	"CLOCK_THREAD_CPUTIME_ID",
+	"CLOCK_MONOTONIC_RAW",
+	"CLOCK_REALTIME_COARSE",
+	"CLOCK_MONOTONIC_COARSE",
+	"CLOCK_BOOTTIME",
+	"CLOCK_REALTIME_ALARM",
+	"CLOCK_BOOTTIME_ALARM",
+	"CLOCK_SGI_CYCLE",
+	"CLOCK_TAI",
+};
+
+/*
+ * Macro to call clock_getres in vdso and by system call
+ * with different values for clock_id.
+ */
+#define vdso_test_clock(clock_id)				\
+do {								\
+	struct timespec x, y;					\
+	printf("clock_id: %s", vdso_clock_name[clock_id]);	\
+	clock_getres(clock_id, &x);				\
+	syscall_clock_getres(clock_id, &y);			\
+	if ((x.tv_sec != y.tv_sec) || (x.tv_sec != y.tv_sec)) {	\
+		printf(" [FAIL]\n");				\
+		return KSFT_SKIP;				\
+	} else {						\
+		printf(" [PASS]\n");				\
+	}							\
+} while (0)
+
+int main(int argc, char **argv)
+{
+
+#if _POSIX_TIMERS > 0
+
+#ifdef CLOCK_REALTIME
+	vdso_test_clock(CLOCK_REALTIME);
+#endif
+
+#ifdef CLOCK_BOOTTIME
+	vdso_test_clock(CLOCK_BOOTTIME);
+#endif
+
+#ifdef CLOCK_TAI
+	vdso_test_clock(CLOCK_TAI);
+#endif
+
+#ifdef CLOCK_REALTIME_COARSE
+	vdso_test_clock(CLOCK_REALTIME_COARSE);
+#endif
+
+#ifdef CLOCK_MONOTONIC
+	vdso_test_clock(CLOCK_MONOTONIC);
+#endif
+
+#ifdef CLOCK_MONOTONIC_RAW
+	vdso_test_clock(CLOCK_MONOTONIC_RAW);
+#endif
+
+#ifdef CLOCK_MONOTONIC_COARSE
+	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+#endif
+
+#endif
+
+	return 0;
+}
-- 
2.21.0

