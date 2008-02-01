Return-Path: <bastian@waldi.eu.org>
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id 76424DDE1F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 08:11:28 +1100 (EST)
Date: Fri, 1 Feb 2008 22:11:25 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove old definition of setup_per_cpu_areas
Message-ID: <20080201211125.GA31779@wavehammer.waldi.eu.org>
References: <20080201201615.GA29187@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080201201615.GA29187@wavehammer.waldi.eu.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 09:16:15PM +0100, Bastian Blank wrote:
> Remove old definition of setup_per_cpu_areas.

This was completely wrong. Lets try it again.

Adopt x86 percpu changes for powerpc and ia64.

dd5af90a7f3d79e04b7eace9a98644dbf2038f4d replaced the config variable
ARCH_SETS_UP_PER_CPU_AREA with HAVE_SETUP_PER_CPU_AREA and moved
percpu_modcopy into kernel/module.c.

Do the same for ia64 and powerpc.

| init/main.c:376: error: static declaration of ‘setup_per_cpu_areas’ follows non-static declaration
| include/asm/percpu.h:33: error: previous declaration of ‘setup_per_cpu_areas’ was here

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 5a41e75..c9307c9 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -80,7 +80,7 @@ config GENERIC_TIME_VSYSCALL
 	bool
 	default y
 
-config ARCH_SETS_UP_PER_CPU_AREA
+config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
 config DMI
diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index e699eb6..bbcdcfd 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -941,13 +941,3 @@ module_arch_cleanup (struct module *mod)
 		unw_remove_unwind_table(mod->arch.core_unw_table);
 }
 
-#ifdef CONFIG_SMP
-void
-percpu_modcopy (void *pcpudst, const void *src, unsigned long size)
-{
-	unsigned int i;
-	for_each_possible_cpu(i) {
-		memcpy(pcpudst + per_cpu_offset(i), src, size);
-	}
-}
-#endif /* CONFIG_SMP */
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fb85f6b..bb16443 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -42,7 +42,7 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
-config ARCH_SETS_UP_PER_CPU_AREA
+config HAVE_SETUP_PER_CPU_AREA
 	def_bool PPC64
 
 config IRQ_PER_CPU
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 26f5791..73fc05d 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -66,7 +66,7 @@ config AUDIT_ARCH
 	bool
 	default y
 
-config ARCH_SETS_UP_PER_CPU_AREA
+config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
 config ARCH_NO_VIRT_TO_BUS
diff --git a/include/asm-ia64/percpu.h b/include/asm-ia64/percpu.h
index 0095bcf..a4af49f 100644
--- a/include/asm-ia64/percpu.h
+++ b/include/asm-ia64/percpu.h
@@ -38,8 +38,9 @@ DECLARE_PER_CPU(unsigned long, local_per_cpu_offset);
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 
-extern void percpu_modcopy(void *pcpudst, const void *src, unsigned long size);
+#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
 extern void setup_per_cpu_areas (void);
+#endif
 extern void *per_cpu_init(void);
 
 #else /* ! SMP */
diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
index cc1cbf6..ea8cbb7 100644
--- a/include/asm-powerpc/percpu.h
+++ b/include/asm-powerpc/percpu.h
@@ -21,16 +21,9 @@
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
 #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, local_paca->data_offset))
 
-/* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
-do {								\
-	unsigned int __i;					\
-	for_each_possible_cpu(__i)				\
-		memcpy((pcpudst)+__per_cpu_offset(__i),		\
-		       (src), (size));				\
-} while (0)
-
+#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
 extern void setup_per_cpu_areas(void);
+#endif
 
 #else /* ! SMP */
 
