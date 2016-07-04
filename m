Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdSW5hTqzDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:10:03 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdSW1nf9z9s65
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:10:03 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c74so15719684pfb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 00:10:03 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 5/6] powerpc/sparse: Pass endianness to sparse
Date: Mon,  4 Jul 2016 17:09:41 +1000
Message-Id: <1467616182-30886-5-git-send-email-dja@axtens.net>
In-Reply-To: <1467616182-30886-1-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Explicitly give sparse an endianness in the Makefile, so that it
doesn't get confused.

Normally we have #ifdef one and #else the other, so it doesn't usually
matter, but we have been bitten by it before, and indeed this patch
fixes a number of sparse errors.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 709a22a3e824..8617c71c3bdb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -181,6 +181,11 @@ KBUILD_CFLAGS	+= -pipe -Iarch/$(ARCH) $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
+ifdef CONFIG_CPU_BIG_ENDIAN
+CHECKFLAGS	+= -D__BIG_ENDIAN__
+else
+CHECKFLAGS	+= -D__LITTLE_ENDIAN__
+endif
 
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 
-- 
2.1.4
