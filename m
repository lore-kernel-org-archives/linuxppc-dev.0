Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEBD81A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:38:15 +1100 (AEDT)
Message-ID: <1444815495.1843.3.camel@ellerman.id.au>
Subject: Re: [v2,1/1] powerpc: Individual System V IPC system calls
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Date: Wed, 14 Oct 2015 20:38:15 +1100
In-Reply-To: <20151014070029.GA8383@tungsten.ozlabs.ibm.com>
References: <a3cfb270cd61cc3aacdf929e7739ae46dcff86bd.1444700960.git.sam.bobroff@au1.ibm.com>
 <20151013093842.B3EA21402D6@ozlabs.org>
 <20151014070029.GA8383@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-14 at 18:00 +1100, Sam Bobroff wrote:
> On Tue, Oct 13, 2015 at 08:38:42PM +1100, Michael Ellerman wrote:
> > On Tue, 2015-13-10 at 01:49:28 UTC, Sam bobroff wrote:
> > > This patch provides individual system call numbers for the following
> > > System V IPC system calls, on PowerPC, so that they do not need to be
> > > multiplexed:
> > > * semop, semget, semctl, semtimedop
> > > * msgsnd, msgrcv, msgget, msgctl
> > > * shmat, shmdt, shmget, shmctl
> > 
> > You tested this right? :)  Tell me about it.
> 
> Why yes I did:

...

> (I also re-ran the tests both for little-endian and big-endian hosts.)

Did you test on 32-bit at all?

> It would obviously be good to have someone else test this, but I can't see a
> way to make it easy to do. They would presumably have to go through all of the
> above, which seems too much to ask given how trivial the kernel side of the
> patch is. Still, it bothers me a bit so if there is any way please let me know.
> (I thought about writing some assembly to directly test the syscall numbers but
> all it would do is verify that the numbers are valid, which really isn't much
> of a test.)

Actually that is still a useful test, it at least tells you if the kernel
you're running on implements the syscalls. Obviously if you're on mainline
that's easy enough to work out from the git history, but if/when these get
backported to distro kernels, it's often harder to work out what's in the
source than just testing it directly.

So I wrote a quick dirty test for that, it seems to work for me:

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 847adf6e8d16..b120dc11aebe 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -12,7 +12,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CFLAGS
 
-SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian dscr benchmarks
+SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian dscr benchmarks syscalls
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/syscalls/Makefile b/tools/testing/selftests/powerpc/syscalls/Makefile
new file mode 100644
index 000000000000..b35c7945bec5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/Makefile
@@ -0,0 +1,12 @@
+TEST_PROGS := ipc_unmuxed
+
+CFLAGS += -I../../../../../usr/include
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/syscalls/ipc.h b/tools/testing/selftests/powerpc/syscalls/ipc.h
new file mode 100644
index 000000000000..fbebc022edf6
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/ipc.h
@@ -0,0 +1,47 @@
+#ifdef __NR_semop
+DO_TEST(semop, __NR_semop)
+#endif
+
+#ifdef __NR_semget
+DO_TEST(semget, __NR_semget)
+#endif
+
+#ifdef __NR_semctl
+DO_TEST(semctl, __NR_semctl)
+#endif
+
+#ifdef __NR_semtimedop
+DO_TEST(semtimedop, __NR_semtimedop)
+#endif
+
+#ifdef __NR_msgsnd
+DO_TEST(msgsnd, __NR_msgsnd)
+#endif
+
+#ifdef __NR_msgrcv
+DO_TEST(msgrcv, __NR_msgrcv)
+#endif
+
+#ifdef __NR_msgget
+DO_TEST(msgget, __NR_msgget)
+#endif
+
+#ifdef __NR_msgctl
+DO_TEST(msgctl, __NR_msgctl)
+#endif
+
+#ifdef __NR_shmat
+DO_TEST(shmat, __NR_shmat)
+#endif
+
+#ifdef __NR_shmdt
+DO_TEST(shmdt, __NR_shmdt)
+#endif
+
+#ifdef __NR_shmget
+DO_TEST(shmget, __NR_shmget)
+#endif
+
+#ifdef __NR_shmctl
+DO_TEST(shmctl, __NR_shmctl)
+#endif
diff --git a/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c b/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c
new file mode 100644
index 000000000000..2ac02706f8c8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright 2015, Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test simply tests that certain syscalls are implemented. It doesn't
+ * actually exercise their logic in any way.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "utils.h"
+
+
+#define DO_TEST(_name, _num)	\
+static int test_##_name(void)			\
+{						\
+	int rc;					\
+	printf("Testing " #_name);		\
+	errno = 0;				\
+	rc = syscall(_num, -1, 0, 0, 0, 0, 0);	\
+	printf("\treturned %d, errno %d\n", rc, errno); \
+	return errno == ENOSYS;			\
+}
+
+#include "ipc.h"
+#undef DO_TEST
+
+static int ipc_unmuxed(void)
+{
+	int tests_done = 0;
+
+#define DO_TEST(_name, _num)		\
+	FAIL_IF(test_##_name());	\
+	tests_done++;
+
+#include "ipc.h"
+#undef DO_TEST
+
+	/*
+	 * If we ran no tests then it means none of the syscall numbers were
+	 * defined, possibly because we were built against old headers. But it
+	 * means we didn't really test anything, so instead of passing mark it
+	 * as a skip to give the user a clue.
+	 */
+	SKIP_IF(tests_done == 0);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(ipc_unmuxed, "ipc_unmuxed");
+}


Which gives:

test: ipc_unmuxed
tags: git_version:v4.3-rc3-44-g10053fa531a8-dirty
Testing semop	returned -1, errno 22
Testing semget	returned -1, errno 2
Testing semctl	returned -1, errno 22
Testing semtimedop	returned -1, errno 22
Testing msgsnd	returned -1, errno 14
Testing msgrcv	returned -1, errno 22
Testing msgget	returned -1, errno 2
Testing msgctl	returned -1, errno 22
Testing shmat	returned -1, errno 22
Testing shmdt	returned -1, errno 22
Testing shmget	returned -1, errno 2
Testing shmctl	returned -1, errno 22
success: ipc_unmuxed


And on an unpatched system:

test: ipc_unmuxed
tags: git_version:v4.3-rc3-44-g10053fa531a8-dirty
Testing semop	returned -1, errno 38
[FAIL] Test FAILED on line 2
failure: ipc_unmuxed


Look OK?

cheers
