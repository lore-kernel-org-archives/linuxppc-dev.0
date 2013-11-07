Return-Path: <rusty@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70D1C2C0185
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:35 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rusty@au1.ibm.com>;
 Thu, 7 Nov 2013 11:21:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 48AF53578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA713uOW5177606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:03:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA71LQB6025229
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:21:26 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc: Add TIF_ELF2ABI flag.
Date: Thu,  7 Nov 2013 11:46:49 +1030
Message-Id: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Little endian ppc64 is getting an exciting new ABI.  This is reflected
by the bottom two bits of e_flags in the ELF header:

	0 == legacy binaries (v1 ABI)
	1 == binaries using the old ABI (compiled with a new toolchain)
	2 == binaries using the new ABI.

We store this in a thread flag, because we need to set it in core
dumps and for signal delivery.  Our chief concern is that it doesn't
use function descriptors.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/include/asm/elf.h         | 4 ++++
 arch/powerpc/include/asm/thread_info.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index ac6ec6e..54c7445 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -85,6 +85,8 @@ typedef elf_vrregset_t elf_fpxregset_t;
 # ifdef CONFIG_COMPAT
 #  define SET_PERSONALITY(ex)					\
 do {								\
+	if (((ex).e_flags & 0x3) == 2)				\
+		set_thread_flag(TIF_ELF2ABI);			\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 		set_thread_flag(TIF_32BIT);			\
 	else							\
@@ -96,6 +98,8 @@ do {								\
 # else /* !COMPAT: */
 #  define SET_PERSONALITY(ex)					\
 do {								\
+	if (((ex).e_flags & 0x3) == 2)				\
+		set_thread_flag(TIF_ELF2ABI);			\
 	if (personality(current->personality) != PER_LINUX32)	\
 		set_personality(PER_LINUX |			\
 			(current->personality & (~PER_MASK)));	\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index f66c2c1..460326f 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -109,6 +109,9 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
 						for stack store? */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
+#if defined(CONFIG_PPC64)
+#define TIF_ELF2ABI		18	/* function descriptors must die! */
+#endif
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -193,6 +196,12 @@ static inline bool test_thread_local_flags(unsigned int flags)
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
