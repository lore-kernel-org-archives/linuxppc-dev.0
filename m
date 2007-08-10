Return-Path: <roland@redhat.com>
Received: from alnrmhc11.comcast.net (alnrmhc11.comcast.net [204.127.225.91])
	by ozlabs.org (Postfix) with ESMTP id 2D6DDDDE18
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 09:10:43 +1000 (EST)
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerfc fix for assembler -g
Message-Id: <20070810230311.34CFFD0136@magilla.localdomain>
Date: Fri, 10 Aug 2007 16:03:11 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc64 does the unusual thing of using #include on a compiler-generated
assembly file (lparmap.s) from an assembly source file (head_64.S).
This runs afoul of my recent patch to pass -gdwarf2 to the assembler
under CONFIG_DEBUG_INFO.  This patch avoids the problem by disabling
DWARF generation (-g0) when producing lparmap.s.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f39a72f..b0cb2e6 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -81,6 +81,7 @@ obj-y				+= iomap.o
 endif
 
 ifeq ($(CONFIG_PPC_ISERIES),y)
+CFLAGS_lparmap.s		+= -g0
 extra-y += lparmap.s
 $(obj)/head_64.o:	$(obj)/lparmap.s
 AFLAGS_head_64.o += -I$(obj)
