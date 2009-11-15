Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 841851007D1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 04:09:56 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH 01/10] 8xx: invalidate non present TLBs
Date: Sun, 15 Nov 2009 18:09:28 +0100
Message-Id: <1258304977-11760-2-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

8xx sometimes need to load a invalid/non-present TLBs in
it DTLB asm handler.
These must be invalidated separaly as linux mm don't.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/mm/fault.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e7dae82..26fb6b9 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -40,7 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/siginfo.h>
-
+#include <mm/mmu_decl.h>
 
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs)
@@ -246,6 +246,12 @@ good_area:
 		goto bad_area;
 #endif /* CONFIG_6xx */
 #if defined(CONFIG_8xx)
+	/* 8xx sometimes need to load a invalid/non-present TLBs.
+	 * These must be invalidated separately as linux mm don't.
+	 */
+	if (error_code & 0x40000000) /* no translation? */
+		_tlbil_va(address, 0, 0, 0);
+
         /* The MPC8xx seems to always set 0x80000000, which is
          * "undefined".  Of those that can be set, this is the only
          * one which seems bad.
-- 
1.6.4.4
