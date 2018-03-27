Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCK2hVWzF27f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:33 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 7/8] powerpc: Disable DAWR on POWER9 via CPU feature quirk
Date: Tue, 27 Mar 2018 15:37:23 +1100
Message-Id: <20180327043724.13862-8-mikey@neuling.org>
In-Reply-To: <20180327043724.13862-1-mikey@neuling.org>
References: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This disables the DAWR on all POWER9 CPUs via cpu feature quirk.

Using the DAWR on POWER9 can cause xstops, hence we need to disable
it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 945e2c29ad..941a5fbd8d 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -709,6 +709,9 @@ static __init void cpufeatures_cpu_quirks(void)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
 	else if ((version & 0xffffefff) == 0x004e0201)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
+
+	if ((version & 0xffff0000) == 0x004e0000)
+		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
 }
 
 static void __init cpufeatures_setup_finished(void)
-- 
2.14.1
