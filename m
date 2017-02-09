Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJsPz0D8kzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 19:56:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: shuahkh@osg.samsung.com,
	bamvor.zhangjian@huawei.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/5] selftests: Fix the .c linking rule
Date: Thu,  9 Feb 2017 19:56:27 +1100
Message-Id: <1486630590-9410-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we can't build some tests, for example:

  $ make -C tools/testing/selftests/ TARGETS=vm
  ...
  gcc -Wall -I ../../../../usr/include   -lrt -lpthread ../../../../usr/include/linux/kernel.h userfaultfd.c -o tools/testing/selftests/vm/userfaultfd
  /tmp/ccmOkQSM.o: In function `stress':
  userfaultfd.c:(.text+0xc60): undefined reference to `pthread_create'
  userfaultfd.c:(.text+0xca5): undefined reference to `pthread_create'
  userfaultfd.c:(.text+0xcee): undefined reference to `pthread_create'
  userfaultfd.c:(.text+0xd30): undefined reference to `pthread_create'
  userfaultfd.c:(.text+0xd77): undefined reference to `pthread_join'
  userfaultfd.c:(.text+0xe7d): undefined reference to `pthread_join'
  userfaultfd.c:(.text+0xe9f): undefined reference to `pthread_cancel'
  userfaultfd.c:(.text+0xec6): undefined reference to `pthread_join'
  userfaultfd.c:(.text+0xf14): undefined reference to `pthread_join'
  /tmp/ccmOkQSM.o: In function `userfaultfd_stress':
  userfaultfd.c:(.text+0x13e2): undefined reference to `pthread_attr_setstacksize'
  collect2: error: ld returned 1 exit status

This is because the rule for linking .c files to binaries is incorrect.

The first bug is that it uses $< (first prerequisite) instead of $^ (all
preqrequisites), fix it by using ^$.

Secondly the ordering of the prerequisites vs $(LDLIBS) is wrong,
meaning on toolchains that use --as-needed we fail to link (as above).
Fix that by placing $(LDLIBS) *after* ^$.

Finally switch to using the default rule $(LINK.c), so that we get
$(CPPFLAGS) etc. included.

Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 17ed4bbe3963..98841c54763a 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -51,7 +51,7 @@ clean:
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
 
 $(OUTPUT)/%:%.c
-	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $< -o $@
+	$(LINK.c) $^ $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
 	$(CC) $(ASFLAGS) -c $< -o $@
-- 
2.7.4
