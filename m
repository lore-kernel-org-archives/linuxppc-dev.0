Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJsPz6mD0zDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 19:56:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: shuahkh@osg.samsung.com,
	bamvor.zhangjian@huawei.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 3/5] selftests: Fix the .S and .S -> .o rules
Date: Thu,  9 Feb 2017 19:56:28 +1100
Message-Id: <1486630590-9410-3-git-send-email-mpe@ellerman.id.au>
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

Both these rules incorrectly use $< (first prerequisite) rather than
$^ (all prerequisites), meaning they don't work if we're using more than
one .S file as input. Switch them to using $^.

They also don't include $(CPPFLAGS) and other variables used in the
default rules, which breaks targets that require those. Fix that by
using the builtin $(COMPILE.S) and $(LINK.S) rules.

Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/lib.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 98841c54763a..ce96d80ad64f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -54,9 +54,9 @@ $(OUTPUT)/%:%.c
 	$(LINK.c) $^ $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
-	$(CC) $(ASFLAGS) -c $< -o $@
+	$(COMPILE.S) $^ -o $@
 
 $(OUTPUT)/%:%.S
-	$(CC) $(ASFLAGS) $< -o $@
+	$(LINK.S) $^ $(LDLIBS) -o $@
 
 .PHONY: run_tests all clean install emit_tests
-- 
2.7.4
