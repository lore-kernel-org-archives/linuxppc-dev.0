Return-Path: <clg@kaod.org>
Received: from 5.mo6.mail-out.ovh.net (5.mo6.mail-out.ovh.net [46.105.54.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMK9w1BYHzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 19:54:43 +1100 (AEDT)
Received: from player786.ha.ovh.net (b7.ovh.net [213.186.33.57])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 911B7A6F54
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 09:44:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] add a const to ioread* routines to fix compile testing
Date: Mon, 13 Feb 2017 09:43:55 +0100
Message-Id: <1486975435-14182-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some architectures, the ioread routines are still using a non-const
argument for the address parameter. Let's change that to be consistent
with the others and fix compile testing (ARM drivers on Intel for
instance).

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 I am not sure how we should handle these changes, so, here is a big
 patch for all architectures to let maintainers decide. I suppose we
 could merge the patch in one arch, and first see how the 0-Day bot
 reacts.

 The patch can be found on this branch :

   https://github.com/legoater/linux/tree/aspeed

 Compiled on :
   
   arm
   arm64
   avr32   
   frv
   ia64
   alpha
   m68k
   parisc32
   parisc64
   mips
   mips64
   sh32
   sparc32
   sparc64
   x86_64
   i386
   powerpc32
   powerpc64
   powerpc64le
   s390x

 arch/alpha/include/asm/core_apecs.h  |  6 ++--
 arch/alpha/include/asm/core_cia.h    |  6 ++--
 arch/alpha/include/asm/core_lca.h    |  6 ++--
 arch/alpha/include/asm/core_marvel.h |  4 +--
 arch/alpha/include/asm/core_mcpcia.h |  6 ++--
 arch/alpha/include/asm/core_t2.h     |  2 +-
 arch/alpha/include/asm/io.h          |  2 +-
 arch/alpha/include/asm/io_trivial.h  |  6 ++--
 arch/alpha/include/asm/jensen.h      |  2 +-
 arch/alpha/include/asm/machvec.h     |  6 ++--
 arch/alpha/kernel/core_marvel.c      |  2 +-
 arch/alpha/kernel/io.c               | 12 ++++----
 arch/frv/include/asm/io.h            | 12 ++++----
 arch/frv/include/asm/mb-regs.h       |  6 ++--
 arch/mips/lib/iomap.c                | 22 ++++++-------
 arch/parisc/lib/iomap.c              | 60 ++++++++++++++++++------------------
 arch/powerpc/kernel/iomap.c          | 20 ++++++------
 arch/sh/kernel/iomap.c               | 22 ++++++-------
 arch/sparc/include/asm/io_64.h       |  6 ++--
 include/asm-generic/iomap.h          | 20 ++++++------
 lib/iomap.c                          | 22 ++++++-------
 21 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/arch/alpha/include/asm/core_apecs.h b/arch/alpha/include/asm/core_apecs.h
index 6785ff7e02bc..a4c88d2a66f0 100644
--- a/arch/alpha/include/asm/core_apecs.h
+++ b/arch/alpha/include/asm/core_apecs.h
@@ -383,7 +383,7 @@ struct el_apecs_procdata
 		}						\
 	} while (0)
 
