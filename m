Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKv4FGQzDrZC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:20:19 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a14so17948843pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:20:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/11] powerpc: move a stray NMI IPI case under NMI_IPI ifdef
Date: Sat,  5 May 2018 03:19:34 +1000
Message-Id: <20180504171935.25410-11-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 914708eeb43f..28ec1638a540 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -193,7 +193,9 @@ const char *smp_ipi_name[] = {
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	[PPC_MSG_TICK_BROADCAST] = "ipi tick-broadcast",
 #endif
+#ifdef CONFIG_NMI_IPI
 	[PPC_MSG_NMI_IPI] = "nmi ipi",
+#endif
 };
 
 /* optional function to request ipi, for controllers with >= 4 ipis */
-- 
2.17.0
