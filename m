Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPwt755mRzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 13:49:03 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (unknown [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qPwt745YTz9sRZ
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 13:49:03 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 16 Mar 2016 12:38:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A70882BB00BB
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 13:30:56 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2G2Um9P131494
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 13:30:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2G2UO3E022700
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 13:30:24 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix possible unrecoverable exception caused by
 '70fe3d9'
Date: Wed, 16 Mar 2016 13:29:30 +1100
Message-Id: <1458095370-26731-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 70fe3d9 "powerpc: Restore FPU/VEC/VSX if previously used" introduces a
call to restore_math() late in the syscall return path, after MSR_RI has been
cleared. The MSR_RI flag is used to indicate whether the kernel can take
another exception or not. A cleared MSR_RI flag indicates that the kernel
cannot.

Unfortunately when a machine is under high load an SLB miss can occur in
restore_math() which (with MSR_RI cleared) leads to an unrecoverable exception.

Unrecoverable exception trace:
 powerpc: Restore FPU/VEC/VSX if previously used
  Unrecoverable exception 4100 at c0000000000088d8
  cpu 0x0: Vector: 4100  at [c0000003fa473b20]
      pc: c0000000000088d8: .load_vr_state+0x70/0x110
      lr: c00000000000f710: .restore_math+0x130/0x188
      sp: c0000003fa473da0
     msr: 9000000002003030
    current = 0xc0000007f876f180
    paca    = 0xc00000000fff0000	 softe: 0	 irq_happened: 0x01
      pid   = 1944, comm = K08umountfs
  Linux version 4.5.0-rc3-g22ccd98 (kerkins@alpine1-p1) (gcc version 5.2.1
  20151001 (GCC) ) #1 SMP Tue Mar 15 21:33:26 AEDT 2016
  WARNING: exception is not recoverable, can't continue
  enter ? for help
  [link register   ] c00000000000f710 .restore_math+0x130/0x188
  [c0000003fa473da0] c0000003fa473e30 (unreliable)
  [c0000003fa473e30] c000000000007b6c system_call+0x84/0xfc
  --- Exception: c00 (System Call) at 000000000fe84328
  0:mon>

The clearing of MSR_RI is actually an optimisation to avoid multiple MSR
writes, what must be disabled are interrupts. See comment in entry_64.S:
  /*
   * For performance reasons we clear RI the same time that we
   * clear EE. We only need to clear RI just before we restore r13
   * below, but batching it with EE saves us one expensive mtmsrd call.
   * We have to be careful to restore RI if we branch anywhere from
   * here (eg syscall_exit_work).
   */
At the point of calling restore_math() r13 has not been restored, as such, the
quick fix of turning MSR_RI back on for the call to restore_math() will
eliminate the occurrence of an unrecoverable exception.

We'd like to do a better fix in future.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 038e0a1..f3aa4b4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -218,7 +218,16 @@ system_call:			/* label this so stack traces look sane */
 	bne	3f
 #endif
 2:	addi    r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_PPC_BOOK3S
+	mtmsrd	r10,1		/* Restore RI */
+#endif
 	bl	restore_math
+#ifdef CONFIG_PPC_BOOK3S
+	ld	r10,PACAKMSR(r13)
+	li	r9,MSR_RI
+	andc	r11,r10,r9 /* Re-clear RI */
+	mtmsrd	r11,1
+#endif
 	ld	r8,_MSR(r1)
 	ld	r3,RESULT(r1)
 	li	r11,-MAX_ERRNO
-- 
2.7.3