-__EXTERN_INLINE unsigned int apecs_ioread8(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int apecs_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -419,7 +419,7 @@ __EXTERN_INLINE void apecs_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int apecs_ioread16(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int apecs_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -455,7 +455,7 @@ __EXTERN_INLINE void apecs_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int apecs_ioread32(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int apecs_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (addr < APECS_DENSE_MEM)
diff --git a/arch/alpha/include/asm/core_cia.h b/arch/alpha/include/asm/core_cia.h
index 9e0516c0ca27..fdc029953b90 100644
--- a/arch/alpha/include/asm/core_cia.h
+++ b/arch/alpha/include/asm/core_cia.h
@@ -341,7 +341,7 @@ struct el_CIA_sysdata_mcheck {
 #define vuip	volatile unsigned int __force *
 #define vulp	volatile unsigned long __force *
 
-__EXTERN_INLINE unsigned int cia_ioread8(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int cia_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -373,7 +373,7 @@ __EXTERN_INLINE void cia_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int cia_ioread16(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int cia_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -403,7 +403,7 @@ __EXTERN_INLINE void cia_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int cia_ioread32(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int cia_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (addr < CIA_DENSE_MEM)
diff --git a/arch/alpha/include/asm/core_lca.h b/arch/alpha/include/asm/core_lca.h
index 8ee6c516279c..25277e989731 100644
--- a/arch/alpha/include/asm/core_lca.h
+++ b/arch/alpha/include/asm/core_lca.h
@@ -229,7 +229,7 @@ union el_lca {
 	} while (0)
 
 
-__EXTERN_INLINE unsigned int lca_ioread8(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int lca_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -265,7 +265,7 @@ __EXTERN_INLINE void lca_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int lca_ioread16(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int lca_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -301,7 +301,7 @@ __EXTERN_INLINE void lca_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int lca_ioread32(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int lca_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (addr < LCA_DENSE_MEM)
diff --git a/arch/alpha/include/asm/core_marvel.h b/arch/alpha/include/asm/core_marvel.h
index dad300fa14ce..e4163d539b9d 100644
--- a/arch/alpha/include/asm/core_marvel.h
+++ b/arch/alpha/include/asm/core_marvel.h
@@ -331,10 +331,10 @@ struct io7 {
 #define vucp	volatile unsigned char __force *
 #define vusp	volatile unsigned short __force *
 
-extern unsigned int marvel_ioread8(void __iomem *);
+extern unsigned int marvel_ioread8(const void __iomem *addr);
 extern void marvel_iowrite8(u8 b, void __iomem *);
 
-__EXTERN_INLINE unsigned int marvel_ioread16(void __iomem *addr)
+__EXTERN_INLINE unsigned int marvel_ioread16(const void __iomem *addr)
 {
 	return __kernel_ldwu(*(vusp)addr);
 }
diff --git a/arch/alpha/include/asm/core_mcpcia.h b/arch/alpha/include/asm/core_mcpcia.h
index ad44bef29fba..9f45699761f7 100644
--- a/arch/alpha/include/asm/core_mcpcia.h
+++ b/arch/alpha/include/asm/core_mcpcia.h
@@ -266,7 +266,7 @@ extern inline int __mcpcia_is_mmio(unsigned long addr)
 	return (addr & 0x80000000UL) == 0;
 }
 
-__EXTERN_INLINE unsigned int mcpcia_ioread8(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int mcpcia_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long)xaddr & MCPCIA_MEM_MASK;
 	unsigned long hose = (unsigned long)xaddr & ~MCPCIA_MEM_MASK;
@@ -290,7 +290,7 @@ __EXTERN_INLINE void mcpcia_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + hose + 0x00) = w;
 }
 
-__EXTERN_INLINE unsigned int mcpcia_ioread16(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int mcpcia_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long)xaddr & MCPCIA_MEM_MASK;
 	unsigned long hose = (unsigned long)xaddr & ~MCPCIA_MEM_MASK;
@@ -314,7 +314,7 @@ __EXTERN_INLINE void mcpcia_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + hose + 0x08) = w;
 }
 
-__EXTERN_INLINE unsigned int mcpcia_ioread32(void __iomem *xaddr)
+__EXTERN_INLINE unsigned int mcpcia_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long)xaddr;
 
diff --git a/arch/alpha/include/asm/core_t2.h b/arch/alpha/include/asm/core_t2.h
index ade9d92e68b4..a7e7114b9b10 100644
--- a/arch/alpha/include/asm/core_t2.h
+++ b/arch/alpha/include/asm/core_t2.h
@@ -571,7 +571,7 @@ __EXTERN_INLINE int t2_is_mmio(const volatile void __iomem *addr)
    it doesn't make sense to merge the pio and mmio routines.  */
 
 #define IOPORT(OS, NS)							\
-__EXTERN_INLINE unsigned int t2_ioread##NS(void __iomem *xaddr)		\
+__EXTERN_INLINE unsigned int t2_ioread##NS(const void __iomem *xaddr)		\
 {									\
 	if (t2_is_mmio(xaddr))						\
 		return t2_read##OS(xaddr);				\
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index ff4049155c84..059be6c68a68 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -144,7 +144,7 @@ static inline void * __deprecated bus_to_virt(unsigned long address)
 /* In a generic kernel, we always go through the machine vector.  */
 
 #define REMAP1(TYPE, NAME, QUAL)					\
-static inline TYPE generic_##NAME(QUAL void __iomem *addr)		\
+static inline TYPE generic_##NAME(QUAL const void __iomem *addr)	\
 {									\
 	return alpha_mv.mv_##NAME(addr);				\
 }
diff --git a/arch/alpha/include/asm/io_trivial.h b/arch/alpha/include/asm/io_trivial.h
index 1c77f10b4b36..a7aa24b4b13d 100644
--- a/arch/alpha/include/asm/io_trivial.h
+++ b/arch/alpha/include/asm/io_trivial.h
@@ -6,13 +6,13 @@
 
 #if IO_CONCAT(__IO_PREFIX,trivial_io_bw)
 __EXTERN_INLINE unsigned int
-IO_CONCAT(__IO_PREFIX,ioread8)(void __iomem *a)
+IO_CONCAT(__IO_PREFIX, ioread8)(const void __iomem *a)
 {
 	return __kernel_ldbu(*(volatile u8 __force *)a);
 }
 
 __EXTERN_INLINE unsigned int
-IO_CONCAT(__IO_PREFIX,ioread16)(void __iomem *a)
+IO_CONCAT(__IO_PREFIX, ioread16)(const void __iomem *a)
 {
 	return __kernel_ldwu(*(volatile u16 __force *)a);
 }
@@ -32,7 +32,7 @@ IO_CONCAT(__IO_PREFIX,iowrite16)(u16 b, void __iomem *a)
 
 #if IO_CONCAT(__IO_PREFIX,trivial_io_lq)
 __EXTERN_INLINE unsigned int
-IO_CONCAT(__IO_PREFIX,ioread32)(void __iomem *a)
+IO_CONCAT(__IO_PREFIX, ioread32)(const void __iomem *a)
 {
 	return *(volatile u32 __force *)a;
 }
diff --git a/arch/alpha/include/asm/jensen.h b/arch/alpha/include/asm/jensen.h
index 964b06ead43b..bafede37d995 100644
--- a/arch/alpha/include/asm/jensen.h
+++ b/arch/alpha/include/asm/jensen.h
@@ -304,7 +304,7 @@ __EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
    that it doesn't make sense to merge them.  */
 
 #define IOPORT(OS, NS)							\
-__EXTERN_INLINE unsigned int jensen_ioread##NS(void __iomem *xaddr)	\
+__EXTERN_INLINE unsigned int jensen_ioread##NS(const void __iomem *xaddr) \
 {									\
 	if (jensen_is_mmio(xaddr))					\
 		return jensen_read##OS(xaddr - 0x100000000ul);		\
diff --git a/arch/alpha/include/asm/machvec.h b/arch/alpha/include/asm/machvec.h
index 75cb3641ed2f..cca4a75f6f6b 100644
--- a/arch/alpha/include/asm/machvec.h
+++ b/arch/alpha/include/asm/machvec.h
@@ -45,9 +45,9 @@ struct alpha_machine_vector
 	void (*mv_pci_tbi)(struct pci_controller *hose,
 			   dma_addr_t start, dma_addr_t end);
 
-	unsigned int (*mv_ioread8)(void __iomem *);
-	unsigned int (*mv_ioread16)(void __iomem *);
-	unsigned int (*mv_ioread32)(void __iomem *);
+	unsigned int (*mv_ioread8)(const void __iomem *);
+	unsigned int (*mv_ioread16)(const void __iomem *);
+	unsigned int (*mv_ioread32)(const void __iomem *);
 
 	void (*mv_iowrite8)(u8, void __iomem *);
 	void (*mv_iowrite16)(u16, void __iomem *);
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index d5f0580746a5..e7dd5914b3ed 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -798,7 +798,7 @@ void __iomem *marvel_ioportmap (unsigned long addr)
 }
 
 unsigned int
-marvel_ioread8(void __iomem *xaddr)
+marvel_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (__marvel_is_port_kbd(addr))
diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index 19c5875ab398..c1c7457bf3d3 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -13,21 +13,21 @@
    "generic", which bumps through the machine vector.  */
 
 unsigned int
-ioread8(void __iomem *addr)
+ioread8(const void __iomem *addr)
 {
 	unsigned int ret = IO_CONCAT(__IO_PREFIX,ioread8)(addr);
 	mb();
 	return ret;
 }
 
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	unsigned int ret = IO_CONCAT(__IO_PREFIX,ioread16)(addr);
 	mb();
 	return ret;
 }
 
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	unsigned int ret = IO_CONCAT(__IO_PREFIX,ioread32)(addr);
 	mb();
@@ -210,7 +210,7 @@ EXPORT_SYMBOL(writeq);
 /*
  * Read COUNT 8-bit bytes from port PORT into memory starting at SRC.
  */
-void ioread8_rep(void __iomem *port, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *port, void *dst, unsigned long count)
 {
 	while ((unsigned long)dst & 0x3) {
 		if (!count)
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(insb);
  * the interfaces seems to be slow: just using the inlined version
  * of the inw() breaks things.
  */
-void ioread16_rep(void __iomem *port, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *port, void *dst, unsigned long count)
 {
 	if (unlikely((unsigned long)dst & 0x3)) {
 		if (!count)
@@ -293,7 +293,7 @@ EXPORT_SYMBOL(insw);
  * but the interfaces seems to be slow: just using the inlined version
  * of the inl() breaks things.
  */
-void ioread32_rep(void __iomem *port, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *port, void *dst, unsigned long count)
 {
 	if (unlikely((unsigned long)dst & 0x3)) {
 		while (count--) {
diff --git a/arch/frv/include/asm/io.h b/arch/frv/include/asm/io.h
index 8062fc73fad0..887add348f38 100644
--- a/arch/frv/include/asm/io.h
+++ b/arch/frv/include/asm/io.h
@@ -310,12 +310,12 @@ static inline void flush_write_buffers(void)
 /*
  * do appropriate I/O accesses for token type
  */
-static inline unsigned int ioread8(void __iomem *p)
+static inline unsigned int ioread8(const void __iomem *p)
 {
 	return __builtin_read8(p);
 }
 
-static inline unsigned int ioread16(void __iomem *p)
+static inline unsigned int ioread16(const void __iomem *p)
 {
 	uint16_t ret = __builtin_read16(p);
 	if (__is_PCI_addr(p))
@@ -323,7 +323,7 @@ static inline unsigned int ioread16(void __iomem *p)
 	return ret;
 }
 
-static inline unsigned int ioread32(void __iomem *p)
+static inline unsigned int ioread32(const void __iomem *p)
 {
 	uint32_t ret = __builtin_read32(p);
 	if (__is_PCI_addr(p))
@@ -361,17 +361,17 @@ static inline void iowrite32(u32 val, void __iomem *p)
 #define iowrite16be(v, addr)	iowrite16(cpu_to_be16(v), (addr))
 #define iowrite32be(v, addr)	iowrite32(cpu_to_be32(v), (addr))
 
-static inline void ioread8_rep(void __iomem *p, void *dst, unsigned long count)
+static inline void ioread8_rep(const void __iomem *p, void *dst, unsigned long count)
 {
 	io_insb((unsigned long) p, dst, count);
 }
 
-static inline void ioread16_rep(void __iomem *p, void *dst, unsigned long count)
+static inline void ioread16_rep(const void __iomem *p, void *dst, unsigned long count)
 {
 	io_insw((unsigned long) p, dst, count);
 }
 
-static inline void ioread32_rep(void __iomem *p, void *dst, unsigned long count)
+static inline void ioread32_rep(const void __iomem *p, void *dst, unsigned long count)
 {
 	__insl_ns((unsigned long) p, dst, count);
 }
diff --git a/arch/frv/include/asm/mb-regs.h b/arch/frv/include/asm/mb-regs.h
index 219e5f926f18..926a8663c3d4 100644
--- a/arch/frv/include/asm/mb-regs.h
+++ b/arch/frv/include/asm/mb-regs.h
@@ -19,9 +19,9 @@
 #ifndef __ASSEMBLY__
 /* gcc builtins, annotated */
 
-unsigned long __builtin_read8(volatile void __iomem *);
-unsigned long __builtin_read16(volatile void __iomem *);
-unsigned long __builtin_read32(volatile void __iomem *);
+unsigned long __builtin_read8(const volatile void __iomem *);
+unsigned long __builtin_read16(const volatile void __iomem *);
+unsigned long __builtin_read32(const volatile void __iomem *);
 void __builtin_write8(volatile void __iomem *, unsigned char);
 void __builtin_write16(volatile void __iomem *, unsigned short);
 void __builtin_write32(volatile void __iomem *, unsigned long);
diff --git a/arch/mips/lib/iomap.c b/arch/mips/lib/iomap.c
index 9daa92428e23..3b342dc40eda 100644
--- a/arch/mips/lib/iomap.c
+++ b/arch/mips/lib/iomap.c
@@ -25,35 +25,35 @@
 
 #define PIO_MASK	0x0ffffUL
 
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	return readb(addr);
 }
 
 EXPORT_SYMBOL(ioread8);
 
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	return readw(addr);
 }
 
 EXPORT_SYMBOL(ioread16);
 
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	return be16_to_cpu(__raw_readw(addr));
 }
 
 EXPORT_SYMBOL(ioread16be);
 
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	return readl(addr);
 }
 
 EXPORT_SYMBOL(ioread32);
 
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	return be32_to_cpu(__raw_readl(addr));
 }
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(iowrite32be);
  * to CPU byte order if the host bus happens to not match the
  * endianness of PCI/ISA (see mach-generic/mangle-port.h).
  */
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
+static inline void mmio_insb(const void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
 		u8 data = __mem_readb(addr);
@@ -110,7 +110,7 @@ static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 	}
 }
 
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
+static inline void mmio_insw(const void __iomem *addr, u16 *dst, int count)
 {
 	while (--count >= 0) {
 		u16 data = __mem_readw(addr);
@@ -119,7 +119,7 @@ static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
 	}
 }
 
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
+static inline void mmio_insl(const void __iomem *addr, u32 *dst, int count)
 {
 	while (--count >= 0) {
 		u32 data = __mem_readl(addr);
@@ -152,21 +152,21 @@ static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
 	}
 }
 
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	mmio_insb(addr, dst, count);
 }
 
 EXPORT_SYMBOL(ioread8_rep);
 
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	mmio_insw(addr, dst, count);
 }
 
 EXPORT_SYMBOL(ioread16_rep);
 
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	mmio_insl(addr, dst, count);
 }
diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index eaffbb90aa14..5dee8c352256 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -42,19 +42,19 @@
 #endif
 
 struct iomap_ops {
-	unsigned int (*read8)(void __iomem *);
-	unsigned int (*read16)(void __iomem *);
-	unsigned int (*read16be)(void __iomem *);
-	unsigned int (*read32)(void __iomem *);
-	unsigned int (*read32be)(void __iomem *);
+	unsigned int (*read8)(const void __iomem *);
+	unsigned int (*read16)(const void __iomem *);
+	unsigned int (*read16be)(const void __iomem *);
+	unsigned int (*read32)(const void __iomem *);
+	unsigned int (*read32be)(const void __iomem *);
 	void (*write8)(u8, void __iomem *);
 	void (*write16)(u16, void __iomem *);
 	void (*write16be)(u16, void __iomem *);
 	void (*write32)(u32, void __iomem *);
 	void (*write32be)(u32, void __iomem *);
-	void (*read8r)(void __iomem *, void *, unsigned long);
-	void (*read16r)(void __iomem *, void *, unsigned long);
-	void (*read32r)(void __iomem *, void *, unsigned long);
+	void (*read8r)(const void __iomem *, void *, unsigned long);
+	void (*read16r)(const void __iomem *, void *, unsigned long);
+	void (*read32r)(const void __iomem *, void *, unsigned long);
 	void (*write8r)(void __iomem *, const void *, unsigned long);
 	void (*write16r)(void __iomem *, const void *, unsigned long);
 	void (*write32r)(void __iomem *, const void *, unsigned long);
@@ -64,17 +64,17 @@ struct iomap_ops {
 
 #define ADDR2PORT(addr) ((unsigned long __force)(addr) & 0xffffff)
 
-static unsigned int ioport_read8(void __iomem *addr)
+static unsigned int ioport_read8(const void __iomem *addr)
 {
 	return inb(ADDR2PORT(addr));
 }
 
-static unsigned int ioport_read16(void __iomem *addr)
+static unsigned int ioport_read16(const void __iomem *addr)
 {
 	return inw(ADDR2PORT(addr));
 }
 
-static unsigned int ioport_read32(void __iomem *addr)
+static unsigned int ioport_read32(const void __iomem *addr)
 {
 	return inl(ADDR2PORT(addr));
 }
@@ -94,17 +94,17 @@ static void ioport_write32(u32 datum, void __iomem *addr)
 	outl(datum, ADDR2PORT(addr));
 }
 
-static void ioport_read8r(void __iomem *addr, void *dst, unsigned long count)
+static void ioport_read8r(const void __iomem *addr, void *dst, unsigned long count)
 {
 	insb(ADDR2PORT(addr), dst, count);
 }
 
-static void ioport_read16r(void __iomem *addr, void *dst, unsigned long count)
+static void ioport_read16r(const void __iomem *addr, void *dst, unsigned long count)
 {
 	insw(ADDR2PORT(addr), dst, count);
 }
 
-static void ioport_read32r(void __iomem *addr, void *dst, unsigned long count)
+static void ioport_read32r(const void __iomem *addr, void *dst, unsigned long count)
 {
 	insl(ADDR2PORT(addr), dst, count);
 }
@@ -145,27 +145,27 @@ static const struct iomap_ops ioport_ops = {
 
 /* Legacy I/O memory ops */
 
-static unsigned int iomem_read8(void __iomem *addr)
+static unsigned int iomem_read8(const void __iomem *addr)
 {
 	return readb(addr);
 }
 
-static unsigned int iomem_read16(void __iomem *addr)
+static unsigned int iomem_read16(const void __iomem *addr)
 {
 	return readw(addr);
 }
 
-static unsigned int iomem_read16be(void __iomem *addr)
+static unsigned int iomem_read16be(const void __iomem *addr)
 {
 	return __raw_readw(addr);
 }
 
-static unsigned int iomem_read32(void __iomem *addr)
+static unsigned int iomem_read32(const void __iomem *addr)
 {
 	return readl(addr);
 }
 
-static unsigned int iomem_read32be(void __iomem *addr)
+static unsigned int iomem_read32be(const void __iomem *addr)
 {
 	return __raw_readl(addr);
 }
@@ -195,7 +195,7 @@ static void iomem_write32be(u32 datum, void __iomem *addr)
 	__raw_writel(datum, addr);
 }
 
-static void iomem_read8r(void __iomem *addr, void *dst, unsigned long count)
+static void iomem_read8r(const void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
 		*(u8 *)dst = __raw_readb(addr);
@@ -203,7 +203,7 @@ static void iomem_read8r(void __iomem *addr, void *dst, unsigned long count)
 	}
 }
 
-static void iomem_read16r(void __iomem *addr, void *dst, unsigned long count)
+static void iomem_read16r(const void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
 		*(u16 *)dst = __raw_readw(addr);
@@ -211,7 +211,7 @@ static void iomem_read16r(void __iomem *addr, void *dst, unsigned long count)
 	}
 }
 
-static void iomem_read32r(void __iomem *addr, void *dst, unsigned long count)
+static void iomem_read32r(const void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
 		*(u32 *)dst = __raw_readl(addr);
@@ -268,35 +268,35 @@ static const struct iomap_ops *iomap_ops[8] = {
 };
 
 
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read8(addr);
 	return *((u8 *)addr);
 }
 
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read16(addr);
 	return le16_to_cpup((u16 *)addr);
 }
 
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read16be(addr);
 	return *((u16 *)addr);
 }
 
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read32(addr);
 	return le32_to_cpup((u32 *)addr);
 }
 
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read32be(addr);
@@ -350,7 +350,7 @@ void iowrite32be(u32 datum, void __iomem *addr)
 
 /* Repeating interfaces */
 
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
 		iomap_ops[ADDR_TO_REGION(addr)]->read8r(addr, dst, count);
