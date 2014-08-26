Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEDBD1A003C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 12:44:15 +1000 (EST)
Date: Tue, 26 Aug 2014 12:44:15 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 sukadev@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Fix ABIv2 kernel backtraces
Message-ID: <20140826124415.153c861c@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ABIv2 kernels are failing to backtrace through the kernel. An example:

39.30%  readseek2_proce  [kernel.kallsyms]    [k] find_get_entry                     
            |
            --- find_get_entry
               __GI___libc_read

The problem is in valid_next_sp() where we check that the new stack
pointer is at least STACK_FRAME_OVERHEAD below the previous one.

ABIv1 has a minimum stack frame size of 112 bytes consisting of 48 bytes
and 64 bytes of parameter save area. ABIv2 changes that to 32 bytes
with no paramter save area.

STACK_FRAME_OVERHEAD is in theory the minimum stack frame size,
but we over 240 uses of it, some of which assume that it includes
space for the parameter area.

We need to work through all our stack defines and rationalise them
but let's fix perf now by creating STACK_FRAME_MIN_SIZE and using
in valid_next_sp(). This fixes the issue:

30.64%  readseek2_proce  [kernel.kallsyms]    [k] find_get_entry                      
            |
            --- find_get_entry
               pagecache_get_page
               generic_file_read_iter
               new_sync_read
               vfs_read
               sys_read
               syscall_exit
               __GI___libc_read

Cc: stable@vger.kernel.org # 3.16+
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/ptrace.h
===================================================================
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -47,6 +47,12 @@
 				 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)
 #define STACK_FRAME_MARKER	12
 
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define STACK_FRAME_MIN_SIZE	32
+#else
+#define STACK_FRAME_MIN_SIZE	STACK_FRAME_OVERHEAD
+#endif
+
 /* Size of dummy stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	128
 #define __SIGNAL_FRAMESIZE32	64
@@ -60,6 +66,7 @@
 #define STACK_FRAME_REGS_MARKER	ASM_CONST(0x72656773)
 #define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD)
 #define STACK_FRAME_MARKER	2
+#define STACK_FRAME_MIN_SIZE	STACK_FRAME_OVERHEAD
 
 /* Size of stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	64
Index: b/arch/powerpc/perf/callchain.c
===================================================================
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -35,7 +35,7 @@ static int valid_next_sp(unsigned long s
 		return 0;		/* must be 16-byte aligned */
 	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
 		return 0;
-	if (sp >= prev_sp + STACK_FRAME_OVERHEAD)
+	if (sp >= prev_sp + STACK_FRAME_MIN_SIZE)
 		return 1;
 	/*
 	 * sp could decrease when we jump off an interrupt stack
