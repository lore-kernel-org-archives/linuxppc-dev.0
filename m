Return-Path: <anton@samba.org>
Date: Wed, 30 Apr 2014 09:12:01 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, felix@linux.vnet.ibm.com
Subject: [PATCH] powerpc: memcpy optimization for 64bit LE
Message-ID: <20140430091201.5eefbeb8@kryten>
In-Reply-To: <20140430091054.4de84c9b@kryten>
References: <20140430091054.4de84c9b@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Philippe Bergheaud <felix@linux.vnet.ibm.com>

Unaligned stores take alignment exceptions on POWER7 running in little-endian.
This is a dumb little-endian base memcpy that prevents unaligned stores.
Once booted the feature fixup code switches over to the VMX copy loops
(which are already endian safe).

The question is what we do before that switch over. The base 64bit
memcpy takes alignment exceptions on POWER7 so we can't use it as is.
Fixing the causes of alignment exception would slow it down, because
we'd need to ensure all loads and stores are aligned either through
rotate tricks or bytewise loads and stores. Either would be bad for
all other 64bit platforms.

[ I simplified the loop a bit - Anton ]

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/string.h |  4 ----
 arch/powerpc/kernel/ppc_ksyms.c   |  2 --
 arch/powerpc/lib/Makefile         |  2 --
 arch/powerpc/lib/memcpy_64.S      | 16 ++++++++++++++++
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 0dffad6..e40010a 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -10,9 +10,7 @@
 #define __HAVE_ARCH_STRNCMP
 #define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
-#ifdef __BIG_ENDIAN__
 #define __HAVE_ARCH_MEMCPY
-#endif
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
 #define __HAVE_ARCH_MEMCHR
@@ -24,9 +22,7 @@ extern int strcmp(const char *,const char *);
 extern int strncmp(const char *, const char *, __kernel_size_t);
 extern char * strcat(char *, const char *);
 extern void * memset(void *,int,__kernel_size_t);
-#ifdef __BIG_ENDIAN__
 extern void * memcpy(void *,const void *,__kernel_size_t);
-#endif
 extern void * memmove(void *,const void *,__kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 3bd77ed..8de1c48 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -154,9 +154,7 @@ EXPORT_SYMBOL(__cmpdi2);
 #endif
 long long __bswapdi2(long long);
 EXPORT_SYMBOL(__bswapdi2);
-#ifdef __BIG_ENDIAN__
 EXPORT_SYMBOL(memcpy);
-#endif
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memcmp);
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 95a20e1..59fa2de 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -23,9 +23,7 @@ obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
 endif
 
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),)
 obj-$(CONFIG_PPC64)		+= memcpy_power7.o memcpy_64.o 
-endif
 
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
 
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 72ad055..dc4ba79 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -12,12 +12,27 @@
 	.align	7
 _GLOBAL(memcpy)
 BEGIN_FTR_SECTION
+#ifdef __LITTLE_ENDIAN__
+	cmpdi	cr7,r5,0
+#else
 	std	r3,48(r1)	/* save destination pointer for return value */
+#endif
 FTR_SECTION_ELSE
 #ifndef SELFTEST
 	b	memcpy_power7
 #endif
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
+#ifdef __LITTLE_ENDIAN__
+	/* dumb little-endian memcpy that will get replaced at runtime */
+	addi r9,r3,-1
+	addi r4,r4,-1
+	beqlr cr7
+	mtctr r5
+1:	lbzu r10,1(r4)
+	stbu r10,1(r9)
+	bdnz 1b
+	blr
+#else
 	PPC_MTOCRF(0x01,r5)
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
@@ -203,3 +218,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	stb	r0,0(r3)
 4:	ld	r3,48(r1)	/* return dest pointer */
 	blr
+#endif
-- 
1.9.1