@@ -362,7 +362,7 @@ void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 	}
 }
 
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
 		iomap_ops[ADDR_TO_REGION(addr)]->read16r(addr, dst, count);
@@ -374,7 +374,7 @@ void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
 	}
 }
 
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
 		iomap_ops[ADDR_TO_REGION(addr)]->read32r(addr, dst, count);
diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 3963f0b68d52..8a7719d1a805 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -13,23 +13,23 @@
  * Here comes the ppc64 implementation of the IOMAP 
  * interfaces.
  */
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	return readb(addr);
 }
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	return readw(addr);
 }
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	return readw_be(addr);
 }
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	return readl(addr);
 }
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	return readl_be(addr);
 }
@@ -39,11 +39,11 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 #ifdef __powerpc64__
-u64 ioread64(void __iomem *addr)
+u64 ioread64(const void __iomem *addr)
 {
 	return readq(addr);
 }
-u64 ioread64be(void __iomem *addr)
+u64 ioread64be(const void __iomem *addr)
 {
 	return readq_be(addr);
 }
@@ -97,15 +97,15 @@ EXPORT_SYMBOL(iowrite64be);
  * FIXME! We could make these do EEH handling if we really
  * wanted. Not clear if we do.
  */
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsb(addr, dst, count);
 }
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsw(addr, dst, count);
 }
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	readsl(addr, dst, count);
 }
