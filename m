Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21BB1A1855
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 04:02:45 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 25 Aug 2014 14:02:43 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A08E76E8048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:02:30 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7PI2fVF9830818
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 18:02:41 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7PI2dCk017284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:02:40 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] powerpc/powernv: Enter deepest supported idle state in
 offline
Date: Mon, 25 Aug 2014 23:31:13 +0530
Message-Id: <1408989673-14137-10-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1408989673-14137-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1408989673-14137-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enter winkle during offline if supported, else revert to sleep or nap.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 3ad31d2..e3fc2c9 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -169,8 +169,10 @@ static void pnv_smp_cpu_kill_self(void)
 	while (!generic_check_cpu_restart(cpu)) {
 		ppc64_runlatch_off();
 
-		/* If sleep is supported, go to sleep, instead of nap */
-		if (idle_states & IDLE_USE_SLEEP)
+		/* Go to deepest supported idle state */
+		if (idle_states & IDLE_USE_WINKLE)
+			power7_winkle();
+		else if (idle_states & IDLE_USE_SLEEP)
 			power7_sleep();
 		else
 			power7_nap(1);
-- 
1.9.0
