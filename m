Return-Path: <SRS0+b1a8919817a61a648e9e+1226+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FDF7DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 05:45:42 +1100 (EST)
Subject: Re: [PATCH] Fix manual assembly WARN_ON() in enter_rtas().
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
In-Reply-To: <1167578149.22068.325.camel@pmac.infradead.org>
References: <1167578149.22068.325.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 18:45:34 +0000
Message-Id: <1167677134.22068.339.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-12-31 at 15:15 +0000, David Woodhouse wrote:
> When we switched over to the generic BUG mechanism we forgot to change
> the assembly code which open-codes a WARN_ON() in enter_rtas(), so the
> bug table got corrupted.
> 
> This patch provides an EMIT_BUG_ENTRY macro for use in assembly code,
> and uses it in entry_64.S. Tested with CONFIG_DEBUG_BUGVERBOSE on ppc64
> but not without -- I tried to turn it off but it wouldn't go away; I
> suspect Aunt Tillie probably needed it.

This version gets __FILE__ and __LINE__ right in the assembly version --
rather than saying include/asm-powerpc/bug.h line 21 every time which is
a little suboptimal.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e965215..030d300 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -303,5 +303,8 @@ int main(void)
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
 	DEFINE(CLOCK_REALTIME_RES, TICK_NSEC);
 
+#ifdef CONFIG_BUG
+	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
+#endif
 	return 0;
 }
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 1a3d4de..2551c08 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -28,6 +28,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 #include <asm/firmware.h>
+#include <asm/bug.h>
 
 /*
  * System calls.
@@ -634,19 +635,15 @@ _GLOBAL(enter_rtas)
 	li	r0,0
 	mtcr	r0
 
+#ifdef CONFIG_BUG	
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
 1:	tdnei	r0,0
-.section __bug_table,"a"
-	.llong	1b,__LINE__ + 0x1000000, 1f, 2f
-.previous
-.section .rodata,"a"
-1:	.asciz	__FILE__
-2:	.asciz "enter_rtas"
-.previous
-
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
+#endif
+	
 	/* Hard-disable interrupts */
 	mfmsr	r6
 	rldicl	r7,r6,48,1
diff --git a/include/asm-powerpc/bug.h b/include/asm-powerpc/bug.h
index 7095688..f6fa394 100644
--- a/include/asm-powerpc/bug.h
+++ b/include/asm-powerpc/bug.h
@@ -11,10 +11,31 @@
 #define BUG_OPCODE .long 0x00b00b00  /* For asm */
 #define BUG_ILLEGAL_INSTR "0x00b00b00" /* For BUG macro */
 
-#ifndef __ASSEMBLY__
-
 #ifdef CONFIG_BUG
 
+#ifdef __ASSEMBLY__
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+.macro EMIT_BUG_ENTRY addr,file,line,flags
+	 .section __bug_table,"a"
+5001:	 PPC_LONG \addr, 5002f
+	 .short \line, \flags
+	 .org 5001b+BUG_ENTRY_SIZE
+	 .previous
+	 .section .rodata,"a"
+5002:	 .asciz "\file"
+	 .previous
+.endm
+#else
+ .macro EMIT_BUG_ENTRY addr,file,line,flags
+	 .section __bug_table,"a"
+5001:	 PPC_LONG \addr
+	 .short \flags
+	 .org 5001b+BUG_ENTRY_SIZE
+	 .previous
+.endm
+#endif /* verbose */
+
+#else /* !__ASSEMBLY__ */
 /* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
    sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
@@ -91,8 +112,8 @@
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_BUG_ON
 #define HAVE_ARCH_WARN_ON
-#endif /* CONFIG_BUG */
 #endif /* __ASSEMBLY __ */
+#endif /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
 

-- 
dwmw2
