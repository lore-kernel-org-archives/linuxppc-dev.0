Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 68D64DDFE4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 15:19:07 +1000 (EST)
Date: Thu, 3 May 2007 15:19:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: suppress build warning in lparmap.c
Message-Id: <20070503151905.e60226e0.sfr@canb.auug.org.au>
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
lparmap.c:51: Warning: ignoring changed section attributes for .text

Idea from Segher Boessenkool.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/lparmap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/lparmap.c b/arch/powerpc/kernel/lparmap.c
index 584d1e3..af11285 100644
--- a/arch/powerpc/kernel/lparmap.c
+++ b/arch/powerpc/kernel/lparmap.c
@@ -10,7 +10,8 @@
 #include <asm/pgtable.h>
 #include <asm/iseries/lpar_map.h>
 
-const struct LparMap __attribute__((__section__(".text"))) xLparMap = {
+/* The # is to stop gcc trying to make .text nonexecutable */
+const struct LparMap __attribute__((__section__(".text #"))) xLparMap = {
 	.xNumberEsids = HvEsidsToMap,
 	.xNumberRanges = HvRangesToMap,
 	.xSegmentTableOffs = STAB0_PAGE,
-- 
1.5.1.3