diff --git a/arch/sh/kernel/iomap.c b/arch/sh/kernel/iomap.c
index 2e8e8b9b9cef..0ee468c88b20 100644
--- a/arch/sh/kernel/iomap.c
+++ b/arch/sh/kernel/iomap.c
@@ -11,31 +11,31 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	return readb(addr);
 }
 EXPORT_SYMBOL(ioread8);
 
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	return readw(addr);
 }
 EXPORT_SYMBOL(ioread16);
 
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	return be16_to_cpu(__raw_readw(addr));
 }
 EXPORT_SYMBOL(ioread16be);
 
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	return readl(addr);
 }
 EXPORT_SYMBOL(ioread32);
 
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	return be32_to_cpu(__raw_readl(addr));
 }
@@ -77,7 +77,7 @@ EXPORT_SYMBOL(iowrite32be);
  * convert to CPU byte order. We write in "IO byte
  * order" (we also don't have IO barriers).
  */
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
+static inline void mmio_insb(const void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
 		u8 data = __raw_readb(addr);
@@ -86,7 +86,7 @@ static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 	}
 }
 
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
+static inline void mmio_insw(const void __iomem *addr, u16 *dst, int count)
 {
 	while (--count >= 0) {
 		u16 data = __raw_readw(addr);
@@ -95,7 +95,7 @@ static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
 	}
 }
 
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
+static inline void mmio_insl(const void __iomem *addr, u32 *dst, int count)
 {
 	while (--count >= 0) {
 		u32 data = __raw_readl(addr);
@@ -128,19 +128,19 @@ static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
 	}
 }
 
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	mmio_insb(addr, dst, count);
 }
 EXPORT_SYMBOL(ioread8_rep);
 
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	mmio_insw(addr, dst, count);
 }
 EXPORT_SYMBOL(ioread16_rep);
 
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	mmio_insl(addr, dst, count);
 }
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index c32fa3f752c8..5be679c58602 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -242,16 +242,16 @@ void insb(unsigned long, void *, unsigned long);
 void insw(unsigned long, void *, unsigned long);
 void insl(unsigned long, void *, unsigned long);
 
