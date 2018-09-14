Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BNpv5dwtzF3VB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 15:09:11 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id s17-v6so3618953plp.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:09:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer
Date: Fri, 14 Sep 2018 15:08:54 +1000
Message-Id: <20180914050854.6214-4-npiggin@gmail.com>
In-Reply-To: <20180914050854.6214-1-npiggin@gmail.com>
References: <20180914050854.6214-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index be47cf8a0798..07d9dce7eda6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -165,8 +165,12 @@ CC_FLAGS_FTRACE := -pg
 ifdef CONFIG_MPROFILE_KERNEL
 CC_FLAGS_FTRACE += -mprofile-kernel
 endif
-# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
-CC_FLAGS_FTRACE	+= -mno-sched-epilog
+# Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
+ifneq ($(cc-name),clang)
+CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
+endif
 endif
 
 CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
-- 
2.18.0
