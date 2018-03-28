Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0179.hostedemail.com
 [216.40.44.179])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BBbN5cf6zF2NB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:28:00 +1100 (AEDT)
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Shea Levy <shea@shealevy.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Vladimir Murzin <vladimir.murzin@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Joe Perches <joe@perches.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Rob Landley <rob@landley.net>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
Subject: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 11:26:51 -0400
Message-Id: <20180328152714.6103-1-shea@shealevy.com>
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now only those architectures that have custom initrd free requirements
need to define free_initrd_mem.

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/alpha/mm/init.c      |  8 --------
 arch/arc/mm/init.c        |  7 -------
 arch/arm/Kconfig          |  1 +
 arch/arm64/Kconfig        |  1 +
 arch/blackfin/Kconfig     |  1 +
 arch/c6x/mm/init.c        |  7 -------
 arch/cris/Kconfig         |  1 +
 arch/frv/mm/init.c        | 11 -----------
 arch/h8300/mm/init.c      |  7 -------
 arch/hexagon/Kconfig      |  1 +
 arch/ia64/Kconfig         |  1 +
 arch/m32r/Kconfig         |  1 +
 arch/m32r/mm/init.c       | 11 -----------
 arch/m68k/mm/init.c       |  7 -------
 arch/metag/Kconfig        |  1 +
 arch/microblaze/mm/init.c |  7 -------
 arch/mips/Kconfig         |  1 +
 arch/mn10300/Kconfig      |  1 +
 arch/nios2/mm/init.c      |  7 -------
 arch/openrisc/mm/init.c   |  7 -------
 arch/parisc/mm/init.c     |  7 -------
 arch/powerpc/mm/mem.c     |  7 -------
 arch/riscv/mm/init.c      |  6 ------
 arch/s390/Kconfig         |  1 +
 arch/score/Kconfig        |  1 +
 arch/sh/mm/init.c         |  7 -------
 arch/sparc/Kconfig        |  1 +
 arch/tile/Kconfig         |  1 +
 arch/um/kernel/mem.c      |  7 -------
 arch/unicore32/Kconfig    |  1 +
 arch/x86/Kconfig          |  1 +
 arch/xtensa/Kconfig       |  1 +
 init/initramfs.c          |  7 +++++++
 usr/Kconfig               |  4 ++++
 34 files changed, 28 insertions(+), 113 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 9d74520298ab..55f7c8efa962 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -291,11 +291,3 @@ free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void
-free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ba145065c579..7bcf23ab1756 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -229,10 +229,3 @@ void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f972e83909b..19d1c5594e2d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -47,6 +47,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cb03e93f03cf..de93620870af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -85,6 +85,7 @@ config ARM64
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index d9c2866ba618..6c6dae9fe894 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -15,6 +15,7 @@ config BLACKFIN
 	def_bool y
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index 4cc72b0d1c1d..a11cb657182a 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -66,13 +66,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __init free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index cd5a0865c97f..5425f77e5664 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -76,6 +76,7 @@ config CRIS
 	select HAVE_DEBUG_BUGVERBOSE if ETRAX_ARCH_V32
 	select HAVE_NMI
 	select DMA_DIRECT_OPS if PCI
+	select HAVE_ARCH_FREE_INITRD_MEM
 
 config HZ
 	int
diff --git a/arch/frv/mm/init.c b/arch/frv/mm/init.c
index cf464100e838..345edc4dc462 100644
--- a/arch/frv/mm/init.c
+++ b/arch/frv/mm/init.c
@@ -131,14 +131,3 @@ void free_initmem(void)
 	free_initmem_default(-1);
 #endif
 } /* end free_initmem() */
