Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1AA7DDDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:24:16 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9H4NtJf030021
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:23:55 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9H4NwA11290282
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:23:58 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9H4NvtA020889
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:23:58 +1000
Subject: [PATCH] powerpc: Fix 64 bits vDSO dwarf info for CR register
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 14:23:57 +1000
Message-Id: <1192595037.11899.146.camel@pasglop>
Mime-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Haley <aph-gcc@littlepinkcloud.COM>,
	Alan Modra <amodra@bigpond.net.au>, Deepak Bhole <dbhole@redhat.com>
Reply-To: benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current DWARF info for CR are incorrect causing the gcc unwinder to
go to lunch if taking a segfault in the vdso. This patch fixes it.

Problem identified by Andrew Haley, and fix provided by Jakub Jelinek
(thanks !).

Unfortunately, a bug in gcc cause it to not quite work either, but that
is being fixed separately with something around the lines of:


Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/arch/powerpc/kernel/vdso64/sigtramp.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso64/sigtramp.S	2007-10-17 13:32:49.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso64/sigtramp.S	2007-10-17 13:34:18.000000000 +1000
@@ -134,13 +134,16 @@ V_FUNCTION_END(__kernel_sigtramp_rt64)
 9:
 
 /* This is where the pt_regs pointer can be found on the stack.  */
-#define PTREGS 128+168+56
+#define PTREGS	128+168+56
 
 /* Size of regs.  */
-#define RSIZE 8
+#define RSIZE	8
+
+/* Size of CR reg in DWARF unwind info. */
+#define CRSIZE	4
 
 /* This is the offset of the VMX reg pointer.  */
-#define VREGS 48*RSIZE+33*8
+#define VREGS	48*RSIZE+33*8
 
 /* Describe where general purpose regs are saved.  */
 #define EH_FRAME_GEN \
@@ -178,7 +181,7 @@ V_FUNCTION_END(__kernel_sigtramp_rt64)
   rsave (31, 31*RSIZE);							\
   rsave (67, 32*RSIZE);		/* ap, used as temp for nip */		\
   rsave (65, 36*RSIZE);		/* lr */				\
-  rsave (70, 38*RSIZE)		/* cr */
+  rsave (70, 38*RSIZE + (RSIZE - CRSIZE)) /* cr */
 
 /* Describe where the FP regs are saved.  */
 #define EH_FRAME_FP \
