Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2g4R8zzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 05/10] powerpc/xmon: Add patch_instruction() support for
 xmon
Date: Mon,  3 Jul 2017 23:01:49 +1000
Message-Id: <1499086914-25695-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

Move from mwrite() to patch_instruction() for xmon for
breakpoint addition and removal.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a728e1919613..08e367e3e8c3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -53,6 +53,7 @@
 #include <asm/xive.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
+#include <asm/code-patching.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -837,7 +838,8 @@ static void insert_bpts(void)
 		store_inst(&bp->instr[0]);
 		if (bp->enabled & BP_CIABR)
 			continue;
-		if (mwrite(bp->address, &bpinstr, 4) != 4) {
+		if (patch_instruction((unsigned int *)bp->address,
+							bpinstr) != 0) {
 			printf("Couldn't write instruction at %lx, "
 			       "disabling breakpoint there\n", bp->address);
 			bp->enabled &= ~BP_TRAP;
@@ -874,7 +876,8 @@ static void remove_bpts(void)
 			continue;
 		if (mread(bp->address, &instr, 4) == 4
 		    && instr == bpinstr
-		    && mwrite(bp->address, &bp->instr, 4) != 4)
+		    && patch_instruction(
+			(unsigned int *)bp->address, bp->instr[0]) != 0)
 			printf("Couldn't remove breakpoint at %lx\n",
 			       bp->address);
 		else
-- 
2.7.4
