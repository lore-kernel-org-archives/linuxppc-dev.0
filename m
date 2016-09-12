Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXfjG6Rf8zDsPC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 17:35:14 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i75so2777657pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:35:14 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v14 15/15] selftests/powerpc: Fix a build issue
Date: Mon, 12 Sep 2016 15:33:25 +0800
Message-Id: <1473665605-11890-16-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
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
