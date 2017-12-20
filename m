Return-Path: <srs0=usgk=dq=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1cCQ0hR6zDrnd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:10:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z1cCP0C6Sz8tFf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:10:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z1cCM36WPz9t16
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2017 12:10:38 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK18eMf005276
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 20:10:36 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ey7qcywmq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 20:10:36 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 19 Dec 2017 20:10:35 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] powerpc: Emulate paste instruction
Date: Tue, 19 Dec 2017 17:10:28 -0800
Message-Id: <1513732229-10066-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
Changelog[v4]:
	- We need to disable pagefaults after all when modifying the thread
	  reconfig registers. Use a mutex, rather than a spinlock around
	  the thread reconfig registers. Acquire the mutex first then block
	  interrupts so we don't sleep on the mutex with interrupts disabled.

Changlog[v3]:
	- [Michael Ellerman] We don't need to disable/enable pagefaults
	  when emulating paste;
	- [Michael Ellerman, Aneesh Kumar] Fix retval from emulate_paste()

Changelog[v2]:
	[Sukadev]: Use PPC_PASTE() rather than the paste instruction since
	in older versions the instruction required a third parameter.
---
 arch/powerpc/include/asm/emulated_ops.h |  1 +
 arch/powerpc/include/asm/ppc-opcode.h   |  1 +
 arch/powerpc/include/asm/reg.h          |  2 +
 arch/powerpc/kernel/traps.c             | 73 +++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/arch/powerpc/include/asm/emulated_ops.h b/arch/powerpc/include/asm/emulated_ops.h
index 651e135..fdc95cf 100644
--- a/arch/powerpc/include/asm/emulated_ops.h
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -59,6 +59,7 @@ extern struct ppc_emulated {
 	struct ppc_emulated_entry lxvh8x;
 	struct ppc_emulated_entry lxvd2x;
 	struct ppc_emulated_entry lxvb16x;
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
index b779f3c..3495ecf 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -469,6 +469,8 @@
 #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
 #define SPRN_PPR	0x380	/* SMT Thread status Register */
 #define SPRN_TSCR	0x399	/* Thread Switch Control Register */
+#define SPRN_TRIG1	0x371	/* WAT Trigger 1 */
+#define SPRN_TRIG2	0x372	/* WAT Trigger 2 */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
 #define SPRN_DER	0x095		/* Debug Enable Register */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f3eb61b..e1ea3be 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1153,6 +1153,74 @@ static inline bool tm_abort_check(struct pt_regs *regs, int reason)
 }
 #endif
 
+static DEFINE_MUTEX(paste_emulation_mutex);
+
+static inline int paste(void *i)
+{
+	int cr;
+	long retval = 0;
+
+	/* Need per core lock to ensure trig1/2 writes don't race */
+	mutex_lock(&paste_emulation_mutex);
+
+	hard_irq_disable();
+
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
+
+	local_irq_enable();
+
+	mutex_unlock(&paste_emulation_mutex);
+
+	return retval ? retval : cr;
+}
+
+static int emulate_paste(struct pt_regs *regs, u32 instword)
+{
+	const void __user *addr;
+	unsigned long ea;
+	u8 ra, rb;
+	int rc;
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
+	pagefault_disable();
+
+	PPC_WARN_EMULATED(paste, regs);
+	rc = paste((void *)addr);
+
+	/* set cr0 to 0 to indicate a paste failure */
+	regs->ccr = (rc == -EFAULT) ? 0 : rc;
+
+	pagefault_enable();
+
+	return (rc == -EFAULT) ? rc : 0;
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -1165,6 +1233,10 @@ static int emulate_instruction(struct pt_regs *regs)
 	if (get_user(instword, (u32 __user *)(regs->nip)))
 		return -EFAULT;
 
+	/* Emulate the paste RA, RB. */
+	if ((instword & PPC_INST_PASTE_MASK) == PPC_INST_PASTE)
+		return emulate_paste(regs, instword);
+
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & PPC_INST_MFSPR_PVR_MASK) == PPC_INST_MFSPR_PVR) {
 		PPC_WARN_EMULATED(mfpvr, regs);
@@ -2088,6 +2160,7 @@ struct ppc_emulated ppc_emulated = {
 	WARN_EMULATED_SETUP(lxvh8x),
 	WARN_EMULATED_SETUP(lxvd2x),
 	WARN_EMULATED_SETUP(lxvb16x),
+	WARN_EMULATED_SETUP(paste),
 #endif
 };
 
-- 
2.7.4
