Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 694D61A1A92
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:47:49 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 01:47:47 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 415C41FF001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 01:36:31 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s917jg8E9306478
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 09:45:42 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s917qKRL008758
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 01:52:20 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] powerpc/powernv: Enter deepest supported idle state in
 offline
Date: Wed,  1 Oct 2014 13:16:57 +0530
Message-Id: <1412149617-3178-6-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1412149617-3178-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1412149617-3178-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
1.9.3
