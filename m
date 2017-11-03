Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySpVC2BsKzDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 15:13:39 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s2so1445850pge.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 21:13:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH v3 2/3] powerpc/64s/idle: avoid POWER9 DD1 and DD2.0 ERAT
 workaround on DD2.1
Date: Fri,  3 Nov 2017 15:13:20 +1100
Message-Id: <20171103041321.5113-3-npiggin@gmail.com>
In-Reply-To: <20171103041321.5113-1-npiggin@gmail.com>
References: <20171103041321.5113-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DD2.1 does not have to flush the ERAT after a state-loss idle.

Performance testing was done on a DD2.1 using only the stop0 idle state
(the shallowest state which supports state loss), using context_switch
selftest configured to ping-poing between two threads on the same core
and two different cores.

Performance improvement for same core is 7.0%, different cores is 14.8%.

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 175d49f468af..d77766814090 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -542,7 +542,9 @@ pnv_restore_hyp_resource_arch300:
 	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
 	 */
 	blt	cr3,1f
+BEGIN_FTR_SECTION
 	PPC_INVALIDATE_ERAT
+END_FTR_SECTION_IFSET(CPU_FTR_POWER9_DD1 | CPU_FTR_POWER9_DD20)
 	ld	r1,PACAR1(r13)
 	mfspr	r4,SPRN_MMCRA
 	ori	r4,r4,(1 << (63-60))
-- 
2.15.0
