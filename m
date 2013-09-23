Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 17/39] powerpc: Use generic checksum code in little endian
Date: Mon, 23 Sep 2013 12:04:51 +1000
Message-Id: <1379901913-5945-18-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to fix some endian issues in our checksum code. For now
just enable the generic checksum routines for little endian builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Kconfig                | 3 +++
 arch/powerpc/include/asm/checksum.h | 5 +++++
 arch/powerpc/kernel/ppc_ksyms.c     | 2 ++
 arch/powerpc/lib/Makefile           | 9 +++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6b7530f..d232c84 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,9 @@ config PPC
 	select OLD_SIGACTION if PPC32
 	select HAVE_DEBUG_STACKOVERFLOW
 
+config GENERIC_CSUM
+	def_bool CPU_LITTLE_ENDIAN
+
 config EARLY_PRINTK
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index ce0c284..8251a3b 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -14,6 +14,9 @@
  * which always checksum on 4 octet boundaries.  ihl is the number
  * of 32-bit words and is always >= 5.
  */
+#ifdef CONFIG_GENERIC_CSUM
+#include <asm-generic/checksum.h>
+#else
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 
 /*
@@ -123,5 +126,7 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 #endif
 }
+
+#endif
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 21646db..3b485c5 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -79,10 +79,12 @@ EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 
+#ifndef CONFIG_GENERIC_CSUM
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
 EXPORT_SYMBOL(ip_fast_csum);
 EXPORT_SYMBOL(csum_tcpudp_magic);
+#endif
 
 EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__clear_user);
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4504332..33ab261 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -10,15 +10,20 @@ CFLAGS_REMOVE_code-patching.o = -pg
 CFLAGS_REMOVE_feature-fixups.o = -pg
 
 obj-y			:= string.o alloc.o \
-			   checksum_$(CONFIG_WORD_SIZE).o crtsavres.o
+			   crtsavres.o
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
-			   checksum_wrappers_64.o hweight_64.o \
+			   hweight_64.o \
 			   copyuser_power7.o string_64.o copypage_power7.o \
 			   memcpy_power7.o
+ifeq ($(CONFIG_GENERIC_CSUM),)
+obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
+endif
+
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
 
 ifeq ($(CONFIG_PPC64),y)
-- 
1.8.1.2
