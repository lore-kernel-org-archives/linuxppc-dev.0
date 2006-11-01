Return-Path: <guij@cn.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3CC667B8F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 13:51:09 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kA130snI251526
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 14:00:56 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA12rlV0238934
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 13:53:57 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA12oLDZ032464
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 13:50:21 +1100
Message-ID: <45480B67.2080904@cn.ltcfwd.linux.ibm.com>
Date: Wed, 01 Nov 2006 10:50:15 +0800
From: "Gui,Jian" <guij@cn.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][kprobe] disallow kprobes on emulate_step and branch_taken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Probing on emulate_step function will crash 2.6.18.1 when it is
triggered. This problem is powerpc dependent.

When kprobe is triggered, emulate_step() is on its kernel path and
will cause recursive kprobe fault. And branch_taken() is called
in emulate_step(). This patch can disallow kprobes on both of them.



diff -Nur orig/arch/powerpc/lib/sstep.c linux-2.6.18.1/arch/powerpc/lib/sstep.c
--- orig/arch/powerpc/lib/sstep.c       2006-11-01 08:45:06.000000000 -0500
+++ linux-2.6.18.1/arch/powerpc/lib/sstep.c     2006-11-01 08:50:19.000000000 -0500
@@ -9,6 +9,7 @@
   * 2 of the License, or (at your option) any later version.
   */
  #include <linux/kernel.h>
+#include <linux/kprobes.h>
  #include <linux/ptrace.h>
  #include <asm/sstep.h>
  #include <asm/processor.h>
@@ -25,7 +26,7 @@
  /*
   * Determine whether a conditional branch instruction would branch.
   */
-static int branch_taken(unsigned int instr, struct pt_regs *regs)
+static int __kprobes branch_taken(unsigned int instr, struct pt_regs *regs)
  {
         unsigned int bo = (instr >> 21) & 0x1f;
         unsigned int bi;
@@ -51,7 +52,7 @@
   * or -1 if the instruction is one that should not be stepped,
   * such as an rfid, or a mtmsrd that would clear MSR_RI.
   */
-int emulate_step(struct pt_regs *regs, unsigned int instr)
+int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
  {
         unsigned int opcode, rd;
         unsigned long int imm;
