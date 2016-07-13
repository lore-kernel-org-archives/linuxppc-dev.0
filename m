Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq19T4VcWzDqFX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 11:15:41 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id y188so2167859ywf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 18:15:41 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/3] powerpc32: kill RELOCATABLE_PPC32
Date: Wed, 13 Jul 2016 09:14:40 +0800
Message-Id: <1468372480-6453-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1468372480-6453-1-git-send-email-haokexin@gmail.com>
References: <1468372480-6453-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is seldom used in the kernel code and can be easily replaced by
either RELOCATABLE or PPC32. So there is no reason to keep a separate
kernel option for this.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig              | 4 ----
 arch/powerpc/include/asm/page.h   | 6 +++---
 arch/powerpc/kernel/Makefile      | 3 +--
 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 arch/powerpc/mm/init_32.c         | 2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a9d847c8a20d..98f7e29e5680 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -481,10 +481,6 @@ config RELOCATABLE
 	  setting can still be useful to bootwrappers that need to know the
 	  load address of the kernel (eg. u-boot/mkimage).
 
-config RELOCATABLE_PPC32
-	def_bool y
-	depends on PPC32 && RELOCATABLE
-
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 51db3a37bced..56398e7e6100 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -96,7 +96,7 @@ extern unsigned int HPAGE_SHIFT;
 extern phys_addr_t memstart_addr;
 extern phys_addr_t kernstart_addr;
 
-#ifdef CONFIG_RELOCATABLE_PPC32
+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_PPC32)
 extern long long virt_phys_offset;
 #endif
 
@@ -139,9 +139,9 @@ extern long long virt_phys_offset;
  * determine MEMORY_START until then.  However we can determine PHYSICAL_START
  * from information at hand (program counter, TLB lookup).
  *
- * On BookE with RELOCATABLE (RELOCATABLE_PPC32)
+ * On BookE with RELOCATABLE && PPC32
  *
- *   With RELOCATABLE_PPC32,  we support loading the kernel at any physical 
+ *   With RELOCATABLE && PPC32,  we support loading the kernel at any physical
  *   address without any restriction on the page alignment.
  *
  *   We find the runtime address of _stext and relocate ourselves based on 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0c7106df90e6..0719b1a3fb24 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -47,7 +47,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o hmi.o
-obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
@@ -92,7 +91,7 @@ extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
-obj-$(CONFIG_RELOCATABLE_PPC32)	+= reloc_32.o
+obj-$(CONFIG_RELOCATABLE)	+= reloc_$(CONFIG_WORD_SIZE).o
 
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2dd91f79de05..b5fba689fca6 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -165,7 +165,7 @@ SECTIONS
 	. = ALIGN(8);
 	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
 	{
-#ifdef CONFIG_RELOCATABLE_PPC32
+#ifdef CONFIG_PPC32
 		__dynamic_symtab = .;
 #endif
 		*(.dynsym)
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index e2d7ba124618..448685fbf27c 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -64,7 +64,7 @@ EXPORT_SYMBOL(memstart_addr);
 phys_addr_t kernstart_addr;
 EXPORT_SYMBOL(kernstart_addr);
 
-#ifdef CONFIG_RELOCATABLE_PPC32
+#ifdef CONFIG_RELOCATABLE
 /* Used in __va()/__pa() */
 long long virt_phys_offset;
 EXPORT_SYMBOL(virt_phys_offset);
-- 
2.8.1
