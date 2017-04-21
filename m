Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w8sHj1KVmzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 09:23:44 +1000 (AEST)
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org, bamvor.zhangjian@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, dvhart@infradead.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, viro@zeniv.linux.org.uk,
 emilio.lopez@collabora.co.uk, mingo@kernel.org, luto@kernel.org,
 dave.hansen@linux.intel.com, dsafonov@virtuozzo.com, rkrcmar@redhat.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] selftests: lib.mk: define CLEAN macro to allow Makefiles
 to override clean
Date: Fri, 21 Apr 2017 17:14:44 -0600
Message-Id: <b39e21f8c47318d82be999aae310bdf6bcfc9bb9.1492815938.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1492815938.git.shuahkh@osg.samsung.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1492815938.git.shuahkh@osg.samsung.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define CLEAN macro to allow Makefiles to override common clean target
in lib.mk. This will help fix the following failures:

warning: overriding recipe for target 'clean'
../lib.mk:55: warning: ignoring old recipe for target 'clean'

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/lib.mk | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 775c589..959273c 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -51,8 +51,12 @@ endef
 emit_tests:
 	$(EMIT_TESTS)
 
-clean:
+define CLEAN
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
+endef
+
+clean:
+	$(CLEAN)
 
 $(OUTPUT)/%:%.c
 	$(LINK.c) $^ $(LDLIBS) -o $@
-- 
2.9.3
