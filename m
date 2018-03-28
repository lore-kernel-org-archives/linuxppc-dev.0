Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B2cr5GH0zF2KS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:28:44 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id h69so745919pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:28:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/5] powerpc: move a stray NMI IPI case under NMI_IPI ifdef
Date: Wed, 28 Mar 2018 19:28:19 +1000
Message-Id: <20180328092819.27015-6-npiggin@gmail.com>
In-Reply-To: <20180328092819.27015-1-npiggin@gmail.com>
References: <20180328092819.27015-1-npiggin@gmail.com>
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
index 17c6abed3def..6185b7245e9e 100644
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
2.16.1
