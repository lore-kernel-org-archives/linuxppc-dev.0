Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E70E91A007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 11:30:23 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpic: Don't init the fsl error int until after mpic
 init
Date: Tue, 20 May 2014 20:30:04 -0500
Message-ID: <1400635804-27382-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Besides other potential problems, if MPIC_NO_RESET is  not set,
the error interrupt will be masked after it is requested.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/mpic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8209744..be33c97 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1588,10 +1588,6 @@ void __init mpic_init(struct mpic *mpic)
 			num_timers = 8;
 	}
 
-	/* FSL mpic error interrupt intialization */
-	if (mpic->flags & MPIC_FSL_HAS_EIMR)
-		mpic_err_int_init(mpic, MPIC_FSL_ERR_INT);
-
 	/* Initialize timers to our reserved vectors and mask them for now */
 	for (i = 0; i < num_timers; i++) {
 		unsigned int offset = mpic_tm_offset(mpic, i);
@@ -1675,6 +1671,10 @@ void __init mpic_init(struct mpic *mpic)
 			irq_set_chained_handler(virq, &mpic_cascade);
 		}
 	}
+
+	/* FSL mpic error interrupt intialization */
+	if (mpic->flags & MPIC_FSL_HAS_EIMR)
+		mpic_err_int_init(mpic, MPIC_FSL_ERR_INT);
 }
 
 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
-- 
1.9.1
