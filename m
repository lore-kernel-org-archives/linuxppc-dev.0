Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8EB7DDEC7
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 16:49:44 +1000 (EST)
Date: Wed, 25 Jul 2007 01:49:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Attempt at addressing head*.S for modpost warnings
Message-ID: <Pine.LNX.4.64.0707250147150.9086@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen,

Paul said you were looking into this issue as well.  Wanted to post what I
did on ppc32/e500 as a start for you to look at.  I think the other ppc32
head*.S can follow the same pattern if we like this.  However, wasn't sure
how to do _ENTRY() for ppc64.

- k

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 1f155d3..d83cbbb 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -52,9 +52,9 @@
  *   r7 - End of kernel command line string
  *
  */
-	.text
-_GLOBAL(_stext)
-_GLOBAL(_start)
+	.section	.text.head, "ax"
+_ENTRY(_stext);
+_ENTRY(_start);
 	/*
 	 * Reserve a word at a fixed location to store the address
 	 * of abatron_pteptrs
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 0c45855..823a8cb 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -34,6 +34,8 @@ SECTIONS

 	/* Text and gots */
 	.text : {
+		ALIGN_FUNCTION();
+		*(.text.head)
 		_text = .;
 		TEXT_TEXT
 		SCHED_TEXT
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index fa083d8..7ec22d2 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -183,6 +183,11 @@ GLUE(.,name):

 #else /* 32-bit */

+#define _ENTRY(n)	\
+	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
+	.globl n;	\
+n:
+
 #define _GLOBAL(n)	\
 	.text;		\
 	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
