Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sVBg2YNYzF1SJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 12:12:27 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P2435f078272
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 22:12:24 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j64j4jayy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 22:12:24 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 24 May 2018 20:12:22 -0600
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2 2/2] selftests/powerpc: Add core file test for Protection
 Key registers
Date: Thu, 24 May 2018 23:11:45 -0300
In-Reply-To: <20180525021145.4520-1-bauerman@linux.ibm.com>
References: <20180525021145.4520-1-bauerman@linux.ibm.com>
Message-Id: <20180525021145.4520-2-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This test verifies that the AMR, IAMR and UAMOR are being written to a
process' core file.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
 tools/testing/selftests/powerpc/ptrace/core-pkey.c | 461 +++++++++++++++++++++
 2 files changed, 465 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/core-pkey.c

Changes in v2:
- Use PARENT_SKIP_IF_UNSUPPORTED macro in first call to
  ptrace_read_regs(NT_PPC_PKEY). (Suggested by Michael Ellerman)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 707ba734faf2..a10916c3f3e1 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
               ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
-              ptrace-tm-spd-vsx ptrace-tm-spr ptrace-pkey
+              ptrace-tm-spd-vsx ptrace-tm-spr ptrace-pkey core-pkey
 
 include ../../lib.mk
 
@@ -12,6 +12,9 @@ CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
 ptrace-pkey: ../harness.c ../utils.c ../lib/reg.S ptrace.h child.h ptrace-pkey.c
 	$(LINK.c) $^ $(LDLIBS) -pthread -o $@
 
