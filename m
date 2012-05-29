Return-Path: <anton@samba.org>
Date: Tue, 29 May 2012 21:20:10 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH] powerpc: Clear RI and EE at the same time in system call exit
Message-ID: <20120529212010.0152a083@kryten>
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


In system call exit we currently clear RI and EE separately. An
mtmsrd is a slow operation and we can save cycles by doing it all
in one go.

This does complicate things a bit - we have to be careful to restore
RI if we branch out before returning to userspace.

On a POWER7 with virtual cputime disabled this patch improves the
null system call by 7%.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/entry_64.S	2012-05-28 18:23:33.374451416 +1000
+++ linux-build/arch/powerpc/kernel/entry_64.S	2012-05-29 21:18:22.280934940 +1000
@@ -197,7 +197,16 @@ syscall_exit:
 	wrteei	0
 #else
 	ld	r10,PACAKMSR(r13)
-	mtmsrd	r10,1
+	/*
+	 * For performance reasons we clear RI the same time that we
+	 * clear EE. We only need to clear RI just before we restore r13
+	 * below, but batching it with EE saves us one expensive mtmsrd call.
+	 * We have to be careful to restore RI if we branch anywhere from
+	 * here (eg syscall_exit_work).
+	 */
+	li	r9,MSR_RI
+	andc	r11,r10,r9
+	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
 	ld	r9,TI_FLAGS(r12)
@@ -214,17 +223,6 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
-	/*
-	 * Clear RI before restoring r13.  If we are returning to
-	 * userspace and we take an exception after restoring r13,
-	 * we end up corrupting the userspace r13 value.
-	 */
-#ifdef CONFIG_PPC_BOOK3S
-	/* No MSR:RI on BookE */
-	li	r12,MSR_RI
-	andc	r11,r10,r12
-	mtmsrd	r11,1			/* clear MSR.RI */
-#endif /* CONFIG_PPC_BOOK3S */
 
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
@@ -271,6 +269,7 @@ syscall_enosys:
 	b	syscall_exit
 	
 syscall_exit_work:
+	mtmsrd	r10,1		/* Restore RI */
 	/* If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
 	 If TIF_NOERROR is set, just save r3 as it is. */
 
