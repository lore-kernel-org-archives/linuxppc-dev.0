Return-Path: <linuxppc-dev+bounces-28289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A58C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 18:35:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsbqQ6Rtxz30Wg;
	Sun, 27 Sep 2026 04:35:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790431106;
	cv=none; b=N/CgTWnuIpmZ/lHeyudblSYsjedlLNempVLcSgq5B8jaAuXCDFn3HHzHNVXia6RZ9i2x8VYvan7C4dDEortkneFvK3+H7n9DWy6OV+CDLWrZLsCjvM5Yzg6RmlQhjxf24bw30KB8alFay3o+wDiikrb9KqLrcQnHZhcALYP9xm8H66z1FRBmnrhNAWczEw8zy5jKhzCnB38LGLESNSofTkcfx1WWnLuvpF0DADsJRO1CQw1UQ7QvCHBuEv0SaSSGBeDEDT3+uEFBoB/VKXH0AUJSp7XB6WG5JEUn/oBbBeLTwytMOiKUCX5dHRau0depM0JAnGuks/Kq/cdc1ffwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790431106; c=relaxed/relaxed;
	bh=EjdYZ3VKKF1InlgDUWnPIDtgkfv1q4IajM0FqAHof5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfrO/DSbUph5qiK5YnShEsPjRPAyNZQzmTB4OQJSkr+UxP/kLBKGVv3VyUjM4Z6qThkkVPFQMk1MJW4tQh0t+MDvlUppDFjLfxske23iAfyE3NDzBPTHqNGK8yFmVQqSZwVPj+oh+HA6dC64zLQ162tJpDwP4H07x0BspU0t4E3nHlqy4Ifdep9bb3M0StvGcsU4geSmQbiSocQPr8si4RtmFJTPHKPTgu8ieH82Rq49B4wYKdrnY4Fud3P1qxqYAvulBcnDa/93LHTqqW+5yyoV8e4zCHQ6u1dgYItSnHR5lsli7q6SnRT1B9RxcrNEInKip85BObeyHE/Dgr8hoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EfARv9qi; dkim-atps=neutral; spf=pass (client-ip=95.215.58.23; helo=mta1.migadu.com; envelope-from=florent.revest@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EfARv9qi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.23; helo=mta1.migadu.com; envelope-from=florent.revest@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 95 seconds by postgrey-1.37 at boromir; Sat, 26 Sep 2026 23:58:24 AEST
Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsTgN5ywJz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 23:58:24 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=71AplhEfg8Kb6ywCW/rLjYtlQ9W7O82jHDKQEeD9aeI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790431086; v=1; x=1791035886;
 b=EfARv9qi/g5KpfiGzbnhL34ZGBzT2yJb1zHmDrRFN0uoOK3ZKRXXMgJUQKFE4hvvcP1TXgLK
 V6u7c058zY4dGQ5+Qx9rDpMkGr7Czr1Qeu/4r0sRr1Adh8EvGFBvSNjqB/F4ye4df4GxEqDRUzE
 wf2y0Em/pcZrnkvo6cAX83vA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d708e1a7eb266324;
	Sat, 26 Sep 2026 13:56:44 +0000
X-Mizu-Trace-ID: d708e1a7eb266324
X-Migadu-Flow: FLOW_OUT
From: "Florent Revest (Anthropic)" <florent.revest@linux.dev>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Junseo Lim <zirajs7@gmail.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	linux-kernel@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH bpf v5 3/3] selftests/bpf: Detach a trampoline prog while a task sleeps before it
Date: Sat, 26 Sep 2026 13:56:00 +0000
Message-ID: <20260926135605.1217928-4-florent.revest@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926135605.1217928-1-florent.revest@linux.dev>
References: <20260926135605.1217928-1-florent.revest@linux.dev>
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

Add a test for the use-after-free fixed by the previous commit. A
sleepable prog on bpf_fentry_test1() blocks a task on a userfaultfd
page, like bpf_mod_race does, while the two progs that run after it in
the same trampoline are detached and freed one after the other, which
the test knows from their .bss maps going away. After the first detach
the task is in an image that isn't the trampoline's current one
anymore. The task is then released and must not call into the freed
progs. This is done with fentry progs, with fexit progs, where the task
is already past the original function, and with a task sleeping in a
fentry prog while fexit progs are detached, where the original function
must still be called. bpf_mod_race's userfaultfd helper moves to
testing_helpers.c so that both tests can use it.

