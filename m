Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com
 [IPv6:2607:f8b0:4002:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C3271A002C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 07:13:47 +1000 (EST)
Received: by mail-yh0-f53.google.com with SMTP id c41so4998678yho.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 14:13:44 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ppc: Fix build error with CONFIG_PCI=n
Date: Mon, 18 Aug 2014 17:13:41 -0400
Message-Id: <1408396422-32658-1-git-send-email-bobby.prani@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, geert@linux-m68k.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix ppc 32 build failure as reported here:

http://kisskb.ellerman.id.au/kisskb/buildresult/11663513/

The error is as follows:

arch/powerpc/include/asm/floppy.h:142:20: error: 'isa_bridge_pcidev' undeclared
(first use in this function)

This is happening since floppy.o is enabled by BLK_DEV_FD which depends on
ARCH_MAY_HAVE_PC_FDC which is in-turn enabled if PPC_PSERIES=n. 

The following commit changes the dependency so that ARCH_MAY_HAVE_PC_FDC is
dependent exclusively on PCI since otherwise it will not compile.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a577609f..9c1aa77 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -182,7 +182,7 @@ config SCHED_OMIT_FRAME_POINTER
 
 config ARCH_MAY_HAVE_PC_FDC
 	bool
-	default !PPC_PSERIES || PCI
+	default PCI
 
 config PPC_OF
 	def_bool y
-- 
1.9.1
