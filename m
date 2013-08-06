Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 05/63] powerpc: Simplify logic in include/uapi/asm/elf.h
Date: Wed,  7 Aug 2013 02:01:22 +1000
Message-Id: <1375804940-22050-6-git-send-email-anton@samba.org>
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

Simplify things by putting all the 32bit and 64bit defines
together instead of in two spots.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/uapi/asm/elf.h | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 05b8d56..89fa042 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -107,6 +107,11 @@ typedef elf_gregset_t32 compat_elf_gregset_t;
 # define ELF_NVRREG	34	/* includes vscr & vrsave in split vectors */
 # define ELF_NVSRHALFREG 32	/* Half the vsx registers */
 # define ELF_GREG_TYPE	elf_greg_t64
+# define ELF_ARCH	EM_PPC64
+# define ELF_CLASS	ELFCLASS64
+# define ELF_DATA	ELFDATA2MSB
+typedef elf_greg_t64 elf_greg_t;
+typedef elf_gregset_t64 elf_gregset_t;
 #else
 # define ELF_NEVRREG	34	/* includes acc (as 2) */
 # define ELF_NVRREG	33	/* includes vscr */
@@ -114,20 +119,10 @@ typedef elf_gregset_t32 compat_elf_gregset_t;
 # define ELF_ARCH	EM_PPC
 # define ELF_CLASS	ELFCLASS32
 # define ELF_DATA	ELFDATA2MSB
+typedef elf_greg_t32 elf_greg_t;
+typedef elf_gregset_t32 elf_gregset_t;
 #endif /* __powerpc64__ */
 
-#ifndef ELF_ARCH
-# define ELF_ARCH	EM_PPC64
-# define ELF_CLASS	ELFCLASS64
-# define ELF_DATA	ELFDATA2MSB
-  typedef elf_greg_t64 elf_greg_t;
-  typedef elf_gregset_t64 elf_gregset_t;
-#else
-  /* Assumption: ELF_ARCH == EM_PPC and ELF_CLASS == ELFCLASS32 */
-  typedef elf_greg_t32 elf_greg_t;
-  typedef elf_gregset_t32 elf_gregset_t;
-#endif /* ELF_ARCH */
-
 /* Floating point registers */
 typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
-- 
1.8.1.2
