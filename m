Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A94D51400DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 22:35:25 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] PPC: ePAPR: Fix hypercall on LE guest
Date: Thu, 15 May 2014 14:35:19 +0200
Message-Id: <1400157319-52181-1-git-send-email-agraf@suse.de>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We get an array of instructions from the hypervisor via device tree that
we write into a buffer that gets executed whenever we want to make an
ePAPR compliant hypercall.

However, the hypervisor passes us these instructions in BE order which
we have to manually convert to LE when we want to run them in LE mode.

With this fixup in place, I can successfully run LE kernels with KVM
PV enabled on PR KVM.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/epapr_paravirt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index 7898be9..d9b7935 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -47,9 +47,10 @@ static int __init early_init_dt_scan_epapr(unsigned long node,
 		return -1;
 
 	for (i = 0; i < (len / 4); i++) {
-		patch_instruction(epapr_hypercall_start + i, insts[i]);
+		u32 inst = be32_to_cpu(insts[i]);
+		patch_instruction(epapr_hypercall_start + i, inst);
 #if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
-		patch_instruction(epapr_ev_idle_start + i, insts[i]);
+		patch_instruction(epapr_ev_idle_start + i, inst);
 #endif
 	}
 
-- 
1.8.1.4
