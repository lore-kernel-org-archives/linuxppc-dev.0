Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2551B67A39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 20:29:57 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8LATrO3029491
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:29:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8LATq6M287800
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:29:52 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8LATqlg025637
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:29:52 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix building gdb against asm/ptrace.h
Date: Thu, 21 Sep 2006 12:29:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609211229.51777.arnd.bergmann@de.ibm.com>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Anton Blanchard <antonb@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ulrich Weigand found a bug with the current version of the
asm-powerpc/ptrace.h that prevents building at least the
SPU target version of gdb, since some ptrace opcodes are
not defined.

The problem seems to have originated in the merging of 32 and
64 bit versions of that file, the problem is that some opcodes
are only valid on 64 bit kernels, but are also used by 32 bit
programs, so they can't depends on the __powerpc64__ symbol.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--- a/include/asm-powerpc/ptrace.h
+++ b/include/asm-powerpc/ptrace.h
@@ -215,12 +215,10 @@ do {									      \
 #define PTRACE_GETVRREGS	18
 #define PTRACE_SETVRREGS	19
 
-#ifndef __powerpc64__
 /* Get/set all the upper 32-bits of the SPE registers, accumulator, and
  * spefscr, in one go */
 #define PTRACE_GETEVRREGS	20
 #define PTRACE_SETEVRREGS	21
-#endif /* __powerpc64__ */
 
 /*
  * Get or set a debug register. The first 16 are DABR registers and the
@@ -235,7 +233,6 @@ do {									      \
 #define PPC_PTRACE_GETFPREGS	0x97	/* Get FPRs 0 - 31 */
 #define PPC_PTRACE_SETFPREGS	0x96	/* Set FPRs 0 - 31 */
 
-#ifdef __powerpc64__
 /* Calls to trace a 64bit program from a 32bit program */
 #define PPC_PTRACE_PEEKTEXT_3264 0x95
 #define PPC_PTRACE_PEEKDATA_3264 0x94
@@ -243,6 +240,5 @@ do {									      \
 #define PPC_PTRACE_POKEDATA_3264 0x92
 #define PPC_PTRACE_PEEKUSR_3264  0x91
 #define PPC_PTRACE_POKEUSR_3264  0x90
-#endif /* __powerpc64__ */
 
 #endif /* _ASM_POWERPC_PTRACE_H */
