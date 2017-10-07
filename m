Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89Rr0Rc6zDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89Rq6GWrz8vjD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:55 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89Rq2mzpz9t3C
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:55 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972QQFQ074668
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:53 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2demj8b0hr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:53 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:52 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 15/18] powerpc: Emulate paste instruction
Date: Fri,  6 Oct 2017 19:28:15 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-16-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

On POWER9 DD2.1 and below there are issues when the paste instruction
generates an error. If an error occurs when thread reconfiguration
happens (ie another thread in the core goes into/out of powersave) the
core may hang.

To avoid this a special sequence is required which stops thread
configuration so that the paste can be safely executed.

This patch assumes paste executed in userspace are trapped into the
illegal instruction exception at 0xe40.

Here we re-execute the paste instruction but with the required
sequence to ensure thread reconfiguration doesn't occur.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Edit by Sukadev: Use PPC_PASTE() rather than the paste instruction since
	in older versions the instruction required a third parameter.
---
 arch/powerpc/include/asm/emulated_ops.h |  1 +
 arch/powerpc/include/asm/ppc-opcode.h   |  1 +
 arch/powerpc/include/asm/reg.h          |  2 ++
 arch/powerpc/kernel/traps.c             | 64 +++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/arch/powerpc/include/asm/emulated_ops.h b/arch/powerpc/include/asm/emulated_ops.h
index f00e10e..9247af9 100644
--- a/arch/powerpc/include/asm/emulated_ops.h
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -55,6 +55,7 @@ extern struct ppc_emulated {
 	struct ppc_emulated_entry mfdscr;
 	struct ppc_emulated_entry mtdscr;
 	struct ppc_emulated_entry lq_stq;
+	struct ppc_emulated_entry paste;
 #endif
 } ppc_emulated;
 
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ce0930d..a55d2ef 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -229,6 +229,7 @@
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
 #define PPC_INST_PASTE			0x7c20070d
+#define PPC_INST_PASTE_MASK		0xfc2007ff
 #define PPC_INST_POPCNTB		0x7c0000f4
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_POPCNTD		0x7c0003f4
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f92eaf7..5cde1c4 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -468,6 +468,8 @@
 #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
 #define SPRN_PPR	0x380	/* SMT Thread status Register */
 #define SPRN_TSCR	0x399	/* Thread Switch Control Register */
+#define SPRN_TRIG1	0x371	/* WAT Trigger 1 */
+#define SPRN_TRIG2	0x372	/* WAT Trigger 2 */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
 #define SPRN_DER	0x095		/* Debug Enable Register */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 13c9dcd..7e6b1fe 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -956,6 +956,65 @@ static inline bool tm_abort_check(struct pt_regs *regs, int reason)
 }
 #endif
 
+static DEFINE_SPINLOCK(paste_emulation_lock);
+
+static inline int paste(void *i)
+{
+	int cr;
+	long retval = 0;
+
+	/* Need per core lock to ensure trig1/2 writes don't race */
+	spin_lock(&paste_emulation_lock);
+	mtspr(SPRN_TRIG1, 0); /* data doesn't matter */
+	mtspr(SPRN_TRIG1, 0); /* HW says do this twice */
+	asm volatile(
+		"1: " PPC_PASTE(0, %2) "\n"
+		"2: mfcr %1\n"
+		".section .fixup,\"ax\"\n"
+		"3:	li %0,%3\n"
+		"	li %2,0\n"
+		"	b 2b\n"
+		".previous\n"
+		EX_TABLE(1b, 3b)
+		: "=r" (retval), "=r" (cr)
+		: "b" (i), "i" (-EFAULT), "0" (retval));
+	mtspr(SPRN_TRIG2, 0);
+	spin_unlock(&paste_emulation_lock);
+	return cr;
+}
+
+static int emulate_paste(struct pt_regs *regs, u32 instword)
+{
+	const void __user *addr;
+	unsigned long ea;
+	u8 ra, rb;
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -EINVAL;
+
+	ra = (instword >> 16) & 0x1f;
+	rb = (instword >> 11) & 0x1f;
+
+	ea = regs->gpr[rb] + (ra ? regs->gpr[ra] : 0ul);
+	if (is_32bit_task())
+		ea &= 0xfffffffful;
+	addr = (__force const void __user *)ea;
+
+	if (!access_ok(VERIFY_WRITE, addr, 128)) // cacheline size == 128
+		return -EFAULT;
+
+	hard_irq_disable(); /* FIXME: could we just soft disable ?? */
+	pagefault_disable();
+
+	PPC_WARN_EMULATED(paste, regs);
+	regs->ccr = paste((void *)addr);
+
+	pagefault_enable();
+	may_hard_irq_enable();
+
+	return 0;
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -968,6 +1027,10 @@ static int emulate_instruction(struct pt_regs *regs)
 	if (get_user(instword, (u32 __user *)(regs->nip)))
 		return -EFAULT;
 
+	/* Emulate the paste RA, RB. */
+	if ((instword & PPC_INST_PASTE_MASK) == PPC_INST_PASTE)
+		return emulate_paste(regs, instword);
+
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & PPC_INST_MFSPR_PVR_MASK) == PPC_INST_MFSPR_PVR) {
 		PPC_WARN_EMULATED(mfpvr, regs);
@@ -1924,6 +1987,7 @@ struct ppc_emulated ppc_emulated = {
 	WARN_EMULATED_SETUP(mfdscr),
 	WARN_EMULATED_SETUP(mtdscr),
 	WARN_EMULATED_SETUP(lq_stq),
+	WARN_EMULATED_SETUP(paste),
 #endif
 };
 
-- 
2.7.4
