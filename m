Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE781A0221
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 16:35:44 +1000 (EST)
Date: Tue, 5 Aug 2014 16:35:45 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com, Emilian.Medve@Freescale.com
Subject: [PATCH 4/5] powerpc: Move sparse_init() into initmem_init
Message-ID: <20140805163545.414d493b@kryten>
In-Reply-To: <20140805163218.47c86615@kryten>
References: <20140805163218.47c86615@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
---

Index: b/arch/powerpc/kernel/setup_64.c
===================================================================
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -678,7 +678,6 @@ void __init setup_arch(char **cmdline_p)
 	emergency_stack_init();
 
 	initmem_init();
-	sparse_init();
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
Index: b/arch/powerpc/mm/mem.c
===================================================================
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -194,6 +194,7 @@ void __init initmem_init(void)
 
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
+	sparse_init();
 }
 
 /* mark pages that don't exist as nosave */
Index: b/arch/powerpc/mm/numa.c
===================================================================
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -957,6 +957,8 @@ void __init initmem_init(void)
 		sparse_memory_present_with_active_regions(nid);
 	}
 
+	sparse_init();
+
 	setup_node_to_cpumask_map();
 
 	reset_numa_cpu_lookup_table();
