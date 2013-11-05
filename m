Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp14.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86EDB2C0126
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 19:39:08 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 5 Nov 2013 08:39:04 -0000
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: memcpy optimization for 64bit LE
Date: Tue,  5 Nov 2013 09:38:52 +0100
Message-Id: <1383640732-21449-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unaligned stores take alignment exceptions on POWER7 running in little-endian.
This is a dumb little-endian base memcpy that prevents unaligned stores.
It is replaced by the VMX memcpy at boot.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/string.h |    4 ----
 arch/powerpc/kernel/ppc_ksyms.c   |    2 --
 arch/powerpc/lib/Makefile         |    2 --
 arch/powerpc/lib/memcpy_64.S      |   19 +++++++++++++++++++
 4 files changed, 19 insertions(+), 8 deletions(-)

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
index 526ad5c..0c2dd60 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -147,9 +147,7 @@ EXPORT_SYMBOL(__ucmpdi2);
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
index 5310132..6670361 100644
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
index d2bbbc8..358cf74 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -12,10 +12,28 @@
 	.align	7
 _GLOBAL(memcpy)
 BEGIN_FTR_SECTION
+#ifdef __LITTLE_ENDIAN__
+	cmpdi cr7,r5,0		/* dumb little-endian memcpy */
+#else
 	std	r3,48(r1)	/* save destination pointer for return value */
+#endif
 FTR_SECTION_ELSE
 	b	memcpy_power7
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
+#ifdef __LITTLE_ENDIAN__
+	addi r5,r5,-1
+	addi r9,r3,-1
+	add r5,r3,r5
+	subf r5,r9,r5
+	addi r4,r4,-1
+	mtctr r5
+	beqlr cr7
+1:
+	lbzu r10,1(r4)
+	stbu r10,1(r9)
+	bdnz 1b
+	blr
+#else
 	PPC_MTOCRF(0x01,r5)
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
@@ -201,3 +219,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	stb	r0,0(r3)
 4:	ld	r3,48(r1)	/* return dest pointer */
 	blr
+#endif
-- 
1.7.10.4
