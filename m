Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8yB13q4fzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:03:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/5] powerpc/Makefile: CROSS32AS is unused, remove it
Date: Thu, 11 Aug 2016 16:03:11 +1000
Message-Id: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In fact it makes no sense at all to have this defined on little endian
builds. Since we disabled the 32-bit VDSO on little endian, we don't
build any 32-bit code when building a little endian kernel.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1934707bf321..ff3369b01666 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -67,7 +67,6 @@ UTS_MACHINE := $(OLDARCH)
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 override LD	+= -EL
-override CROSS32AS += -mlittle-endian
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
-- 
2.7.4
