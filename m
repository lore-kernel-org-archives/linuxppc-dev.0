Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 90982DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 09:42:59 +1000 (EST)
Date: Thu, 3 Jul 2008 18:42:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] enable AT_BASE_PLATFORM aux vector for powerpc
Message-ID: <20080703234228.GD9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	McGrath <roland@redhat.com>, Roland
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stash the first platform string matched by identify_cpu() in
powerpc_base_platform, and supply that to the ELF loader for the value
of AT_BASE_PLATFORM.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

Note: I wasn't sure how to pick the index value for AT_BASE_PLATFORM;
I simply searched include/ for all AT_ values and added 1 to the
highest value found.

 arch/powerpc/kernel/cputable.c |   11 +++++++++++
 include/asm-powerpc/auxvec.h   |    3 +++
 include/asm-powerpc/cputable.h |    2 ++
 include/asm-powerpc/elf.h      |    8 ++++++++
 4 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index a9c90be..f1eb632 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -23,6 +23,9 @@
 struct cpu_spec* cur_cpu_spec = NULL;
 EXPORT_SYMBOL(cur_cpu_spec);
 
+/* The platform string corresponding to the real PVR */
+const char *powerpc_base_platform;
+
 /* NOTE:
  * Unlike ppc32, ppc64 will only call this once for the boot CPU, it's
  * the responsibility of the appropriate CPU save/restore functions to
@@ -1620,6 +1623,14 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 			} else
 				*t = *s;
 			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
+
+			/*
+			 * Set the base platform string once; assumes
+			 * we're called with real pvr first.
+			 */
+			if (powerpc_base_platform == NULL)
+				powerpc_base_platform = t->platform;
+
 #if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
 			/* ppc64 and booke expect identify_cpu to also call
 			 * setup_cpu for that processor. I will consolidate
diff --git a/include/asm-powerpc/auxvec.h b/include/asm-powerpc/auxvec.h
index 19a099b..507f081 100644
--- a/include/asm-powerpc/auxvec.h
+++ b/include/asm-powerpc/auxvec.h
@@ -16,4 +16,7 @@
  */
 #define AT_SYSINFO_EHDR		33
 
+/* The actual hardware platform; may differ from AT_PLATFORM */
+#define AT_BASE_PLATFORM	38
+
 #endif
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index a9c1de3..527152f 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -125,6 +125,8 @@ extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
 
+extern const char *powerpc_base_platform;
+
 #endif /* __ASSEMBLY__ */
 
 /* CPU kernel features */
diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 38a5172..ff0c947 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -237,6 +237,14 @@ extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
 
 #define ELF_PLATFORM	(cur_cpu_spec->platform)
 
+/* While ELF_PLATFORM indicates the ISA supported by the platform, it
+ * may not accurately reflect the underlying behavior of the hardware
+ * (as in the case of running in Power5+ compatibility mode on a
+ * Power6 machine).  ELF_BASE_PLATFORM allows ld.so to load libraries
+ * that are tuned for the real hardware.
+ */
+#define ELF_BASE_PLATFORM (powerpc_base_platform)
+
 #ifdef __powerpc64__
 # define ELF_PLAT_INIT(_r, load_addr)	do {	\
 	_r->gpr[2] = load_addr; 		\
-- 
1.5.5.1
