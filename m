Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7C2L08sBzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 19:35:38 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so24775326pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 02:35:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/64be: must build vdso32 as BE on LE host
Date: Mon,  8 Aug 2016 19:35:27 +1000
Message-Id: <1470648927-15590-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vdso32 should be built with `gcc -m32 --big-endian` when compiling a big
endian kernel.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 709a22a..bf183b2a 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -82,6 +82,8 @@ else
 ifeq ($(call cc-option-yn,-mbig-endian),y)
 override CC	+= -mbig-endian
 override AS	+= -mbig-endian
+override CROSS32CC += -mbig-endian
+override CROSS32AS += -mbig-endian
 endif
 override LD	+= -EB
 LDEMULATION	:= ppc
-- 
2.8.1
