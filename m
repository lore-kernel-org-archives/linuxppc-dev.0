Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gxKd6ZsZzF2Mv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 23:00:21 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id f7-v6so4269815plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 06:00:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
 -ffunction-sections/-fdata-sections for module build
Date: Wed,  9 May 2018 22:59:59 +1000
Message-Id: <20180509130001.24276-3-npiggin@gmail.com>
In-Reply-To: <20180509130001.24276-1-npiggin@gmail.com>
References: <20180509130001.24276-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modules do not tend to cope with -ffunction-sections, even though they
do not link with -gc-sections. It may be possible for unused symbols to
be trimmed from modules, but in general that would take much more work
in architecture module linker scripts.

For now, enable these only for kernel build.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 619a85ad716b..9dcbfb353f81 100644
--- a/Makefile
+++ b/Makefile
@@ -799,8 +799,8 @@ KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
-KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
+KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-ffunction-sections,)
+KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-fdata-sections,)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-- 
2.17.0
