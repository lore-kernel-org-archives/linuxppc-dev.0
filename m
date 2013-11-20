Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 3/9] powerpc: Add TIF_ELF2ABI flag.
Date: Wed, 20 Nov 2013 22:15:00 +1100
Message-Id: <1384946106-18200-4-git-send-email-anton@samba.org>
In-Reply-To: <1384946106-18200-1-git-send-email-anton@samba.org>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

Little endian ppc64 is getting an exciting new ABI.  This is reflected
by the bottom two bits of e_flags in the ELF header:

	0 == legacy binaries (v1 ABI)
	1 == binaries using the old ABI (compiled with a new toolchain)
	2 == binaries using the new ABI.

We store this in a thread flag, because we need to set it in core
dumps and for signal delivery.  Our chief concern is that it doesn't
use function descriptors.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/elf.h         | 2 ++
 arch/powerpc/include/asm/thread_info.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index cc0655a..6d0e236 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -86,6 +86,8 @@ typedef elf_vrregset_t elf_fpxregset_t;
 #ifdef __powerpc64__
 # define SET_PERSONALITY(ex)					\
 do {								\
+	if (((ex).e_flags & 0x3) == 2)				\
+		set_thread_flag(TIF_ELF2ABI);			\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 		set_thread_flag(TIF_32BIT);			\
 	else							\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ba7b197..05a3030 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -107,6 +107,9 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
 						for stack store? */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
+#if defined(CONFIG_PPC64)
+#define TIF_ELF2ABI		18	/* function descriptors must die! */
+#endif
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -185,6 +188,12 @@ static inline bool test_thread_local_flags(unsigned int flags)
 #define is_32bit_task()	(1)
 #endif
 
+#if defined(CONFIG_PPC64)
+#define is_elf2_task() (test_thread_flag(TIF_ELF2ABI))
+#else
+#define is_elf2_task() (0)
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
-- 
1.8.3.2