-static inline void ioread8_rep(void __iomem *port, void *buf, unsigned long count)
+static inline void ioread8_rep(const void __iomem *port, void *buf, unsigned long count)
 {
 	insb((unsigned long __force)port, buf, count);
 }
-static inline void ioread16_rep(void __iomem *port, void *buf, unsigned long count)
+static inline void ioread16_rep(const void __iomem *port, void *buf, unsigned long count)
 {
 	insw((unsigned long __force)port, buf, count);
 }
 
-static inline void ioread32_rep(void __iomem *port, void *buf, unsigned long count)
+static inline void ioread32_rep(const void __iomem *port, void *buf, unsigned long count)
 {
 	insl((unsigned long __force)port, buf, count);
 }
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 650fede33c25..77ac2a1e838f 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -25,14 +25,14 @@
  * in the low address range. Architectures for which this is not
  * true can't use this generic implementation.
  */
-extern unsigned int ioread8(void __iomem *);
-extern unsigned int ioread16(void __iomem *);
-extern unsigned int ioread16be(void __iomem *);
-extern unsigned int ioread32(void __iomem *);
-extern unsigned int ioread32be(void __iomem *);
+extern unsigned int ioread8(const void __iomem *);
+extern unsigned int ioread16(const void __iomem *);
+extern unsigned int ioread16be(const void __iomem *);
+extern unsigned int ioread32(const void __iomem *);
+extern unsigned int ioread32be(const void __iomem *);
 #ifdef CONFIG_64BIT
