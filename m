Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <b1077fa5aa8f7d0382fd771e66464c1ace5677fc.1185932073.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/1] Fix parse_drconf_memory() for 64-bit start addresses
Date: Wed,  1 Aug 2007 11:34:38 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some new machines use the "ibm,dynamic-reconfiguration-memory" property
to provide memory layout information, rather than via memory nodes.

There is a bug in the code to parse this property for start addresses over
4GB, we throw away the high bits and add apparently duplicate regions. This
results in a BUG() in free_bootmem_core().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/numa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index de45aa8..c12adc3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -307,9 +307,9 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	const unsigned int *lm, *dm, *aa;
 	unsigned int ls, ld, la;
 	unsigned int n, aam, aalen;
-	unsigned long lmb_size, size;
+	unsigned long lmb_size, size, start;
 	int nid, default_nid = 0;
-	unsigned int start, ai, flags;
+	unsigned int ai, flags;
 
 	lm = of_get_property(memory, "ibm,lmb-size", &ls);
 	dm = of_get_property(memory, "ibm,dynamic-memory", &ld);
-- 
1.5.1.3.g7a33b
