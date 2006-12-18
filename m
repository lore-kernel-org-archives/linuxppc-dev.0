Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8B19C67C78
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 16:14:39 +1100 (EST)
Date: Mon, 18 Dec 2006 16:14:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: supress lparmap.c warning
Message-Id: <20061218161429.4ffeec4e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

lparmap.c: Assembler messages:
lparmap.c:43: Warning: ignoring changed section attributes for .text

We do not need the .section ops in the generated .s file, so
just remove them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile  |    7 +++++--
 arch/powerpc/kernel/head_64.S |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index d2ded19..0f7cb0b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -76,9 +76,12 @@ obj-y				+= iomap.o
 endif
 
 ifeq ($(CONFIG_PPC_ISERIES),y)
-extra-y += lparmap.s
-$(obj)/head_64.o:	$(obj)/lparmap.s
+extra-y += lparmap.s lparmap1.s
+$(obj)/head_64.o:	$(obj)/lparmap1.s
 AFLAGS_head_64.o += -I$(obj)
+
+$(obj)/lparmap1.s:	$(obj)/lparmap.s
+	@grep -v '\.section' $< >$@
 endif
 
 else
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 71b1fe5..b34e173 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1535,7 +1535,7 @@ fwnmi_data_area:
 	 * both pSeries and iSeries */
 #ifdef CONFIG_PPC_ISERIES
         . = LPARMAP_PHYS
-#include "lparmap.s"
+#include "lparmap1.s"
 /*
  * This ".text" is here for old compilers that generate a trailing
  * .note section when compiling .c files to .s
-- 
1.4.4.2
