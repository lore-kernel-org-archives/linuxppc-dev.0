Return-Path: <rupran@einserver.de>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D88EA1A0C6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 22:05:41 +1100 (AEDT)
Received: by mail-wi0-f179.google.com with SMTP id ex7so15668459wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 03:05:38 -0800 (PST)
From: Andreas Ruprecht <rupran@einserver.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: lib: Do not include string.o in obj-y twice
Date: Wed, 17 Dec 2014 12:05:13 +0100
Message-Id: <1418814313-21461-1-git-send-email-rupran@einserver.de>
Cc: Andreas Ruprecht <rupran@einserver.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the Makefile, string.o (which is generated from string.S) is
included into the list of objects being built unconditionally
(obj-y) in line 12.

Additionally, if CONFIG_PPC64 is set, it is included again in
line 17.

This patch removes the latter unnecessary inclusion.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
---
 arch/powerpc/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 597562f69b2d..1b01159b81f3 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -14,8 +14,7 @@ obj-y			:= string.o alloc.o \
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
-			   usercopy_64.o mem_64.o string.o \
-			   hweight_64.o \
+			   usercopy_64.o mem_64.o hweight_64.o \
 			   copyuser_power7.o string_64.o copypage_power7.o
 ifeq ($(CONFIG_GENERIC_CSUM),)
 obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
-- 
1.9.1
