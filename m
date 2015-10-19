Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0105.outbound.protection.outlook.com [157.56.110.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B95D71A047B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 09:10:34 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <kexec@lists.infradead.org>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH v3 13/17] powerpc/book3e-64: Don't limit paca to 256 MiB
Date: Mon, 19 Oct 2015 17:10:18 -0500
Message-ID: <1445292618-20418-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-14-git-send-email-scottwood@freescale.com>
References: <1444189702-17241-14-git-send-email-scottwood@freescale.com>
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
v3: Fix book3s build error

 arch/powerpc/kernel/paca.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 5a23b69..01ea0ed 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -204,14 +204,19 @@ static int __initdata paca_size;
 
 void __init allocate_pacas(void)
 {
-	int cpu, limit;
+	u64 limit;
+	int cpu;
 
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
