Return-Path: <BATV+8bba78745af9c1a25adb+4602+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb26S2LqZzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 09:16:15 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Carl Love <cel@us.ibm.com>, Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/2] perf jit: genelf makes assumptions about endian
Date: Wed, 30 Mar 2016 19:13:55 -0300
Message-Id: <1459376035-22929-3-git-send-email-acme@kernel.org>
In-Reply-To: <1459376035-22929-1-git-send-email-acme@kernel.org>
References: <1459376035-22929-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Commit 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
incorrectly assumed that PowerPC is big endian only.

Simplify things by consolidating the define of GEN_ELF_ENDIAN and checking
for __BYTE_ORDER == __BIG_ENDIAN.

The PowerPC checks were also incorrect, they do not match what gcc
emits. We should first look for __powerpc64__, then __powerpc__.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Carl Love <cel@us.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Link: http://lkml.kernel.org/r/20160329175944.33a211cc@kryten
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/genelf.h | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index cd67e64a0494..2fbeb59c4bdd 100644
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
-- 
2.5.5
