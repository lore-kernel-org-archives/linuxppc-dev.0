Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20009C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 21:34:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73965213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 21:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73965213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QTmX6Kh3zF3BN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 07:34:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QTk06cyczF374
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 07:31:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w93LT4pu015719
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 17:31:50 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mw4xhj40n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 17:31:49 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 3 Oct 2018 17:31:48 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Oct 2018 17:31:46 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w93LVjNX26476608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Oct 2018 21:31:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BFD2AC05F;
 Wed,  3 Oct 2018 17:31:01 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCF3FAC060;
 Wed,  3 Oct 2018 17:30:59 -0400 (EDT)
Received: from debra.ibm.com (unknown [9.80.226.63])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  3 Oct 2018 17:30:59 -0400 (EDT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: Add check for TM SPRS on coredump
Date: Wed,  3 Oct 2018 18:31:42 -0300
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18100321-0040-0000-0000-0000047A9BD7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009817; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097440; UDB=6.00567549; IPR=6.00877482; 
 MB=3.00023602; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-03 21:31:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100321-0041-0000-0000-00000882A763
Message-Id: <1538602302-5725-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-03_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030195
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a selftest to check if the TM SPRs are being properly saved into a
coredump. The segfault is caused by an illegal instruction and ideally it
happens after load_tm overflowed and TM became lazily disabled.

This test is implemented basically setting three TM_SPR and sleeping until
load_tm is expected to be zero.  Then it causes a segfault and open the
coredump to check if the SPRs saved in the coredump notes section contain
the same values that were set by the test.

This test needs root privileges in order to change the coredump file
pattern (/proc/sys/kernel/core_pattern).

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/tm/Makefile  |   3 +-
 tools/testing/selftests/powerpc/tm/tm-core.c | 480 +++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm.h      |   4 +
 3 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-core.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index c0e45d2dde25..b06a58fc6f79 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -4,7 +4,7 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-trap \
-	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn
+	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-core
 
 include ../../lib.mk
 
@@ -19,6 +19,7 @@ $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-resched-dscr: ../pmu/lib.c
 $(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -mvsx
 $(OUTPUT)/tm-trap: CFLAGS += -O0 -pthread -m64
+$(OUTPUT)/tm-core: CFLAGS += -pthread
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-core.c b/tools/testing/selftests/powerpc/tm/tm-core.c
new file mode 100644
index 000000000000..b01a3a1ae1bf
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-core.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2018, Breno Leitao, Gustavo Romero, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test case that sets TM SPR and sleeps, waiting kernel load_tm to be
+ * zero. Then causes a segfault to generate a core dump file that will be
+ * analyzed. The coredump needs to have the same HTM SPR values set
+ * initially for a successful test.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <error.h>
+#include <elf.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <linux/kernel.h>
+
+#include "utils.h"
+#include "tm.h"
+
+/* Default time that causes load_tm = 0 on P8/pseries */
+#define DEFAULT_SLEEP_TIME	0x00d0000000
+
+/* MAX string length for string concatenation */
+#define LEN_MAX			1024
+
+/* Maximum coredump file size */
+#define CORE_FILE_LIMIT		(5 * 1024 * 1024)
+
+/* Name of the coredump file to be generated */
+#define COREDUMPFILE		"core-tm-spr"
+
+/* Function that returns concatenated strings */
+#define COREDUMP(suffix)	(COREDUMPFILE#suffix)
+
+/* File to change the coredump file name pattern */
+#define CORE_PATTERN_FILE	"/proc/sys/kernel/core_pattern"
+
+/* Logging macros */
+#define err_at_line(status, errnum, format, ...) \
+	error_at_line(status, errnum,  __FILE__, __LINE__, format ##__VA_ARGS__)
+#define pr_err(code, format, ...) err_at_line(1, code, format, ##__VA_ARGS__)
+
+/* Child PID */
+static pid_t child;
+
+/* pthread attribute for both ping and pong threads */
+static pthread_attr_t attr;
+
+/* SPR values to be written to TM SPRs and verified later */
+const unsigned long texasr = 0x31;
+const unsigned long tfiar = 0xdeadbeef0;
+const unsigned long tfhar = 0xbaadf00d0;
+
+struct tm_sprs {
+	unsigned long texasr;
+	unsigned long tfhar;
+	unsigned long tfiar;
+};
+
+struct coremem {
+	void *p;
+	off_t len;
+};
+
+/* Set the process limits to be able to create a coredump file */
+static int increase_core_file_limit(void)
+{
+	struct rlimit rlim;
+	int ret;
+
+	ret = getrlimit(RLIMIT_CORE, &rlim);
+	if (ret != 0) {
+		pr_err(ret, "getrlimit CORE failed\n");
+		return -1;
+	}
+
+	if (rlim.rlim_cur != RLIM_INFINITY && rlim.rlim_cur < CORE_FILE_LIMIT) {
+		rlim.rlim_cur = CORE_FILE_LIMIT;
+
+		if (rlim.rlim_max != RLIM_INFINITY &&
+		    rlim.rlim_max < CORE_FILE_LIMIT)
+			rlim.rlim_max = CORE_FILE_LIMIT;
+
+		ret = setrlimit(RLIMIT_CORE, &rlim);
+		if (ret != 0) {
+			pr_err(ret, "setrlimit CORE failed\n");
+			return -1;
+		}
+	}
+
+	ret = getrlimit(RLIMIT_FSIZE, &rlim);
+	if (ret != 0) {
+		pr_err(ret, "getrlimit FSIZE failed\n");
+		return -1;
+	}
+
+	if (rlim.rlim_cur != RLIM_INFINITY && rlim.rlim_cur < CORE_FILE_LIMIT) {
+		rlim.rlim_cur = CORE_FILE_LIMIT;
+
+		if (rlim.rlim_max != RLIM_INFINITY &&
+		    rlim.rlim_max < CORE_FILE_LIMIT)
+			rlim.rlim_max = CORE_FILE_LIMIT;
+
+		ret = setrlimit(RLIMIT_FSIZE, &rlim);
+		if (ret != 0) {
+			pr_err(ret, "setrlimit FSIZE failed\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Set pattern for coredump file name. It returns current pattern being
+ * used as 'old' if old != NULL
+ */
+static int write_core_pattern(const char *core_pattern, char *old)
+{
+	FILE *f;
+	size_t len = strlen(core_pattern), ret;
+
+	f = fopen(CORE_PATTERN_FILE, "r+");
+	if (!f) {
+		perror("Error writing to core_pattern file");
+		return -1;
+	}
+
+	/* Skip saving old value */
+	if (old != NULL) {
+		ret = fread(old, 1, LEN_MAX, f);
+		if (!ret) {
+			perror("Error reading core_pattern file");
+			fclose(f);
+			return -1;
+		}
+		rewind(f);
+	}
+
+	ret = fwrite(core_pattern, 1, len, f);
+
+	fclose(f);
+
+	if (ret != len) {
+		perror("Error writing to core_pattern file");
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/* Thread to force context switch. Will die when the test is done */
+static void __attribute__((noreturn)) *tm_core_pong(void *not_used)
+{
+	while (1)
+		sched_yield();
+}
+
+/* Sleep in user space waiting for load_tm to reach zero */
+static void wait_lazy(unsigned long counter)
+{
+	asm volatile (
+		"mtctr  %[counter]      ;"
+		"1:     bdnz 1b         ;"
+		:
+		: [counter] "r" (counter)
+		:
+	);
+}
+
+/*
+ * This function will fork, and the child will set the SPRs and sleep
+ * expecting load_tm to be zero. After a while, it will segfault and
+ * generate a core dump. The parent process just wait the child to die
+ * before continuing.
+ */
+static void *sleep_and_dump(void *time)
+{
+	int status;
+	unsigned long t = *(unsigned long *)time;
+
+	/* Fork, and the child process will sleep and die */
+	child = fork();
+	if (child < 0) {
+		pr_err(child, "fork failure");
+	} else if (child == 0) {
+		/* Set TM SPRS to be checked later */
+		mtspr(SPRN_TFIAR, tfiar);
+		mtspr(SPRN_TFHAR, tfhar);
+		mtspr(SPRN_TEXASR, texasr);
+
+		/*
+		 * Sleep in userspace. Not sleeping with
+		 * sleep()/nanosleep() because we want to continue to do
+		 * context switch, incrementing load_tm until it overflows
+		 */
+		wait_lazy(t);
+
+		/*
+		 * Cause a segfault and coredump. Can not call any syscalls,
+		 * which will reload load_tm due to 'tabort.' being executed
+		 * before each syscall by some glibc versions.
+		 */
+		asm(".long 0x0");
+	}
+
+	/* Only parent will continue here */
+	waitpid(child, &status, 0);
+	if (!WCOREDUMP(status)) {
+		pr_err(status, "Core dump not generated.");
+		return (void *) -1;
+	}
+
+	return  NULL;
+}
+
+
+/* Speed up load_tm overflow with this thread */
+static int start_pong_thread(void)
+{
+	int ret;
+	pthread_t t1;
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	/* Init pthread attribute. */
+	ret = pthread_attr_init(&attr);
+	if (ret) {
+		pr_err(ret, "pthread_attr_init()");
+		return ret;
+	}
+
+	ret = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
+	if (ret) {
+		pr_err(ret, "pthread_attr_setaffinity_np()");
+		return ret;
+	}
+
+	ret = pthread_create(&t1, &attr /* CPU 0 */, tm_core_pong, NULL);
+	if (ret) {
+		pr_err(ret, "pthread_create()");
+		return ret;
+	}
+
+	return 0;
+}
+
+
+/* Main test thread */
+static int start_main_thread(unsigned long t)
+{
+	pthread_t t0;
+	void *ret_value;
+	int ret, rc = 0;
+	char old_core_pattern[LEN_MAX];
+
+	ret = increase_core_file_limit();
+	if (ret)
+		return ret;
+
+	/* Change the name of the core dump file */
+	ret = write_core_pattern(COREDUMP(.%p), old_core_pattern);
+	if (ret) {
+		pr_err(ret, "Not able to change core pattern. Are you root!?");
+		return -1;
+	}
+
+	ret = pthread_create(&t0, &attr, sleep_and_dump, &t);
+	if (ret) {
+		pr_err(ret, "pthread_create()");
+		/* Not returning because core_pattern should be restored */
+		rc = ret;
+	}
+
+	ret = pthread_join(t0, &ret_value);
+	if (ret || ret_value != NULL) {
+		pr_err(ret, "sleep_and_dump didn't finished successfully");
+		rc += ret;
+	}
+
+	/* Restore old core pattern to the original value */
+	ret = write_core_pattern(old_core_pattern, NULL);
+	if (ret != 0) {
+		pr_err(ret, "/proc/sys/kernel/core_pattern not restored properly");
+		rc += ret;
+	}
+
+	return rc;
+}
+
+/* Open coredump file and return it mapped into memory */
+static void open_coredump(struct coremem *c)
+{
+	struct stat buf;
+	int fd; int ret;
+	void *core;
+	off_t core_size;
+
+	char coredump[LEN_MAX];
+
+	/* default return value */
+	c->p = NULL;
+
+	sprintf(coredump, COREDUMP(.%d), child);
+
+	fd = open(coredump, O_RDONLY);
+	if (fd == -1)
+		perror("Error opening core file");
+
+	ret = stat(coredump, &buf);
+	if (ret == -1) {
+		printf("Coredump does not exist!\n");
+		return;
+	}
+	core_size = buf.st_size;
+
+	core = mmap(NULL, core_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (core == MAP_FAILED) {
+		perror("Error mmaping core file");
+		return;
+	}
+	c->p = core;
+	c->len = core_size;
+}
+
+static Elf64_Nhdr *next_note(Elf64_Nhdr *nhdr)
+{
+	return (void *) nhdr + sizeof(*nhdr) +
+		__ALIGN_KERNEL(nhdr->n_namesz, 4) +
+		__ALIGN_KERNEL(nhdr->n_descsz, 4);
+}
+
+/* Parse elf in memory and return TM SPRS values */
+static void parse_elf(Elf64_Ehdr *ehdr, struct tm_sprs *ret)
+{
+	void *p = ehdr;
+	Elf64_Phdr *phdr;
+	Elf64_Nhdr *nhdr;
+	size_t phdr_size;
+	unsigned long *regs, *note;
+
+	assert(memcmp(ehdr->e_ident, ELFMAG, SELFMAG) == 0);
+
+	assert(ehdr->e_type == ET_CORE);
+	assert(ehdr->e_machine == EM_PPC64);
+	assert(ehdr->e_phoff != 0 || ehdr->e_phnum != 0);
+
+	phdr_size = sizeof(*phdr) * ehdr->e_phnum;
+
+	for (phdr = p + ehdr->e_phoff;
+	     (void *) phdr < p + ehdr->e_phoff + phdr_size;
+	      phdr += ehdr->e_phentsize)
+		/* Stop at NOTES section type */
+		if (phdr->p_type == PT_NOTE)
+			break;
+
+	for (nhdr = p + phdr->p_offset;
+	     (void *) nhdr < p + phdr->p_offset + phdr->p_filesz;
+	     nhdr = next_note(nhdr))
+		/* Stop at TM SPR segment */
+		if (nhdr->n_type == NT_PPC_TM_SPR)
+			break;
+
+	assert(nhdr->n_descsz != 0);
+
+	p = nhdr;
+	note = p + sizeof(*nhdr) + __ALIGN_KERNEL(nhdr->n_namesz, 4);
+	regs = (unsigned long *) note;
+
+	ret->texasr = regs[1];
+	ret->tfhar = regs[0];
+	ret->tfiar = regs[2];
+}
+
+static int check_return_value(struct tm_sprs *s)
+{
+	if ((s->texasr == texasr) &&
+	    (s->tfiar == tfiar) &&
+	    (s->tfhar == tfhar)) {
+		return 0;
+	}
+
+	/* Corrupted values detected */
+	printf("Detected one or more TM SPR corrupted:\n");
+	printf("TFIAR : %016lx vs %016lx\n", s->texasr, texasr);
+	printf("TEXASR: %016lx vs %016lx\n", s->tfiar, tfiar);
+	printf("TFHAR : %016lx vs %016lx\n", s->tfhar, tfhar);
+
+	return 1;
+}
+
+/* Remove coredump file generated by this test */
+static int clear_coredump(void)
+{
+	char file[LEN_MAX];
+	int ret;
+
+	sprintf(file, COREDUMP(.%d), child);
+	ret = remove(file);
+	if (ret != 0)
+		perror("Not able to remove coredump file");
+
+	return ret;
+}
+
+/* Main function  */
+static int tm_core_test(void)
+{
+	unsigned long time =  DEFAULT_SLEEP_TIME;
+	struct tm_sprs sprs;
+	struct coremem mem;
+	int ret;
+
+	/* Skip if TM is not available */
+	SKIP_IF(!have_htm());
+
+	/*
+	 * Skip if not root. Could not change the default coredump name
+	 * pattern
+	 */
+	SKIP_IF(geteuid() != 0);
+
+	printf("Sleeping for %lu cycles\n", time);
+	ret = start_pong_thread();
+	if (ret != 0)
+		return ret;
+
+	ret = start_main_thread(time);
+	if (ret != 0)
+		return ret;
+
+	open_coredump(&mem);
+	if (mem.p == NULL) {
+		/* if open_coredump failed, mem.p returns NULL */
+		pr_err(1, "Open coredump file failed");
+		return -1;
+	}
+
+	parse_elf(mem.p, &sprs);
+
+	/* unmap memory allocated in open_coredump() */
+	munmap(mem.p, mem.len);
+
+	ret = clear_coredump();
+	if (ret != 0)
+		return ret;
+
+	ret = check_return_value(&sprs);
+	if (ret == 0)
+		printf("Success!\n");
+	else
+		printf("Failure!\n");
+
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness(tm_core_test, "tm_core_test");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index df4204247d45..cfe2ead9d366 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -12,6 +12,10 @@
 
 #include "utils.h"
 
+#ifndef NT_PPC_TM_SPR
+#define NT_PPC_TM_SPR	0x10c
+#endif
+
 static inline bool have_htm(void)
 {
 #ifdef PPC_FEATURE2_HTM
-- 
2.19.0

