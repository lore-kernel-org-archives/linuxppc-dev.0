Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2/2] arch/powerpc: Dynamically allocate slb_shadow from
 memblock
Message-Id: <1386214268.68246.485420017657.2.gpush@pablo>
In-Reply-To: <1386214268.68092.227432126043.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 05 Dec 2013 11:31:08 +0800
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the slb_shadow buffer is our largest symbol:

  [jk@pablo linux]$ nm --size-sort -r -S obj/vmlinux | head -1
  c000000000da0000 0000000000040000 d slb_shadow

- we allocate 128 bytes per cpu; so 256k with NR_CPUS=2048. As we have
constant initialisers, it's allocated in .text, causing a larger vmlinux
image. We may also allocate unecessary slb_shadow buffers (> no. pacas),
since we use the build-time NR_CPUS rather than the run-time nr_cpu_ids.

We could move this to the bss, but then we still have the NR_CPUS vs
nr_cpu_ids potential for overallocation.

This change dynamically allocates the slb_shadow array, during
initialise_pacas(). At a cost of 104 bytes of text, we save 256k of
data:

  [jk@pablo linux]$ size obj/vmlinux{.orig,}
     text     data      bss       dec     hex	filename
  9202795  5244676  1169576  15617047  ee4c17	obj/vmlinux.orig
  9202899  4982532  1169576  15355007  ea4c7f	obj/vmlinux

Tested on pseries.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/kernel/paca.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 9095a6f7..ad7a485f 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -99,12 +99,28 @@ static inline void free_lppacas(void) { }
  * 3 persistent SLBs are registered here.  The buffer will be zero
  * initially, hence will all be invaild until we actually write them.
  */
-static struct slb_shadow slb_shadow[] __cacheline_aligned = {
-	[0 ... (NR_CPUS-1)] = {
-		.persistent = cpu_to_be32(SLB_NUM_BOLTED),
-		.buffer_length = cpu_to_be32(sizeof(struct slb_shadow)),
-	},
-};
+static struct slb_shadow *slb_shadow;
+
+static void __init allocate_slb_shadows(int nr_cpus, int limit)
+{
+	int size = PAGE_ALIGN(sizeof(struct slb_shadow) * nr_cpus);
+	slb_shadow = __va(memblock_alloc_base(size, PAGE_SIZE, limit));
+	memset(slb_shadow, 0, size);
+}
+
+static struct slb_shadow * __init init_slb_shadow(int cpu)
+{
+	struct slb_shadow *s = &slb_shadow[cpu];
+
+	s->persistent = ARRAY_SIZE(s->save_area);
+	s->buffer_length = sizeof(*s);
+
+	return s;
+}
+
+#else /* CONFIG_PPC_STD_MMU_64 */
+
+static void __init allocate_slb_shadows(int nr_cpus, int limit) { }
 
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
@@ -142,7 +158,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->__current = &init_task;
 	new_paca->data_offset = 0xfeeeeeeeeeeeeeeeULL;
 #ifdef CONFIG_PPC_STD_MMU_64
-	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
+	new_paca->slb_shadow_ptr = init_slb_shadow(cpu);
 #endif /* CONFIG_PPC_STD_MMU_64 */
 }
 
@@ -190,6 +206,8 @@ void __init allocate_pacas(void)
 
 	allocate_lppacas(nr_cpu_ids, limit);
 
+	allocate_slb_shadows(nr_cpu_ids, limit);
+
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		initialise_paca(&paca[cpu], cpu);
