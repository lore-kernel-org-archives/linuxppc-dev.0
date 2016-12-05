Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXDPZ1BWczDvXg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 16:50:26 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tXDPY42bFz9t25
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2016 16:50:25 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so15351372pgd.0
 for <linuxppc-dev@ozlabs.org>; Sun, 04 Dec 2016 21:50:25 -0800 (PST)
Subject: [RFC][PATCH] powerpc/oops: Provide disassembly on OOPS
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a04c2ba0-88f7-17af-8c2f-8fda8569ec13@gmail.com>
Date: Mon, 5 Dec 2016 16:50:19 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch is tied to xmon, it can be refactored out
better later if required. The idea is to provide
disassembly using xmon so that when we get an OOPS
we see something like the following below

...
NIP [c00000000063a230] lkdtm_WARNING+0x0/0x10
LR [c00000000063986c] lkdtm_do_action+0x3c/0x80
Call Trace:
[c0000000ef1bbbc0] [c0000000009a5804] printk+0x50/0x64 (unreliable)
[c0000000ef1bbbe0] [c000000000639cc0] direct_entry+0x100/0x1b0
[c0000000ef1bbc70] [c00000000043eb4c] full_proxy_write+0x8c/0x100
[c0000000ef1bbcd0] [c00000000028fe24] __vfs_write+0x54/0x1c0
[c0000000ef1bbd80] [c000000000291138] vfs_write+0xc8/0x260
[c0000000ef1bbdd0] [c000000000292c98] SyS_write+0x78/0x120
[c0000000ef1bbe30] [c00000000000b220] system_call+0x38/0xfc
Instruction dump:
c00000000063a200  38630618      addi    r3,r3,1560
c00000000063a204  f8010010      std     r0,16(r1)
c00000000063a208  f821ffa1      stdu    r1,-96(r1)
c00000000063a20c  4836b0f1      bl      c0000000009a52fc# panic+0x8/0x304
c00000000063a210  60000000      nop
c00000000063a214  60000000      nop
c00000000063a218  60000000      nop
c00000000063a21c  60420000      ori     r2,r2,0
c00000000063a220  0fe00000      twi     31,r0,0
c00000000063a224  60000000      nop
c00000000063a228  60000000      nop
c00000000063a22c  60420000      ori     r2,r2,0
c00000000063a230  0fe00000      twi     31,r0,0
                  ^^^^^^^^
c00000000063a234  4e800020      blr
c00000000063a238  60000000      nop
c00000000063a23c  60420000      ori     r2,r2,0
---[ end trace 4def3909e4288c1c ]---

NOTE: That the <> around the instruction that caused the
OOPS is now replaced with a ^^^^ following the disassembly
in the output. An issue was raised if as to whether calling
xmon during OOPS can cause further issues? xmon has been used
robustly in the past to look at OOPS and disassemble them
and moreover the OOPS output is at the end, so we've already
captured the GPR's and stack trace already.

NOTE2: If CONFIG_XMON_DISASSEMBLY is turned off, the disassembly
will be printed as a list of .long(s). It is highly recommended
to have both CONFIG_XMON_DISASSEMBLY and CONFIG_XMON for usable
output.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/xmon.h |  1 +
 arch/powerpc/kernel/process.c   | 11 +++++++++++
 arch/powerpc/xmon/xmon.c        |  3 +--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
index 5eb8e59..cd4c0cd 100644
--- a/arch/powerpc/include/asm/xmon.h
+++ b/arch/powerpc/include/asm/xmon.h
@@ -20,6 +20,7 @@ extern void xmon_register_spus(struct list_head *list);
 struct pt_regs;
 extern int xmon(struct pt_regs *excp);
 extern irqreturn_t xmon_irq(int, void *);
+extern int ppc_inst_dump(unsigned long addr, long count, int praddr);
 #else
 static inline void xmon_setup(void) { };
 static inline void xmon_register_spus(struct list_head *list) { };
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 04885ce..2a235bf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/tm.h>
 #include <asm/debug.h>
+#include <asm/xmon.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #endif
@@ -1217,10 +1218,20 @@ static void show_instructions(struct pt_regs *regs)
 		     probe_kernel_address((unsigned int __user *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
+#ifndef CONFIG_XMON
 			if (regs->nip == pc)
 				pr_cont("<%08x> ", instr);
 			else
 				pr_cont("%08x ", instr);
+#else
+			/* Does not work for SPU's */
+			ppc_inst_dump(pc, 1, 1);
+			if (regs->nip == pc)
+				/*
+				 * 26 = 16 (addr) + 2 (spaces) + 8 (instr)
+				 */
+				printk("%*s\n", 26, "^^^^^^^^");
+#endif
 		}
 
 		pc += sizeof(int);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..ceb7a05 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -123,7 +123,6 @@ static void memex(void);
 static int bsesc(void);
 static void dump(void);
 static void prdump(unsigned long, long);
-static int ppc_inst_dump(unsigned long, long, int);
 static void dump_log_buf(void);
 
 #ifdef CONFIG_PPC_POWERNV
@@ -2471,7 +2470,7 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
 	return adr - first_adr;
 }
 
-static int
+int
 ppc_inst_dump(unsigned long adr, long count, int praddr)
 {
 	return generic_inst_dump(adr, count, praddr, print_insn_powerpc);
-- 
2.5.5
