Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115854.GB12006@kryten>
Message-Id: <20090222115331.774772471@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:49:58 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 01/10] powerpc: Move is_32bit_task
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move is_32bit_task into asm/thread_info.h, that allows us to test for
32/64bit tasks without an ugly CONFIG_PPC64 ifdef.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/thread_info.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/thread_info.h	2009-02-20 13:44:37.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/thread_info.h	2009-02-20 16:03:02.000000000 +1100
@@ -154,6 +154,13 @@
 	ti->local_flags |= _TLF_RESTORE_SIGMASK;
 	set_bit(TIF_SIGPENDING, &ti->flags);
 }
+
+#ifdef CONFIG_PPC64
+#define is_32bit_task()	(test_thread_flag(TIF_32BIT))
+#else
+#define is_32bit_task()	(1)
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6/arch/powerpc/kernel/signal.h
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal.h	2009-02-20 13:44:34.000000000 +1100
+++ linux-2.6/arch/powerpc/kernel/signal.h	2009-02-20 13:45:33.000000000 +1100
@@ -39,22 +39,12 @@
 
 #ifdef CONFIG_PPC64
 
-static inline int is_32bit_task(void)
-{
-	return test_thread_flag(TIF_32BIT);
-}
-
 extern int handle_rt_signal64(int signr, struct k_sigaction *ka,
 			      siginfo_t *info, sigset_t *set,
 			      struct pt_regs *regs);
 
 #else /* CONFIG_PPC64 */
 
-static inline int is_32bit_task(void)
-{
-	return 1;
-}
-
 static inline int handle_rt_signal64(int signr, struct k_sigaction *ka,
 				     siginfo_t *info, sigset_t *set,
 				     struct pt_regs *regs)

-- 