+core-pkey: ../harness.c ../utils.c ../lib/reg.S ptrace.h child.h core-pkey.c
+	$(LINK.c) $^ $(LDLIBS) -pthread -o $@
+
 $(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
 
 clean:
diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
new file mode 100644
index 000000000000..36bc312b1f5c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Ptrace test for Memory Protection Key registers
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ * Copyright (C) 2018 IBM Corporation.
+ */
+#include <limits.h>
+#include <linux/kernel.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include "ptrace.h"
+#include "child.h"
+
+#ifndef __NR_pkey_alloc
+#define __NR_pkey_alloc		384
+#endif
+
+#ifndef __NR_pkey_free
+#define __NR_pkey_free		385
+#endif
+
+#ifndef NT_PPC_PKEY
+#define NT_PPC_PKEY		0x110
+#endif
+
+#ifndef PKEY_DISABLE_EXECUTE
+#define PKEY_DISABLE_EXECUTE	0x4
+#endif
+
+#define AMR_BITS_PER_PKEY 2
+#define PKEY_REG_BITS (sizeof(u64) * 8)
+#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
+
+#define CORE_FILE_LIMIT	(5 * 1024 * 1024)	/* 5 MB should be enough */
+
+static const char core_pattern_file[] = "/proc/sys/kernel/core_pattern";
+
+static const char user_write[] = "[User Write (Running)]";
+static const char core_read_running[] = "[Core Read (Running)]";
+
+/* Information shared between the parent and the child. */
+struct shared_info {
+	struct child_sync child_sync;
+
+	/* AMR value the parent expects to read in the core file. */
+	unsigned long amr;
+
+	/* IAMR value the parent expects to read in the core file. */
+	unsigned long iamr;
+
+	/* UAMOR value the parent expects to read in the core file. */
+	unsigned long uamor;
+
+	/* When the child crashed. */
+	time_t core_time;
+};
+
+static int sys_pkey_alloc(unsigned long flags, unsigned long init_access_rights)
+{
+	return syscall(__NR_pkey_alloc, flags, init_access_rights);
+}
+
+static int sys_pkey_free(int pkey)
+{
+	return syscall(__NR_pkey_free, pkey);
+}
+
+static int increase_core_file_limit(void)
+{
+	struct rlimit rlim;
+	int ret;
+
+	ret = getrlimit(RLIMIT_CORE, &rlim);
+	FAIL_IF(ret);
+
+	if (rlim.rlim_cur != RLIM_INFINITY && rlim.rlim_cur < CORE_FILE_LIMIT) {
+		rlim.rlim_cur = CORE_FILE_LIMIT;
+
+		if (rlim.rlim_max != RLIM_INFINITY &&
+		    rlim.rlim_max < CORE_FILE_LIMIT)
+			rlim.rlim_max = CORE_FILE_LIMIT;
+
+		ret = setrlimit(RLIMIT_CORE, &rlim);
+		FAIL_IF(ret);
+	}
+
+	ret = getrlimit(RLIMIT_FSIZE, &rlim);
+	FAIL_IF(ret);
+
+	if (rlim.rlim_cur != RLIM_INFINITY && rlim.rlim_cur < CORE_FILE_LIMIT) {
+		rlim.rlim_cur = CORE_FILE_LIMIT;
+
+		if (rlim.rlim_max != RLIM_INFINITY &&
+		    rlim.rlim_max < CORE_FILE_LIMIT)
+			rlim.rlim_max = CORE_FILE_LIMIT;
+
+		ret = setrlimit(RLIMIT_FSIZE, &rlim);
+		FAIL_IF(ret);
+	}
+
+	return TEST_PASS;
+}
+
+static int child(struct shared_info *info)
+{
+	bool disable_execute = true;
+	int pkey1, pkey2, pkey3;
+	int *ptr, ret;
+
+	/* Wait until parent fills out the initial register values. */
+	ret = wait_parent(&info->child_sync);
+	if (ret)
+		return ret;
+
+	ret = increase_core_file_limit();
+	FAIL_IF(ret);
+
+	/* Get some pkeys so that we can change their bits in the AMR. */
+	pkey1 = sys_pkey_alloc(0, PKEY_DISABLE_EXECUTE);
+	if (pkey1 < 0) {
+		pkey1 = sys_pkey_alloc(0, 0);
+		FAIL_IF(pkey1 < 0);
+
+		disable_execute = false;
+	}
+
+	pkey2 = sys_pkey_alloc(0, 0);
+	FAIL_IF(pkey2 < 0);
+
+	pkey3 = sys_pkey_alloc(0, 0);
+	FAIL_IF(pkey3 < 0);
+
+	info->amr |= 3ul << pkeyshift(pkey1) | 2ul << pkeyshift(pkey2);
+
+	if (disable_execute)
+		info->iamr |= 1ul << pkeyshift(pkey1);
+
+	info->uamor |= 3ul << pkeyshift(pkey1) | 3ul << pkeyshift(pkey2);
+
+	printf("%-30s AMR: %016lx pkey1: %d pkey2: %d pkey3: %d\n",
+	       user_write, info->amr, pkey1, pkey2, pkey3);
+
+	mtspr(SPRN_AMR, info->amr);
+
+	/*
+	 * We won't use pkey3. This tests whether the kernel restores the UAMOR
+	 * permissions after a key is freed.
+	 */
+	sys_pkey_free(pkey3);
+
+	info->core_time = time(NULL);
+
+	/* Crash. */
+	ptr = 0;
+	*ptr = 1;
+
+	/* Shouldn't get here. */
+	FAIL_IF(true);
+
+	return TEST_FAIL;
+}
+
+/* Return file size if filename exists and pass sanity check, or zero if not. */
+static off_t try_core_file(const char *filename, struct shared_info *info,
+			   pid_t pid)
+{
+	struct stat buf;
+	int ret;
+
+	ret = stat(filename, &buf);
+	if (ret == -1)
+		return TEST_FAIL;
+
+	/* Make sure we're not using a stale core file. */
+	return buf.st_mtime >= info->core_time ? buf.st_size : TEST_FAIL;
+}
+
+static Elf64_Nhdr *next_note(Elf64_Nhdr *nhdr)
+{
+	return (void *) nhdr + sizeof(*nhdr) +
+		__ALIGN_KERNEL(nhdr->n_namesz, 4) +
+		__ALIGN_KERNEL(nhdr->n_descsz, 4);
+}
+
+static int check_core_file(struct shared_info *info, Elf64_Ehdr *ehdr,
+			   off_t core_size)
+{
+	unsigned long *regs;
+	Elf64_Phdr *phdr;
+	Elf64_Nhdr *nhdr;
+	size_t phdr_size;
+	void *p = ehdr, *note;
+	int ret;
+
+	ret = memcmp(ehdr->e_ident, ELFMAG, SELFMAG);
+	FAIL_IF(ret);
+
+	FAIL_IF(ehdr->e_type != ET_CORE);
+	FAIL_IF(ehdr->e_machine != EM_PPC64);
+	FAIL_IF(ehdr->e_phoff == 0 || ehdr->e_phnum == 0);
+
+	/*
+	 * e_phnum is at most 65535 so calculating the size of the
+	 * program header cannot overflow.
+	 */
+	phdr_size = sizeof(*phdr) * ehdr->e_phnum;
+
+	/* Sanity check the program header table location. */
+	FAIL_IF(ehdr->e_phoff + phdr_size < ehdr->e_phoff);
+	FAIL_IF(ehdr->e_phoff + phdr_size > core_size);
+
+	/* Find the PT_NOTE segment. */
+	for (phdr = p + ehdr->e_phoff;
+	     (void *) phdr < p + ehdr->e_phoff + phdr_size;
+	     phdr += ehdr->e_phentsize)
+		if (phdr->p_type == PT_NOTE)
+			break;
+
+	FAIL_IF((void *) phdr >= p + ehdr->e_phoff + phdr_size);
+
+	/* Find the NT_PPC_PKEY note. */
+	for (nhdr = p + phdr->p_offset;
+	     (void *) nhdr < p + phdr->p_offset + phdr->p_filesz;
+	     nhdr = next_note(nhdr))
+		if (nhdr->n_type == NT_PPC_PKEY)
+			break;
+
+	FAIL_IF((void *) nhdr >= p + phdr->p_offset + phdr->p_filesz);
+	FAIL_IF(nhdr->n_descsz == 0);
+
+	p = nhdr;
+	note = p + sizeof(*nhdr) + __ALIGN_KERNEL(nhdr->n_namesz, 4);
+
+	regs = (unsigned long *) note;
+
+	printf("%-30s AMR: %016lx IAMR: %016lx UAMOR: %016lx\n",
+	       core_read_running, regs[0], regs[1], regs[2]);
+
+	FAIL_IF(regs[0] != info->amr);
+	FAIL_IF(regs[1] != info->iamr);
+	FAIL_IF(regs[2] != info->uamor);
+
+	return TEST_PASS;
+}
+
+static int parent(struct shared_info *info, pid_t pid)
+{
+	char *filenames, *filename[3];
+	int fd, i, ret, status;
+	unsigned long regs[3];
+	off_t core_size;
+	void *core;
+
+	/*
+	 * Get the initial values for AMR, IAMR and UAMOR and communicate them
+	 * to the child.
+	 */
+	ret = ptrace_read_regs(pid, NT_PPC_PKEY, regs, 3);
+	PARENT_SKIP_IF_UNSUPPORTED(ret, &info->child_sync);
+	PARENT_FAIL_IF(ret, &info->child_sync);
+
+	info->amr = regs[0];
+	info->iamr = regs[1];
+	info->uamor = regs[2];
+
+	/* Wake up child so that it can set itself up. */
+	ret = prod_child(&info->child_sync);
+	PARENT_FAIL_IF(ret, &info->child_sync);
+
+	ret = wait(&status);
+	if (ret != pid) {
+		printf("Child's exit status not captured\n");
+		return TEST_FAIL;
+	} else if (!WIFSIGNALED(status) || !WCOREDUMP(status)) {
+		printf("Child didn't dump core\n");
+		return TEST_FAIL;
+	}
+
+	/* Construct array of core file names to try. */
+
+	filename[0] = filenames = malloc(PATH_MAX);
+	if (!filenames) {
+		perror("Error allocating memory");
+		return TEST_FAIL;
+	}
+
+	ret = snprintf(filename[0], PATH_MAX, "core-pkey.%d", pid);
+	if (ret < 0 || ret >= PATH_MAX) {
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	filename[1] = filename[0] + ret + 1;
+	ret = snprintf(filename[1], PATH_MAX - ret - 1, "core.%d", pid);
+	if (ret < 0 || ret >= PATH_MAX - ret - 1) {
+		ret = TEST_FAIL;
+		goto out;
+	}
+	filename[2] = "core";
+
+	for (i = 0; i < 3; i++) {
+		core_size = try_core_file(filename[i], info, pid);
+		if (core_size != TEST_FAIL)
+			break;
+	}
+
+	if (i == 3) {
+		printf("Couldn't find core file\n");
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	fd = open(filename[i], O_RDONLY);
+	if (fd == -1) {
+		perror("Error opening core file");
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	core = mmap(NULL, core_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (core == (void *) -1) {
+		perror("Error mmaping core file");
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = check_core_file(info, core, core_size);
+
+	munmap(core, core_size);
+	close(fd);
+	unlink(filename[i]);
+
+ out:
+	free(filenames);
+
+	return ret;
+}
+
+static int write_core_pattern(const char *core_pattern)
+{
+	size_t len = strlen(core_pattern), ret;
+	FILE *f;
+
+	f = fopen(core_pattern_file, "w");
+	if (!f) {
+		perror("Error writing to core_pattern file");
+		return TEST_FAIL;
+	}
+
+	ret = fwrite(core_pattern, 1, len, f);
+	fclose(f);
+	if (ret != len) {
+		perror("Error writing to core_pattern file");
+		return TEST_FAIL;
+	}
+
+	return TEST_PASS;
+}
+
+static int setup_core_pattern(char **core_pattern_, bool *changed_)
+{
+	FILE *f;
+	char *core_pattern;
+	int ret;
+
+	core_pattern = malloc(PATH_MAX);
+	if (!core_pattern) {
+		perror("Error allocating memory");
+		return TEST_FAIL;
+	}
+
+	f = fopen(core_pattern_file, "r");
+	if (!f) {
+		perror("Error opening core_pattern file");
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = fread(core_pattern, 1, PATH_MAX, f);
+	fclose(f);
+	if (!ret) {
+		perror("Error reading core_pattern file");
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	/* Check whether we can predict the name of the core file. */
+	if (!strcmp(core_pattern, "core") || !strcmp(core_pattern, "core.%p"))
+		*changed_ = false;
+	else {
+		ret = write_core_pattern("core-pkey.%p");
+		if (ret)
+			goto out;
+
+		*changed_ = true;
+	}
+
+	*core_pattern_ = core_pattern;
+	ret = TEST_PASS;
+
+ out:
+	if (ret)
+		free(core_pattern);
+
+	return ret;
+}
+
+static int core_pkey(void)
+{
+	char *core_pattern;
+	bool changed_core_pattern;
+	struct shared_info *info;
+	int shm_id;
+	int ret;
+	pid_t pid;
+
+	ret = setup_core_pattern(&core_pattern, &changed_core_pattern);
+	if (ret)
+		return ret;
+
+	shm_id = shmget(IPC_PRIVATE, sizeof(*info), 0777 | IPC_CREAT);
+	info = shmat(shm_id, NULL, 0);
+
+	ret = init_child_sync(&info->child_sync);
+	if (ret)
+		return ret;
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		ret = TEST_FAIL;
+	} else if (pid == 0)
+		ret = child(info);
+	else
+		ret = parent(info, pid);
+
+	shmdt(info);
+
+	if (pid) {
+		destroy_child_sync(&info->child_sync);
+		shmctl(shm_id, IPC_RMID, NULL);
+
+		if (changed_core_pattern)
+			write_core_pattern(core_pattern);
+	}
+
+	free(core_pattern);
+
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(core_pkey, "core_pkey");
+}
