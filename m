Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hM0x41cJzF2Sc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 15:17:21 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id a39-v6so600352pla.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 22:17:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/5] kbuild: call cc-option with the current set of
 KBUILD_CFLAGS
Date: Thu, 10 May 2018 15:16:57 +1000
Message-Id: <20180510051659.15356-4-npiggin@gmail.com>
In-Reply-To: <20180510051659.15356-1-npiggin@gmail.com>
References: <20180510051659.15356-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some cases, the options that gcc will accept depend on options it
has already been given. For example -m32 / -m64 and -mbig-endian /
-mlittle-endian can have this affect.

Passing in KBUILD_CFLAGS to cc-option allows an architecture to
set such basic machine types at the beginning, rather than override
CC itself.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/Kbuild.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 9f7eb10079cc..66869bb815d2 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -121,7 +121,7 @@ CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
 
 cc-option = $(call __cc-option, $(CC),\
-	$(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS),$(1),$(2))
+	$(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS),$(1),$(2))
 
 # hostcc-option
 # Usage: cflags-y += $(call hostcc-option,-march=winchip-c6,-march=i586)
@@ -131,12 +131,12 @@ hostcc-option = $(call __cc-option, $(HOSTCC),\
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
 cc-option-yn = $(call try-run,\
-	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
+	$(CC) -Werror $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
 
 # cc-disable-warning
 # Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
 cc-disable-warning = $(call try-run,\
-	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
+	$(CC) -Werror $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
 # cc-name
 # Expands to either gcc or clang
@@ -160,7 +160,7 @@ cc-if-fullversion = $(shell [ $(cc-fullversion) $(1) $(2) ] && echo $(3) || echo
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
 cc-ldoption = $(call try-run,\
-	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) $(1) $(KBUILD_CFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
-- 
2.17.0