Without the fix, on a kernel with KASAN:

  BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0xed/0x1e0
  Read of size 8 at addr ffa0000000144040 by task test_progs/171
  CPU: 6 UID: 0 PID: 171 Comm: test_progs Tainted: G           OE       7.2.0+ #1 PREEMPT(full)
  Call Trace:
   <TASK>
   __bpf_prog_enter_recur+0xed/0x1e0
   bpf_trampoline_6442545468+0x72/0xe3
   bpf_fentry_test1+0x9/0x20
   bpf_prog_test_run_tracing+0x183/0x3e0
   __sys_bpf+0xd3f/0x38f0
   ...

Assisted-by: Claude:unspecified
Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
---
 .../selftests/bpf/prog_tests/bpf_mod_race.c   |  34 +---
 .../bpf/prog_tests/tramp_prog_detach.c        | 188 ++++++++++++++++++
 .../selftests/bpf/progs/tramp_prog_detach.c   |  56 ++++++
 tools/testing/selftests/bpf/testing_helpers.c |  28 +++
 tools/testing/selftests/bpf/testing_helpers.h |   2 +
 5 files changed, 275 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tramp_prog_detach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
index ecc3d47919ad..f8497e764beb 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
@@ -55,38 +55,6 @@ static void *load_module_thread(void *p)
 	return p;
 }
 
