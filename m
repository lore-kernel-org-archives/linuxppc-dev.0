Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whdyg72SbzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 14:30:19 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id w69so23063911pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 21:30:19 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 4/9] powerpc/xmon: Add patch_instruction supporf for xmon
Date: Tue,  6 Jun 2017 14:29:40 +1000
Message-Id: <20170606042945.24997-5-bsingharora@gmail.com>
In-Reply-To: <20170606042945.24997-1-bsingharora@gmail.com>
References: <20170606042945.24997-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move from mwrite() to patch_instruction() for xmon for
breakpoint addition and removal.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a728e19..08e367e 100644
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
2.9.4
