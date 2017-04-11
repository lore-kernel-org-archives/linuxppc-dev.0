Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2FSS4HH9zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 15:08:24 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3B53nbp056092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 01:08:21 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rmq6s362-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 01:08:21 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 10:38:18 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3B58Arx9568380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:38:10 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3B58EZE005086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:38:15 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 chris@distroguy.com, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 anton@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2] ppc64/kprobe: Fix oops when kprobed on 'stdu' instruction
Date: Tue, 11 Apr 2017 10:38:13 +0530
Message-Id: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of emulate_step()") 
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> 
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

  So kprobe on 'stdu' has always been broken on powerpc64.  We haven't
  noticed since most stdu operations were probably landing in the red
  zone so the exception frame never got corrupted. In that sense, this
  fix is needed for BE ever since load/store emulation was added.

  For LE, this is only getting exposed now due to my recent patch to
  enable load/store emulation on LE, which got merged as commit
  e148bd17f48b ("powerpc: Emulation support for load/store instructions
  on LE").

  Please mark this for stable as well.

Changes in v2:
  - Replace 'stwu' with 'stdu' in the comment.

 arch/powerpc/kernel/entry_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4b..767ef6d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -689,7 +689,7 @@ resume_kernel:
 
 	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
 
-	lwz	r3,GPR1(r1)
+	ld	r3,GPR1(r1)
 	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
 	mr	r4,r1			/* src:  current exception frame */
 	mr	r1,r3			/* Reroute the trampoline frame to r1 */
@@ -703,8 +703,8 @@ resume_kernel:
 	addi	r6,r6,8
 	bdnz	2b
 
-	/* Do real store operation to complete stwu */
-	lwz	r5,GPR1(r1)
+	/* Do real store operation to complete stdu */
+	ld	r5,GPR1(r1)
 	std	r8,0(r5)
 
 	/* Clear _TIF_EMULATE_STACK_STORE flag */
-- 
1.9.3
