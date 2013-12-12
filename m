Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 2/8] powerpc: Fix endian issue in setup-common.c
Date: Thu, 12 Dec 2013 15:59:35 +1100
Message-Id: <1386824381-14032-3-git-send-email-anton@samba.org>
In-Reply-To: <1386824381-14032-1-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During on LE boot we see:

    Partition configured for 1073741824 cpus, operating system maximum is 2048.

Clearly missing a byteswap here.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/setup-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index febc804..bc76cc6 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -479,7 +479,7 @@ void __init smp_setup_cpu_maps(void)
 	if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR) &&
 	    (dn = of_find_node_by_path("/rtas"))) {
 		int num_addr_cell, num_size_cell, maxcpus;
-		const unsigned int *ireg;
+		const __be32 *ireg;
 
 		num_addr_cell = of_n_addr_cells(dn);
 		num_size_cell = of_n_size_cells(dn);
@@ -489,7 +489,7 @@ void __init smp_setup_cpu_maps(void)
 		if (!ireg)
 			goto out;
 
-		maxcpus = ireg[num_addr_cell + num_size_cell];
+		maxcpus = be32_to_cpup(ireg + num_addr_cell + num_size_cell);
 
 		/* Double maxcpus for processors which have SMT capability */
 		if (cpu_has_feature(CPU_FTR_SMT))
-- 
1.8.3.2
