Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0C9C9474ED
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 02:08:37 +1100 (EST)
Date: Wed, 4 Feb 2009 18:08:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090204150835.GA30027@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
Cc: linux-rt-users@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch gives arches more freedom on overwriting CFLAGS, specifically
on PowerPC we want to remove -fno-omit-frame-pointer flag.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7715b2c..d1ba93f 100644
--- a/Makefile
+++ b/Makefile
@@ -525,8 +525,6 @@ else
 KBUILD_CFLAGS	+= -O2
 endif
 
-include $(srctree)/arch/$(SRCARCH)/Makefile
-
 ifneq (CONFIG_FRAME_WARN,0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
@@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
 KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
+include $(srctree)/arch/$(SRCARCH)/Makefile
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
-- 
1.5.6.5
