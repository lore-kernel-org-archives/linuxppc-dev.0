Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 468E71007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2011 20:01:08 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Don't write protect kernel text with
	CONFIG_DYNAMIC_FTRACE enabled
Date: Fri, 15 Apr 2011 11:49:53 +0200
Message-Id: <1302860993-28829-1-git-send-email-sr@denx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This problem was noticed on an MPC855T platform. Ftrace did oops
when trying to write to the kernel text segment.

Many thanks to Joakim for finding the root cause of this problem.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/pte-common.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 811f04a..8d1569c 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -162,7 +162,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
  * on platforms where such control is possible.
  */
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES)
+	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-- 
1.7.4.4
