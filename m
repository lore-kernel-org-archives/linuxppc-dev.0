Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id B68EB2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 11:44:17 +1000 (EST)
Message-ID: <18949a6b246ced7268c2d2831f931f01.squirrel@mignight.com>
Date: Mon, 15 Apr 2013 01:44:14 -0000
Subject: [PATCH] powerpc: Fix audit crash due to save/restore PPR changes
From: "Alistair Popple" <alistair@popple.id.au>
To: sfr@canb.auug.org.au,
 benh@kernel.crashing.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, haren@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current mainline crashes when hitting userspace with the following:

kernel BUG at /home/alistair/Source/linux-stable/kernel/auditsc.c:1769!
cpu 0x1: Vector: 700 (Program Check) at [c000000023883a60]
    pc: c0000000001047a8: .__audit_syscall_entry+0x38/0x130
    lr: c00000000000ed64: .do_syscall_trace_enter+0xc4/0x270
    sp: c000000023883ce0
   msr: 8000000000029032
  current = 0xc000000023800000
  paca    = 0xc00000000f080380   softe: 0        irq_happened: 0x01
    pid   = 1629, comm = start_udev
kernel BUG at /home/alistair/Source/linux-stable/kernel/auditsc.c:1769!
enter ? for help
[c000000023883d80] c00000000000ed64 .do_syscall_trace_enter+0xc4/0x270
[c000000023883e30] c000000000009b08 syscall_dotrace+0xc/0x38
--- Exception: c00 (System Call) at 0000008010ec50dc

Bisecting found the following patch caused it:

commit 44e9309f1f357794b7ae93d5f3e3e6f11d2b8a7f
Author: Haren Myneni <haren@linux.vnet.ibm.com>
powerpc: Implement PPR save/restore

It was found this patch corrupted r9 when calling
SET_DEFAULT_THREAD_PPR()

Using r10 as a scratch register instead of r9 solved the problem.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Acked-by: Michael Neuling <mikey@neuling.org>
---

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 256c5bf..3acb1a0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -304,7 +304,7 @@ syscall_exit_work:
 	subi	r12,r12,TI_FLAGS

 4:	/* Anything else left to do? */
-	SET_DEFAULT_THREAD_PPR(r3, r9)		/* Set thread.ppr = 3 */
+	SET_DEFAULT_THREAD_PPR(r3, r10)		/* Set thread.ppr = 3 */
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq	.ret_from_except_lite