-
-/*****************************************************************************/
-/*
- * free the initial ramdisk memory
- */
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-} /* end free_initrd_mem() */
-#endif
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 015287ac8ce8..37574332b202 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -102,13 +102,6 @@ void __init mem_init(void)
 }
 
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void
 free_initmem(void)
 {
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 76d2f20d525e..69a16cd2e253 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -17,6 +17,7 @@ config HEXAGON
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_SHOW
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select NO_IOPORT_MAP
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bbe12a038d21..366ef1dd3cd4 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -28,6 +28,7 @@ config IA64
 	select HAVE_DYNAMIC_FTRACE if (!ITANIUM)
 	select HAVE_FUNCTION_TRACER
 	select TTY
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_MEMBLOCK
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index dd84ee194579..9e41bdff45c3 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -21,6 +21,7 @@ config M32R
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DIRECT_OPS
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
+	select HAVE_ARCH_FREE_INITRD_MEM
 
 config SBUS
 	bool
diff --git a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
index 93abc8c3a46e..e2b5f09209ee 100644
--- a/arch/m32r/mm/init.c
+++ b/arch/m32r/mm/init.c
@@ -139,14 +139,3 @@ void free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-/*======================================================================*
- * free_initrd_mem() :
- * orig : arch/sh/mm/init.c
- *======================================================================*/
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index e85acd131fa8..e20bef09258c 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -172,10 +172,3 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 	print_memmap();
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index c7b62a339539..5be7f1693b1b 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -7,6 +7,7 @@ config METAG
 	select GENERIC_IRQ_SHOW
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_64BIT_ALIGNED_ACCESS
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index df6de7ccdc2e..ea058dfda222 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -187,13 +187,6 @@ void __init setup_memory(void)
 	paging_init();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8128c3b68d6b..c033cd1e0c52 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -27,6 +27,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index e9d8d60bd28b..5aa4f1aa309f 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -6,6 +6,7 @@ config MN10300
 	select HAVE_UID16
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_KGDB
 	select GENERIC_ATOMIC64
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index c92fe4234009..3df75ff8c768 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -82,13 +82,6 @@ void __init mmu_init(void)
 	flush_tlb_all();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 6972d5d6f23f..c1a3dcf9ad40 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -222,13 +222,6 @@ void __init mem_init(void)
 	return;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index cab32ee824d2..3643399230f3 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -932,10 +932,3 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index fe8c61149fb8..e85b2a3cd264 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -404,13 +404,6 @@ void free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /*
  * This is called when a page has been modified by the kernel.
  * It just marks the page as not i-cache clean.  We do the i-cache
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c77df8142be2..36f83fe8a726 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -62,9 +62,3 @@ void free_initmem(void)
 {
 	free_initmem_default(0);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index eaee7087886f..94a9879f1ea8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -125,6 +125,7 @@ config S390
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_JUMP_LABEL
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index d881f99c9ddd..2beff03b2429 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -16,6 +16,7 @@ config SCORE
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
 	select CPU_NO_EFFICIENT_FFS
+	select HAVE_ARCH_FREE_INITRD_MEM
 
 choice
 	prompt "System type"
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..7451459d0725 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -477,13 +477,6 @@ void free_initmem(void)
 	free_initmem_default(-1);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		bool want_memblock)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..06d543e35caf 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -18,6 +18,7 @@ config SPARC
 	select OF_PROMTREE
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_EXIT_THREAD
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index ef9d403cbbe4..7fb36c15762c 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -16,6 +16,7 @@ config TILE
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CONTEXT_TRACKING
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 3c0e470ea646..2d26eec92126 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -170,13 +170,6 @@ void free_initmem(void)
 {
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /* Allocate and free page tables. */
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 462e59a7ae78..4da24cf467de 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -4,6 +4,7 @@ config UNICORE32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_MEMBLOCK
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fa71a78ec99..51ce64e6d848 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -111,6 +111,7 @@ config X86
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KGDB
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c921e8bccdc8..01a4a0e42118 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -16,6 +16,7 @@ config XTENSA
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_STRNCPY_FROM_USER if KASAN
+	select HAVE_ARCH_FREE_INITRD_MEM
 	select HAVE_ARCH_KASAN if MMU
 	select HAVE_CC_STACKPROTECTOR
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..d319058eb464 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+#ifndef CONFIG_HAVE_ARCH_FREE_INITRD_MEM
+void __init free_initrd_mem(unsigned long start, unsigned long end)
+{
+       free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+#endif
+
 static void __init free_initrd(void)
 {
 #ifdef CONFIG_KEXEC_CORE
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..7a94f6df39bf 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
 	default ".lzma" if RD_LZMA
 	default ".bz2"  if RD_BZIP2
 	default ""
+
+config HAVE_ARCH_FREE_INITRD_MEM
+	bool
+	default n
-- 
2.16.2
