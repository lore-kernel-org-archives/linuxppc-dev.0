Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 33/63] powerpc: Fix little endian coredumps
Date: Wed,  7 Aug 2013 02:01:50 +1000
Message-Id: <1375804940-22050-34-git-send-email-anton@samba.org>
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

We need to set ELF_DATA correctly on LE coredumps.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/uapi/asm/elf.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 89fa042..7e39c91 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -109,7 +109,6 @@ typedef elf_gregset_t32 compat_elf_gregset_t;
 # define ELF_GREG_TYPE	elf_greg_t64
 # define ELF_ARCH	EM_PPC64
 # define ELF_CLASS	ELFCLASS64
-# define ELF_DATA	ELFDATA2MSB
 typedef elf_greg_t64 elf_greg_t;
 typedef elf_gregset_t64 elf_gregset_t;
 #else
@@ -118,11 +117,16 @@ typedef elf_gregset_t64 elf_gregset_t;
 # define ELF_GREG_TYPE	elf_greg_t32
 # define ELF_ARCH	EM_PPC
 # define ELF_CLASS	ELFCLASS32
-# define ELF_DATA	ELFDATA2MSB
 typedef elf_greg_t32 elf_greg_t;
 typedef elf_gregset_t32 elf_gregset_t;
 #endif /* __powerpc64__ */
 
+#ifdef __BIG_ENDIAN__
+#define ELF_DATA	ELFDATA2MSB
+#else
+#define ELF_DATA	ELFDATA2LSB
+#endif
+
 /* Floating point registers */
 typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
-- 
1.8.1.2
