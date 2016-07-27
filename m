Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzqTq0sPHzDqpW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:30:23 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so1470018pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 02:30:22 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v12 30/30] selftests/powerpc: Fix a build issue
Date: Wed, 27 Jul 2016 17:26:55 +0800
Message-Id: <1469611615-2935-31-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Fixes the following build failure -

cp_abort.c:90:3: error: ‘for’ loop initial declarations are only
allowed in C99 or C11 mode
   for (int i = 0; i < NUM_LOOPS; i++) {
   ^
cp_abort.c:90:3: note: use option -std=c99, -std=gnu99, -std=c11 or
-std=gnu11 to compile your code
cp_abort.c:97:3: error: ‘for’ loop initial declarations are only
allowed in C99 or C11 mode
   for (int i = 0; i < NUM_LOOPS; i++) {

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/context_switch/cp_abort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/context_switch/cp_abort.c b/tools/testing/selftests/powerpc/context_switch/cp_abort.c
index 5a5b55a..1ce7dce 100644
--- a/tools/testing/selftests/powerpc/context_switch/cp_abort.c
+++ b/tools/testing/selftests/powerpc/context_switch/cp_abort.c
@@ -67,7 +67,7 @@ int test_cp_abort(void)
 	/* 128 bytes for a full cache line */
 	char buf[128] __cacheline_aligned;
 	cpu_set_t cpuset;
-	int fd1[2], fd2[2], pid;
+	int fd1[2], fd2[2], pid, i;
 	char c;
 
 	/* only run this test on a P9 or later */
@@ -87,14 +87,14 @@ int test_cp_abort(void)
 	FAIL_IF(pid < 0);
 
 	if (!pid) {
-		for (int i = 0; i < NUM_LOOPS; i++) {
+		for (i = 0; i < NUM_LOOPS; i++) {
 			FAIL_IF((write(fd1[WRITE_FD], &c, 1)) != 1);
 			FAIL_IF((read(fd2[READ_FD], &c, 1)) != 1);
 			/* A paste succeeds if CR0 EQ bit is set */
 			FAIL_IF(paste(buf) & 0x20000000);
 		}
 	} else {
-		for (int i = 0; i < NUM_LOOPS; i++) {
+		for (i = 0; i < NUM_LOOPS; i++) {
 			FAIL_IF((read(fd1[READ_FD], &c, 1)) != 1);
 			copy(buf);
 			FAIL_IF((write(fd2[WRITE_FD], &c, 1) != 1));
-- 
1.8.3.1
