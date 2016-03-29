Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ1qy1nxJzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 18:00:14 +1100 (AEDT)
Date: Tue, 29 Mar 2016 17:59:44 +1100
From: Anton Blanchard <anton@samba.org>
To: eranian@google.com, sukadev@linux.vnet.ibm.com, acme@redhat.com,
 mpe@ellerman.id.au, cel@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf jit: genelf makes assumptions about endian
Message-ID: <20160329175944.33a211cc@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
incorrectly assumed that PowerPC is big endian only.

Simplify things by consolidating the define of GEN_ELF_ENDIAN and checking
for __BYTE_ORDER == __BIG_ENDIAN.

The PowerPC checks were also incorrect, they do not match what gcc
emits. We should first look for __powerpc64__, then __powerpc__.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index cd67e64..2fbeb59 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -9,36 +9,32 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 
 #if   defined(__arm__)
 #define GEN_ELF_ARCH	EM_ARM
-#define GEN_ELF_ENDIAN	ELFDATA2LSB
 #define GEN_ELF_CLASS	ELFCLASS32
 #elif defined(__aarch64__)
 #define GEN_ELF_ARCH	EM_AARCH64
-#define GEN_ELF_ENDIAN	ELFDATA2LSB
 #define GEN_ELF_CLASS	ELFCLASS64
 #elif defined(__x86_64__)
 #define GEN_ELF_ARCH	EM_X86_64
-#define GEN_ELF_ENDIAN	ELFDATA2LSB
 #define GEN_ELF_CLASS	ELFCLASS64
 #elif defined(__i386__)
 #define GEN_ELF_ARCH	EM_386
-#define GEN_ELF_ENDIAN	ELFDATA2LSB
 #define GEN_ELF_CLASS	ELFCLASS32
-#elif defined(__ppcle__)
-#define GEN_ELF_ARCH	EM_PPC
-#define GEN_ELF_ENDIAN	ELFDATA2LSB
-#define GEN_ELF_CLASS	ELFCLASS64
-#elif defined(__powerpc__)
-#define GEN_ELF_ARCH	EM_PPC64
-#define GEN_ELF_ENDIAN	ELFDATA2MSB
-#define GEN_ELF_CLASS	ELFCLASS64
-#elif defined(__powerpcle__)
+#elif defined(__powerpc64__)
 #define GEN_ELF_ARCH	EM_PPC64
-#define GEN_ELF_ENDIAN	ELFDATA2LSB
 #define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__powerpc__)
+#define GEN_ELF_ARCH	EM_PPC
+#define GEN_ELF_CLASS	ELFCLASS32
 #else
 #error "unsupported architecture"
 #endif
 
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define GEN_ELF_ENDIAN	ELFDATA2MSB
+#else
+#define GEN_ELF_ENDIAN	ELFDATA2LSB
+#endif
+
 #if GEN_ELF_CLASS == ELFCLASS64
 #define elf_newehdr	elf64_newehdr
 #define elf_getshdr	elf64_getshdr
