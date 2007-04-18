Return-Path: <ananth@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A340DDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 15:54:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l3I5pV5L018574
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 01:51:31 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3I5sCJm172580
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 23:54:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3I5sBvt009677
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 23:54:11 -0600
Date: Wed, 18 Apr 2007 11:27:51 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] kprobes: eliminate sstep exception if instruction can be
	emulated
Message-ID: <20070418055751.GB16650@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For cases when probes are placed on instructions that can be emulated,
don't take the single-step exception.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/kprobes.c |   36 +++++++++++++++++++++++++++++++++++-
 include/asm-powerpc/kprobes.h |    5 +++++
 2 files changed, 40 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc7/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.21-rc7.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.21-rc7/arch/powerpc/kernel/kprobes.c
@@ -59,12 +59,14 @@ int __kprobes arch_prepare_kprobe(struct
 	}
 
 	if (!ret) {
-		memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+		memcpy(p->ainsn.insn, p->addr,
+				MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 		p->opcode = *p->addr;
 		flush_icache_range((unsigned long)p->ainsn.insn,
 			(unsigned long)p->ainsn.insn + sizeof(kprobe_opcode_t));
 	}
 
+	p->ainsn.boostable = 0;
 	return ret;
 }
 
@@ -232,6 +234,38 @@ static int __kprobes kprobe_handler(stru
 		return 1;
 
 ss_probe:
+	if (p->ainsn.boostable >= 0) {
+		unsigned int insn = *p->ainsn.insn;
+
+		/* regs->nip is also adjusted if emulate_step returns 1 */
+		ret = emulate_step(regs, insn);
+		if (ret > 0) {
+			/*
+			 * Once this instruction has been boosted
+			 * successfully, set the boostable flag
+			 */
+			if (unlikely(p->ainsn.boostable == 0))
+				p->ainsn.boostable = 1;
+
+			if (p->post_handler)
+				p->post_handler(p, regs, 0);
+
+			kcb->kprobe_status = KPROBE_HIT_SSDONE;
+			reset_current_kprobe();
+			preempt_enable_no_resched();
+			return 1;
+		} else if (ret < 0) {
+			/*
+			 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
+			 * So, we should never get here... but, its still
+			 * good to catch them, just in case...
+			 */
+			printk("Can't step on instruction %x\n", insn);
+			BUG();
+		} else if (ret == 0)
+			/* This instruction can't be boosted */
+			p->ainsn.boostable = -1;
+	}
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
Index: linux-2.6.21-rc7/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.21-rc7.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.21-rc7/include/asm-powerpc/kprobes.h
@@ -87,6 +87,11 @@ extern void arch_remove_kprobe(struct kp
 struct arch_specific_insn {
 	/* copy of original instruction */
 	kprobe_opcode_t *insn;
+	/*
+	 * Set in kprobes code, initially to 0. If the instruction can be
+	 * eumulated, this is set to 1, if not, to -1.
+	 */
+	int boostable;
 };
 
 struct prev_kprobe {
