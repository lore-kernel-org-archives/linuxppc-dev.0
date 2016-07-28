Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Gpf4C4WzDrLh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 13:01:30 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so2699642pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:01:30 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH v13 30/30] selftests/powerpc: Fix a build issue
Date: Thu, 28 Jul 2016 10:57:59 +0800
Message-Id: <1469674679-8580-31-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
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

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
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
