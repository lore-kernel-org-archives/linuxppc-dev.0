Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EDE4B721C
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:13 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 03/13] 8xx: invalidate non present TLBs
Date: Mon, 10 Jan 2011 22:37:49 +0100
Message-Id: <1294695479-344-4-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
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
 arch/ppc/mm/fault.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
index 9d3ce2d..874005a 100644
--- a/arch/ppc/mm/fault.c
+++ b/arch/ppc/mm/fault.c
@@ -116,7 +116,13 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	else
 		is_write = error_code & 0x02000000;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
-
+#if defined(CONFIG_8xx)
+	/* 8xx does no invalidate TLBs that are ~PRESENT,
+	 * do it here.
+	 */
+	if (error_code & 0x40000000)
+		_tlbie(address);
+#endif
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && regs->trap == 0x300) {
 		debugger_fault_handler(regs);
-- 
1.7.3.4
