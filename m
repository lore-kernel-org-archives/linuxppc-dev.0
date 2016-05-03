Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzWWS6MQ4zDqmp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:28 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:30:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 47E533578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:30:26 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u436UI1T58392624
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:30:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u436Tr5P023368
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 16:29:54 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [RFC 6/7] TEST: Reserve system memory to be emulated as device memory
Date: Tue,  3 May 2016 11:59:25 +0530
Message-Id: <1462256966-19321-7-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While booting, cap system memory at SYSRAM_END and start recording
the memory from DEVRAM_START as reserved memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/prom.h | 15 +++++++++++++++
 arch/powerpc/kernel/prom.c      | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..a4ec240e4 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -165,5 +165,20 @@ struct of_drconf_cell {
  */
 extern unsigned char ibm_architecture_vec[];
 
+#define SYSRAM_END	0x400000000
+#define DEVRAM_START	0xb00000000
+#define NR_RESERVE	500
+
+enum resmem_elements {
+	MEM_BASE = 0,
+	MEM_SIZE = 1,
+	MEM_NODE = 2,
+	MEM_MAX = 3
+};
+
+struct resmem {
+	u64     mem[NR_RESERVE][MEM_MAX];
+	u64     nr;
+};
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index a15fe1d..9b3bf2e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -438,6 +438,8 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 }
 
 #ifdef CONFIG_PPC_PSERIES
+struct resmem rmem;
+EXPORT_SYMBOL(rmem);
 /*
  * Interpret the ibm,dynamic-memory property in the
  * /ibm,dynamic-reconfiguration-memory node.
@@ -471,6 +473,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 	if (usm != NULL)
 		is_kexec_kdump = 1;
 
+	memset(&rmem, 0, sizeof(struct resmem));
 	for (; n != 0; --n) {
 		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
 		flags = of_read_number(&dm[3], 1);
@@ -508,6 +511,14 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 				if ((base + size) > 0x80000000ul)
 					size = 0x80000000ul - base;
 			}
+			if (base > DEVRAM_START) {
+				rmem.mem[rmem.nr][MEM_BASE] = base;
+				rmem.mem[rmem.nr][MEM_SIZE] = size;
+				rmem.nr++;
+				continue;
+			}
+			if (base > SYSRAM_END)
+				continue;
 			memblock_add(base, size);
 		} while (--rngs);
 	}
-- 
1.8.3.1
