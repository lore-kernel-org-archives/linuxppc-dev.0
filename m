Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429k4M2GXrzF3RM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 13:03:31 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 mikey@neuling.org, =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc: Avoid code patching freed init sections
Date: Thu, 13 Sep 2018 13:03:29 +1000
Message-Id: <20180913030329.12052-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This stops us from doing code patching in init sections after they've
been freed.

In this chain:
  kvm_guest_init() ->
    kvm_use_magic_page() ->
      fault_in_pages_readable() ->
	 __get_user() ->
	   __get_user_nocheck() ->
	     barrier_nospec();

We have a code patching location at barrier_nospec() and
kvm_guest_init() is an init function. This whole chain gets inlined,
so when we free the init section (hence kvm_guest_init()), this code
goes away and hence should no longer be patched.

We seen this as userspace memory corruption when using a memory
checker while doing partition migration testing on powervm (this
starts the code patching post migration via
/sys/kernel/mobility/migration). In theory, it could also happen when
using /sys/kernel/debug/powerpc/barrier_nospec.

cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Michael Neuling <mikey@neuling.org>

---
For stable I've marked this as v4.13+ since that's when we refactored
code-patching.c but it could go back even further than that. In
reality though, I think we can only hit this since the first
spectre/meltdown changes.

v3:
 Add init_mem_free flag to avoid potential race.
 Feedback from Christophe Leroy:
   - use init_section_contains()
   - change order of init test for performance
   - use pr_debug()
   - remove blank line

v2:
  Print when we skip an address
---
 arch/powerpc/include/asm/setup.h | 1 +
 arch/powerpc/lib/code-patching.c | 7 +++++++
 arch/powerpc/mm/mem.c            | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 1a951b0046..4b4522b738 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -9,6 +9,7 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
+extern bool init_mem_free;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 850f3b8f4d..dacd6cef92 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -28,6 +28,13 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 {
 	int err;
 
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_free && init_section_contains(exec_addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%lx\n",
+			 (unsigned long)exec_addr);
+		return 0;
+	}
+
 	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5c8530d0c6..b9d59e1a83 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -63,6 +63,7 @@
 #endif
 
 unsigned long long memory_limit;
+bool init_mem_free;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -396,6 +397,7 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	mark_initmem_nx();
+	init_mem_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-- 
2.17.1
