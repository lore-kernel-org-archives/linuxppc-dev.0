Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4299BD3m4bzF38B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:21:40 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 mikey@neuling.org, =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: Avoid code patching freed init sections
Date: Wed, 12 Sep 2018 15:20:58 +1000
Message-Id: <20180912052058.10062-1-mikey@neuling.org>
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

With this patch there is a small change of a race if we code patch
between the init section being freed and setting SYSTEM_RUNNING (in
kernel_init()) but that seems like an impractical time and small
window for any code patching to occur.

cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Michael Neuling <mikey@neuling.org>

---
For stable I've marked this as v4.13+ since that's when we refactored
code-patching.c but it could go back even further than that. In
reality though, I think we can only hit this since the first
spectre/meltdown changes.

v2:
  Print when we skip an address
---
 arch/powerpc/lib/code-patching.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 850f3b8f4d..68254e7f17 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -23,11 +23,33 @@
 #include <asm/code-patching.h>
 #include <asm/setup.h>
 
+
+static inline bool in_init_section(unsigned int *patch_addr)
+{
+	if (patch_addr < (unsigned int *)__init_begin)
+		return false;
+	if (patch_addr >= (unsigned int *)__init_end)
+		return false;
+	return true;
+}
+
+static inline bool init_freed(void)
+{
+	return (system_state >= SYSTEM_RUNNING);
+}
+
 static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 			       unsigned int *patch_addr)
 {
 	int err;
 
+	/* Make sure we aren't patching a freed init section */
+	if (in_init_section(patch_addr) && init_freed()) {
+		printk(KERN_DEBUG "Skipping init section patching addr: 0x%lx\n",
+			(unsigned long)patch_addr);
+		return 0;
+	}
+
 	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
-- 
2.17.1
