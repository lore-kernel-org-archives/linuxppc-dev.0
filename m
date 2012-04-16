Return-Path: <anton@samba.org>
Date: Mon, 16 Apr 2012 16:56:45 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/2] powerpc: Optimise enable_kernel_altivec
Message-ID: <20120416165645.1e8ef2fb@kryten>
In-Reply-To: <20120416165459.6da18f9c@kryten>
References: <20120416165459.6da18f9c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add two optimisations to enable_kernel_altivec:

- enable_kernel_altivec has already determined if we need to
save the previous task's state but we call giveup_altivec
in both cases, requiring an extra branch in giveup_altivec. Create
giveup_altivec_notask which only turns on the VMX bit in the
MSR.

- We write the VMX MSR bit each time we call enable_kernel_altivec
even it was already set. Check the bit and branch out if we have
already set it. The classic case for this is vectored IO
where we have to copy multiple buffers to or from userspace.

The following testcase was used to confirm this patch improves
performance:

http://ozlabs.org/~anton/junkcode/copy_to_user.c

Since the current breakpoint for using VMX in copy_tofrom_user is
4096 bytes, I'm using buffers of 4096 + 1 cacheline (4224) bytes.
A benchmark of 16 entry readvs (-s 16):

time copy_to_user -l 4224 -s 16 -i 1000000

completes 5.2% faster on a POWER7 PS700.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/process.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/process.c	2012-04-16 11:35:19.000000000 +1000
+++ linux-build/arch/powerpc/kernel/process.c	2012-04-16 12:56:47.489355793 +1000
@@ -124,7 +124,7 @@ void enable_kernel_altivec(void)
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
 		giveup_altivec(current);
 	else
-		giveup_altivec(NULL);	/* just enable AltiVec for kernel - force */
+		giveup_altivec_notask();
 #else
 	giveup_altivec(last_task_used_altivec);
 #endif /* CONFIG_SMP */
Index: linux-build/arch/powerpc/kernel/vector.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vector.S	2012-04-12 20:06:21.000000000 +1000
+++ linux-build/arch/powerpc/kernel/vector.S	2012-04-16 12:56:47.489355793 +1000
@@ -89,6 +89,16 @@ _GLOBAL(load_up_altivec)
 	/* restore registers and return */
 	blr
 
+_GLOBAL(giveup_altivec_notask)
+	mfmsr	r3
+	andis.	r4,r3,MSR_VEC@h
+	bnelr				/* Already enabled? */
+	oris	r3,r3,MSR_VEC@h
+	SYNC
+	MTMSRD(r3)			/* enable use of VMX now */
+	isync
+	blr
+
 /*
  * giveup_altivec(tsk)
  * Disable VMX for the task given as the argument,
Index: linux-build/arch/powerpc/include/asm/switch_to.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/switch_to.h	2012-04-16 12:56:45.149313158 +1000
+++ linux-build/arch/powerpc/include/asm/switch_to.h	2012-04-16 12:56:47.489355793 +1000
@@ -40,6 +40,7 @@ static inline void discard_lazy_cpu_stat
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
+extern void giveup_altivec_notask(void);
 #else
 static inline void flush_altivec_to_thread(struct task_struct *t)
 {
