Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460D01A0930
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 22:15:44 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Emilian.Medve@Freescale.com
Subject: [PATCH 4/5] powerpc: Move sparse_init() into initmem_init
Date: Wed, 17 Sep 2014 22:15:36 +1000
Message-Id: <1410956137-4824-4-git-send-email-anton@samba.org>
In-Reply-To: <1410956137-4824-1-git-send-email-anton@samba.org>
References: <1410956137-4824-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We did part of sparse initialisation in setup_arch and part in
initmem_init. Put them together.

Signed-off-by: Anton Blanchard <anton@samba.org>
Tested-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/kernel/setup_64.c | 1 -
 arch/powerpc/mm/mem.c          | 1 +
 arch/powerpc/mm/numa.c         | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 9f8f472..8bc8f77 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -682,7 +682,6 @@ void __init setup_arch(char **cmdline_p)
 	emergency_stack_init();
 
 	initmem_init();
-	sparse_init();
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index aa067b7..abbc55d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -195,6 +195,7 @@ void __init initmem_init(void)
 
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
+	sparse_init();
 }
 
 /* mark pages that don't exist as nosave */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 4f9c18a..52559ff 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -964,6 +964,8 @@ void __init initmem_init(void)
 		sparse_memory_present_with_active_regions(nid);
 	}
 
+	sparse_init();
+
 	setup_node_to_cpumask_map();
 
 	reset_numa_cpu_lookup_table();
-- 
1.9.1