-extern u64 ioread64(void __iomem *);
-extern u64 ioread64be(void __iomem *);
+extern u64 ioread64(const void __iomem *);
+extern u64 ioread64be(const void __iomem *);
 #endif
 
 extern void iowrite8(u8, void __iomem *);
@@ -56,9 +56,9 @@ extern void iowrite64be(u64, void __iomem *);
  * memory across multiple ports, use "memcpy_toio()"
  * and friends.
  */
-extern void ioread8_rep(void __iomem *port, void *buf, unsigned long count);
-extern void ioread16_rep(void __iomem *port, void *buf, unsigned long count);
-extern void ioread32_rep(void __iomem *port, void *buf, unsigned long count);
+extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
+extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
+extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
 
 extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
diff --git a/lib/iomap.c b/lib/iomap.c
index fc3dcb4b238e..ec9b235835d9 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -68,27 +68,27 @@ static void bad_io_access(unsigned long port, const char *access)
 #define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
 #endif
 
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	IO_COND(addr, return inb(port), return readb(addr));
 	return 0xff;
 }
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	IO_COND(addr, return inw(port), return readw(addr));
 	return 0xffff;
 }
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read16be(port), return mmio_read16be(addr));
 	return 0xffff;
 }
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	IO_COND(addr, return inl(port), return readl(addr));
 	return 0xffffffff;
 }
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read32be(port), return mmio_read32be(addr));
 	return 0xffffffff;
@@ -142,7 +142,7 @@ EXPORT_SYMBOL(iowrite32be);
  * order" (we also don't have IO barriers).
  */
 #ifndef mmio_insb
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
+static inline void mmio_insb(const void __iomem *addr, u8 *dst, int count)
 {
 	while (--count >= 0) {
 		u8 data = __raw_readb(addr);
@@ -150,7 +150,7 @@ static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
 		dst++;
 	}
 }
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
+static inline void mmio_insw(const void __iomem *addr, u16 *dst, int count)
 {
 	while (--count >= 0) {
 		u16 data = __raw_readw(addr);
@@ -158,7 +158,7 @@ static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
 		dst++;
 	}
 }
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
+static inline void mmio_insl(const void __iomem *addr, u32 *dst, int count)
 {
 	while (--count >= 0) {
 		u32 data = __raw_readl(addr);
@@ -192,15 +192,15 @@ static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
 }
 #endif
 
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insb(port,dst,count), mmio_insb(addr, dst, count));
 }
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insw(port,dst,count), mmio_insw(addr, dst, count));
 }
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insl(port,dst,count), mmio_insl(addr, dst, count));
 }
-- 
2.7.4
