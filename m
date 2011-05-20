Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C399BB71F6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:43 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69esG001129
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:40 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/14] powerpc/book3e: Clarify HW table walk enable/disable
	message
Date: Fri, 20 May 2011 01:09:28 -0500
Message-Id: <1305871771-16334-11-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-10-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-10-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before if we didn't support or enable HW table walk we'd get a messaage
like:

MMU: Book3E Page Tables Disabled

Which is a bit misleading.  Now it will say:

MMU: Book3E HW tablewalk not supported

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/tlb_nohash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 2a030d8..97e6193 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -476,8 +476,8 @@ static void setup_mmu_htw(void)
 			     (unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
 		book3e_htw_enabled = 1;
 	}
-	pr_info("MMU: Book3E Page Tables %s\n",
-		book3e_htw_enabled ? "Enabled" : "Disabled");
+	pr_info("MMU: Book3E HW tablewalk %s\n",
+		book3e_htw_enabled ? "enabled" : "not supported");
 }
 
 /*
-- 
1.7.3.4
