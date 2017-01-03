Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tt5GY33DGzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 18:31:17 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so25314740pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 23:31:17 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC v2 1/3] Merge IPI and DEFAULT priorities
Date: Tue,  3 Jan 2017 18:30:56 +1100
Message-Id: <20170103073058.30066-2-bsingharora@gmail.com>
In-Reply-To: <20170103073058.30066-1-bsingharora@gmail.com>
References: <20170103073058.30066-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We merge IPI and DEFAULT priorities to the same
value. The idea is to keep interrupts enabled
even in lazy soft-disabled mode. Instead of storing
the IPI and irq separately, we keep the levels
same so that we deal with only one of them

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/xics.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index f0b2385..d6cb9a0 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -14,17 +14,13 @@
 /* Want a priority other than 0.  Various HW issues require this. */
 #define	DEFAULT_PRIORITY	5
 
-/*
- * Mark IPIs as higher priority so we can take them inside interrupts
- * FIXME: still true now?
- */
-#define IPI_PRIORITY		4
+#define IPI_PRIORITY		5
 
 /* The least favored priority */
 #define LOWEST_PRIORITY		0xFF
 
 /* The number of priorities defined above */
-#define MAX_NUM_PRIORITIES	3
+#define MAX_NUM_PRIORITIES	2
 
 /* Native ICP */
 #ifdef CONFIG_PPC_ICP_NATIVE
-- 
2.9.3
