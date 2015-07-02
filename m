Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C82B1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 14:56:22 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Add plain English description for alignment
 exception oopses
Date: Thu,  2 Jul 2015 14:56:20 +1000
Message-Id: <1435812980-16360-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we take an alignment exception which we cannot fix, the oops
currently prints:

Unable to handle kernel paging request for unknown fault

Lets print something more useful:

Unable to handle kernel paging request for unaligned access at address 0xc0000000f77bba8f

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/mm/fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b396868..661ba0a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -528,6 +528,10 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 		printk(KERN_ALERT "Unable to handle kernel paging request for "
 			"instruction fetch\n");
 		break;
+	case 0x600:
+		printk(KERN_ALERT "Unable to handle kernel paging request for "
+			"unaligned access at address 0x%08lx\n", regs->dar);
+		break;
 	default:
 		printk(KERN_ALERT "Unable to handle kernel paging request for "
 			"unknown fault\n");
-- 
2.1.4
