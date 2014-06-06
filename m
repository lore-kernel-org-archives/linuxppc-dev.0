Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 164911A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 14:28:52 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Don't setup CPUs with bad status
Date: Fri,  6 Jun 2014 14:28:51 +1000
Message-Id: <1402028931-13195-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL will mark a CPU that is guarded as "bad" in the status property of the CPU
node.

Unfortunatley Linux doesn't check this property and will put the bad CPU in the
present map.  This has caused hangs on booting when we try to unsplit the core.

This patch checks the CPU is avaliable via this status property before putting
it in the present map.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Tested-by: Anton Blanchard <anton@samba.org>
cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d4d4183..e239df3 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -471,7 +471,7 @@ void __init smp_setup_cpu_maps(void)
 		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
 			    j, cpu, be32_to_cpu(intserv[j]));
-			set_cpu_present(cpu, true);
+			set_cpu_present(cpu, of_device_is_available(dn));
 			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
 			cpu++;
-- 
1.9.1
