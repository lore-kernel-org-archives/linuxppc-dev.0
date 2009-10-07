Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A2FFB7B77
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 07:46:12 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/6] 8xx: invalidate non present TLBs
Date: Wed, 7 Oct 2009 22:46:01 +0200
Message-Id: <1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
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
---
 arch/powerpc/mm/fault.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7699394..72941c7 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -39,7 +39,7 @@
 #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/siginfo.h>
-
+#include <mm/mmu_decl.h>
 
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs)
@@ -243,6 +243,12 @@ good_area:
 		goto bad_area;
 #endif /* CONFIG_6xx */
 #if defined(CONFIG_8xx)
+	/* 8xx sometimes need to load a invalid/non-present TLBs.
+	 * These must be invalidated separately as linux mm don't.
+	 */
+	if (error_code & 0x40000000) /* no translation? */
+		_tlbil_va(address);
+
         /* The MPC8xx seems to always set 0x80000000, which is
          * "undefined".  Of those that can be set, this is the only
          * one which seems bad.
-- 
1.6.4.4
