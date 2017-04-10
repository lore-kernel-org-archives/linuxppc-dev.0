Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1v6T0zgtzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 01:21:36 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3AFImTg025411
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 11:21:27 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29r99tk4bg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 11:21:26 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 20:51:22 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3AFLJkl18940014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 20:51:19 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3AFLHws019086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 20:51:19 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 chris@distroguy.com, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] ppc64/kprobe: Fix oops when kprobed on 'stdu' instruction
Date: Mon, 10 Apr 2017 20:50:57 +0530
Message-Id: <1491837657-4918-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we set a kprobe on a 'stdu' instruction on powerpc64, we see a kernel 
OOPS:

  [ 1275.165932] Bad kernel stack pointer cd93c840 at c000000000009868
  [ 1275.166378] Oops: Bad kernel stack pointer, sig: 6 [#1]
  ...
  GPR00: c000001fcd93cb30 00000000cd93c840 c0000000015c5e00 00000000cd93c840
  ...
  [ 1275.178305] NIP [c000000000009868] resume_kernel+0x2c/0x58
  [ 1275.178594] LR [c000000000006208] program_check_common+0x108/0x180

Basically, on 64 bit system, when user probes on 'stdu' instruction,
kernel does not emulate actual store in emulate_step itself because it
may corrupt exception frame. So kernel does actual store operation in
exception return code i.e. resume_kernel().

resume_kernel() loads the saved stack pointer from memory using lwz,
effectively loading a corrupt (32bit) address, causing the kernel crash.

Fix this by loading the 64bit value instead.

Fixes: 8e9f69371536 ("powerpc/kprobe: Don't emulate store when kprobe stwu r1")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
History:
  Commit 8e9f69371536 ("powerpc/kprobe: Don't emulate store when kprobe
  stwu r1") fixed exception frame corruption for 32 bit system which uses
  'stwu' instruction for stack frame allocation. This commit also added
  code for 64 bit system but did not enabled it for 'stdu' instruction.
  So 'stdu' instruction on 64 bit machine was emulating actual store in
  emulate_step() itself until...

  Commit be96f63375a1 ("powerpc: Split out instruction analysis part of
  emulate_step()"), enabled it for 'stdu' instruction on 64 bit machine.

  Since then it's broken. So this should also go into stable.

 arch/powerpc/kernel/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4b..530f6e9 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -689,7 +689,7 @@ resume_kernel:
 
 	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
 
-	lwz	r3,GPR1(r1)
+	ld	r3,GPR1(r1)
 	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
 	mr	r4,r1			/* src:  current exception frame */
 	mr	r1,r3			/* Reroute the trampoline frame to r1 */
@@ -704,7 +704,7 @@ resume_kernel:
 	bdnz	2b
 
 	/* Do real store operation to complete stwu */
-	lwz	r5,GPR1(r1)
+	ld	r5,GPR1(r1)
 	std	r8,0(r5)
 
 	/* Clear _TIF_EMULATE_STACK_STORE flag */
-- 
1.9.3
