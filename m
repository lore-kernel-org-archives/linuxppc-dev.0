Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B7E51A0F08
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:35 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 12/17] powerpc/book3e-64: Don't limit paca to 256 MiB
Date: Sat, 18 Jul 2015 15:08:49 -0500
Message-ID: <1437250134-307-13-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This limit only makes sense on book3s, and on book3e it can cause
problems with kdump if we don't have any memory under 256 MiB.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/paca.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 5a23b69..7fdff63 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -206,12 +206,16 @@ void __init allocate_pacas(void)
 {
 	int cpu, limit;
 
+	limit = ppc64_rma_size;
+
+#ifdef CONFIG_PPC_BOOK3S_64
 	/*
 	 * We can't take SLB misses on the paca, and we want to access them
 	 * in real mode, so allocate them within the RMA and also within
 	 * the first segment.
 	 */
-	limit = min(0x10000000ULL, ppc64_rma_size);
+	limit = min(0x10000000ULL, limit);
+#endif
 
 	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
 
-- 
2.1.4
