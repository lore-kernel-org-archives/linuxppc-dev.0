Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S70c4Cr8zF219
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 17:34:40 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p6so3888634pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 00:34:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/4] kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
 -ffunction-sections/-fdata-sections for module build
Date: Fri, 20 Apr 2018 17:34:12 +1000
Message-Id: <20180420073414.23169-3-npiggin@gmail.com>
In-Reply-To: <20180420073414.23169-1-npiggin@gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
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
index e811e0c509c5..2ed651403bb4 100644
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
