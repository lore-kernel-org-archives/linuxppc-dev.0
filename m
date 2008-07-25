Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807251451s623b87cetcf7ed5ff6a12f012@mail.gmail.com>
Date: Fri, 25 Jul 2008 17:51:24 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: ppc-dev <Linuxppc-dev@ozlabs.org>
Subject: can't boot mpc5200, powerpc: Enable AT_BASE_PLATFORM aux vector
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've lost my ability to boot on the mpc5200. Reverting this patch fixes it.

powerpc: Enable AT_BASE_PLATFORM aux vector
9115d13453dee22473a1e8cacc90a8d64a9c4bc9

commit 9115d13453dee22473a1e8cacc90a8d64a9c4bc9
Author: Nathan Lynch <ntl@pobox.com>
Date:   Wed Jul 16 09:58:51 2008 +1000

    powerpc: Enable AT_BASE_PLATFORM aux vector

    Stash the first platform string matched by identify_cpu() in
    powerpc_base_platform, and supply that to the ELF loader for the value
    of AT_BASE_PLATFORM.

    Signed-off-by: Nathan Lynch <ntl@pobox.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b936a1d..25a052c 100644
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
@@ -1652,6 +1655,14 @@ struct cpu_spec * __init identify_cpu(unsigned
long offset, unsigned int pvr)
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
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 2a3e907..ef8a248 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -127,6 +127,8 @@ extern struct cpu_spec *identify_cpu(unsigned long
offset, unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);

+extern const char *powerpc_base_platform;
+
 #endif /* __ASSEMBLY__ */

 /* CPU kernel features */
diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 8966467..80d1f39 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -217,6 +217,14 @@ typedef elf_vrregset_t elf_fpxregset_t;

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
Jon Smirl
jonsmirl@gmail.com