-static int sys_userfaultfd(int flags)
-{
-	return syscall(__NR_userfaultfd, flags);
-}
-
-static int test_setup_uffd(void *fault_addr)
-{
-	struct uffdio_register uffd_register = {};
-	struct uffdio_api uffd_api = {};
-	int uffd;
-
-	uffd = sys_userfaultfd(O_CLOEXEC);
-	if (uffd < 0)
-		return -errno;
-
-	uffd_api.api = UFFD_API;
-	uffd_api.features = 0;
-	if (ioctl(uffd, UFFDIO_API, &uffd_api)) {
-		close(uffd);
-		return -1;
-	}
-
-	uffd_register.range.start = (unsigned long)fault_addr;
-	uffd_register.range.len = getpagesize();
-	uffd_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffd_register)) {
-		close(uffd);
-		return -1;
-	}
-	return uffd;
-}
-
 static void test_bpf_mod_race_config(const struct test_config *config)
 {
 	void *fault_addr, *skel_fail;
@@ -117,7 +85,7 @@ static void test_bpf_mod_race_config(const struct test_config *config)
 	if (!ASSERT_OK(bpf_mod_race__attach(skel), "bpf_mod_kfunc_race__attach"))
 		goto end_destroy;
 
-	uffd = test_setup_uffd(fault_addr);
+	uffd = uffd_block_page(fault_addr);
 	if (!ASSERT_GE(uffd, 0, "userfaultfd open + register address"))
 		goto end_destroy;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
new file mode 100644
index 000000000000..1eb0d7237605
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <pthread.h>
+#include <poll.h>
+#include <sys/mman.h>
+#include <linux/userfaultfd.h>
+#include "tramp_prog_detach.skel.h"
+#include "testing_helpers.h"
+
+/*
+ * Detach and free progs while a task sleeps in the prog that runs before them
+ * in the same trampoline image, then let that task continue through the
+ * image. It must not call into the freed progs.
+ *
+ * The task is held in a sleepable prog with userfaultfd, like bpf_mod_race
+ * does.
+ */
+
+static struct bpf_program *pick_prog(struct tramp_prog_detach *skel,
+				     bool fexit, bool sleepable)
+{
+	if (fexit)
+		return sleepable ? skel->progs.fexit_sleepable :
+				   skel->progs.fexit_victim;
+	return sleepable ? skel->progs.fentry_sleepable :
+			   skel->progs.fentry_victim;
+}
+
+static struct bpf_program *sleepable_prog;
+
+static void *run_sleepable(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	/* calls bpf_fentry_test1() */
+	return (void *)(long)bpf_prog_test_run_opts(bpf_program__fd(sleepable_prog),
+						    &topts);
+}
+
+static struct tramp_prog_detach *load_one(bool fexit, bool sleepable)
+{
+	struct tramp_prog_detach *skel;
+	int err;
+
+	skel = tramp_prog_detach__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+
+	bpf_program__set_autoload(pick_prog(skel, fexit, sleepable), true);
+	err = tramp_prog_detach__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto err;
+	skel->bss->pid = getpid();
+	err = tramp_prog_detach__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto err;
+	return skel;
+err:
+	tramp_prog_detach__destroy(skel);
+	return NULL;
+}
+
+/* The .bss map of a destroyed skeleton goes away when its prog is freed */
+static bool wait_for_map_free(__u32 map_id)
+{
+	int i, fd;
+
+	for (i = 0; i < 100; i++) {
+		fd = bpf_map_get_fd_by_id(map_id);
+		if (fd < 0)
+			return true;
+		close(fd);
+		usleep(100 * 1000);
+	}
+	return false;
+}
+
+static void test_detach(bool sleepable_fexit, bool victim_fexit)
+{
+	struct tramp_prog_detach *sleepable = NULL, *victims[2] = {};
+	struct pollfd pfd = { .events = POLLIN };
+	struct uffdio_copy uffd_copy = {};
+	struct bpf_map_info map_info = {};
+	__u32 map_info_len = sizeof(map_info);
+	struct uffd_msg uffd_msg;
+	void *fault_page, *src_page = MAP_FAILED;
+	long page_size = getpagesize();
+	bool started = false;
+	void *thread_ret;
+	pthread_t thread;
+	int i, uffd = -1;
+
+	fault_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(fault_page, MAP_FAILED, "mmap fault_page"))
+		return;
+	src_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(src_page, MAP_FAILED, "mmap src_page"))
+		goto out;
+
+	/* The most recently attached prog runs first */
+	for (i = 0; i < ARRAY_SIZE(victims); i++) {
+		victims[i] = load_one(victim_fexit, false);
+		if (!victims[i])
+			goto out;
+	}
+	sleepable = load_one(sleepable_fexit, true);
+	if (!sleepable)
+		goto out;
+	sleepable_prog = pick_prog(sleepable, sleepable_fexit, true);
+
+	/* Not armed yet so this doesn't block, make sure sleepable runs first */
+	if (!ASSERT_OK((long)run_sleepable(NULL), "dry run"))
+		goto out;
+	for (i = 0; i < ARRAY_SIZE(victims); i++)
+		if (!ASSERT_LT(sleepable->bss->ts, victims[i]->bss->ts, "prog order"))
+			goto out;
+
+	uffd = uffd_block_page(fault_page);
+	if (!ASSERT_GE(uffd, 0, "userfaultfd open + register address"))
+		goto out;
+	sleepable->bss->fault_addr = fault_page;
+
+	if (!ASSERT_OK(pthread_create(&thread, NULL, run_sleepable, NULL),
+		       "pthread_create"))
+		goto out;
+	started = true;
+
+	/* Wait for the thread to sleep in bpf_copy_from_user() */
+	pfd.fd = uffd;
+	if (!ASSERT_EQ(poll(&pfd, 1, 10000), 1, "poll uffd"))
+		goto out;
+	if (!ASSERT_EQ(read(uffd, &uffd_msg, sizeof(uffd_msg)), sizeof(uffd_msg),
+		       "read uffd"))
+		goto out;
+	if (!ASSERT_EQ(uffd_msg.event, UFFD_EVENT_PAGEFAULT, "uffd pagefault"))
+		goto out;
+
+	/*
+	 * Detach and unload the victim progs and wait for them to be freed.
+	 * After the first one, the task is in an image that isn't the
+	 * trampoline's current one anymore.
+	 */
+	for (i = 0; i < ARRAY_SIZE(victims); i++) {
+		if (!ASSERT_OK(bpf_map_get_info_by_fd(bpf_map__fd(victims[i]->maps.bss),
+						      &map_info, &map_info_len),
+			       "victim bss info"))
+			goto out;
+		tramp_prog_detach__destroy(victims[i]);
+		victims[i] = NULL;
+		if (!ASSERT_TRUE(wait_for_map_free(map_info.id), "victim freed"))
+			goto out;
+	}
+
+out:
+	/* Let the thread proceed with the rest of the trampoline */
+	if (uffd >= 0) {
+		uffd_copy.dst = (unsigned long)fault_page;
+		uffd_copy.src = (unsigned long)src_page;
+		uffd_copy.len = page_size;
+		ASSERT_OK(ioctl(uffd, UFFDIO_COPY, &uffd_copy), "uffd copy");
+		close(uffd);
+	}
+	if (started &&
+	    ASSERT_OK(pthread_join(thread, &thread_ret), "pthread_join"))
+		ASSERT_NULL(thread_ret, "blocking run");
+
+	for (i = 0; i < ARRAY_SIZE(victims); i++)
+		tramp_prog_detach__destroy(victims[i]);
+	tramp_prog_detach__destroy(sleepable);
+	if (src_page != MAP_FAILED)
+		munmap(src_page, page_size);
+	munmap(fault_page, page_size);
+}
+
+void serial_test_tramp_prog_detach(void)
+{
+	/* a task sleeping before the original function is called */
+	if (test__start_subtest("fentry"))
+		test_detach(false, false);
+	/* a task sleeping after the original function returned */
+	if (test__start_subtest("fexit"))
+		test_detach(true, true);
+	/* the original function runs in between and must still be called */
+	if (test__start_subtest("fentry_fexit"))
+		test_detach(false, true);
+}
diff --git a/tools/testing/selftests/bpf/progs/tramp_prog_detach.c b/tools/testing/selftests/bpf/progs/tramp_prog_detach.c
new file mode 100644
index 000000000000..507d372167ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tramp_prog_detach.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+void *fault_addr;
+__u64 ts;
+
+static int do_sleepable(void)
+{
+	char dst;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	ts = bpf_ktime_get_ns();
+	/* blocks for as long as user space wants when fault_addr is armed */
+	bpf_copy_from_user(&dst, sizeof(dst), fault_addr);
+	return 0;
+}
+
+static int do_victim(void)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	ts = bpf_ktime_get_ns();
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+int BPF_PROG(fentry_sleepable, int a)
+{
+	return do_sleepable();
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_victim, int a)
+{
+	return do_victim();
+}
+
+SEC("?fexit.s/bpf_fentry_test1")
+int BPF_PROG(fexit_sleepable, int a, int ret)
+{
+	return do_sleepable();
+}
+
+SEC("?fexit/bpf_fentry_test1")
+int BPF_PROG(fexit_victim, int a, int ret)
+{
+	return do_victim();
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index c970e7793dfc..9f672d0c9dda 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -13,6 +13,7 @@
 #include "test_progs.h"
 #include "testing_helpers.h"
 #include <linux/membarrier.h>
+#include <linux/userfaultfd.h>
 
 int parse_num_list(const char *s, bool **num_set, int *num_set_len)
 {
@@ -459,6 +460,33 @@ int kern_sync_rcu(void)
 	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
 }
 
+int uffd_block_page(void *fault_addr)
+{
+	struct uffdio_register uffd_register = {};
+	struct uffdio_api uffd_api = {};
+	int uffd;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
+	if (uffd < 0)
+		return -errno;
+
+	uffd_api.api = UFFD_API;
+	uffd_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffd_api)) {
+		close(uffd);
+		return -1;
+	}
+
+	uffd_register.range.start = (unsigned long)fault_addr;
+	uffd_register.range.len = getpagesize();
+	uffd_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffd_register)) {
+		close(uffd);
+		return -1;
+	}
+	return uffd;
+}
+
 int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
 {
 	__u32 buf_element_size = sizeof(struct bpf_insn);
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 2edc6fb7fc52..1f83b6080716 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -36,6 +36,8 @@ __u64 read_perf_max_sample_freq(void);
 int load_bpf_testmod(bool verbose);
 int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
+/* returns a userfaultfd that makes accesses to fault_addr's page block */
+int uffd_block_page(void *fault_addr);
 int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
 int load_module(const char *path, bool verbose);
-- 
2.55.0


