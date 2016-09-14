Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYn073GDZzDsF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 13:21:59 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so92605pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 20:21:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
Subject: [PATCH] powerpc/64: syscall ABI
Date: Wed, 14 Sep 2016 13:21:47 +1000
Message-Id: <20160914032147.11728-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some documentation for the 64-bit syscall ABI, which doesn't seem
to be documented elsewhere.

This attempts to documented existing practice. The only small
discrepancy is glibc clobbers not quite matching the kernel (e.g.,
xer, some vsyscalls trash cr1 whereas glibc only clobbers cr0). These
will be resolved after this document is merged.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/powerpc/syscall64-abi.txt | 103 ++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/powerpc/syscall64-abi.txt

diff --git a/Documentation/powerpc/syscall64-abi.txt b/Documentation/powerpc/syscall64-abi.txt
new file mode 100644
index 0000000..30d1843
--- /dev/null
+++ b/Documentation/powerpc/syscall64-abi.txt
@@ -0,0 +1,103 @@
+Power Architecture 64-bit Linux system call ABI
+
+===============================================
+syscall
+===============================================
+syscall calling sequence[*] matches the Power Architecture 64-bit ELF ABI
+specification C function calling sequence, including register preservation
+rules, with the following differences.
+
+[*] Some syscalls (typically low-level management functions) may have
+    different calling sequences (e.g., rt_sigreturn).
+
+Parameters and return value
+---------------------------
+The system call number is specified in r0.
+
+There is a maximum of 6 integer parameters to a syscall, passed in r3-r8.
+
+Both a return value and a return error code are returned. cr0.SO is the return
+error code, and r3 is the return value or error code. When cr0.SO is clear,
+the syscall succeeded and r3 is the return value. When cr0.SO is set, the
+syscall failed and r3 is the error code that generally corresponds to errno.
+
+Stack
+-----
+System calls do not modify the caller's stack frame. For example, the caller's
+stack frame LR and CR save fields are not used.
+
+Register preservation rules
+---------------------------
+Register preservation rules match the ELF ABI calling sequence with the
+following differences:
+
+r0:         Volatile.   (System call number.)
+r3:         Volatile.   (Parameter 1, and return value.)
+r4-r8:      Volatile.   (Parameters 2-6.)
+cr0:        Volatile    (cr0.SO is the return error condition)
+cr1, cr5-7: Nonvolatile.
+lr:         Nonvolatile.
+
+All floating point and vector data registers as well as control and status
+registers are nonvolatile.
+
+Invocation
+----------
+The syscall is performed with the sc instruction, and returns with execution
+continuing at the instruction following the sc instruction.
+
+Transactional Memory
+--------------------
+Syscall behavior can change if the processor is in transactional or suspended
+transaction state, and the syscall can affect the behavior of the transaction.
+
+If the processor is in suspended state when a syscall is made, the syscall
+will be performed as normal, and will return as normal. The syscall will be
+performed in suspended state, so its side effects will be persistent according
+to the usual transactional memory semantics. A syscall may or may not result
+in the transaction being doomed by hardware.
+
+If the processor is in transactional state when a syscall is made, then the
+behavior depends on the presence of PPC_FEATURE2_HTM_NOSC in the AT_HWCAP2 ELF
+auxiliary vector.
+
+- If present, which is the case for newer kernels, then the syscall will not
+  be performed and the transaction will be doomed by the kernel with the
+  failure code TM_CAUSE_SYSCALL | TM_CAUSE_PERSISTENT in the TEXASR SPR.
+
+- If not present (older kernels), then the kernel will suspend the
+  transactional state and the syscall will proceed as in the case of a
+  suspended state syscall, and will resume the transactional state before
+  returning to the caller. This case is not well defined or supported, so this
+  behavior should not be relied upon.
+
+===============================================
+vsyscall
+===============================================
+vsyscall calling sequence matches the syscall calling sequence, with the
+following differences. Some vsyscalls may have different calling sequences.
+
+Parameters and return value
+---------------------------
+r0 is not used as an input. The vsyscall is selected by its address.
+
+Stack
+-----
+The vsyscall may or may not use the caller's stack frame save areas.
+
+Register preservation rules
+---------------------------
+r0: Volatile.
+cr1, cr5-7: Volatile.
+lr: Volatile.
+
+Invocation
+----------
+The vsyscall is performed with a branch-with-link instruction to the vsyscall
+function address.
+
+Transactional Memory
+--------------------
+vsyscalls will run in the same transactional state as the caller. A vsyscall
+may or may not result in the transaction being doomed by hardware.
+
-- 
2.9.3
