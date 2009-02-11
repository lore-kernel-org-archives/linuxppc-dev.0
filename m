Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49935F81.7060203@am.sony.com>
Date: Wed, 11 Feb 2009 15:30:09 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC patch] powerpc: Add topology_ready to machdep calls
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new member topology_ready to the powerpc machdep_calls
structure.

The NUMA hot plug memory routines require the NUMA node to have
been registered via register_one_node() prior to adding memory
to the node.  The powerpc arch registers NUMA nodes during
startup in its topology_init() routine.

Currently, there is no mechanism for the platform code to know
when the nodes have been registered, and hence, when it is safe
to add hot plug memory.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/include/asm/machdep.h |    1 +
 arch/powerpc/kernel/sysfs.c        |    3 +++
 2 files changed, 4 insertions(+)

--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -106,6 +106,7 @@ struct machdep_calls {
 	void		(*setup_arch)(void); /* Optional, may be NULL */
 	void		(*init_early)(void);
 	/* Optional, may be NULL. */
+	void		(*topology_ready)(void); /* Optional, may be NULL */
 	void		(*show_cpuinfo)(struct seq_file *m);
 	void		(*show_percpuinfo)(struct seq_file *m, int i);
 
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -647,6 +647,9 @@ static int __init topology_init(void)
 			register_cpu_online(cpu);
 	}
 
+	if (ppc_md.topology_ready)
+		ppc_md.topology_ready();
+
 	return 0;
 }
 subsys_initcall(topology_init);
