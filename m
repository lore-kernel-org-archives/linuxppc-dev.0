Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9cYw4DLBzDrF6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:54:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Disable the fast-endian switch syscall by default
Date: Mon,  9 Oct 2017 21:54:05 +1100
Message-Id: <1507546445-28089-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1507546445-28089-1-git-send-email-mpe@ellerman.id.au>
References: <1507546445-28089-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in 2008 we added support for "fast little-endian switch" in the
syscall path. This added a special case syscall number 0x1ebe, which
is caught very early in the system call exception and switches endian
with as little overhead as possible. See commit 745a14cc264b
("[POWERPC] Add fast little-endian switch system call") for full
details.

Although it is fast, it's also completely non standard. The "syscall
number" is out of the range of normal syscalls, it can't be traced or
audited, and it's a bit of a wart. To the best of our knowledge it was
only used by one program, now long since discontinued.

So in an effort to shake out any current users, put it behind a config
option, and make it default n. If anyone *is* using it they can
quickly reinstate it with a rebuild, and we can flip it to default y.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug           | 6 ++++++
 arch/powerpc/kernel/exceptions-64s.S | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c86df246339e..b8a1eb42a38d 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -369,4 +369,10 @@ config PPC_HTDUMP
 	def_bool y
 	depends on PPC_PTDUMP && PPC_BOOK3S
 
+config PPC_FAST_ENDIAN_SWITCH
+	bool "Deprecated fast endian-switch syscall"
+        depends on DEBUG_KERNEL && PPC_BOOK3S_64
+        help
+	  If you're unsure what this is, say N.
+
 endmenu
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5bdad80dd9c2..6a945a120827 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -879,6 +879,7 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 	rfid ; 							\
 	b	. ;	/* prevent speculative execution */
 
+#ifdef CONFIG_PPC_FAST_ENDIAN_SWITCH
 #define SYSCALL_FASTENDIAN_TEST					\
 BEGIN_FTR_SECTION						\
 	cmpdi	r0,0x1ebe ; 					\
@@ -893,6 +894,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mr	r13,r9 ;					\
 	rfid ;		/* return to userspace */		\
 	b	. ;	/* prevent speculative execution */
+#else
+#define SYSCALL_FASTENDIAN_TEST
+#define SYSCALL_FASTENDIAN
+#endif /* CONFIG_PPC_FAST_ENDIAN_SWITCH */
 
 #if defined(CONFIG_RELOCATABLE)
 	/*
-- 
2.7.4
