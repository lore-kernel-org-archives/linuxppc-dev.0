Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdST65KwzDqpg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:10:01 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdST1z3pz9s5J
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:10:01 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i123so15673557pfg.3
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 00:10:01 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4/6] powerpc/kernel: Clean up some sparse warnings
Date: Mon,  4 Jul 2016 17:09:40 +1000
Message-Id: <1467616182-30886-4-git-send-email-dja@axtens.net>
In-Reply-To: <1467616182-30886-1-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In hw_breakpoint.c, mark a user NIP as __user before passing it to
__get_user_inatomic.

In process.c, 7b051f665c32 ("powerpc: Use probe_kernel_address in
show_instructions") changed a call from __get_user to
probe_kernel_address. The address space annotations for that are
different: it no longer takes a user pointer, but a kernel pointer:
the new type is simply void *.

(This sounds super dodgy: why is a user pointer now a kernel pointer?
It's not so bad - it was always supposed to be kernel
pointer. __get_user was used on a kernel address to avoid an OOPS
should the address be invalid. probe_kernel_address handles this case,
so there's now no monkeying around with address spaces.)

io.c contains macros for reading and writing from io devices. Sparse
complains about things moving between address spaces. This is what the
functions are designed to do, so tell sparse we know what we're doing
with __force.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/hw_breakpoint.c |  2 +-
 arch/powerpc/kernel/io.c            | 16 ++++++++--------
 arch/powerpc/kernel/process.c       |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index aec9a1b1d25b..e903a6b96b7f 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -264,7 +264,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 
 	stepped = 0;
 	instr = 0;
-	if (!__get_user_inatomic(instr, (unsigned int *) regs->nip))
+	if (!__get_user_inatomic(instr, (unsigned int __user *) regs->nip))
 		stepped = emulate_step(regs, instr);
 
 	/*
diff --git a/arch/powerpc/kernel/io.c b/arch/powerpc/kernel/io.c
index 2a2b4aeab80f..3f70b7dccee8 100644
--- a/arch/powerpc/kernel/io.c
+++ b/arch/powerpc/kernel/io.c
@@ -37,7 +37,7 @@ void _insb(const volatile u8 __iomem *port, void *buf, long count)
 		return;
 	asm volatile("sync");
 	do {
-		tmp = *port;
+		tmp = *(u8 __force *)port;
 		eieio();
 		*tbuf++ = tmp;
 	} while (--count != 0);
@@ -47,13 +47,13 @@ EXPORT_SYMBOL(_insb);
 
 void _outsb(volatile u8 __iomem *port, const void *buf, long count)
 {
-	const u8 *tbuf = buf;
+	const u8 __force *tbuf = buf;
 
 	if (unlikely(count <= 0))
 		return;
 	asm volatile("sync");
 	do {
-		*port = *tbuf++;
+		*(volatile u8 __force *)port = *tbuf++;
 	} while (--count != 0);
 	asm volatile("sync");
 }
@@ -68,7 +68,7 @@ void _insw_ns(const volatile u16 __iomem *port, void *buf, long count)
 		return;
 	asm volatile("sync");
 	do {
-		tmp = *port;
+		tmp = *(u16 __force *)port;
 		eieio();
 		*tbuf++ = tmp;
 	} while (--count != 0);
@@ -78,13 +78,13 @@ EXPORT_SYMBOL(_insw_ns);
 
 void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count)
 {
-	const u16 *tbuf = buf;
+	const u16 __force *tbuf = buf;
 
 	if (unlikely(count <= 0))
 		return;
 	asm volatile("sync");
 	do {
-		*port = *tbuf++;
+		*(volatile u16 __force *)port = *tbuf++;
 	} while (--count != 0);
 	asm volatile("sync");
 }
@@ -99,7 +99,7 @@ void _insl_ns(const volatile u32 __iomem *port, void *buf, long count)
 		return;
 	asm volatile("sync");
 	do {
-		tmp = *port;
+		tmp = *(u32 __force *)port;
 		eieio();
 		*tbuf++ = tmp;
 	} while (--count != 0);
@@ -115,7 +115,7 @@ void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count)
 		return;
 	asm volatile("sync");
 	do {
-		*port = *tbuf++;
+		*(volatile u32 __force *)port = *tbuf++;
 	} while (--count != 0);
 	asm volatile("sync");
 }
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a8cca88e972f..9c775e97558b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1194,7 +1194,7 @@ static void show_instructions(struct pt_regs *regs)
 #endif
 
 		if (!__kernel_text_address(pc) ||
-		     probe_kernel_address((unsigned int __user *)pc, instr)) {
+		     probe_kernel_address((void *)pc, instr)) {
 			printk(KERN_CONT "XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-- 
2.1.4
