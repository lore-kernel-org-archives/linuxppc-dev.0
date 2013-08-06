Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 58/63] powerpc: Use generic memcpy code in little endian
Date: Wed,  7 Aug 2013 02:02:15 +1000
Message-Id: <1375804940-22050-59-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to fix some endian issues in our memcpy code. For now
just enable the generic memcpy routine for little endian builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/string.h | 4 ++++
 arch/powerpc/kernel/ppc_ksyms.c   | 2 ++
 arch/powerpc/lib/Makefile         | 9 ++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index e40010a..0dffad6 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -10,7 +10,9 @@
 #define __HAVE_ARCH_STRNCMP
 #define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
+#ifdef __BIG_ENDIAN__
 #define __HAVE_ARCH_MEMCPY
+#endif
 #define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMCMP
 #define __HAVE_ARCH_MEMCHR
@@ -22,7 +24,9 @@ extern int strcmp(const char *,const char *);
 extern int strncmp(const char *, const char *, __kernel_size_t);
 extern char * strcat(char *, const char *);
 extern void * memset(void *,int,__kernel_size_t);
+#ifdef __BIG_ENDIAN__
 extern void * memcpy(void *,const void *,__kernel_size_t);
+#endif
 extern void * memmove(void *,const void *,__kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 0c2dd60..526ad5c 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -147,7 +147,9 @@ EXPORT_SYMBOL(__ucmpdi2);
 #endif
 long long __bswapdi2(long long);
 EXPORT_SYMBOL(__bswapdi2);
+#ifdef __BIG_ENDIAN__
 EXPORT_SYMBOL(memcpy);
+#endif
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memcmp);
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 33ab261..5310132 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -15,15 +15,18 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
-			   memcpy_64.o usercopy_64.o mem_64.o string.o \
+			   usercopy_64.o mem_64.o string.o \
 			   hweight_64.o \
-			   copyuser_power7.o string_64.o copypage_power7.o \
-			   memcpy_power7.o
+			   copyuser_power7.o string_64.o copypage_power7.o
 ifeq ($(CONFIG_GENERIC_CSUM),)
 obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
 endif
 
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),)
+obj-$(CONFIG_PPC64)		+= memcpy_power7.o memcpy_64.o 
+endif
+
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
 
 ifeq ($(CONFIG_PPC64),y)
-- 
1.8.1.2
