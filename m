Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 16/63] powerpc: More little endian fixes for setup-common.c
Date: Wed,  7 Aug 2013 02:01:33 +1000
Message-Id: <1375804940-22050-17-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/kernel/setup-common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ee0e055..3d261c0 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -437,6 +437,7 @@ void __init smp_setup_cpu_maps(void)
 
 	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < nr_cpu_ids) {
 		const __be32 *intserv;
+		__be32 cpu_be;
 		int j, len;
 
 		DBG("  * %s...\n", dn->full_name);
@@ -450,8 +451,10 @@ void __init smp_setup_cpu_maps(void)
 		} else {
 			DBG("    no ibm,ppc-interrupt-server#s -> 1 thread\n");
 			intserv = of_get_property(dn, "reg", NULL);
-			if (!intserv)
-				intserv = &cpu;	/* assume logical == phys */
+			if (!intserv) {
+				cpu_be = cpu_to_be32(cpu);
+				intserv = &cpu_be;	/* assume logical == phys */
+			}
 		}
 
 		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
-- 
1.8.1.2
