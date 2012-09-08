Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Initialise paca.data_offset with poison
Date: Sat,  8 Sep 2012 11:31:44 +1000
Message-Id: <1347067904-14262-1-git-send-email-michael@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's possible for the cpu_possible_mask to change between the time we
initialise the pacas and the time we setup per_cpu areas.

Obviously impossible cpus shouldn't ever be running, but stranger things
have happened. So be paranoid and initialise data_offset with a poison
value in case we don't set it up later.

Based on a patch from Anton Blanchard.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/paca.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index fbe1a12..cd6da85 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -142,6 +142,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->hw_cpu_id = 0xffff;
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
+	new_paca->data_offset = 0xfeeeeeeeeeeeeeeeULL;
 #ifdef CONFIG_PPC_STD_MMU_64
 	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
 #endif /* CONFIG_PPC_STD_MMU_64 */
-- 
1.7.9.5
